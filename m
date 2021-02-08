Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D321F3128E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 03:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBHCS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 21:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhBHCSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 21:18:55 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC828C061786
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 18:18:14 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id y15so11349193ilj.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 18:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XSBwCQhIiL7WoW30Wg1JyXmwITq5X3TRIbKEv5Zbwd4=;
        b=aQ4fvSLxKak589bkgvtFHLWFPLXJ1jYNQEGn2MiAgo4WDFUklqm3ZslZFEwU+V6c4y
         Ri2xMmxkjHK7raR+UbWYZ3NDRvXoSaaTJn+U210nt95J1klI5rTDku/nrpiE71pvPDy2
         12b1Ow+x2AWKFoMRqN874RpVtuNURym1Fk2UIbAbABVOnWV8mH1SDyc8ZNqCNv0YNvW5
         CmBjYoB+t5Yv1WWCpFqgqB7hpG4kBIJpDkXroVyLHRrScz3hjeNSmcP0iM3IZ2NoLNyS
         seWdDRGAtQN3nt+gi6WpTQcmCMAedYVcBuvEi0+YNyGZ585w+mPr8/ifZQcRGfi6W1tG
         j6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XSBwCQhIiL7WoW30Wg1JyXmwITq5X3TRIbKEv5Zbwd4=;
        b=uBauPuRm+jHD6asX4lezAD+VA0NoUYDzKp8kLakdj45k8kRfFjaehiLy/7vMKcMKVv
         8JV3jKMvEhkkMJ2YI8uLuvB6//euEG5gkLDRbcj27ZUOnknm6PlBzZVsdRla+g37x1O8
         VZvoqbKv4rAcPjRhfzCaFm1PhYuK0V2e8Z38BPHCAJGu79bAUDP2/IV5QaYvachsC+kd
         D2tj9BJrb/Pv5I4zt/FQj1C5L4PlUP2g3EyM+7EjhfQhSXuIobZzCvK1lzveMGPK1A+V
         OeTXNyzY2XYHCUR8WBj7yxSusnGcEvQgz/nQ1RTmCXbz8dIvzgygHu87pDHv0npy09/Y
         iNOg==
X-Gm-Message-State: AOAM5324tVyiEjYx+/7iRCUN+T6lzdiQsk17JUjbQyLlQgzQCibnXiXI
        W0zvWe1uH7ZGRJ2VgKPGoneTuNXzIUysgp50+/c=
X-Google-Smtp-Source: ABdhPJyaffUfa2FHmraU2AhVABXIPl7gszkVKSGfn0IITKZeRil1eUQRWK9lCMiY6m740Mc4HTUHfVrE6P3H93Nc8R0=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr14023226ilr.10.1612750694254;
 Sun, 07 Feb 2021 18:18:14 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUhzpmoD_XrHtnFUGSpXHrVOTnVG9Q_Tek8oA8isHZe=Q@mail.gmail.com>
 <CAP045Aot_wYcwXVtfB9NmS98NGZumER39q8piN1ucgHCcpc8OA@mail.gmail.com>
In-Reply-To: <CAP045Aot_wYcwXVtfB9NmS98NGZumER39q8piN1ucgHCcpc8OA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Feb 2021 03:18:03 +0100
Message-ID: <CA+icZUW-9stFCoJRk_sPoyktoykue77eh7SF+SaSNyKAqmx7LA@mail.gmail.com>
Subject: Re: [Linux v5.11-rc7] x86: entry: Leftover of _TIF_SINGLESTEP define?
To:     Kyle Huey <me@kylehuey.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 12:25 AM Kyle Huey <me@kylehuey.com> wrote:
>
> On Sun, Feb 7, 2021 at 3:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi,
> >
> > congrats to Linux v5.11-rc7.
> >
> > after commit 6342adcaa683 ("entry: Ensure trap after single-step on
> > system call return"):
> >
> > $ git grep '\_TIF_SINGLESTEP' arch/x86/
> > arch/x86/include/asm/thread_info.h:#define _TIF_SINGLESTEP
> >  (1 << TIF_SINGLESTEP)
> >
> > Is this a leftover and can be removed (now)?
> >
> > Thanks.
> >
> > Regards,
> > - Sedat -
> >
> > [1] https://marc.info/?l=linux-kernel&m=161273724611262&w=2
> > [2] https://git.kernel.org/linus/6342adcaa683
>
> Yes it looks like that can be removed now.
>

Hi Kylem

Thanks for the confirmation.

Shall I send a patch?
With an ACK of you or mention in the commit message?

- Sedat -
