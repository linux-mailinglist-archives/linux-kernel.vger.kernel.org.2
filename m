Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3C456E62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhKSLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhKSLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n29so17588321wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikSCEchi+3cxIon3kQZpPwsUWEn4hTLf9NrVGKkU7xg=;
        b=cuDltTDH79M1Y2EiIDFF8ehbm60n3mXFaAiSdM4dmD+7lgEFU+uNDfv4rhO/VF1wZ5
         i/mPk+WFIu4bXStPTmVZARSrcvmHMb5TS1228vknaY+v1kF6CnD9coHQFVEzwAtLN6Xd
         +s2FzsN3mTAyO6hOg/UCm6xQGLlWoBP9nnaICKEvKMFXEQWivOrNmBm6jxc8GDWfFk8R
         Q5j2w0ab1aLKMqvn/p4SjeC14XhaEoESYm13GqjLpKnAjstOJkiaWtEVmN9zWSx2eYK9
         E5VIE6MQWaXjiyOARTriwjnASRPZ0wz798YKt+/WLKy8G6CCQg8zMwi39mu+9RQgwaWO
         OHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikSCEchi+3cxIon3kQZpPwsUWEn4hTLf9NrVGKkU7xg=;
        b=I7QyHy4pg8jNRJ1uf37sdozQv7qJKGvKxYOfYj9p5hdH1Ptzh4iD16UAGkqgYPtQyh
         3hBKOF7xUv14JgYNtiS7xdPk0b+tJvEdTfq/buH8kD2suTYySMA4WkdzgqCe3JPWa5+f
         0VbkMjMOa7PjbONDa6cPspiaPQmJsKHMa1QONDwmP2Oaevwpo7f6AGvzyQbIyn4VNfi2
         OtLQoNkvwIIt+zZBL6BCWTF7y1rtlMlusM+yMF/Svsw71qKjboRy4aWHevmH6DyFADlV
         498QE4A8fS/QYnxYOVx+HsX4mISILVxJxfM9sJHksO0mcsuuDBoWE46ilZRx9tOVUUl0
         l+7g==
X-Gm-Message-State: AOAM530z7ciMayDVxouSBpmEwc7GDlbki7b20xybG4ooLG0J5YMBCK9z
        TKmxJisTNPvePyX93iIK07d+faO4JYPI0g==
X-Google-Smtp-Source: ABdhPJzga/uw114VuWEJwthO+MVup+GsQxrIi+yQQzV0rbIk76zumKEMoHqbdNPpS1/AorOXEhIYAw==
X-Received: by 2002:adf:e44d:: with SMTP id t13mr6249393wrm.371.1637321837024;
        Fri, 19 Nov 2021 03:37:17 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:16 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 08/17] linux/offsetof.h: Move offsetof(T, m) to a separate header
Date:   Fri, 19 Nov 2021 12:36:36 +0100
Message-Id: <20211119113644.1600-9-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching files so used for the kernel,
forces 'make' to recompile most of the kernel.

Having those definitions in more granular files
helps avoid recompiling so much of the kernel.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/arm_ffa.h                       |  1 +
 include/linux/blk_types.h                     |  1 +
 include/linux/can/core.h                      |  1 +
 include/linux/container_of.h                  |  1 +
 include/linux/crash_core.h                    |  1 +
 include/linux/f2fs_fs.h                       |  1 +
 include/linux/filter.h                        |  1 +
 include/linux/fs.h                            |  1 +
 include/linux/ieee80211.h                     |  1 +
 include/linux/kbuild.h                        |  3 +++
 include/linux/kvm_host.h                      |  1 +
 include/linux/libata.h                        |  1 +
 include/linux/llist.h                         |  1 +
 include/linux/mlx5/device.h                   |  1 +
 include/linux/mlx5/driver.h                   |  1 +
 include/linux/mm_types.h                      |  1 +
 include/linux/netdevice.h                     |  1 +
 include/linux/nvme-fc.h                       |  2 ++
 include/linux/offsetof.h                      | 16 ++++++++++++++++
 include/linux/rcupdate.h                      |  1 +
 include/linux/sched/task.h                    |  1 +
 include/linux/skb_array.h                     |  1 +
 include/linux/skbuff.h                        |  1 +
 include/linux/slab.h                          |  1 +
 include/linux/spinlock_types.h                |  1 +
 include/linux/stddef.h                        |  8 +-------
 include/linux/string.h                        |  1 +
 include/linux/surface_aggregator/serial_hub.h |  1 +
 include/linux/swap.h                          |  1 +
 include/linux/ti-emif-sram.h                  |  1 +
 include/linux/vdpa.h                          |  1 +
 include/linux/virtio_config.h                 |  1 +
 include/linux/wireless.h                      |  2 ++
 33 files changed, 52 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/offsetof.h

diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 85651e41ded8..e6e4c96018d2 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/offsetof.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index fe065c394fff..2515a329811c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,6 +10,7 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
+#include <linux/offsetof.h>
 
 struct bio_set;
 struct bio;
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 5fb8d0e3f9c1..945853463289 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -15,6 +15,7 @@
 #define _CAN_CORE_H
 
 #include <linux/can.h>
+#include <linux/offsetof.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 
diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 082188b5cd29..45aa73f5e392 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -5,6 +5,7 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/memberof.h>
+#include <linux/offsetof.h>
 
 
 /**
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..3802410ed61d 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <linux/offsetof.h>
 
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d445150c5350..411213cb771c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_F2FS_FS_H
 #define _LINUX_F2FS_FS_H
 
+#include <linux/offsetof.h>
 #include <linux/pagemap.h>
 #include <linux/types.h>
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 24b7ed2677af..3b6bd782e1d6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -17,6 +17,7 @@
 #include <linux/set_memory.h>
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
+#include <linux/offsetof.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..90077f100579 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/offsetof.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 11d7af260f20..ee9c68833c8d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
+#include <linux/offsetof.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
diff --git a/include/linux/kbuild.h b/include/linux/kbuild.h
index e7be517aaaf6..cfe4c02f6167 100644
--- a/include/linux/kbuild.h
+++ b/include/linux/kbuild.h
@@ -2,6 +2,9 @@
 #ifndef __LINUX_KBUILD_H
 #define __LINUX_KBUILD_H
 
+#include <linux/offsetof.h>
+
+
 #define DEFINE(sym, val) \
 	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9e0667e3723e..289778b9e6fa 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -29,6 +29,7 @@
 #include <linux/refcount.h>
 #include <linux/nospec.h>
 #include <linux/notifier.h>
+#include <linux/offsetof.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2a8404b26083..ae6b043011eb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -23,6 +23,7 @@
 #include <linux/cdrom.h>
 #include <linux/sched.h>
 #include <linux/async.h>
+#include <linux/offsetof.h>
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..aa04f80cf37b 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -50,6 +50,7 @@
 
 #include <linux/atomic.h>
 #include <linux/container_of.h>
+#include <linux/offsetof.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 9c25edfd59a6..e4e5dbbbb45e 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -33,6 +33,7 @@
 #ifndef MLX5_DEVICE_H
 #define MLX5_DEVICE_H
 
+#include <linux/offsetof.h>
 #include <linux/types.h>
 #include <rdma/ib_verbs.h>
 #include <linux/mlx5/mlx5_ifc.h>
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a623ec635947..da3cb7f10fe3 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -49,6 +49,7 @@
 #include <linux/notifier.h>
 #include <linux/refcount.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/offsetof.h>
 
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/doorbell.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bb8c6f5f19bc..d93f3606cfcc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -11,6 +11,7 @@
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
+#include <linux/offsetof.h>
 #include <linux/uprobes.h>
 #include <linux/rcupdate.h>
 #include <linux/page-flags-layout.h>
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3ec42495a43a..ca45dda19890 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -25,6 +25,7 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
+#include <linux/offsetof.h>
 #include <linux/prefetch.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>
diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
index 51fe44e0328b..02ac9c80fc1a 100644
--- a/include/linux/nvme-fc.h
+++ b/include/linux/nvme-fc.h
@@ -11,6 +11,8 @@
 #ifndef _NVME_FC_H
 #define _NVME_FC_H 1
 
+#include <linux/offsetof.h>
+
 #include <uapi/scsi/fc/fc_fs.h>
 
 #define NVME_CMD_FORMAT_ID		0xFD
diff --git a/include/linux/offsetof.h b/include/linux/offsetof.h
new file mode 100644
index 000000000000..d0e2f1c34aae
--- /dev/null
+++ b/include/linux/offsetof.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OFFSETOF_H
+#define _LINUX_OFFSETOF_H
+
+#include <linux/compiler_types.h>
+
+
+#undef offsetof
+#ifdef __compiler_offsetof
+#define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
+#else
+#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
+#endif
+
+
+#endif  /* _LINUX_OFFSETOF_H */
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e0beb5c5659..310537479e54 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -29,6 +29,7 @@
 #include <linux/lockdep.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
+#include <linux/offsetof.h>
 
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ba88a6987400..19fecc23d6fd 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -7,6 +7,7 @@
  * functionality:
  */
 
+#include <linux/offsetof.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
diff --git a/include/linux/skb_array.h b/include/linux/skb_array.h
index e2d45b7cb619..2b04a33e5cf5 100644
--- a/include/linux/skb_array.h
+++ b/include/linux/skb_array.h
@@ -20,6 +20,7 @@
 #include <linux/ptr_ring.h>
 #include <linux/skbuff.h>
 #include <linux/if_vlan.h>
+#include <linux/offsetof.h>
 #endif
 
 struct skb_array {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 686a666d073d..9abcc13bede2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -16,6 +16,7 @@
 #include <linux/bug.h>
 #include <linux/bvec.h>
 #include <linux/cache.h>
+#include <linux/offsetof.h>
 #include <linux/rbtree.h>
 #include <linux/socket.h>
 #include <linux/refcount.h>
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 181045148b06..61cb3191566f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -13,6 +13,7 @@
 #define	_LINUX_SLAB_H
 
 #include <linux/gfp.h>
+#include <linux/offsetof.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 2dfa35ffec76..bbef450b7abf 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/spinlock_types_raw.h>
+#include <linux/offsetof.h>
 
 #ifndef CONFIG_PREEMPT_RT
 
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 0fbbaa83a9d8..6ab0f57eccde 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -4,6 +4,7 @@
 
 #include <uapi/linux/stddef.h>
 #include <linux/NULL.h>
+#include <linux/offsetof.h>
 
 
 enum {
@@ -11,13 +12,6 @@ enum {
 	true	= 1
 };
 
-#undef offsetof
-#ifdef __compiler_offsetof
-#define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
-#else
-#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
-#endif
-
 /**
  * sizeof_field() - Report the size of a struct field in bytes
  *
diff --git a/include/linux/string.h b/include/linux/string.h
index b6572aeca2f5..2ddcd560659b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/offsetof.h>
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index c3de43edcffa..95e8f54677ea 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -16,6 +16,7 @@
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
+#include <linux/offsetof.h>
 #include <linux/types.h>
 
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..76b732c6744e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/atomic.h>
+#include <linux/offsetof.h>
 #include <linux/page-flags.h>
 #include <uapi/linux/mempolicy.h>
 #include <asm/page.h>
diff --git a/include/linux/ti-emif-sram.h b/include/linux/ti-emif-sram.h
index 2fc854155c27..611b7d7f4651 100644
--- a/include/linux/ti-emif-sram.h
+++ b/include/linux/ti-emif-sram.h
@@ -17,6 +17,7 @@
 #define __LINUX_TI_EMIF_H
 
 #include <linux/kbuild.h>
+#include <linux/offsetof.h>
 #include <linux/types.h>
 #ifndef __ASSEMBLY__
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index c3011ccda430..1bf977122197 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/offsetof.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/virtio_net.h>
 #include <linux/if_ether.h>
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index ff1752441e5d..87423a50cd13 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -8,6 +8,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_byteorder.h>
 #include <linux/compiler_types.h>
+#include <linux/offsetof.h>
 #include <linux/typeof_member.h>
 #include <uapi/linux/virtio_config.h>
 
diff --git a/include/linux/wireless.h b/include/linux/wireless.h
index 2d1b54556eff..99e9cc56ba01 100644
--- a/include/linux/wireless.h
+++ b/include/linux/wireless.h
@@ -10,6 +10,8 @@
 #ifndef _LINUX_WIRELESS_H
 #define _LINUX_WIRELESS_H
 
+#include <linux/offsetof.h>
+
 #include <uapi/linux/wireless.h>
 
 #ifdef CONFIG_COMPAT
-- 
2.33.1

