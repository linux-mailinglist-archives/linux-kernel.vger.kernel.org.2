Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC76381D53
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhEPHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhEPHth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 03:49:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDECC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:48:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so4511760ejy.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h6oV9wd5kA7+2uCRYGnxwbcp91vUgplkvPfsbcp8srY=;
        b=Or7C8gx2e0I7UuD8b4rio9s7sssLTUmnyIR4hTR7rlLFME/0QDuq9u28n9zDVVG80h
         BucAclKbJ4xRH4yAS0A9qnPe4/K1X/R+RpQiZ+ho4XO2TLQCBG6TPgKms5pJIWfQzPGE
         8vztCJ5FOhNNzozx3Tkh5CcgeqisvNaOLhAxsDI2LW8KnNfIwlFi5/6cFTLO0IcPAtiQ
         fS9XfYe3R5MX+gTCuNe0DpH8iMNK/YhucgeWRG5IFqxwx4jgiEtAOOGhvu/Pe7EyMWZo
         N/Y7b3u0SAdib+J/MpFq+g6FXvkH/5gApg/naZrAi/0oQ2+HpZx8AVF/JGjbEZV4UOL6
         N25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h6oV9wd5kA7+2uCRYGnxwbcp91vUgplkvPfsbcp8srY=;
        b=GiSOZZR8lBu0/AD7MXMLfuvbUv0UBLlmHcK0VMSMnwSZB0SLESEU7LcKS+qRs/NIel
         bWEkA66baIGoejhuLGuNLycMsZvVQJm2iHtQbWabkm/c32BnnxCAYn4ZZCFLL/cyjHA5
         Olmsjjbyk4/E9DEcHb+ihe2QRE7KeCgveWM8xsSgdpibou+be0fMh8nr0p4wd19xwbNZ
         rfGHRk1jgU97zPrVn+4J0jWlrF258sAg/RJtTDreWFAGmGmmqk9lGmOluXd5Yq4ZoVEA
         3pw3eJeFqCQ4w0uMcgs5cwOiVgMugqEcQnQO4Z72geVHzF+uITvWEf1x5cEOSym96KWa
         gScw==
X-Gm-Message-State: AOAM531umeT45ArZs0VI3zejQMTvbsRK7Zugss8RV8OqdbhuZKxDejts
        sXK0aESPTFm5mqH4rYq9jIQ=
X-Google-Smtp-Source: ABdhPJzYvfcQ2BB+OtBAXmsE3htFgq+2Pz7DZByrbDxmyceB/bwrATlVX4914puGIliWNpu1JjUzoQ==
X-Received: by 2002:a17:906:170a:: with SMTP id c10mr55285983eje.493.1621151301548;
        Sun, 16 May 2021 00:48:21 -0700 (PDT)
Received: from gmail.com (563BBFD3.dsl.pool.telekom.hu. [86.59.191.211])
        by smtp.gmail.com with ESMTPSA id a22sm8554251edu.14.2021.05.16.00.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:48:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 16 May 2021 09:48:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] x86/syscall: sign-extend system calls on entry to
 int
Message-ID: <YKDOQxRS+kX1WhQq@gmail.com>
References: <20210515011015.2707542-1-hpa@zytor.com>
 <20210515011015.2707542-2-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515011015.2707542-2-hpa@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> This is an ABI change, but is in fact a revert to the original x86-64
> ABI. The original assembly entry code would zero-extend the system
> call number; this patch uses sign extend to be explicit that this is
> treated as a signed number (although in practice it makes no
> difference, of course) and to avoid people getting the idea of
> "optimizing" it, as has happened on at least two(!) separate
> occasions.

The original x86-64 ABI as documented by AMD, as we (probably) never had 
this in Linux, right?

Sounds sensible to do this, assuming nothing relies on the weirdness.

Thanks,

	Ingo
