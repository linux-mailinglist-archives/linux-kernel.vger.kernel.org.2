Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5700C399277
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFBSW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:22:59 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:49899 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:22:58 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 152IKviR021564
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jun 2021 03:20:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 152IKviR021564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622658058;
        bh=yCsf8LnkRxLPnoPEquDuilaMalZNFaFdoh+pIQY02MY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DymrX7NCQfNGlE0dFYUKhUyKL6MD7N68ftfFbYwzBNb9cMaXQu2vkvGkF0ZEmURhg
         KEPBd767KRHPpjl5UndBpf095JAeez4dp1tSaqDSJd02insYbuuyFRjat/ri1Thmp3
         2TJCIk79e690Wx2ycGUXd/rUgFKIq77FD3nFZIYQFDawTvfbAjvBkemIiVREtJxEdu
         5jT09te9UdIKD5kUeuYFpWWgawRcsqE3K2GW+xz8YnlVQKE99RzNj08jKVclpSZzJI
         1VJEJrWeh90MGFfO17eYHIjsQPZ1ZjvhtmAMYqK1qzzaWqOWZNRLVkQ9F+9G39LZiy
         3DEFMdMBsgVbA==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id n12so2928381pgs.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:20:58 -0700 (PDT)
X-Gm-Message-State: AOAM532WH/J2TpBstI3UxoeMA6J3JGQs223qP2wFiT26DlhcVqZWbvUV
        piH8jEXECZeyw6GfypLGPBJpE0J95SIJyWDLo/s=
X-Google-Smtp-Source: ABdhPJxQyd6p++VVdrc+VCIElHh7OAKBGEu1DMVjtDdHVrymXvYz5gO8S/yrzWrNTOfmo3PLafZiYUyflZdDbA+3vLs=
X-Received: by 2002:a63:164f:: with SMTP id 15mr35359811pgw.175.1622658057211;
 Wed, 02 Jun 2021 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <YLeot94yAaM4xbMY@gmail.com>
In-Reply-To: <YLeot94yAaM4xbMY@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Jun 2021 03:20:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
Message-ID: <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
Subject: Re: kbuild: Ctrl-C of parallel kernel build sometimes corrupts .o.cmd
 files permanently
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 12:50 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> There's a sporadic kbuild bug that's been happening for years, maybe you
> guys can think of where it comes from.
>
> Sometimes when I Ctrl-C a kernel build job, the .o.cmd file becomes
> corrupted and this breaks the build:
>
>
>    kernel/.panic.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.
>
>    ...
>
>    drivers/gpu/drm/.drm_blend.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.
>
> The file was just partially created and didn't get cleaned up:
>
>   kepler:~/tip> ls -l drivers/gpu/drm/.drm_blend.o.cmd.corrupted drivers/gpu/drm/.drm_blend.o.cmd.good
>   -rw-rw-r-- 1 mingo mingo 28672 Jun  2 17:46 drivers/gpu/drm/.drm_blend.o.cmd.corrupted
>   -rw-rw-r-- 1 mingo mingo 51331 Jun  2 17:46 drivers/gpu/drm/.drm_blend.o.cmd.good
>
> The file just got cut in half due to the Ctrl-C:
>
>  --- drivers/gpu/drm/.drm_blend.o.cmd.corrupted  2021-06-02 17:46:16.951428326 +0200
>  +++ drivers/gpu/drm/.drm_blend.o.cmd.good       2021-06-02 17:46:34.391111668 +0200
>  @@ -646,4 +646,578 @@ deps_drivers/gpu/drm/drm_blend.o := \
>       $(wildcard include/config/OF_OVERLAY) \
>     include/linux/kobject.h \
>       $(wildcard include/config/UEVENT_HELPER) \
>  -    $(wildcard include
>  \ No newline at end of file
>  +    $(wildcard include/config/DEBUG_KOBJECT_RELEASE) \
>  +  include/linux/sysfs.h \
>  +  include/linux/kernfs.h \
>  +    $(wildcard include/config/KERNFS) \
>
>
> ... but once in this state it can only be fixed by 'make clean' (which
> loses all build progress), or by removing the stale file manually.
>
> It happens more frequently on systems with a lot of CPUs.
>
> Thanks,
>
>         Ingo



Hmm, I have not observed this.

My expectation is, it should work like this:

When scripts/basic/fixdep is interrupted (or fail due to any reason),
partially written *.o.cmd is left over. So, having incomplete *.o.cmd
files is expectation.

When .DELETE_ON_ERROR is specified, GNU Make is supposed to
automatically delete the target on any error.
(If it is interrupted, it should exit with code 130)

On the next invocation of Make, Kbuild will not include .*.o.cmd files
whose corresponding *.o files do not exist.





When you got the corrupted drivers/gpu/drm/.drm_blend.o.cmd,
didn't you see the log
Deleting file 'drivers/gpu/drm/drm_blend.o' ?



If it works as I expect, the log should look like follows:
(I marked  the lines with '<---- Deleting')



  CC      security/keys/keyctl_pkey.o
  CC      kernel/sys.o
  CC      arch/x86/power/hibernate_64.o
^Cmake[5]: *** Deleting file 'drivers/video/fbdev/core/fbcmap.o'  <---- Deleting
make[5]: *** [scripts/Makefile.build:272:
drivers/video/fbdev/core/fbmon.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: security/selinux/nlmsgtab.o] Interrupt
make[2]: *** [scripts/Makefile.build:272: arch/x86/power/cpu.o] Interrupt
make[2]: *** [scripts/Makefile.build:272:
arch/x86/power/hibernate_64.o] Interrupt
make[2]: *** [scripts/Makefile.build:272: arch/x86/pci/legacy.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: arch/x86/mm/srat.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: drivers/pnp/resource.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: drivers/pnp/manager.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: sound/core/ctljack.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: net/core/skbuff.o] Interrupt
make[2]: *** [scripts/Makefile.build:515: arch/x86/mm] Interrupt
make[2]: *** [scripts/Makefile.build:272: kernel/signal.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: drivers/acpi/device_sysfs.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: drivers/pci/pci.o] Interrupt
make[2]: *** [scripts/Makefile.build:272: kernel/sys.o] Interrupt
make[2]: *** [scripts/Makefile.build:515: net/core] Interrupt
make[2]: *** [scripts/Makefile.build:272: block/blk-ioc.o] Interrupt
make[4]: *** [scripts/Makefile.build:272: arch/x86/events/intel/pt.o] Interrupt
make[2]: *** [scripts/Makefile.build:272: crypto/skcipher.o] Interrupt
make[3]: *** [scripts/Makefile.build:272: security/keys/keyctl_pkey.o] Interrupt
make[2]: *** [scripts/Makefile.build:272: fs/namei.o] Interrupt
make[3]: *** [scripts/Makefile.build:515: arch/x86/events/intel] Interrupt
make[5]: *** [scripts/Makefile.build:272:
drivers/video/fbdev/core/fbcmap.o] Interrupt
make[2]: *** [scripts/Makefile.build:515: arch/x86/events] Interrupt
make[2]: *** [scripts/Makefile.build:515: security/selinux] Interrupt
make[2]: *** [scripts/Makefile.build:272: ipc/mq_sysctl.o] Interrupt
make[2]: *** [scripts/Makefile.build:272: mm/percpu.o] Interrupt
make[2]: *** [scripts/Makefile.build:515: security/keys] Interrupt
make[2]: *** [scripts/Makefile.build:515: sound/core] Interrupt
make[4]: *** [scripts/Makefile.build:515: drivers/video/fbdev/core] Interrupt
make[3]: *** Deleting file 'arch/x86/kernel/nmi.o'        <---- Deleting
make[1]: *** [Makefile:1849: arch/x86/pci] Interrupt
make[2]: *** [scripts/Makefile.build:515: drivers/pnp] Interrupt
make[1]: *** [Makefile:1849: kernel] Interrupt
make[1]: *** [Makefile:1849: fs] Interrupt
make[2]: *** [scripts/Makefile.build:515: drivers/pci] Interrupt
make[1]: *** [Makefile:1849: ipc] Interrupt
make[2]: *** [scripts/Makefile.build:515: drivers/acpi] Interrupt
make[1]: *** [Makefile:1849: security] Interrupt
make[1]: *** [Makefile:1849: crypto] Interrupt
make[1]: *** [Makefile:1849: block] Interrupt
make[1]: *** [Makefile:1849: sound] Interrupt
make[3]: *** [scripts/Makefile.build:272: arch/x86/kernel/ldt.o] Interrupt
make[1]: *** [Makefile:1849: net] Interrupt
make[3]: *** [scripts/Makefile.build:272: arch/x86/kernel/nmi.o] Interrupt
make[1]: *** [Makefile:1849: arch/x86/power] Interrupt
make[3]: *** [scripts/Makefile.build:515: drivers/video/fbdev] Interrupt
make[1]: *** [Makefile:1849: mm] Interrupt
make[2]: *** [scripts/Makefile.build:515: drivers/video] Interrupt
make[1]: *** [Makefile:1849: drivers] Interrupt
make[2]: *** [scripts/Makefile.build:515: arch/x86/kernel] Interrupt
make[1]: *** [Makefile:1849: arch/x86] Interrupt
make: *** [Makefile:351: __build_one_by_one] Interrupt






--
Best Regards


Masahiro Yamada
