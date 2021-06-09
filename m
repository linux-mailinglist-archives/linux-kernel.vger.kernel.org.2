Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15E33A165C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhFIOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:02:32 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:57494 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbhFIOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:02:29 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 159E0GGi026506
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jun 2021 23:00:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 159E0GGi026506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1623247219;
        bh=RkIwX0pUME6LZvISnFq3X05EzbICGx/taXobpj7u0Eg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PkK4bBZFua48ukhRcS3ErQdbAADha+vi4S785FLXvLmVJGpXrdgDr7yX+kEdHPOD0
         uo/F3oGknMlN2W/X3yKWHbM10YEAM1kl6XSbE6e9/QYVlV+iPF1WiYGmwU3tpe5Ghn
         +EdEtpvLAsM95TrAw6RqftFkX5KvH2Sd1kVuk3oweNMXnpOI/NhjEP9ZdchYs1bacV
         m0WL3Zcq3O0HF8KmvywuZkLbZd2Ph84JlhTTBMujsKi1KNsoc2y5kF9OyCEOZ19Xxx
         oXUkr/o6uAC8pIBFKNkzZMAIh7K07irUiSDDAS9QwK/vo4jcu8GdkNXPFtuu3pokg3
         54tH8th+rq2Lg==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id k5so1401145pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:00:18 -0700 (PDT)
X-Gm-Message-State: AOAM5303uL6kMYi7uCbFkXxHfnhJyaC+TEj9ZuztuKwYYKqY/y7GL2RP
        /yrJ79kKzN8m5ILkpY0/vdUBP7u3crM5HcekjSY=
X-Google-Smtp-Source: ABdhPJwo/la98z22IRLa1bFWy9IYCNul5xdSAFDe845AwS3erHG6oY/zET3exelN1ljcFrlfgIGIddvj7NdAfc/5Qpc=
X-Received: by 2002:a17:903:22c6:b029:10e:b813:eb37 with SMTP id
 y6-20020a17090322c6b029010eb813eb37mr5120815plg.47.1623247215334; Wed, 09 Jun
 2021 07:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <YLeot94yAaM4xbMY@gmail.com> <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
 <YLjNa7vaYOfVhBFm@gmail.com> <YLjOjZVetM4UbUPn@gmail.com> <CAK7LNAQ73zG69F4hMJhgrHp8yT9tUmb-0tN=kFtWA98-YV3eNA@mail.gmail.com>
In-Reply-To: <CAK7LNAQ73zG69F4hMJhgrHp8yT9tUmb-0tN=kFtWA98-YV3eNA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 9 Jun 2021 22:59:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYuP70tz-dV+MfrpRke_3UvZ9wqqS2X8-FR9eXjcBmWQ@mail.gmail.com>
Message-ID: <CAK7LNARYuP70tz-dV+MfrpRke_3UvZ9wqqS2X8-FR9eXjcBmWQ@mail.gmail.com>
Subject: Re: kbuild: Ctrl-C of parallel kernel build sometimes corrupts .o.cmd
 files permanently
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 12:22 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Jun 3, 2021 at 9:44 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > > >   CC      security/keys/keyctl_pkey.o
> > > >   CC      kernel/sys.o
> > > >   CC      arch/x86/power/hibernate_64.o
> > > > ^Cmake[5]: *** Deleting file 'drivers/video/fbdev/core/fbcmap.o'  <---- Deleting
> > > > make[5]: *** [scripts/Makefile.build:272:
> > > > drivers/video/fbdev/core/fbmon.o] Interrupt
> > > > make[3]: *** [scripts/Makefile.build:272: security/selinux/nlmsgtab.o] Interrupt
> > > > make[2]: *** [scripts/Makefile.build:272: arch/x86/power/cpu.o] Interrupt
> > > > make[2]: *** [scripts/Makefile.build:272:
> > >
> > > Interestingly I don't get *any* interruption messages at all:
> > >
> > >   CC      drivers/dma/dw/acpi.o
> > >   CC      sound/pci/ice1712/ice1712.o
> > >   CC      drivers/char/ipmi/ipmi_watchdog.o
> > >   CC      fs/overlayfs/export.o
> > >   CC      fs/nls/nls_cp936.o
> > >   CC      drivers/char/ipmi/ipmi_poweroff.o
> > >  ^Ckepler:~/tip>
> > >
> > > The '^C' there - it just stops, make never prints anything for me.
> >
> > Found something - seems to be related whether the build is going into a
> > pipe or not.
> >
> >
> > I usually build this way (directly or via a script):
> >
> >    make -j96 bzImage ARCH=x86 2>&1 | tee e
> >
> > Ctrl-C interruption is not handled by kbuild in this case:
> >
> >   CC      fs/jffs2/xattr_trusted.o
> >   CC      sound/firewire/motu/motu-transaction.o
> >   CC      sound/usb/clock.o
> >   ^Ckepler:~/tip>
> >
> > Immediate prompt - no cleanup sequence.
> >
> > But if I do it without 'tee', I get the expected cleanup sequence by make:
> >
> >   kepler:~/tip> make -j96 bzImage ARCH=x86 2>&1
> >
> >   CC      fs/jffs2/acl.o
> >   CC      sound/pci/echoaudio/mona.o
> >   CC      fs/nls/nls_iso8859-9.o
> >   ^Cmake[2]: *** Deleting file 'drivers/reset/core.o'
> >     make[3]: *** Deleting file 'sound/pci/mixart/mixart.o'
> >     make[3]: *** Deleting file 'sound/pci/emu10k1/voice.o'
> >     make[2]: *** Deleting file 'fs/gfs2/aops.o'
> >
> > Thanks,
> >
> >         Ingo
>
>
>
> Hmm, I do not know why GNU Make behaves like this...
>
> I will ask about this in GNU Make ML.


https://lists.gnu.org/archive/html/help-make/2021-06/msg00001.html


In short, 'tee' was also interrupted,
then 'make' got SIGPIPE, which terminated the app
due to the default behavior.

-- 
Best Regards
Masahiro Yamada
