Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81939B0D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFDDZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:25:27 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:42730 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhFDDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:25:26 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1543NAX0031704
        for <linux-kernel@vger.kernel.org>; Fri, 4 Jun 2021 12:23:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1543NAX0031704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622776991;
        bh=4ZgwLrSdL0ckNfaVKbFIuxYSiOqIzn7/uA3PaNeKOHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oAqnyCjfxeEVNk8weaq7LPQmzv++IXw4cCCGEDQGHyzhCTOkgk8miy4DYws+Boy6q
         /FoAduPGNonLt+JnBjAu4suQiZ+lzJjTI3TwcpTRkF9yvMq2eOCTyQxFp2O+ViytxX
         TEQDZDGSpnomYLFSGIteAgmzdg1c5YLn6o1xjTmgIr0FO5dAuGMvbwtbD26x7xZwj+
         qsDX6z2eRiBKk0tvRGMhC02WtZ7/DGAyQ4U/vF+lNbGVz8VdtryDB8hJsuRizHZZuG
         swz8DolPgHyYFsMnAqprDb0LN6aI9Zxq3ZNRej/8F7RjnqVWE3xErsNKKNqb3EN3Ry
         72Udmi3k1bEGQ==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id t28so6443646pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:23:11 -0700 (PDT)
X-Gm-Message-State: AOAM533IScNKEfYmZEZbg7Yk9m1i5tyjBUgFcjjFfXhTF7YUqlOTJEKR
        ER4+34aI7W4plfXfejE0Wc7zpwemlQT6HKY8JFU=
X-Google-Smtp-Source: ABdhPJwzG6dSHDkc7BVXMtqRxyF+S5t5Z8JUeSsMbtmb2WyZtG7KGiugsfIlPZuGdXqAnpehOOn12LZfcI8pmop1wdE=
X-Received: by 2002:aa7:99c9:0:b029:2e9:e084:e1de with SMTP id
 v9-20020aa799c90000b02902e9e084e1demr2482878pfi.80.1622776990547; Thu, 03 Jun
 2021 20:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <YLeot94yAaM4xbMY@gmail.com> <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
 <YLjNa7vaYOfVhBFm@gmail.com> <YLjOjZVetM4UbUPn@gmail.com>
In-Reply-To: <YLjOjZVetM4UbUPn@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 4 Jun 2021 12:22:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ73zG69F4hMJhgrHp8yT9tUmb-0tN=kFtWA98-YV3eNA@mail.gmail.com>
Message-ID: <CAK7LNAQ73zG69F4hMJhgrHp8yT9tUmb-0tN=kFtWA98-YV3eNA@mail.gmail.com>
Subject: Re: kbuild: Ctrl-C of parallel kernel build sometimes corrupts .o.cmd
 files permanently
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 9:44 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > >   CC      security/keys/keyctl_pkey.o
> > >   CC      kernel/sys.o
> > >   CC      arch/x86/power/hibernate_64.o
> > > ^Cmake[5]: *** Deleting file 'drivers/video/fbdev/core/fbcmap.o'  <---- Deleting
> > > make[5]: *** [scripts/Makefile.build:272:
> > > drivers/video/fbdev/core/fbmon.o] Interrupt
> > > make[3]: *** [scripts/Makefile.build:272: security/selinux/nlmsgtab.o] Interrupt
> > > make[2]: *** [scripts/Makefile.build:272: arch/x86/power/cpu.o] Interrupt
> > > make[2]: *** [scripts/Makefile.build:272:
> >
> > Interestingly I don't get *any* interruption messages at all:
> >
> >   CC      drivers/dma/dw/acpi.o
> >   CC      sound/pci/ice1712/ice1712.o
> >   CC      drivers/char/ipmi/ipmi_watchdog.o
> >   CC      fs/overlayfs/export.o
> >   CC      fs/nls/nls_cp936.o
> >   CC      drivers/char/ipmi/ipmi_poweroff.o
> >  ^Ckepler:~/tip>
> >
> > The '^C' there - it just stops, make never prints anything for me.
>
> Found something - seems to be related whether the build is going into a
> pipe or not.
>
>
> I usually build this way (directly or via a script):
>
>    make -j96 bzImage ARCH=x86 2>&1 | tee e
>
> Ctrl-C interruption is not handled by kbuild in this case:
>
>   CC      fs/jffs2/xattr_trusted.o
>   CC      sound/firewire/motu/motu-transaction.o
>   CC      sound/usb/clock.o
>   ^Ckepler:~/tip>
>
> Immediate prompt - no cleanup sequence.
>
> But if I do it without 'tee', I get the expected cleanup sequence by make:
>
>   kepler:~/tip> make -j96 bzImage ARCH=x86 2>&1
>
>   CC      fs/jffs2/acl.o
>   CC      sound/pci/echoaudio/mona.o
>   CC      fs/nls/nls_iso8859-9.o
>   ^Cmake[2]: *** Deleting file 'drivers/reset/core.o'
>     make[3]: *** Deleting file 'sound/pci/mixart/mixart.o'
>     make[3]: *** Deleting file 'sound/pci/emu10k1/voice.o'
>     make[2]: *** Deleting file 'fs/gfs2/aops.o'
>
> Thanks,
>
>         Ingo



Hmm, I do not know why GNU Make behaves like this...

I will ask about this in GNU Make ML.


-- 
Best Regards
Masahiro Yamada
