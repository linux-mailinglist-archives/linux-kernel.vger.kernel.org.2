Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB10C339E03
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhCMMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:11:53 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28314 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:11:38 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 12DCBFCX006416
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:11:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 12DCBFCX006416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615637476;
        bh=JF14MXVjNJP1v4CgLXuDskri7mZ0masa0jozJ64DhYE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MyEUGxvwnE/3xRA/aj3QnVhmp/cy8llGwTVsS/QGJOGirTlwFVpHcXXWlcEpD7q7B
         jPd/ORnJmsKb5vahxrqdAfKkYPsm6YEH+E51/08wpfLSTHQd3J5vXIBAdHKdQHPF3S
         Oqb0A2kJc7FWXfFA5zLA1xs06Et1pQ0Jh0joyWzg2CpYIi7Elnav8T3J/GvCdUXlYd
         1g/uZ3yscLY8whvwzkvr98CVWBiQIIH6Inmy4nE+Fy8sNfyKFMzI3GBKD5uShIf+8M
         WQme7ud0dKUFh9kzr6+EKmHZs6ANDkOuTBRCSaY22ev6dby2hKdhn7NvH66WI+BHeo
         kGE25UbFmLgYw==
X-Nifty-SrcIP: [209.85.214.180]
Received: by mail-pl1-f180.google.com with SMTP id d23so9941716plq.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 04:11:16 -0800 (PST)
X-Gm-Message-State: AOAM5322znkUgsEFLMtWS/Ass+wZ5vMQCyBks38qs4mX160i8wV1y20w
        xugjlaLYFtha0JBHd7BF7dqCU7u+4P8ctTUb0v4=
X-Google-Smtp-Source: ABdhPJxO2ZBOg17YwwsHHxay3BeeiHHFHrm18qxs3+QlP5aRturdHfgYgIyytLJq9MSGhp8LrFxIpyy3Vb3px7yDRS4=
X-Received: by 2002:a17:902:b589:b029:e6:2875:aa4c with SMTP id
 a9-20020a170902b589b02900e62875aa4cmr3070985pls.71.1615637475398; Sat, 13 Mar
 2021 04:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20210312151411.101942-1-masahiroy@kernel.org> <CAMo8BfL3Zx2_uYD6yJQgju90JJj5=occjsDtcXZY0E2jmqUhow@mail.gmail.com>
 <CAK7LNASb4wDk4p7Qk28nNbu0fr9kNa_PaDq-RXRzB_qiJedzQg@mail.gmail.com>
In-Reply-To: <CAK7LNASb4wDk4p7Qk28nNbu0fr9kNa_PaDq-RXRzB_qiJedzQg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 13 Mar 2021 21:10:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9n4OtyRHx+PyJi-1CoxHrRT8OV6nKuiqsnvSPO1jUeg@mail.gmail.com>
Message-ID: <CAK7LNAT9n4OtyRHx+PyJi-1CoxHrRT8OV6nKuiqsnvSPO1jUeg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 9:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Mar 13, 2021 at 5:57 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > On Fri, Mar 12, 2021 at 7:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Move the definition of CONFIG_CPU_*_ENDIAN to Kconfig, the best place
> > > for CONFIG options.
> > >
> > > I slightly simplified the test code. You can use the -P option to suppress
> > > linemarker generation. The grep command is unneeded.
> > >
> > >   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -
> > >   # 1 "<stdin>"
> > >   # 1 "<built-in>"
> > >   # 1 "<command-line>"
> > >   # 1 "<stdin>"
> > >   1
> > >
> > >   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -P -
> > >   1
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> >
> > > If I understood correctly, xtensa compilers can support either
> > > big-endian or little-endian. We cannot change it via a command option.
> > > Actually, it does not understand -mbig-endian or -mlittle-endian.
> > > (Is this correct?)
> >
> > This is correct. The idea is that specific xtensa core has fixed endianness,
> > but it can be either little or big. The toolchain is configured for the specific
> > xtensa core at build time, so there's no need for a runtime endian switch.
> >
> > >   $ xtensa-linux-gcc   -mbig-endian  /dev/null  -c -o /dev/null
> > >   xtensa-linux-gcc: error: unrecognized command-line option '-mbig-endian'
> > >
> > > I see -mbig-endian / -mlittle-endian in old GCC manual.
> > >   https://gcc.gnu.org/onlinedocs/gcc-3.3.5/gcc/Xtensa-Options.html
> > > But, I cannot see them in recent gcc manuals.
> > > So, I have no idea better than checking __XTENSA_EB__ or __XTENSA_EL__.
> > > I just moved the logic to Kconfig from Makefile.
> > >
> > >
> > >  arch/xtensa/Kconfig  | 6 ++++++
> > >  arch/xtensa/Makefile | 9 +--------
> > >  2 files changed, 7 insertions(+), 8 deletions(-)
> >
> > Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> > Please let me know if I should take it into the xtensa tree or you will
> > carry it in the kbuild tree.
>
>
> Please apply it to the xtensa tree.
>

Ah, wait.

I think I can do a little more cleanups.

arch/xtensa/boot/Makefile:BIG_ENDIAN        := $(shell echo
__XTENSA_EB__ | $(CC) -E - | grep -v "\#")


Will send v2.

-- 
Best Regards
Masahiro Yamada
