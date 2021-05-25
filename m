Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3738F39006E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhEYL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:59:36 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20108 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhEYL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:59:34 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 14PBvWFS006493
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:57:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 14PBvWFS006493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621943853;
        bh=mpOgwI13xUd6gsf4BgpS23a6oQKA2w9/DQe52unJqtg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OiNJIt2x4TreLo2jrbOSDaqrN7iSKboAUHgF1lh1l/rO3HvEIuAsTNNpU8dTqbLFn
         As50to0irvczFYcnS8gTWMvB3Q5J3ZNBVh+kFLyaADvW4l4jYwra9eGRPFU2rJbhqz
         m0yiCyoQciUhiC1Ei/Wtt9WrPbTyPUSiMuyv7MKddJMUrTDJ4RW3BQpgnMWaiPO03j
         PbCXejOhDxRH92LxL+/eGiT4HqFNGbYafwxm821DQhneJFY0Sy/DBen2W9d2wdrd8l
         6YQqlu+EHwfIFxgzu6YvrM39KiANnY2t9Z5XLpNtZhEI3MikaYGuzxWDhqfexfIIfd
         a/JY3XQ4bJ6Og==
X-Nifty-SrcIP: [209.85.210.174]
Received: by mail-pf1-f174.google.com with SMTP id g18so21757930pfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 04:57:33 -0700 (PDT)
X-Gm-Message-State: AOAM532tIhkY1QYh1lpVuN3BiIJr4j6x/TFWu/MlHpZ9w8M6M43vN4/l
        4pJVLDteKBLHoXZmN2wvuv7yVCaWfS7GU+Ccjmg=
X-Google-Smtp-Source: ABdhPJwRRqPqDylrs56txPLrqhRPRTVjOd7OdCpcgpt/pR9jynzd6GPVV0Ykek7Qd6IM7gzPLC0V8ALhg/+mZ8jUlfw=
X-Received: by 2002:a63:164f:: with SMTP id 15mr18752599pgw.175.1621943852344;
 Tue, 25 May 2021 04:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFXTHPKwasdVidF7qEHdqwRht8Xg6qm6CCLL0HGaU1ew@mail.gmail.com>
 <874ker9j8y.ffs@nanos.tec.linutronix.de>
In-Reply-To: <874ker9j8y.ffs@nanos.tec.linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 May 2021 20:56:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2iVHa6RvQMxpPJco0ruqWDHMyN3-qBM+wb+RfzTdzSA@mail.gmail.com>
Message-ID: <CAK7LNAR2iVHa6RvQMxpPJco0ruqWDHMyN3-qBM+wb+RfzTdzSA@mail.gmail.com>
Subject: Re: x86: unistd_64.h: warning: missing whitespace after the macro name
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 7:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, May 24 2021 at 17:16, Naresh Kamboju wrote:
>
> > While building Linux next-20210524 tag with gcc 7.x the following warnings and
> > errors were noticed.
> >
> > build log:
> > ------------
> >   HOSTLD  scripts/mod/modpost
> >   CC      kernel/bounds.s
> >   CALL    /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/scripts/atomic/check-atomics.sh
> >   UPD     include/generated/bounds.h
> >   UPD     include/generated/timeconst.h
> >   CC      arch/x86/kernel/asm-offsets.s
> > In file included from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/include/asm/unistd.h:20:0,
> >                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/include/asm/seccomp.h:5,
> >                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/include/linux/seccomp.h:21,
> >                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/include/linux/sched.h:21,
> >                  from
> > /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/kernel/asm-offsets.c:10:
> > ./arch/x86/include/generated/uapi/asm/unistd_64.h:4:14: warning:
> > missing whitespace after the macro name
> >  #define __NR_/usrread 0
> >               ^
>
> Where is that "/usr" coming from?
>
> Looking at the generator script this looks like a stale $prefix
> parameter...


Sorry, it is my mistake.
I submitted a fix.

https://lore.kernel.org/patchwork/patch/1435988/


-- 
Best Regards
Masahiro Yamada
