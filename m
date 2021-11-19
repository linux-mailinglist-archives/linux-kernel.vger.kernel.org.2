Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF36456E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhKSLlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhKSLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F52C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 133so8236300wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVPyhY98kaZDy81xIhcO8lqE/X6yuYhnt0vCnbF9jg4=;
        b=cbjhxS4bdn7C8DMo+9UxDfsd9ffrsbILongzNVKYHz7NqHt26SmWPO/hNKV7wB8G0E
         qTmgMN9awTqfAXnMs4nGn+efBD3CXnzaIUDp3GiRKhIS0+10r/QO4yEnuNgpylyTOnsF
         XTDh7UcXPYosNs2eFepTfosKW3VhqieuEX0D4jHc2jjraX/030381abA994BPFuKcw1M
         5xTuZGuz1Z0I2micq99+cfzDe8MZ3GdP2PjFwMZLB1s3canMoN0A0zuzR8k+dY4SkPV8
         isdusJAtmMkOalNyb8Gtx0ddUYiqjATYLu4vihwlGd4cEmO6SCB6anyThrKOFAxCeBbH
         0VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVPyhY98kaZDy81xIhcO8lqE/X6yuYhnt0vCnbF9jg4=;
        b=HeLti4KOadOh9qfTs8v76AOxFdGmgCG9YD/c2LgkODbqfqZeXrUiMQkAc3Zdu0kcOa
         vN+of/MSI3PcsidMTeg7T2y5qZBZTzoQQgqlzHPSsRqYmKmjm8Rvo/ISWe4RiCMcgcve
         ZrJLZ+Dcb7IMnkUkzy58uCuxaugIradpUgbapIelKbWQNWIsTuzSA8NpPwZWeh24UqjL
         S9MdtbCnuXIbfnYq7vmNoxdrem8gX/YgmyLsMJY6S+y38ocp/zF1D5hHp2UTc7B5rgul
         2Lg/5q16TQ69XDXGHXicqhfDiKM2Fw79QrAyxWCD6Eq0Vzt6bO49LZ+leM95QjQzes9W
         vALQ==
X-Gm-Message-State: AOAM533NRacCRvuZJ85mt7eE4g7roNXwyrmIpiAZ9ANTelqEBgnAfzPR
        YVSEdob2ybPcww7t+IfkyiimPimAwauTaA==
X-Google-Smtp-Source: ABdhPJwBPM4R5OITaJRmTj3PtiQGIN0roTYMj8LQzOJpklNzRUyhqMlSbMuWWTAtwIuYrugbQUjcWg==
X-Received: by 2002:a1c:9a4f:: with SMTP id c76mr5880206wme.162.1637321844236;
        Fri, 19 Nov 2021 03:37:24 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:23 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 17/17] include/: Include <linux/array_size.h> for ARRAY_SIZE()
Date:   Fri, 19 Nov 2021 12:36:45 +0100
Message-Id: <20211119113644.1600-18-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/crypto/internal/blake2b.h          | 1 +
 include/crypto/internal/blake2s.h          | 1 +
 include/crypto/internal/chacha.h           | 1 +
 include/drm/drm_mipi_dbi.h                 | 1 +
 include/drm/drm_mode_object.h              | 1 +
 include/kunit/test.h                       | 1 +
 include/net/bond_3ad.h                     | 1 +
 include/net/dsa.h                          | 1 +
 include/net/ip_vs.h                        | 1 +
 include/net/netfilter/nf_conntrack_tuple.h | 1 +
 include/net/netfilter/nf_tables.h          | 1 +
 include/net/netlink.h                      | 1 +
 include/rdma/uverbs_ioctl.h                | 1 +
 include/rdma/uverbs_named_ioctl.h          | 1 +
 include/scsi/scsi_host.h                   | 1 +
 include/sound/soc-dapm.h                   | 1 +
 include/sound/soc.h                        | 1 +
 include/trace/events/wbt.h                 | 1 +
 include/uapi/linux/netfilter/xt_sctp.h     | 1 +
 include/xen/hvm.h                          | 1 +
 20 files changed, 20 insertions(+)

diff --git a/include/crypto/internal/blake2b.h b/include/crypto/internal/blake2b.h
index 982fe5e8471c..870561f85a51 100644
--- a/include/crypto/internal/blake2b.h
+++ b/include/crypto/internal/blake2b.h
@@ -9,6 +9,7 @@
 
 #include <crypto/blake2b.h>
 #include <crypto/internal/hash.h>
+#include <linux/array_size.h>
 #include <linux/string.h>
 
 void blake2b_compress_generic(struct blake2b_state *state,
diff --git a/include/crypto/internal/blake2s.h b/include/crypto/internal/blake2s.h
index 8e50d487500f..6d7649759bc9 100644
--- a/include/crypto/internal/blake2s.h
+++ b/include/crypto/internal/blake2s.h
@@ -9,6 +9,7 @@
 
 #include <crypto/blake2s.h>
 #include <crypto/internal/hash.h>
+#include <linux/array_size.h>
 #include <linux/string.h>
 
 void blake2s_compress_generic(struct blake2s_state *state,const u8 *block,
diff --git a/include/crypto/internal/chacha.h b/include/crypto/internal/chacha.h
index b085dc1ac151..0d27df9ecbfa 100644
--- a/include/crypto/internal/chacha.h
+++ b/include/crypto/internal/chacha.h
@@ -5,6 +5,7 @@
 
 #include <crypto/chacha.h>
 #include <crypto/internal/skcipher.h>
+#include <linux/array_size.h>
 #include <linux/crypto.h>
 
 struct chacha_ctx {
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 05e194958265..9ca24caa3f91 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -8,6 +8,7 @@
 #ifndef __LINUX_MIPI_DBI_H
 #define __LINUX_MIPI_DBI_H
 
+#include <linux/array_size.h>
 #include <linux/mutex.h>
 #include <drm/drm_device.h>
 #include <drm/drm_simple_kms_helper.h>
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index c34a3e8030e1..83c1f4eef982 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -23,6 +23,7 @@
 #ifndef __DRM_MODESET_H__
 #define __DRM_MODESET_H__
 
+#include <linux/array_size.h>
 #include <linux/kref.h>
 #include <drm/drm_lease.h>
 struct drm_object_properties;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..6d316249be95 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -12,6 +12,7 @@
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
 
+#include <linux/array_size.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/init.h>
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 38785d48baff..a1fceafcb630 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -7,6 +7,7 @@
 #define _NET_BOND_3AD_H
 
 #include <asm/byteorder.h>
+#include <linux/array_size.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/if_ether.h>
diff --git a/include/net/dsa.h b/include/net/dsa.h
index eff5c44ba377..3d6effe14cca 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -7,6 +7,7 @@
 #ifndef __LINUX_NET_DSA_H
 #define __LINUX_NET_DSA_H
 
+#include <linux/array_size.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/list.h>
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index ff1804a0c469..0abb6706145c 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -10,6 +10,7 @@
 
 #include <asm/types.h>                  /* for __uXX types */
 
+#include <linux/array_size.h>
 #include <linux/list.h>                 /* for struct list_head */
 #include <linux/spinlock.h>             /* for struct rwlock_t */
 #include <linux/atomic.h>               /* for struct atomic_t */
diff --git a/include/net/netfilter/nf_conntrack_tuple.h b/include/net/netfilter/nf_conntrack_tuple.h
index 9334371c94e2..473ba3943b59 100644
--- a/include/net/netfilter/nf_conntrack_tuple.h
+++ b/include/net/netfilter/nf_conntrack_tuple.h
@@ -11,6 +11,7 @@
 #ifndef _NF_CONNTRACK_TUPLE_H
 #define _NF_CONNTRACK_TUPLE_H
 
+#include <linux/array_size.h>
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/nf_conntrack_tuple_common.h>
 #include <linux/list_nulls.h>
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index a0d9e0b47ab8..324f23b7a2c4 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -3,6 +3,7 @@
 #define _NET_NF_TABLES_H
 
 #include <asm/unaligned.h>
+#include <linux/array_size.h>
 #include <linux/list.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nfnetlink.h>
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 7a2a9d3144ba..bc5cdb6d2f99 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -2,6 +2,7 @@
 #ifndef __NET_NETLINK_H
 #define __NET_NETLINK_H
 
+#include <linux/array_size.h>
 #include <linux/types.h>
 #include <linux/netlink.h>
 #include <linux/jiffies.h>
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 23bb404aba12..8d08414ca386 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -6,6 +6,7 @@
 #ifndef _UVERBS_IOCTL_
 #define _UVERBS_IOCTL_
 
+#include <linux/array_size.h>
 #include <rdma/uverbs_types.h>
 #include <linux/uaccess.h>
 #include <rdma/rdma_user_ioctl.h>
diff --git a/include/rdma/uverbs_named_ioctl.h b/include/rdma/uverbs_named_ioctl.h
index ee7873f872c3..1882ce8cb0c2 100644
--- a/include/rdma/uverbs_named_ioctl.h
+++ b/include/rdma/uverbs_named_ioctl.h
@@ -6,6 +6,7 @@
 #ifndef _UVERBS_NAMED_IOCTL_
 #define _UVERBS_NAMED_IOCTL_
 
+#include <linux/array_size.h>
 #include <rdma/uverbs_ioctl.h>
 
 #ifndef UVERBS_MODULE_NAME
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index ebe059badba0..34c453591953 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -2,6 +2,7 @@
 #ifndef _SCSI_SCSI_HOST_H
 #define _SCSI_SCSI_HOST_H
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/types.h>
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c3039e97929a..6585e53a6f9b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_SND_SOC_DAPM_H
 #define __LINUX_SND_SOC_DAPM_H
 
+#include <linux/array_size.h>
 #include <linux/types.h>
 #include <sound/control.h>
 #include <sound/soc-topology.h>
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e6dd8a257c5..4de5c7dbdcd2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_SND_SOC_H
 #define __LINUX_SND_SOC_H
 
+#include <linux/array_size.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 9c66e59d859c..7a8a83d061ed 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_WBT_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_WBT_H
 
+#include <linux/array_size.h>
 #include <linux/tracepoint.h>
 #include "../../../block/blk-wbt.h"
 
diff --git a/include/uapi/linux/netfilter/xt_sctp.h b/include/uapi/linux/netfilter/xt_sctp.h
index b4d804a9fccb..748fedc04228 100644
--- a/include/uapi/linux/netfilter/xt_sctp.h
+++ b/include/uapi/linux/netfilter/xt_sctp.h
@@ -2,6 +2,7 @@
 #ifndef _XT_SCTP_H_
 #define _XT_SCTP_H_
 
+#include <linux/array_size.h>
 #include <linux/types.h>
 
 #define XT_SCTP_SRC_PORTS	        0x01
diff --git a/include/xen/hvm.h b/include/xen/hvm.h
index b7fd7fc9ad41..adac232da84d 100644
--- a/include/xen/hvm.h
+++ b/include/xen/hvm.h
@@ -3,6 +3,7 @@
 #ifndef XEN_HVM_H__
 #define XEN_HVM_H__
 
+#include <linux/array_size.h>
 #include <xen/interface/hvm/params.h>
 #include <asm/xen/hypercall.h>
 
-- 
2.33.1

