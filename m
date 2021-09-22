Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3E415099
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhIVToi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhIVTod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:44:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:43:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c21so14018114edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ji/3OHxxXp7JEAMabZ4O6FOUwmnPHOOQ4kW39G0L+nM=;
        b=dTFSpslXwVuPgK3I+MG3/Mn+QR2KHY0LI+FaIOrwdDS8uqh0ekTRw8jPKeUhUVaVKe
         38C/lgCGY7nEQSCN3DPM9mI1c7XCKyDUoUdMv5qAkz7IiPD/gf5+6NggVObtPNZoOsba
         kVfWrPfBOqJErapIC34Reff3p5nAAEJXlXWXqgfPQ/zB5SDL3exEPBXxipyCkTcCaY2p
         VnGpVq/b2hLwjc2ihzf+POyGFgYoVlr9ms3Ahk6Ost75sBpRdR9JlprP8SmJqaImEH/7
         5vxmZf5XsWHZkTlkF3QXhZmh3iK6T7Zcy0/o1CJFZ7lELa4L3qGZL8d+pQeNsLTovvdU
         0oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ji/3OHxxXp7JEAMabZ4O6FOUwmnPHOOQ4kW39G0L+nM=;
        b=uu6cno84qwBb8t6c9O5LvHpaUqh4bUbZ8HQ2lm1GRzU0Ehwd3OIdZXCn3ecS8LJ+NL
         VBUM8sr6OfI0msT7WH77m/Y8POCrsvGQ8UohxMLq+5Vuqim9hbRmW704HqAw0A7VCdTg
         1SZzFeAmzqv6PcVGDnfx7Z6bsJ1hvXf4/EnwepcPS16KPdbD3QPjgw5u4hOq+Pxp5DHy
         oTLzfTrdV/GxHZtrKWl1Fy+qoeiBYoA9R/1mu0PNS89xibb/UGd6tChtEw2n6N1rxCsk
         t5mVEyqRAtJdCtK4tUxv9LgDOhkiyDPRabIkELCpHCdfPAl4l7N3KZyQHgT00p1jz6Ar
         DnYA==
X-Gm-Message-State: AOAM533jNdluq/6OxxeqpAXkzKgXgZ1F5nAsU39XEr6Zl7Vb5ZDsOM/K
        cjYesMh0kKXOu4jEszPxawvBlL7qT1x+Mj5NK9ROow==
X-Google-Smtp-Source: ABdhPJyQ804Xjf1u8CSIenNl78ule3d/nkHMCInpor5s23mf6xloNOF23jfFh+LDkd8j8TA0FkCyJoiupRqoMhgQXh4=
X-Received: by 2002:a17:906:b782:: with SMTP id dt2mr1028918ejb.310.1632339781455;
 Wed, 22 Sep 2021 12:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210908130922.118265849@linutronix.de> <20210908132525.794334915@linutronix.de>
 <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com> <871r5h7km4.ffs@tglx>
In-Reply-To: <871r5h7km4.ffs@tglx>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 22 Sep 2021 21:42:50 +0200
Message-ID: <CADYN=9LmxMAU7DPAQUZpHkXLPh8QJgrGT7qgd9SZ_80brfmfrQ@mail.gmail.com>
Subject: Re: [patch V3 15/20] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 22:13, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Sep 21 2021 at 12:58, Anders Roxell wrote:
> > On Wed, 8 Sept 2021 at 15:30, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Now that copy_fpregs_to_sigframe() returns boolean the individual return
> >> codes in the related helper functions do not make sense anymore. Change
> >> them to return boolean success/fail.
> >>
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > When I build and boot (qemu_x86_64) a defconfig kernel on from todays
> > next tag next-20210921 I see the following segmentation fault
> >
> > 2021-09-21T10:11:45 <6>[    1.622922] mount (89) used greatest stack
> > depth: 14384 bytes left
> > 2021-09-21T10:11:45 <6>[    1.664760] EXT4-fs (sda): re-mounted. Opts:
> > (null). Quota mode: none.
> > 2021-09-21T10:11:45 <6>[    1.691041] mkdir (92) used greatest stack
> > depth: 14312 bytes left
> > 2021-09-21T10:11:45 <6>[    1.713201] mount (93) used greatest stack
> > depth: 13720 bytes left
> > 2021-09-21T10:11:46 Starting syslogd: /etc/init.d/rcS: line 12:   101
> > Segmentation fault      $i start
> >
> >
> > I did a bisection and found this as the faulty patch [1]. When I
> > revert this patch I can't see the issue.
> >
> > We noticed that function 'save_xstate_epilog()' changes the polarity
> > of its return code for one of the return statements, and for its only
> > caller. but not for the other return statement.
> >
> > I tried this patch and I couldn't see the segmentation fault.
> >
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index 445c57c9c539..61eeebc04427 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -104,7 +104,7 @@ static inline int save_xstate_epilog(void __user
> > *buf, int ia32_frame)
> >         err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
> >
> >         if (!use_xsave())
> > -               return err;
> > +               return !err;
>
> Oops. Good catch. Care to send a proper patch for this?

Yes I can try to do that.

Cheers,
Anders
