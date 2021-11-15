Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8A44FE01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhKOE7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhKOE72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:59:28 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A9C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 20:56:18 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id be32so32293169oib.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 20:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q98dyu74MJe5navKxdckyMo+w5gQ0k/mUeimmz+GJ/Y=;
        b=n+WGS0Ni0D+xgVih/OamcGVVp5y/g1euL1JZEA0fdhU11BPaTwraG6eFQFX9Xebe42
         wNdHX/nQ5LT4EJw8+3IntergmBNSTGLDMhZy557vlCe9HdIRilrmdi7blw7resm3invF
         LRKDf6ToHFUyg1lTPyDfo4qf09Dv5GRuWgQVN4Vx950VISxspuonRKx2cjvojI+zrKLg
         m3s38gSeQWnfk0bQK80iN5E74oxhqYPRyptJkYrOaYpyGvZCnrp/QLoO4PwnHRvdfPet
         fhszwEyqocI7k+zeOT+/LuHYVGGEK8n9a6NPXlkvUBr9/kIAEAKoo+FOmMzdhIPsh9Qe
         NcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=q98dyu74MJe5navKxdckyMo+w5gQ0k/mUeimmz+GJ/Y=;
        b=Qql60Pl+Mur1O3OJcNtnnRb/j89Zhqtvhqa2LZjuCU4mEzwzK31PtlhVw8Gdx8GNID
         iEX7QE9lyxvi7UyY5UOmeEoEihGkB1xBvq3fGXirib4AwxOdk3ZpzuWo01AO2E2ioYUM
         6+wEXleOY7Kl4ZJ07rJoC3jCwglvFHEB7LP4Ak1me7a4WktmYCYrtxjmXBctcMmv9Tc0
         8n7ZEgSRwTtnJdYzuq6+axdzV3HMW8nrBO3f6n6qE6HzDnq7unWfMhbyOhkBTTGenhtv
         HL1PGlvJUJMM/1eBupA/f/WvfuIa0E+Cw5+UKM3ptx9QI+Dk68OY7mxVBe5Uwka4aknl
         g5VA==
X-Gm-Message-State: AOAM53030acAA+0vtdnBwRjfL5MMbOeH0mRfw3ArRSfUHcOEJcH3fEDI
        kymCTsv6TWsG+oiSMLb30hVGHek1yqU=
X-Google-Smtp-Source: ABdhPJywoFfmeOAXu4lKAgkDverrd1RwKqApbMFzuiVZJTDoubS/DDsC0d472DIHe383xH03bFcdNQ==
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr33170390oic.48.1636952178268;
        Sun, 14 Nov 2021 20:56:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w19sm1841837oik.58.2021.11.14.20.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 20:56:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 14 Nov 2021 20:56:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.16-rc1
Message-ID: <20211115045616.GA1012538@roeck-us.net>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 02:28:55PM -0800, Linus Torvalds wrote:
> It's been two weeks, and the merge window is thus closed.
> 
> I actually anticipated more problems during the merge window than we
> hit - I was traveling with a laptop for a few days early on in the
> merge window, and that's usually fairly painful. But - knock wood - it
> all worked out fine. Partly thanks to a lot of people sending in their
> pull requests fairly early, so that I could get a bit of a head start
> before travels. But partly also because I didn't end up having any
> "uhhuh, things aren't working and now I need to bisect where they
> broke" events for me on any of my machines. At least yet.
> 
> So who knows? Maybe this will be one of those painless releases where
> everything just works.
> 

I don't think so.

Build results:
	total: 153 pass: 141 fail: 12
Failed builds:
	arm:allmodconfig
	arm64:allmodconfig
	csky:defconfig
	csky:allmodconfig
	mips:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	powerpc:ppc6xx_defconfig
	riscv32:allmodconfig
	riscv:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 482 pass: 436 fail: 46
Failed tests:
	<all mips>
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,ne2k_pci:initrd
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,pcnet:ide:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000:sdhci:mmc:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,e1000e:nvme:rootfs
	ppc64:mac99:ppc64_book3s_defconfig:smp:net,virtio-net:scsi[DC395]:rootfs
	<all sheb>
	<all sparc32>
	<all xtensa>

Various compile errors:

arm:allmodconfig
arm64:allmodconfig
riscv32:allmodconfig
riscv64:allmodconfig
s390:allmodconfig

In function 'memcmp',
    inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
include/linux/fortify-string.h:263:25: error:
	call to '__read_overflow' declared with attribute error: detected read beyond size of object

csky:defconfig
sparc64:allmodconfig

fs/netfs/read_helper.c: In function 'netfs_rreq_unlock':
fs/netfs/read_helper.c:435:25: error: implicit declaration of function 'flush_dcache_folio'

mips:allmodconfig

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

parisc:allmodconfig

arch/parisc/include/asm/jump_label.h: In function 'arch_static_branch':
arch/parisc/include/asm/jump_label.h:18:18: error: expected ':' before '__stringify'

and other similar errors.

drivers/gpu/drm/msm/msm_drv.h:531: error: "COND" redefined
arch/parisc/include/asm/assembly.h:37: note: this is the location of the previous definition

powerpc:allmodconfig

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes

powerpc:ppc6xx_defconfig

arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: In function 'mcu_remove':
arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c:189:13: error: unused variable 'ret'

With gcc 5.4, mips:mapta_defconfig

mips-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’

Various powerpc qemu builds:

arch/powerpc/mm/slice.c: In function ‘slice_get_unmapped_area’:
arch/powerpc/mm/slice.c:639:1: error: the frame size of 1056 bytes is larger than 1024 bytes

sheb, gcc-6.3.0:

sh4eb-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’

sparc32, gcc 6.5.0:

sparc64-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’

xtensa, gcc 6.3.0 and gcc 6.4.0:

xtensa-linux-gcc.br_real: error: unrecognized command line option ‘-Wimplicit-fallthrough=5’

Some of those, like the kasan and the mips build errors, have been fixed
in -next. The "unrecognized command line option" is brand new. I did not
have time to look into the others. From a testing perspective this release
was a nightmare: at times there were more than 100 qemu boot test failures
in my tests. Ultimately that means that bisectability will be limited.

Not that it helps, but yesterday the situation looked much better than
today.

Guenter
