Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A195331DFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhBQT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhBQT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:58:13 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 11:57:33 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C70742223B;
        Wed, 17 Feb 2021 20:57:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613591850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrODXuTgsf7zBHPo7frB6zjXgYKZPgqYhct8frc2jWA=;
        b=WaQ5btcIO3kEQG1TsEiitPkRO8ReJRdW7F8w41RnuHZlbUnEvwkNvaXE6VWq96DnE9n2Vz
        8uuooCb2/mg0qkE8OX/fCX8Yz6tYu38odyTxit05e3BeaU/3TiuPEPy9njHEQIweHW9H1t
        7tuwQeuiI92RnDzo0/OPldqHDh24ke8=
From:   Michael Walle <michael@walle.cc>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
Date:   Wed, 17 Feb 2021 20:57:17 +0100
Message-Id: <20210217195717.13727-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YCvYV53ZdzQSWY6w@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> There's no need to keep around a dentry pointer to a simple file that
> debugfs itself can look up when we need to remove it from the system.
> So simplify the code by deleting the variable and cleaning up the logic
> around the debugfs file.

This will generate the following oops on my board (arm64,
freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
debugfs_mount is NULL.

[    0.000000] Linux version 5.11.0-next-20210217-00014-g41e0e92a2d05 (mwalle@mwalle01) (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #69 SMP PREEMPT Wed Feb 17 20:47:10 CET 2021
[..]
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0000000000000000] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.11.0-next-20210217-00013-g960bc30321c0-dirty #68
[    0.000000] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[    0.000000] pc : debugfs_lookup+0x64/0xa0
[    0.000000] lr : debugfs_lookup+0x5c/0xa0
[    0.000000] sp : ffff800011933c90
[    0.000000] x29: ffff800011933c90 x28: 0000000000000000 
[    0.000000] x27: 0000000000000000 x26: 0000000000000001 
[    0.000000] x25: ffff00200016f100 x24: ffff800010f19750 
[    0.000000] x23: ffff80001193d000 x22: ffff800011939948 
[    0.000000] x21: ffff800011bfaf98 x20: ffff00200016f200 
[    0.000000] x19: 0000000000000000 x18: 0000000000000010 
[    0.000000] x17: 0000000000007fff x16: 00000000ffffffff 
[    0.000000] x15: ffffffffffffffff x14: ffff800011939948 
[    0.000000] x13: ffff800091933997 x12: ffff8000119cb670 
[    0.000000] x11: 0000000000000003 x10: ffff8000119b3630 
[    0.000000] x9 : ffff800010102bc4 x8 : 0000000000017fe8 
[    0.000000] x7 : c0000000ffffefff x6 : 0000000000000001 
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 
[    0.000000] x3 : 00000000ffffffff x2 : 0000000000000000 
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000000 
[    0.000000] Call trace:
[    0.000000]  debugfs_lookup+0x64/0xa0
[    0.000000]  debugfs_remove_domain_dir+0x24/0x38
[    0.000000]  irq_domain_update_bus_token+0x6c/0xb8
[    0.000000]  gic_init_bases+0x19c/0x64c
[    0.000000]  gic_of_init+0x188/0x228
[    0.000000]  of_irq_init+0x1a8/0x350
[    0.000000]  irqchip_init+0x20/0x48
[    0.000000]  init_IRQ+0xd4/0x178
[    0.000000]  start_kernel+0x628/0x85c
[    0.000000]  0x0
[    0.000000] Code: 9128a000 9426cd08 b5000073 f94006a0 (f9400013) 
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x34/0x60 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

If I revert this commit, the oops will go away.

-michael
