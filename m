Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8D314DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBILKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhBILHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:07:53 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808AC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 03:07:13 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f23so10598551lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5EJybRjlcUj0cKcnS64rOqPsdV5T718ti2rqezNgtA=;
        b=u/ku/44GHyiITEMkHko1k4WquzgkS67Nq7Pn4nB9PJ4DPAEi8KD8vihae7WnnVKvcI
         7Dmhv9NgmeHwkTw1hidSSR7J2+LndGjZPYUWGncD0s/ajPERZSYQF5O3dtGyK4DysZ9K
         SZc1E4vufJvvt3exrLO7cR8i/drfxzGPWbgkYLfsTSXqAUEfowwVLRAxKQH3GE5IJetg
         XB6ZNqyx1Zlgkn9gvejccWj0crMW/Ut6jdqwdlQHIPNfWI52WTFbGefR+hKFCsZ+oLOJ
         9grlEexIFK54ZNauc1NaP86Q4eC00qGGutsP/XCzciZFFiTDVRYXXmKtdd1jslC0rjJN
         PRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5EJybRjlcUj0cKcnS64rOqPsdV5T718ti2rqezNgtA=;
        b=S8RhCD+grw9U5St73M6Plo86THCoo9yILPsOxU1NEa7wdK9l+g99malcU6/Xmh7iKm
         nDD+gMKaPCA/9QGsmOm6xBYaMSl41LWW+zI2yy/mIpJkHs+dFKtgtNBqdIhdo5xHvqar
         mwssXzEW8fpttRlgau+VJPvZDbZAi4+l8iFHbUk4R4vrLNHXMT+9iRLPWpNehRk0vH5j
         9zjrbW0L9C5q7Xxb/rxX3c2GiDPOSaMbSujsBwY4MLUvKwuVwkDAuByg7SVxzxNIVc3f
         7fPasSR5M/QUSbX5ye+7+CT6xicBdWr4Evqw4WS4vSNOtasxLCFvl61ruHGhIYGIe7kP
         gSXg==
X-Gm-Message-State: AOAM531zfMDsuC6zjK5IcnUxY4/iHxnWpJIQ64CPT8SuyH9J5/tqoRrk
        yu64tz5prUFkFqEdkog/6WOblK+xL4D3RYsQ89hDOg==
X-Google-Smtp-Source: ABdhPJzLbQUT4WCDN4pSG8w6zr/IEQsLh2NzEQBC6nrHaNNP7YMTXvwlagtlTwlztPvOLWQ/TglCFfRjUudGxyV7WKY=
X-Received: by 2002:a19:6410:: with SMTP id y16mr13216081lfb.113.1612868831761;
 Tue, 09 Feb 2021 03:07:11 -0800 (PST)
MIME-Version: 1.0
References: <1611915427-3196-1-git-send-email-sumit.garg@linaro.org>
 <20210208094303.csu2kkyi25d7a25y@maple.lan> <CAFA6WYNDydeDg8J16tFC30=yXCDMeaMKOm0Jt-3yF5jUMCq0yQ@mail.gmail.com>
 <20210208134802.tr7jzk27ja5chwgf@maple.lan>
In-Reply-To: <20210208134802.tr7jzk27ja5chwgf@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 9 Feb 2021 16:37:00 +0530
Message-ID: <CAFA6WYO_ZNt8P_fAiaj17yHu2spWyjYAm78xPGaRxJsggE4z=A@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Simplify kdb commands registration
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 19:18, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Mon, Feb 08, 2021 at 03:18:19PM +0530, Sumit Garg wrote:
> > On Mon, 8 Feb 2021 at 15:13, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Jan 29, 2021 at 03:47:07PM +0530, Sumit Garg wrote:
> > > > @@ -1011,25 +1005,17 @@ int kdb_parse(const char *cmdstr)
> > > >               ++argv[0];
> > > >       }
> > > >
> > > > -     for_each_kdbcmd(tp, i) {
> > > > -             if (tp->cmd_name) {
> > > > -                     /*
> > > > -                      * If this command is allowed to be abbreviated,
> > > > -                      * check to see if this is it.
> > > > -                      */
> > > > -
> > > > -                     if (tp->cmd_minlen
> > > > -                      && (strlen(argv[0]) <= tp->cmd_minlen)) {
> > > > -                             if (strncmp(argv[0],
> > > > -                                         tp->cmd_name,
> > > > -                                         tp->cmd_minlen) == 0) {
> > > > -                                     break;
> > > > -                             }
> > > > -                     }
> > > > -
> > > > -                     if (strcmp(argv[0], tp->cmd_name) == 0)
> > > > +     list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> > > > +             /*
> > > > +              * If this command is allowed to be abbreviated,
> > > > +              * check to see if this is it.
> > > > +              */
> > > > +             if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen) &&
> > > > +                 (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0))
> > > >                               break;
> > >
> > > Looks like you forgot to unindent this line.
> > >
> > > I will fix it up but... checkpatch would have found this.
> > >
> >
> > Ah, I missed to run checkpatch on v3. Thanks for fixing this up.
>
> Unfortunately, it's not just checkpatch. This patch also causes a
> large number of test suite regressions. In particular it looks like
> kgdbwait does not work with this patch applied.
>
> The problem occurs on multiple architectures all with
> close-to-defconfig kernels. However to share one specific
> failure, x86_64_defconfig plus the following is not bootable:
>
>     ../scripts/config --enable DEBUG_INFO --enable DEBUG_FS \
>       --enable KALLSYMS_ALL --enable MAGIC_SYSRQ --enable KGDB \
>       --enable KGDB_TESTS --enable KGDB_KDB --enable KDB_KEYBOARD \
>       --enable LKDTM
>
> Try:
>
>     qemu-system-x86_64 \
>       -enable-kvm -m 1G -smp 2 -nographic
>       -kernel arch/x86/boot/bzImage \
>       -append "console=ttyS0,115200 kgdboc=ttyS0 kgdbwait"
>

Thanks Daniel for this report. I am able to reproduce it with
"kgdbwait" and will investigate it.

-Sumit

>
> Daniel.
