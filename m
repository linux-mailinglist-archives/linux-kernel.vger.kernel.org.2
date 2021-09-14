Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6503840AA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhINJNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhINJNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9918760295;
        Tue, 14 Sep 2021 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631610736;
        bh=nRA/AHjgTMxHgowbKHAYAGp8F9pmWjOSvssEv7FfAPo=;
        h=From:To:Cc:Subject:Date:From;
        b=jNfqcdKLWHly1RIdwPJ+Gn64Z37hURjw6TrhdoaC0gcGuoZieq5cf+McCkBZsSLRD
         tBwQjyQMeQgfQZH4iI0alZDi3IUYHmIjRT1M6u36w5y/XpFXzXlmZTrZRt1Lf/hL37
         MM5O/WYDgqcpXMsGe/GsoGwHVr75mxKOBbX9aaR8nHXYgFdGuIg1UHGUmjB0ytU83C
         lzUXv3ltkjAdoM0Y36ExFIg7GmKe+uAmlOUPSHfls7OT9obmUJXnWSCHrkyP58/Nry
         oKudAWbVDYRNnEgaZp+jrHSRq1uzQElwOFvaYSnA9XJ5peZohtas9moHUQx7evRvnd
         Z9d8BWxNMTbLA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH -rc] init: don't panic if mount_nodev_root failed
Date:   Tue, 14 Sep 2021 12:12:10 +0300
Message-Id: <b83c61f6ab34c8f17672d88e0853a9d324c3d48a.1631610487.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Attempt to mount 9p file system as root gives the following kernel panic:

 9pnet_virtio: no channels available for device root
 Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2
 CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc1+ #127
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack_lvl+0x45/0x59
  panic+0x1e2/0x44b
  ? __warn_printk+0xf3/0xf3
  ? free_unref_page+0x2d4/0x4a0
  ? trace_hardirqs_on+0x32/0x120
  ? free_unref_page+0x2d4/0x4a0
  mount_root+0x189/0x1e0
  prepare_namespace+0x136/0x165
  kernel_init_freeable+0x3b8/0x3cb
  ? rest_init+0x2e0/0x2e0
  kernel_init+0x19/0x130
  ret_from_fork+0x1f/0x30
 Kernel Offset: disabled
 ---[ end Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2 ]---

QEMU command line:
 "qemu-system-x86_64 -append root=/dev/root rw rootfstype=9p rootflags=trans=virtio ..."

This error is because root_device_name is truncated in prepare_namespace() from
being "/dev/root" to be "root" prior to call to mount_nodev_root().

As a solution, don't treat errors in mount_nodev_root() as errors that
require panics and allow failback to the mount flow that existed before
patch citied in Fixes tag.

Fixes: f9259be6a9e7 ("init: allow mounting arbitrary non-blockdevice filesystems as root")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
I'm not sure if this is the right thing to do, but it works for me.
---
 init/do_mounts.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2ed30ff6c906..b423ea7dcc6b 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -553,9 +553,6 @@ static int __init mount_nodev_root(void)
 				    root_mount_data);
 		if (!err)
 			break;
-		if (err != -EACCES && err != -EINVAL)
-			panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
-			      root_device_name, fstype, err);
 	}
 
 	free_page((unsigned long)fs_names);
-- 
2.31.1

