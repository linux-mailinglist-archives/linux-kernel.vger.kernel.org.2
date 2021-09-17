Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41BA40EEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbhIQBjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbhIQBjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:39:23 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C3C061574;
        Thu, 16 Sep 2021 18:38:01 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso10753825otr.13;
        Thu, 16 Sep 2021 18:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sbr09wjbDl43jobq4LCfjnblD1bZBQGOnhiX3MEQR/w=;
        b=PpKBaGDANtdEL+sOvVKeef9DPsjNyIaHy5g4XJpcwafhxzTZ9p0z80Ehw4GK7Fw1d8
         CHkvdnpgdgn0EvIYQmV9pPwsZb+lvBJcGeedxQuqnGpaMzdGDR8ofg1fNN2tZcmxUD7L
         AbGGx38v5geFCI7om82T5030h7chsyX2zmdKc2ASJslYFfqav/aliCfHilo0ZfClviie
         Yfir+ZJQvX5mmzQ6GT3aNn1+bVADzvyop05OLTLGV5K8ylBLAeJCZWTkWyZy7R8vp1Q5
         PeNSGqykE7ASuS5qXXueSKNJpfc8jcH6cfjQAc9uMfhavFfm4PEucpMczwkzukkA35Bu
         i++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sbr09wjbDl43jobq4LCfjnblD1bZBQGOnhiX3MEQR/w=;
        b=0oSJ5AIk7Uue/T08NGJS1KEjZk7YsjOS9HgS+lteRsxnZE1oH0PeLsN56DRZLXaYJq
         hSzkmnNgE9OPbEtU40Kl1H976fA3yaCjtHTOPOEkfJPBWhjWCnXaFc8BR3yUMe9yzh4J
         JEDCiVsxp6alcu33YzQGUgXZAaL7fDZ1vvYaJqI2NxIuucFrMNTjCPI5t/ckwlCV909z
         B3kfAGGvMiSj4FGqnJxinQpNWGO7ThJs5l2QmzZL5QCiO0vLhh5NHObyrSGsr8QwH192
         qKBKdK9ftrWpIqSdtf7IwiX3sxAqSwhPYPPxumT1B0Lpi13AWOqejIDYf9pPXC4CMacp
         w50g==
X-Gm-Message-State: AOAM531gKvYCq/FAsCyducb8S4jzdWvz7g5aGD4Kzrtq/FhLLuL6wblg
        8laEZw3s5jqcUc4rXsxHhw4=
X-Google-Smtp-Source: ABdhPJzu0HFfT+regor1fJa8Kb0ZBqQz48QWHApyFLPemlfDMWPP8ldUH+bhwwsyM54s4mo2m+3hyg==
X-Received: by 2002:a9d:7299:: with SMTP id t25mr7197243otj.272.1631842681237;
        Thu, 16 Sep 2021 18:38:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l4sm1052586oth.4.2021.09.16.18.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 18:38:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Sep 2021 18:37:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
Message-ID: <20210917013758.GA2520170@roeck-us.net>
References: <YUNi6hTcS8nUrrpF@ls3530>
 <b3d13e4f-c9cd-495b-5df2-1080ca4d3aa3@roeck-us.net>
 <f3713fe6-2806-9d65-618b-a9d210193e60@infradead.org>
 <26cfe07e-98b0-ec46-9665-01d2f8761c40@roeck-us.net>
 <CAHk-=wh82AyhEQmNoWzqoFQjmwaQ8XiNL3u=knmr844LKkJQTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh82AyhEQmNoWzqoFQjmwaQ8XiNL3u=knmr844LKkJQTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 01:25:32PM -0700, Linus Torvalds wrote:
> On Thu, Sep 16, 2021 at 1:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 9/16/21 1:03 PM, Randy Dunlap wrote:
> > >
> > > Already merged in the net tree.
> >
> > Ah, ok. Sorry for the noise (I already sent that patch).
> 
> Well, I _just_ got the networking pull, so now that particular problem
> is solved in my tree too.
> 
> There's a few more from your list, but I _think_ they are at least
> mostly pending in other trees and patch queues, so I'll ignore them
> unless told otherwise.
> 
> But I've literally set aside this week to just get this mess sorted out.
> 
> Not only do I think it's time to just *fix* these damn warning issues,
> but usually the week after rc1 is somewhat quiet since it takes a
> while for people to find regressions.
> 
> So I have actually spent more time than I would normally consider
> healthy on code that I in any normal situation wouldn't care about at
> all.
> 
> (I realize that Arnd and Guenther are now scoffing at my "normally
> consider healthy" since they have put even more time into this, but
> hey, I usually actively try to avoid reading grotty code in areas I
> don't actually care for).
> 
> So if somebody is aware of some warning situation that still remains
> and doesn't seem to have any movement, please point me at all. Maybe
> we can't force-enable -Wall, but I want us to be really really close.
> 

Let's say the list is getting small enough to be able to keep track.
Below is my current list of -Werror related build errors, as of
v5.15-rc1-164-gbdb575f87217.

Guenter

---
drivers/spi/spi-tegra20-slink.c:1200:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
 1200 | static int tegra_slink_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/spi-tegra20-slink.c:1188:12: error: 'tegra_slink_runtime_suspend' defined but not used [-Werror=unused-function]
 1188 | static int tegra_slink_runtime_suspend(struct device *dev)

Affected builds:
	alpha:allmodconfig
	m68k:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig

Patch:
	https://lore.kernel.org/lkml/20210907045358.2138282-1-linux@roeck-us.net/

Status:
	Applied to
	    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

	[ I hope that doesn't mean we'll have to wait for v5.16 for a fix ]

---
In file included from arch/mips/include/asm/sibyte/sb1250.h:28,
                 from drivers/watchdog/sb_wdog.c:58:
arch/mips/include/asm/sibyte/bcm1480_scd.h:261: error: "M_SPC_CFG_CLEAR" redefined

In file included from arch/mips/include/asm/sibyte/sb1250.h:28,
                 from drivers/watchdog/sb_wdog.c:58:
arch/mips/include/asm/sibyte/bcm1480_scd.h:262: error: "M_SPC_CFG_ENABLE" redefined

Affected builds:
	mips:allmodconfig

Patch:
	https://lore.kernel.org/r/20210913073220.1159520-1-liu.yun@linux.dev

Status:
	Waiting for pull request from Wim

---
drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c: In function 'nvkm_control_mthd_pstate_info':
drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c:60:35: error: overflow in conversion from 'int' to '__s8' {aka 'signed char'} changes value from '-251' to '5' [-Werror=overflow]
   60 |                 args->v0.pwrsrc = -ENOSYS;

Affected builds:
	parisc:allmodconfig

Background:
	args->v0.pwrsrc is s8, -ENOSYS is -251 on parisc

Patch:
	https://lore.kernel.org/lkml/20210908190817.1213486-1-linux@roeck-us.net/

Status:
	No response as of 9/15 (or I missed it)

---
drivers/scsi/ncr53c8xx.c:8000:26: error: 'retrieve_from_waiting_list' defined but not used

Affected builds:
	parisc:allmodconfig

Patch:
	https://lore.kernel.org/r/YTfS/LH5vCN6afDW@ls3530

Status:
	Applied to 5.15/scsi-fixes

---
arch/s390/kernel/syscall.c: In function '__do_syscall':
arch/s390/kernel/syscall.c:168:1: error: '__do_syscall' uses dynamic stack allocation

lib/test_kasan.c: In function 'kasan_alloca_oob_right':
lib/test_kasan.c:782:1: error: 'kasan_alloca_oob_right' uses dynamic stack allocation

lib/test_kasan.c: In function 'kasan_alloca_oob_left':
lib/test_kasan.c:767:1: error: 'kasan_alloca_oob_left' uses dynamic stack allocation 

Affected builds:
	s390:allmodconfig

Background:
	s390 defines a configuration flag to mark dynamic stack allocations as
	warnings. This causes a build failure with -Werror.

Patch:
	https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=fixes&id=f5711f9df9242446feccf2bdb6fdc06a72ca1010

Status:
	Queued in https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git#fixes

---
drivers/video/fbdev/omap2/omapfb/dss/dsi.c: In function 'dsi_dump_dsidev_irqs':
drivers/video/fbdev/omap2/omapfb/dss/dsi.c:1623:1: error: the frame size of 1104 bytes is larger than 1024 bytes

and many similar errors. Seen in xtensa:allmodconfig.

Background:
	xtensa:allmodconfig enables KASAN which in turn increases stack size
	requirements significantly.

Patch:
	https://lore.kernel.org/lkml/20210912025235.3514761-1-linux@roeck-us.net/

Status:
	Queued in https://www.ozlabs.org/~akpm/mmotm/
