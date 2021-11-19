Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E8456E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhKSLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhKSLkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A9FC061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d24so17696960wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Du8HGzrjFn/1BtG+P7A2laTdMVZNhuWPZMoG9vRulZY=;
        b=TrNRXvhf/XVWa3TTGfVEYHfsObafolJl2v/4tyYzKsoOpF6RpipZ/3TuHg0jRuMEfm
         dCeFVeaTmnJ5vU4NHAy7ewxQ4ke2SPt77vhIM6z+fIdZtYMzWBQ8g7Vl53lkoHi2+THs
         1TeW8BCc27XJcJneWXrJVhGmdGlP0zV9xwYVD90xRA5nES/Vo831ozdITb5bbF9qBhn0
         MBlXNndffeuToTuJ/OEgJ+xJJUOEqGXZvYEyaGiGQeU99PTlDKiISpBEgmmnlVucQGjY
         EIa3T8YceKf4tk2qv7eK4e9/0UF2kqU1CVm3FoZczSJFJ/zr2mnzDFtQaX1K93lCfR47
         do6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Du8HGzrjFn/1BtG+P7A2laTdMVZNhuWPZMoG9vRulZY=;
        b=2DDb4nFrwKQzUqxx9c4XKa3Fzs3F0m5FE8Q47dtGoMaK2XfAd/snngoXOfCdA+0fas
         h3ffTrI4M7sYfotDpoOih84FGKREV4EFa0wZmazBDsyUj5A0pha+P+op3rHt7WhlkKHt
         dKCtvRZTCkP8OMm4dO4uVTxzioJaP6FKrVhJlDtWYRVbCR2ryjdKTKgn09A71kgRZ1Iy
         +z6atU/aI9QMtqvuls1dKdAKVkiwlux/62YH2j+eHhG19JkmeHLPsQiprI4A+uqcuWFc
         dm7mTxqqJjbJUvRY2nLenpnJQxfdfPHZJ6gesI5FwHMGy2aL8LRk/USJE4IWTTdnoacP
         vbLg==
X-Gm-Message-State: AOAM533jjsnRsVWMNOnEp59VBNfo0n4oInJ0BFcOq9HBE0tNnGV9CcOI
        Us6jZVQ+TfG6OAARWcEUsk3Mv4awj2o+yw==
X-Google-Smtp-Source: ABdhPJzgygcdwrFvVI7ObgipNF+MwtZ4xdGF9LjVWzCd6pxix50Moptr/qzUberVdzWyTwLGRTXjkw==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr6493531wrx.292.1637321833214;
        Fri, 19 Nov 2021 03:37:13 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:12 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 03/17] Replace some uses of memberof() by its wrappers
Date:   Fri, 19 Nov 2021 12:36:31 +0100
Message-Id: <20211119113644.1600-4-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

offsetof(), sizeof_field(), and typeof_member()
are common wrappers over memberof()
that simplify and make more consistent the code
around memberof().

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 arch/x86/include/asm/bootparam_utils.h |  4 ++--
 arch/x86/kernel/signal_compat.c        |  6 +++---
 drivers/net/ethernet/emulex/benet/be.h | 11 +++++------
 drivers/net/ethernet/i825xx/ether1.c   |  6 +++---
 drivers/scsi/be2iscsi/be.h             | 13 ++++++-------
 drivers/scsi/be2iscsi/be_cmds.h        |  4 ++--
 fs/btrfs/ctree.h                       |  6 +++---
 include/acpi/actypes.h                 |  4 ++--
 include/linux/virtio_config.h          |  8 ++++----
 9 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 71b28b5fb088..728c9245fe33 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_BOOTPARAM_UTILS_H
 
 #include <asm/bootparam.h>
-#include <linux/container_of.h>
+#include <linux/stddef.h>
 
 /*
  * This file is included from multiple environments.  Do not
@@ -20,7 +20,7 @@
  * private magic, so it is better to leave it unchanged.
  */
 
-#define sizeof_mbr(type, member) ({ sizeof(memberof(type, member)); })
+#define sizeof_mbr(type, member) ({ sizeof_field(type, member); })
 
 #define BOOT_PARAM_PRESERVE(struct_member)				\
 	{								\
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 28420a7df056..f8b37577d983 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compat.h>
-#include <linux/container_of.h>
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
+#include <linux/stddef.h>
 
 /*
  * The compat_siginfo_t structure and handing code is very easy
@@ -70,8 +70,8 @@ static inline void signal_compat_build_tests(void)
 	 * structure stays within the padding size (checked
 	 * above).
 	 */
-#define CHECK_CSI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(memberof(compat_siginfo_t ,_sifields.name)))
-#define CHECK_SI_SIZE(name, size)  BUILD_BUG_ON(size != sizeof(memberof(siginfo_t, _sifields.name)))
+#define CHECK_CSI_SIZE(name, size) BUILD_BUG_ON(size != sizeof_field(compat_siginfo_t ,_sifields.name))
+#define CHECK_SI_SIZE(name, size)  BUILD_BUG_ON(size != sizeof_field(siginfo_t, _sifields.name))
 
 	CHECK_CSI_OFFSET(_kill);
 	CHECK_CSI_SIZE  (_kill, 2*sizeof(int));
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index dc790bae2451..1c80d19cf59f 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -14,10 +14,10 @@
 #ifndef BE_H
 #define BE_H
 
-#include <linux/container_of.h>
 #include <linux/pci.h>
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
+#include <linux/stddef.h>
 #include <net/tcp.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -824,8 +824,7 @@ extern const struct ethtool_ops be_ethtool_ops;
 			(size) + (PAGE_SIZE_4K - 1)) >> PAGE_SHIFT_4K))
 
 /* Returns bit offset within a DWORD of a bitfield */
-#define AMAP_BIT_OFFSET(_struct, field)  				\
-		(((size_t)&(memberof(_struct, field)))%32)
+#define AMAP_BIT_OFFSET(_struct, field)  (offsetof(_struct, field) % 32)
 
 /* Returns the bit mask of the field that is NOT shifted into location. */
 static inline u32 amap_mask(u32 bitsize)
@@ -843,8 +842,8 @@ amap_set(void *ptr, u32 dw_offset, u32 mask, u32 offset, u32 value)
 
 #define AMAP_SET_BITS(_struct, field, ptr, val)				\
 		amap_set(ptr,						\
-			offsetof(_struct, field)/32,			\
-			amap_mask(sizeof(memberof(_struct, field))),	\
+			offsetof(_struct, field) / 32,			\
+			amap_mask(sizeof_field(_struct, field)),	\
 			AMAP_BIT_OFFSET(_struct, field),		\
 			val)
 
@@ -857,7 +856,7 @@ static inline u32 amap_get(void *ptr, u32 dw_offset, u32 mask, u32 offset)
 #define AMAP_GET_BITS(_struct, field, ptr)				\
 		amap_get(ptr,						\
 			offsetof(_struct, field)/32,			\
-			amap_mask(sizeof(memberof(_struct, field))),	\
+			amap_mask(sizeof_field(_struct, field)),	\
 			AMAP_BIT_OFFSET(_struct, field))
 
 #define GET_RX_COMPL_V0_BITS(field, ptr)				\
diff --git a/drivers/net/ethernet/i825xx/ether1.c b/drivers/net/ethernet/i825xx/ether1.c
index 4dece3476d31..938b5948883c 100644
--- a/drivers/net/ethernet/i825xx/ether1.c
+++ b/drivers/net/ethernet/i825xx/ether1.c
@@ -28,7 +28,6 @@
  * 1.07	RMK	13/05/2000	Updated for 2.3.99-pre8
  */
 
-#include <linux/containerof.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -37,6 +36,7 @@
 #include <linux/ioport.h>
 #include <linux/in.h>
 #include <linux/slab.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -82,9 +82,9 @@ static char version[] = "ether1 ethernet driver (c) 2000 Russell King v1.07\n";
 #define NORMALIRQS  0
 
 #define ether1_readw(dev, addr, type, offset, svflgs) \
-	ether1_inw_p(dev, addr + (int)(&(memberof(type, offset))), svflgs)
+	ether1_inw_p(dev, addr + offsetof(type, offset), svflgs)
 #define ether1_writew(dev, val, addr, type, offset, svflgs) \
-	ether1_outw_p(dev, val, addr + (int)(&(memberof(type, offset))), svflgs)
+	ether1_outw_p(dev, val, addr + offsetof(type, offset), svflgs)
 
 static inline unsigned short
 ether1_inw_p (struct net_device *dev, int addr, int svflgs)
diff --git a/drivers/scsi/be2iscsi/be.h b/drivers/scsi/be2iscsi/be.h
index 6830e07fd37a..ec44b0d86ae4 100644
--- a/drivers/scsi/be2iscsi/be.h
+++ b/drivers/scsi/be2iscsi/be.h
@@ -10,10 +10,10 @@
 #ifndef BEISCSI_H
 #define BEISCSI_H
 
-#include <linux/container_of.h>
 #include <linux/pci.h>
 #include <linux/if_vlan.h>
 #include <linux/irq_poll.h>
+#include <linux/stddef.h>
 #define FW_VER_LEN	32
 #define MCC_Q_LEN	128
 #define MCC_CQ_LEN	256
@@ -153,8 +153,7 @@ struct be_ctrl_info {
 			(size) + (PAGE_SIZE_4K - 1)) >> PAGE_SHIFT_4K))
 
 /* Returns bit offset within a DWORD of a bitfield */
-#define AMAP_BIT_OFFSET(_struct, field)					\
-		(((size_t)&(memberof(_struct, field)))%32)
+#define AMAP_BIT_OFFSET(_struct, field)  (offsetof(_struct, field) % 32)
 
 /* Returns the bit mask of the field that is NOT shifted into location. */
 static inline u32 amap_mask(u32 bitsize)
@@ -172,8 +171,8 @@ static inline void amap_set(void *ptr, u32 dw_offset, u32 mask,
 
 #define AMAP_SET_BITS(_struct, field, ptr, val)				\
 		amap_set(ptr,						\
-			offsetof(_struct, field)/32,			\
-			amap_mask(sizeof(memberof(_struct, field))),	\
+			offsetof(_struct, field) / 32,			\
+			amap_mask(sizeof_field(_struct, field)),	\
 			AMAP_BIT_OFFSET(_struct, field),		\
 			val)
 
@@ -185,8 +184,8 @@ static inline u32 amap_get(void *ptr, u32 dw_offset, u32 mask, u32 offset)
 
 #define AMAP_GET_BITS(_struct, field, ptr)				\
 		amap_get(ptr,						\
-			offsetof(_struct, field)/32,			\
-			amap_mask(sizeof(memberof(_struct, field))),	\
+			offsetof(_struct, field) / 32,			\
+			amap_mask(sizeof_field(_struct, field)),	\
 			AMAP_BIT_OFFSET(_struct, field))
 
 #define be_dws_cpu_to_le(wrb, len) swap_dws(wrb, len)
diff --git a/drivers/scsi/be2iscsi/be_cmds.h b/drivers/scsi/be2iscsi/be_cmds.h
index bb6ee43769d5..370ca9131090 100644
--- a/drivers/scsi/be2iscsi/be_cmds.h
+++ b/drivers/scsi/be2iscsi/be_cmds.h
@@ -11,7 +11,7 @@
 #define BEISCSI_CMDS_H
 
 
-#include <linux/container_of.h>
+#include <linux/stddef.h>
 
 /**
  * The driver sends configuration and managements command requests to the
@@ -1303,7 +1303,7 @@ struct be_cmd_get_port_name {
 
 /* Returns the number of items in the field array. */
 #define BE_NUMBER_OF_FIELD(_type_, _field_)	\
-	(sizeof_field(_type_, _field_) / sizeof(memberof(_type_, _field_[0])))
+	(sizeof_field(_type_, _field_) / sizeof_field(_type_, _field_[0]))
 
 /**
  * Different types of iSCSI completions to host driver for both initiator
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 442b6f937b22..cbad9202f213 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -6,7 +6,6 @@
 #ifndef BTRFS_CTREE_H
 #define BTRFS_CTREE_H
 
-#include <linux/container_of.h>
 #include <linux/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/highmem.h>
@@ -29,6 +28,7 @@
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
 #include <linux/iomap.h>
+#include <linux/stddef.h>
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -1576,13 +1576,13 @@ static inline void put_unaligned_le8(u8 val, void *p)
 	read_extent_buffer(eb, (char *)(result),			\
 			   ((unsigned long)(ptr)) +			\
 			    offsetof(type, member),			\
-			   sizeof(memberof(type, member))))
+			   sizeof_field(type, member)))
 
 #define write_eb_member(eb, ptr, type, member, result) (\
 	write_extent_buffer(eb, (char *)(result),			\
 			   ((unsigned long)(ptr)) +			\
 			    offsetof(type, member),			\
-			   sizeof(memberof(type, member))))
+			   sizeof_field(type, member)))
 
 #define DECLARE_BTRFS_SETGET_BITS(bits)					\
 u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index c3b0eccb3377..e0bcfd37a005 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -10,7 +10,7 @@
 #ifndef __ACTYPES_H__
 #define __ACTYPES_H__
 
-#include <linux/container_of.h>
+#include <linux/stddef.h>
 
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
@@ -510,7 +510,7 @@ typedef u64 acpi_integer;
 
 #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
-#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(memberof(d, f)), (void *) 0)
+#define ACPI_OFFSET(d, f)               offsetof(d, f)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index a1e656c0d94a..4fd659e26450 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -333,7 +333,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 /* Config space accessors. */
 #define virtio_cread(vdev, structname, member, ptr)			\
 	do {								\
-		typeof(memberof(structname, member)) virtio_cread_v;	\
+		typeof_member(structname, member) virtio_cread_v;	\
 									\
 		might_sleep();						\
 		/* Sanity check: must match the member's type */	\
@@ -362,7 +362,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 /* Config space accessors. */
 #define virtio_cwrite(vdev, structname, member, ptr)			\
 	do {								\
-		typeof(memberof(structname, member)) virtio_cwrite_v =	\
+		typeof_member(structname, member) virtio_cwrite_v =	\
 			cpu_to_virtio(vdev, *(ptr), memberof(structname, member)); \
 									\
 		might_sleep();						\
@@ -397,7 +397,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 /* LE (e.g. modern) Config space accessors. */
 #define virtio_cread_le(vdev, structname, member, ptr)			\
 	do {								\
-		typeof(memberof(structname, member)) virtio_cread_v;	\
+		typeof_member(structname, member) virtio_cread_v;	\
 									\
 		might_sleep();						\
 		/* Sanity check: must match the member's type */	\
@@ -425,7 +425,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 
 #define virtio_cwrite_le(vdev, structname, member, ptr)			\
 	do {								\
-		typeof(memberof(structname, member)) virtio_cwrite_v =	\
+		typeof_member(structname, member) virtio_cwrite_v =	\
 			virtio_cpu_to_le(*(ptr), memberof(structname, member)); \
 									\
 		might_sleep();						\
-- 
2.33.1

