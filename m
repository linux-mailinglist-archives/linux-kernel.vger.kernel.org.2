Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A8313E69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBHTD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhBHRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:35:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAF8C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:35:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so26169710ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rk8hBnqzSk8IKdehPpMR21St3g94W00HJk2pGpZRlUM=;
        b=QhTtHeK4ZKTuLys3oD1ge2sDBy25LyBIlEb6rq0+qySZxVVbbXsJAxCtEVCdDmMTl4
         xJGa8G4tHKClDCp26tjcgxYm16FeSmIpK+4i7WHnI+XE2uRBwY0lYjXSuIas/15OJt6j
         tIaPvQ+/kTOaDd6ZYQOevDvu8PIBU5OsbEXiL+XEEoZlk0H5Km4oZlZ51d3LwmbPqOAi
         fewTdelXJC8xS93sqoBs4f0d5De8Hp3x5fJ3xy3+1KeEA1XlNY3DWze+W2pUDB/pqWKj
         kEl1d/WXeDsRXO5mwXmwG6lR+EQfdrduR1Jfe6cw09ilje/B1akvhfFbAB6ZXDVhcgaT
         HS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk8hBnqzSk8IKdehPpMR21St3g94W00HJk2pGpZRlUM=;
        b=O9hD+/gIlUJbQc+d7yk09WIWZ/u4hYagwsRwI2fEFJ7/W1hRTRk1qiYVLRI7rGRYL+
         3SDvh3WHYKxjK9svL5nV1WVNcJsJuIg+VOUQC5EkrmxIcPtSgBSSWM4UtZcgXr6+lki8
         UPpasB1yWQpsJaJWJYp+ZrhTVf6iKsc+0rJnjGNSoTMGns88qHiuYlXdguxTdWyKWlxc
         n1xlEGPKMiVsjHrwNr+1pNWA3TkqJo9JkT4+d7sX5Ybd6HuRs9M4hvdt1yWok7U3Z8hC
         lhllKVcT+naU3SwXls9WAfRsatP0YPyHRQ8HWaCgohzLrJY2BAVwOkFPh6mmVVD5/j/G
         hvpA==
X-Gm-Message-State: AOAM530FU1kLysSq/CFyka5ghKhq83GZ8SltkAYTvbkDtALHQV7fR4tU
        MoHQYg82Pb6j1VXpYX+1STUA+ReK/kpmQBC0VwAttA==
X-Google-Smtp-Source: ABdhPJztUCCKCvHw2ApoSKFKrVrK62dPz1Txw2JJsmk5m6cJ/R0froV9I9Y/DbVNUnQzMb7w2imKagFhA3Eejldzgho=
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr17887566ejb.503.1612805715256;
 Mon, 08 Feb 2021 09:35:15 -0800 (PST)
MIME-Version: 1.0
References: <f81afd12-91ed-27c9-58d6-e59e7e1178c0@intel.com>
 <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net> <YCFwo5tD3Jad6F69@google.com>
In-Reply-To: <YCFwo5tD3Jad6F69@google.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 8 Feb 2021 09:35:03 -0800
Message-ID: <CALCETrWC8qEFuUBdknaU-u_BbB1+HEibAKSjygH_bX0fYR1hYg@mail.gmail.com>
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 9:11 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sun, Feb 07, 2021, Andy Lutomirski wrote:
> >

> > How much of the register state is revealed to the VMM when we do a TDVMCALL?
> > Presumably we should fully sanitize all register state that shows up in
> > cleartext on the other end, and we should treat all regs that can be modified
> > by the VMM as clobbered.
>
> The guest gets to choose, with a few restrictions.  RSP cannot be exposed to the
> host.  RAX, RCX, R10, and R11 are always exposed as they hold mandatory info
> about the TDVMCALL (TDCALL fn, GPR mask, GHCI vs. vendor, and TDVMCALL fn).  All
> other GPRs are exposed and clobbered if their bit in RCX is set, otherwise they
> are saved/restored by the TDX-Module.
>
> I agree with Dave, pass everything required by the GHCI in the main routine, and
> sanitize and save/restore all such GPRs.

Sounds okay to me.
