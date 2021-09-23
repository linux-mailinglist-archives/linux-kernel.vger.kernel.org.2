Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF66C41614C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhIWOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:45:25 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:44701 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbhIWOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:45:23 -0400
Received: by mail-vs1-f53.google.com with SMTP id 66so2773340vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocmWBy5EYqhzDku3sEqRq+XF89g3KCCaraUmmsxvZxA=;
        b=IofLwUGYraoFWiyrGxlSkGhI5sKr4tuHsWI0GvmabcMrosdNe6lsP0CrXDMAN5xZ/V
         fvvzi8D8m5jfyGwaBywsPDvCUdpbE2Mg8LeVSsKrwAiaXAJFTXhRMzBdL53Wt1Ia0BoH
         E+q076RfDm9dAUpOHTSNih3zQz5Em/T/Lk/VZPy1682tFzth40JFfLtK4pBbbhuGU9nX
         cgocwOHW5j1r3/sampKc2hdNKKrQYkTY8P/R/60s+CwwNGghwJO84qfhVmNBzXSR8OFX
         g7ynaGU7lrunNsSfk0xtqzw6LGdshXjhphfHDLagFznPYbSd4RyivuV08qJcziUulCgv
         zeEA==
X-Gm-Message-State: AOAM531m6UcKQ+B5Sgvvb0+ryMkivqXz6pmgjNEfUHjLQdJzUjqihz1o
        +T+EklYsjWsVk8LotiURVHn8B8NTdbAXt9KgnM4=
X-Google-Smtp-Source: ABdhPJxVhNFaORbf/Sq8uI+nB2u48TKxPHs/r33zxy4poRdxsbqJ+ea+JNouH2QmknckwzzAzeQwY/bmL25nCKAEo7c=
X-Received: by 2002:a05:6102:2086:: with SMTP id h6mr4418320vsr.50.1632408230604;
 Thu, 23 Sep 2021 07:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk> <89b7f0e5-21a5-5828-1eb8-5119fb8e2d58@linux-m68k.org>
In-Reply-To: <89b7f0e5-21a5-5828-1eb8-5119fb8e2d58@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Sep 2021 16:43:39 +0200
Message-ID: <CAMuHMdVMbo5868XxW5Lk6tiX3qY0drevfjv9TjMNmbrLrbAPig@mail.gmail.com>
Subject: Re: [RFC][CFT] signal handling fixes
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, Sep 16, 2021 at 11:03 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Sun, 25 Jul 2021, Al Viro wrote:
> > ...
> >
> > PS:  FWIW, ifdefs in arch/m68k/kernel/signal.c are wrong - it's not !MMU
> > vs. coldfire/MMU vs. classic/MMU.  It's actually 68000 vs. coldfire vs.
> > everything else.  These days it's nearly correct, but only because on
> > MMU variants of coldfire we never see exception stack frames with type
> > other than 4 - it's controlled by alignment of kernel stack pointer on
> > those, and it's under the kernel control, so it's always 32bit-aligned.
> > It used to be more serious back when we had 68360 support - that's !MMU
> > and exception stack frames are like those on 68020, unless I'm
> > misreading their manual...
> >
>
> I don't claim to understand this code but CPU32 cores appear to be
> unsupported on either #ifdef branch: the MMU branch due to CACR and CAAR
> used in push_cache(), and the !MMU branch due to frame format $4 used in
> adjust_format().
>
> The CPU32 Reference Manual appendix says these chips only supports control
> registers SFC, DFC, VBR and stack frame formats $0, $2, $C.
> https://www.nxp.com/files-static/microcontrollers/doc/ref_manual/CPU32RM.pdf

As of commit a3595962d82495f5 ("m68knommu: remove obsolete 68360
support"), nothing selects MCPU32 anymore.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
