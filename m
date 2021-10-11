Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A380D428C60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhJKLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:55:15 -0400
Received: from first.geanix.com ([116.203.34.67]:37358 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234148AbhJKLzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:55:14 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 11810C2CD3;
        Mon, 11 Oct 2021 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633953192; bh=pbRkeukv21LDSj8H7Ux10RpLsbQPs7ZZl4KidK4wSvg=;
        h=From:To:Cc:Subject:Date;
        b=OsjGAR6dpz8i7hOsD+TCN++BHttqyMSMRGpetl+m5Weqs6Wqn70EZ3cO8gd5Yp9pT
         1cCcBdZjibK0cS2ojAn7wGn9xyq+e/y4hqZh2cjhAPXE9Rr/XyiDEHW3gk4hfZKpiT
         t0VqIM2g7uOG0nnh3sCiKA7rxlSBQcxIZE3hT8Tq1wZPmNcqq68N561gTBPuooWiLw
         e1W9d1Yj2Bgfik4hvL3ohZD8F0yMX7n4YkodE67VRzkNFPyxQ/ArQhScyr8hiOau/Z
         xL6mwM5/cpiiwppgq8lbyYoZ/nVZOMm9I96HYezpkY8D9q2huZow7KUkCsZIeN3s9f
         n3tQ8NKs1zZ9w==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mtd: core: protect access to mtd devices while in suspend
Date:   Mon, 11 Oct 2021 13:52:50 +0200
Message-Id: <20211011115253.38497-1-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=4.0 tests=ALL_TRUSTED,BAYES_40,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow-up on discussion in https://lkml.org/lkml/2021/10/4/41

Changes since from rfc v1/v2:
 - added access protection for all device access hooks in mtd_info.
 - added Suggested-by to [1/3] patch.
 - removed refereces to commit ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
   from commit msg as commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") is 
   to be blamed.
 - tested on a kernel with LOCKDEP enabled.

@Miquel: I havn't covered every ioctl, to me it looks like they havn't
direct device access.

One (small) issue still present. gpmi_nand.c uses the rwsem before it's
initialized. Seems cumbersome to have every mtd/nand driver to call
init_waitqueue_head() and init_rwsem(). Could we somehow move the call
to mtd_set_dev_defaults() before nand_create_bbt()?

---
nand: device found, Manufacturer ID: 0x98, Chip ID: 0xdc
nand: Toshiba NAND 512MiB 3,3V 8-bit
nand: 512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 128
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/locking/rwsem.c:1240 down_read+0x160/0x184
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x0, magic = 0x0, owner = 0x0, curr 0xc40b0000, list not empty 
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3-00002-g7eab985fa8cd-dirty #163 
Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[<c010fa90>] (unwind_backtrace) from [<c010b8fc>] (show_stack+0x10/0x14)
[<c010b8fc>] (show_stack) from [<c0b34998>] (dump_stack_lvl+0x58/0x70)
[<c0b34998>] (dump_stack_lvl) from [<c0123884>] (__warn+0xd4/0x154) 
[<c0123884>] (__warn) from [<c0b2e9ac>] (warn_slowpath_fmt+0x94/0xbc)
[<c0b2e9ac>] (warn_slowpath_fmt) from [<c0b428c8>] (down_read+0x160/0x184)
[<c0b428c8>] (down_read) from [<c06df42c>] (mtd_read_oob+0xc8/0x284)
[<c06df42c>] (mtd_read_oob) from [<c06f28cc>] (scan_block_fast+0x78/0xf4) 
[<c06f28cc>] (scan_block_fast) from [<c06f3c14>] (search_bbt+0x268/0x304) 
[<c06f3c14>] (search_bbt) from [<c06f3ef0>] (nand_create_bbt+0x240/0x6dc) 
[<c06f3ef0>] (nand_create_bbt) from [<c06fa758>] (gpmi_nand_probe+0x568/0x6d0)
[<c06fa758>] (gpmi_nand_probe) from [<c068731c>] (platform_probe+0x58/0xb8)
[<c068731c>] (platform_probe) from [<c0684a48>] (really_probe.part.0+0x9c/0x32c)
[<c0684a48>] (really_probe.part.0) from [<c0684d78>] (__driver_probe_device+0xa0/0x138) 
[<c0684d78>] (__driver_probe_device) from [<c0684e40>] (driver_probe_device+0x30/0x10c) 
[<c0684e40>] (driver_probe_device) from [<c0685510>] (__driver_attach+0xb4/0x174) 
[<c0685510>] (__driver_attach) from [<c0682b84>] (bus_for_each_dev+0x78/0xb8) 
[<c0682b84>] (bus_for_each_dev) from [<c0683ea4>] (bus_add_driver+0xf0/0x1d8) 
[<c0683ea4>] (bus_add_driver) from [<c0686270>] (driver_register+0x88/0x118)
[<c0686270>] (driver_register) from [<c0102108>] (do_one_initcall+0x74/0x378) 
[<c0102108>] (do_one_initcall) from [<c1001304>] (kernel_init_freeable+0x2a4/0x348) 
[<c1001304>] (kernel_init_freeable) from [<c0b3bc34>] (kernel_init+0x10/0x124)
[<c0b3bc34>] (kernel_init) from [<c010011c>] (ret_from_fork+0x14/0x38)
Exception stack(0xc40a7fb0 to 0xc40a7ff8) 
7fa0: ???????? ???????? ???????? ???????? 
7fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ???????? 
7fe0: ???????? ???????? ???????? ???????? ???????? ???????? 
irq event stamp: 110936 
hardirqs lastenabled at (110935): [<c0100b04>] __irq_svc+0x64/0x80
hardirqs last disabled at (110936): [<c0100af0>] __irq_svc+0x50/0x80
softirqs lastenabled at (110906): [<c093818c>] netlink_insert+0x60/0x8a4
softirqs last disabled at (110904): [<c08ac6d4>] release_sock+0x18/0x98 
---[ end trace c70a1a8da23b619d ]---
Bad block table found at page 131008, version 0x01
Bad block table found at page 130944, version 0x01
---

Sean Nyekjaer (3):
  mtd: core: protect access to MTD devices while in suspend
  mtd: rawnand: remove suspended check
  mtd: mtdconcat: add suspend lock handling

 drivers/mtd/mtdconcat.c          |  11 ++-
 drivers/mtd/mtdcore.c            | 133 +++++++++++++++++++++++++++----
 drivers/mtd/nand/raw/nand_base.c |  52 +++---------
 include/linux/mtd/mtd.h          | 109 +++++++++++++++++++++----
 include/linux/mtd/rawnand.h      |   5 +-
 5 files changed, 234 insertions(+), 76 deletions(-)

-- 
2.33.0

