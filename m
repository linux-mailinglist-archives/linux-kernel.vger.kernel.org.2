Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207EE34B9FE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhC0Wle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhC0WlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:41:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B8C0613B1;
        Sat, 27 Mar 2021 15:41:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m13so9459395oiw.13;
        Sat, 27 Mar 2021 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tIonhQ6jSherPdEgkHRqjapY1quzFLfyJgucWcfEOu0=;
        b=Mc3UqeFUHHwfeZmTjqQUxNL6OmN/P60CIYzcZW5Itg4em3Bnaz/9UWmfe+jZv4SBuQ
         yjOBaWASb64hEakq0dfLDrUj3msg6FBBzd4cmmwJWYtCJbBgKw1WfuIZPD9peRypMe8t
         0d/fogrCpL7QEhxeOCDQdn4+p1XfRjVQ06Sdxn9FvTBLjLcwvUm6cIBzeCvDcIZWYCZt
         xAE/6W4JLqj6KlwzR/6SPqlRUEc+ubR3pd8W7/Cj0lHvZ/2f8JskJzv9+l9BWPakNYrC
         KalBneB8J1cW8rp0T2ZyL7+4rwX3cYM+ewdv7qz3Tj/IhUQqoweXNYaDT244PCtWEPRm
         V8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=tIonhQ6jSherPdEgkHRqjapY1quzFLfyJgucWcfEOu0=;
        b=P6bIy2lLjWx5LYNIHlaDyoQXIVRU6Bdg2ggj2FJeEVQdWm9x4DV1nwWzvz/OmQu3ar
         zyIHM97+EAe8xAgEMssCnMoPWWzx/qJTkV3nxCS19G13UfVfNxfh+NPhmQjQBHsjvJYH
         xMnjWgnEQqxGBm54WQazc+lqsYO5w56SfMD7L+jORE7R9+Vlsw70lW0shhpnfQY6xWGd
         P2U4Gc7D0Vu5WU8kRFYeK/pwTGEDfrTkkKxqyZIKiLb8L0QgRWN5X0aoNRymBh4aYTSD
         qAqVcPyqa+j/sZDuatDVcZG4I7jUHY4ynVdTSfHnEzYrByw2Cke2kJdKMh/ApHgJIXfK
         BR1w==
X-Gm-Message-State: AOAM533Em11eZt/JHgLruQSqi/shpU7kW3SoYxNLKYCcVQzWvSxkxawQ
        RnAlGvzZ7s70yvui+RZedoo=
X-Google-Smtp-Source: ABdhPJxlaa1w08naiwZxeYBB50j5joGO2/ft9mX+pcGzSP569fwrgGkCUUn1EKYQn/LreIbvAMCNwg==
X-Received: by 2002:a05:6808:1392:: with SMTP id c18mr14588047oiw.176.1616884879259;
        Sat, 27 Mar 2021 15:41:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18sm3199740otf.2.2021.03.27.15.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Mar 2021 15:41:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] of/fdt: Improve error checking
Date:   Sat, 27 Mar 2021 15:41:16 -0700
Message-Id: <20210327224116.69309-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an unaligned pointer is passed to of_fdt_unflatten_tree(),
populate_node() as called from unflatten_dt_nodes() will fail.
unflatten_dt_nodes() will return 0 and set *nodepp to NULL.
This is not expected to happen in __unflatten_device_tree(),
which then tries to write into the NULL pointer, causing a crash
on openrisc if CONFIG_OF_UNITTEST=y.

 ### dt-test ### start of unittest - you will see error messages
Unable to handle kernel NULL pointer dereference
 at virtual address 0x00000064

Oops#: 0000
CPU #: 0
   PC: c03a25d4    SR: 0000807f    SP: c102dd50
GPR00: 00000000 GPR01: c102dd50 GPR02: c102dd78 GPR03: c1704004
GPR04: 00000000 GPR05: c102dc18 GPR06: c102ddc8 GPR07: c102dcf7
GPR08: 00000001 GPR09: c03a25a0 GPR10: c102c000 GPR11: c16fd75c
GPR12: 0000ffb7 GPR13: 00000000 GPR14: 00000008 GPR15: 00000000
GPR16: c16fd75c GPR17: 00000064 GPR18: c1704004 GPR19: 00000004
GPR20: 00000000 GPR21: 00000000 GPR22: c102ddc8 GPR23: 00000018
GPR24: 00000001 GPR25: 00000010 GPR26: c16fd75c GPR27: 00000008
GPR28: deadbeef GPR29: 00000000 GPR30: c0720128 GPR31: 00060000
  RES: c16fd75c oGPR11: ffffffff
Process swapper (pid: 1, stackpage=c1028ba0)

Stack:
Call trace:
[<(ptrval)>] __unflatten_device_tree+0xe0/0x184
[<(ptrval)>] of_fdt_unflatten_tree+0x60/0x90
[<(ptrval)>] of_unittest+0xb4/0x3614
[<(ptrval)>] ? __kernfs_create_file+0x130/0x188
[<(ptrval)>] ? sysfs_add_file_mode_ns+0x13c/0x288
[<(ptrval)>] ? of_unittest+0x0/0x3614
[<(ptrval)>] ? lock_is_held_type+0x160/0x20c
[<(ptrval)>] ? of_unittest+0x0/0x3614
[<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
[<(ptrval)>] do_one_initcall+0x98/0x340
[<(ptrval)>] ? parse_args+0x220/0x4e4
[<(ptrval)>] ? lock_is_held_type+0x160/0x20c
[<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
[<(ptrval)>] ? rcu_read_lock_sched_held+0x34/0x88
[<(ptrval)>] kernel_init_freeable+0x1c0/0x240
[<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
[<(ptrval)>] ? kernel_init+0x0/0x154
[<(ptrval)>] kernel_init+0x1c/0x154
[<(ptrval)>] ? calculate_sigpending+0x54/0x64
[<(ptrval)>] ret_from_fork+0x1c/0x150

This problem affects all architectures with a 4-byte memory alignment.
Since commit 79edff12060f ("scripts/dtc: Update to upstream version
v1.6.0-51-g183df9e9c2b9"), devicetree code in the Linux kernel mandates
an 8-byte memory alignment of devicetree pointers, but it does not take
into account that functions such as kmalloc() or kmemdup() may not return
accordingly aligned pointers.

To fix the immediate crash, check if *mynodes is NULL in
__unflatten_device_tree() before writing into it.

Also affected by this problem is the code calling of_fdt_unflatten_tree().
That code checks for errors using the content of the mynodes pointer,
which is not set by the devicetree code if the alignment problem is
observed. Result is that the callers of of_fdt_unflatten_tree() check
if an uninitialized pointer is set to NULL. Preinitialize that pointer
to avoid the problem.

With this code in place, devicetree code on openrisc (and any other
architecture with 4-byte memory alignment) will still not work properly,
but at least it won't crash anymore. The resulting log message is

 ### dt-test ### start of unittest - you will see error messages
 ### dt-test ### unittest_data_add: No tree to attach; not running tests

when trying to run devicetree unittests.

Fixes: 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/of/fdt.c      | 2 +-
 drivers/of/overlay.c  | 2 +-
 drivers/of/unittest.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a..ab95fdb4461d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -415,7 +415,7 @@ void *__unflatten_device_tree(const void *blob,
 		pr_warn("End of tree marker overwritten: %08x\n",
 			be32_to_cpup(mem + size));
 
-	if (detached && mynodes) {
+	if (detached && mynodes && *mynodes) {
 		of_node_set_flag(*mynodes, OF_DETACHED);
 		pr_debug("unflattened tree is detached\n");
 	}
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 50bbe0edf538..e12c643b6ba8 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1017,7 +1017,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	const void *new_fdt;
 	int ret;
 	u32 size;
-	struct device_node *overlay_root;
+	struct device_node *overlay_root = NULL;
 
 	*ovcs_id = 0;
 	ret = 0;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index eb100627c186..5dc4d2378bfd 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1408,7 +1408,7 @@ static void attach_node_and_children(struct device_node *np)
 static int __init unittest_data_add(void)
 {
 	void *unittest_data;
-	struct device_node *unittest_data_node, *np;
+	struct device_node *unittest_data_node = NULL, *np;
 	/*
 	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
 	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
-- 
2.17.1

