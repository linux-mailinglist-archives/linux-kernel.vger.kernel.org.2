Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96950411608
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhITNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhITNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:45:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:44:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s69so17247009oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugZ3mOISe1bB3KTcfcAf8AXSxAmMIw6ehmJklg0PAD8=;
        b=QpdEpMIAFasHjJYywPNq253rOM3iQIC1ka9kuJrZtjtTXahkk1mCxTGBDlz4+1sR+f
         FTbNjKCR+g0Zug8smgzjx+2YGmh26cYh4b/uE+WumdTGY28V97gp4FcwdTttxj0vhBDv
         NHqQn3IrmdEqrS+uIZBZlGPg1FTSbzWyd2kUx7Ek8q6zbbDS8itNqwPySBUD3GluUqZF
         /PjN/iyF8/zKEeSoMxLrAhy3v4Aucrslq/SJoyufJ2RdBA3s0XIndRq1yyqbfOIXWGV6
         A5lCp6tU6fZTVGe0xJ1iv1jsSw4oM5wwoCEZSqyCqqh+LRHdVRwn+CDR9n+qcBGehN28
         jsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ugZ3mOISe1bB3KTcfcAf8AXSxAmMIw6ehmJklg0PAD8=;
        b=k3PIp+wu93eRQuToNJA3lpoRmqcEr6S7p/w1OZynZm1BHYDnm4NpmGLn7b3iJDo7Kr
         //WDGa3m54g0fE7Ui4gk5hZ4FopWwY82t4pr/lgg6x/QHszgvNOdUHYOdG49ydodjl/r
         +cqENE2jRgAL3xosbVKkbf8mcz+lIzm8ltZdybiTqPN9xo315FBdsdebOhPesXsZglIN
         9yV8n6kLWhQNtDKKTeFMQOLWKTSAZixW4HsAkYiWE+R1iBFAc3Lf0rw70d9Oo5FMQD6c
         eZdiOjDXIwlosCNwNnodncC5i/j1gXgCB5gr4QdGCpOyDVVbS2T+AI+bPj6klHxl8gxk
         q+IA==
X-Gm-Message-State: AOAM532xqPsYxb+GyibmZQmhNXgaJM7p3MR8oyAfLLL8H3wzidFNzkuc
        9CyRlUkGei5BejjpIgH/tBQtjX/d86U=
X-Google-Smtp-Source: ABdhPJw1pWQS+Q1ng/3Rb8xpm5bdTWfPhyE8pO7y4+j7LpGZdZbdXKVffuKRarALHwCh1Rt40xx+eA==
X-Received: by 2002:a05:6808:1481:: with SMTP id e1mr12878841oiw.5.1632145466357;
        Mon, 20 Sep 2021 06:44:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8sm3426410ooc.21.2021.09.20.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:44:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Sep 2021 06:44:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc2
Message-ID: <20210920134424.GA346531@roeck-us.net>
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 05:40:42PM -0700, Linus Torvalds wrote:
[ ... ]
> 
> Go test, and keep the reports coming,
> 

Build results:
	total: 153 pass: 148 fail: 5
Failed builds:
	mips:allmodconfig
	parisc:allmodconfig
	sparc64:allnoconfig
	sparc64:tinyconfig
	xtensa:allmodconfig
Qemu test results:
	total: 480 pass: 479 fail: 1
Failed tests:
	sparc64:sun4u:nodebug:smp:virtio-pci:net,i82559er:hd

Details for build failures below. Several improvements since last week,
but it looks like the alpha related pci_iounmap patches still need some
tweaking (see error log at the very end).

Guenter

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
	No response as of 9/20

---
drivers/scsi/ncr53c8xx.c:8000:26: error: 'retrieve_from_waiting_list' defined but not used

Affected builds:
	parisc:allmodconfig

Patch:
	https://lore.kernel.org/r/YTfS/LH5vCN6afDW@ls3530

Status:
	Applied to 5.15/scsi-fixes

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

---
arch/sparc/lib/iomap.c:22:6: error: redefinition of 'pci_iounmap'
   22 | void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
      |      ^~~~~~~~~~~
In file included from arch/sparc/include/asm/io_64.h:11,
                 from arch/sparc/include/asm/io.h:5,
                 from include/linux/io.h:13,
                 from include/linux/pci.h:39,
                 from arch/sparc/lib/iomap.c:5:
include/asm-generic/pci_iomap.h:54:20: note: previous definition of 'pci_iounmap' was here
   54 | static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)

Affected builds:
	sparc64:allnoconfig, sparc64:tinyconfig
