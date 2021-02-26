Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53674326678
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBZRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:48:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:47:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so5666475pli.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K0LiJMFsZzonxRiACJX9bTxGPskMvO8X+dFkrCpK9f8=;
        b=flBMYTva+Ub7O2J4tf0pmjGVcRRmsH028DAWb+FJ5ZTaVZH3/wd50QU4ehT1YPn+3I
         Iix8MWa6WAR3JGYqbXgh2ZAgYBifslyGpfHIcg9i2qsfHPTAL62Gq5FiRd73StFnRaMa
         ii4vyNgpJFbBMMCxAPA4M59qvHkJyQaxID5oJy4ScRsOF2iU9mhFQ3RQbZfMC3zK0o5G
         /RURL3EiOTXKQIL8XquJi75X3DYnIIXzMOmF699893Sjpb+ErSgEvMaAPQTMQJeSnxiU
         6Ewk1ZawmvKwXfCxvd9hzc6zZdjx0aiFMcPdQsWNZyMPLUyxjYZwBEeXhQWEubpaoNd7
         xGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K0LiJMFsZzonxRiACJX9bTxGPskMvO8X+dFkrCpK9f8=;
        b=EblukSvSy4bVIuPedBDwhPLhfBDY9DkDRY0XhrYHBMNBlQeKiFJRQwv38VtBei0Kpe
         TeZHCsbhGncInTi911jeh8m+WC48K/5gwYy9hAGTOOVnrVt6KqfZ9AmWZF32ahXeeae4
         mtrEegb6rVINr5BNO6a311PO1//5SJnlKX/fNZsox6nqOW/dD7cTS56lGy+ucCOVZBWb
         GtFmklLEQkjKvKlnxizAV8xU3YJclmjoEfsRVCi2fK1U3TduhRLednYqwqyf83b031tR
         tjSd68IRvscu3i1L6CU4Jn1hZLkvzZPuLLJ3shoFUN7x85smmZvuXdK9fW84+M5/u3q4
         Ay+w==
X-Gm-Message-State: AOAM533OTfd4WVWUOpRfbhxYpbz8SK8tMiABNpLRXKdDRydI7ZdMF3gn
        KP6kiZ6iLqM7cJyfWlzoF0yQ/w==
X-Google-Smtp-Source: ABdhPJw16OL6xdvgFPC+h6kiZu1Jjno2uNAyLXCqNtPonj3qIVLXIlapOY5pgH5rUlbisZjLDIO4Zg==
X-Received: by 2002:a17:90a:f68b:: with SMTP id cl11mr4449383pjb.187.1614361652700;
        Fri, 26 Feb 2021 09:47:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e190:bf4c:e355:6c55])
        by smtp.gmail.com with ESMTPSA id 7sm9924571pfh.142.2021.02.26.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:47:32 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:47:25 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC 1/6] vdso/extable: fix calculation of base
Message-ID: <YDk0Ld5TIEnhA0Cb@google.com>
References: <20210225072910.2811795-1-namit@vmware.com>
 <20210225072910.2811795-2-namit@vmware.com>
 <YDgTrqNDk+vPF9LA@google.com>
 <2CDFE432-90D3-43EE-BA9F-2CFEB8BB343C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2CDFE432-90D3-43EE-BA9F-2CFEB8BB343C@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021, Nadav Amit wrote:
> 
> > On Feb 25, 2021, at 1:16 PM, Sean Christopherson <seanjc@google.com> wrote:
> > It's been literally years since I wrote this code, but I distinctly remember the
> > addresses being relative to the base.  I also remember testing multiple entries,
> > but again, that was a long time ago.
> > 
> > Assuming things have changed, or I was flat out wrong, the comment above the
> > macro magic should also be updated.
> > 
> > /*
> > * Inject exception fixup for vDSO code.  Unlike normal exception fixup,
> > * vDSO uses a dedicated handler the addresses are relative to the overall
> > * exception table, not each individual entry.
> > */
> 
> I will update the comment. I am not very familiar with pushsection stuff,
> but the offsets were wrong.
> 
> Since you say you checked it, I wonder whether it can somehow be caused
> by having exception table entries defined from multiple object files.

Oooh, I think that would do it.  Have you checked what happens if there are
multiple object files and multiple fixups within an object file?

> Anyhow, this change follows the kernel’s (not vDSO) exception table
> scheme.
