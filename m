Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB91B3F53C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhHWXvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhHWXur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:50:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83025C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:50:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so28609105wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYvM//XflDl5luddIn4dvmOvBEGYHudcWi9V4yu/ZCI=;
        b=Ri3OS9aHcin5L1YNj1K78A1Wes1+F6rh4rvjGdeEaOj4DgHdzSpvPGXBd7TFUT0Q79
         PHBz/mE9WuxUfjVMUYvjtuOL8SSIV1rgT/OTYwSUb00pnj1PSiA3ktu/QY6hXmVrurrL
         kkWCWONy9QE+riYGjF9eaL9G2fsASQNJ1mezpGuO8GULjIzFBFAk+Rfv0I3Qs1x2MUEM
         PTEvBai7XJlsdWCc9ODgD6Kg/CH0uoShdacks6bKBCQQN5JKhU01ilNugC3YtWv99aim
         RFMrmkYZvFN/6DyVwsgdNMl2hcsRbgp9QnM0poe32lc/1sXM9Vb/RvyB5vgf8wdNeYjn
         Dopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYvM//XflDl5luddIn4dvmOvBEGYHudcWi9V4yu/ZCI=;
        b=ik0akdqANcjXcSIwFpUIYBIwtZjrAnILfOCkJ+2F5/Hu8an/QKy/HAy4V3FwYWl80H
         nXIzn52BVsu6R1OHoH0TI0MZIoVTYJiO9YwklZABrkZY+ZIs0ARtenloEYlM8PiYEuCA
         gCyyfygtBU8sz9I5pJquakSaE37NNRGj5msDYEkdIVYU9vZjVFo4/zeo89vIcSS/2MU2
         hDyHiCtaAbWRxvpv6/hIrYGZCsYMrv5c5yB65RjVmNxGp/XsWw7ShFk04cVSiIcaeRjR
         kA6DSzxTflrvvf3xUhyJLWCa1tf25iVOpleKLxKSAFR2DO+fy3qYfrlw3IR0ghxV2F2/
         X19g==
X-Gm-Message-State: AOAM530l0pFBH61DtH2bmJVUxtuDQHJJ78KB0YaDwNvLpT5OOfkrPEMV
        K7xzzl6ZrvSKAewFl+HpvRg=
X-Google-Smtp-Source: ABdhPJynU6MgJ+iDd6CB0wVTd0+GgTBoz6seWsAiO0om4bIGNXumVJXMdRA4LWISlm/sbi9m87NqCA==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr15979962wrm.213.1629762603144;
        Mon, 23 Aug 2021 16:50:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id r4sm562124wmq.34.2021.08.23.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 16:50:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove ip.h header file
Date:   Tue, 24 Aug 2021 01:48:58 +0200
Message-Id: <20210823234858.2633-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823234858.2633-1-straube.linux@gmail.com>
References: <20210823234858.2633-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct ip_options declared in ip.h is only unsed in the optlength
macro which is also defined in ip.h and not used in the driver code.
All other definitions/declarations in ip.h are duplicated from
<include/uapi/linux/ip.h>. Remove the ip.h header file and its includes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      |   1 -
 drivers/staging/r8188eu/core/rtw_xmit.c      |   1 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c |   1 -
 drivers/staging/r8188eu/include/ip.h         | 109 -------------------
 drivers/staging/r8188eu/os_dep/xmit_linux.c  |   1 -
 5 files changed, 113 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/ip.h

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 08066c9587f9..ea42b4954067 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -7,7 +7,6 @@
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
 #include "../include/mlme_osdep.h"
-#include "../include/ip.h"
 #include "../include/ethernet.h"
 #include "../include/usb_ops.h"
 #include "../include/wifi.h"
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f242f3ffca70..38183fd37b93 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -7,7 +7,6 @@
 #include "../include/drv_types.h"
 #include "../include/wifi.h"
 #include "../include/osdep_intf.h"
-#include "../include/ip.h"
 #include "../include/usb_ops.h"
 #include "../include/usb_osintf.h"
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 3a2c7090cd7b..666afa69fce6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -6,7 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
 #include "../include/mlme_osdep.h"
-#include "../include/ip.h"
 #include "../include/ethernet.h"
 
 #include "../include/usb_ops.h"
diff --git a/drivers/staging/r8188eu/include/ip.h b/drivers/staging/r8188eu/include/ip.h
deleted file mode 100644
index b7388c8c1b8a..000000000000
--- a/drivers/staging/r8188eu/include/ip.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef _LINUX_IP_H
-#define _LINUX_IP_H
-
-/* SOL_IP socket options */
-
-#define IPTOS_TOS_MASK		0x1E
-#define IPTOS_TOS(tos)		((tos)&IPTOS_TOS_MASK)
-#define	IPTOS_LOWDELAY		0x10
-#define	IPTOS_THROUGHPUT	0x08
-#define	IPTOS_RELIABILITY	0x04
-#define	IPTOS_MINCOST		0x02
-
-#define IPTOS_PREC_MASK		0xE0
-#define IPTOS_PREC(tos)		((tos)&IPTOS_PREC_MASK)
-#define IPTOS_PREC_NETCONTROL           0xe0
-#define IPTOS_PREC_INTERNETCONTROL      0xc0
-#define IPTOS_PREC_CRITIC_ECP           0xa0
-#define IPTOS_PREC_FLASHOVERRIDE        0x80
-#define IPTOS_PREC_FLASH                0x60
-#define IPTOS_PREC_IMMEDIATE            0x40
-#define IPTOS_PREC_PRIORITY             0x20
-#define IPTOS_PREC_ROUTINE              0x00
-
-/* IP options */
-#define IPOPT_COPY		0x80
-#define IPOPT_CLASS_MASK	0x60
-#define IPOPT_NUMBER_MASK	0x1f
-
-#define	IPOPT_COPIED(o)		((o)&IPOPT_COPY)
-#define	IPOPT_CLASS(o)		((o)&IPOPT_CLASS_MASK)
-#define	IPOPT_NUMBER(o)		((o)&IPOPT_NUMBER_MASK)
-
-#define	IPOPT_CONTROL		0x00
-#define	IPOPT_RESERVED1		0x20
-#define	IPOPT_MEASUREMENT	0x40
-#define	IPOPT_RESERVED2		0x60
-
-#define IPOPT_END	(0 | IPOPT_CONTROL)
-#define IPOPT_NOOP	(1 | IPOPT_CONTROL)
-#define IPOPT_SEC	(2 | IPOPT_CONTROL | IPOPT_COPY)
-#define IPOPT_LSRR	(3 | IPOPT_CONTROL | IPOPT_COPY)
-#define IPOPT_TIMESTAMP	(4 | IPOPT_MEASUREMENT)
-#define IPOPT_RR	(7 | IPOPT_CONTROL)
-#define IPOPT_SID	(8 | IPOPT_CONTROL | IPOPT_COPY)
-#define IPOPT_SSRR	(9 | IPOPT_CONTROL | IPOPT_COPY)
-#define IPOPT_RA	(20 | IPOPT_CONTROL | IPOPT_COPY)
-
-#define IPVERSION	4
-#define MAXTTL		255
-#define IPDEFTTL	64
-#define IPOPT_OPTVAL 0
-#define IPOPT_OLEN   1
-#define IPOPT_OFFSET 2
-#define IPOPT_MINOFF 4
-#define MAX_IPOPTLEN 40
-#define IPOPT_NOP IPOPT_NOOP
-#define IPOPT_EOL IPOPT_END
-#define IPOPT_TS  IPOPT_TIMESTAMP
-
-#define	IPOPT_TS_TSONLY		0	/* timestamps only */
-#define	IPOPT_TS_TSANDADDR	1	/* timestamps and addresses */
-#define	IPOPT_TS_PRESPEC	3	/* specified modules only */
-
-struct ip_options {
-	__u32		faddr;			/* Saved first hop address */
-	unsigned char	optlen;
-	unsigned char srr;
-	unsigned char rr;
-	unsigned char ts;
-	unsigned char	is_setbyuser:1,	/* Set by setsockopt?		*/
-			is_data:1,	/* Options in __data, rather than skb*/
-			is_strictroute:1,/* Strict source route		*/
-			srr_is_hit:1,	/* Packet destn addr was ours */
-			is_changed:1,	/* IP checksum more not valid	*/
-			rr_needaddr:1,	/* Need to record addr of out dev*/
-			ts_needtime:1,	/* Need to record timestamp	*/
-			ts_needaddr:1;	/* Need to record addr of out dev  */
-	unsigned char router_alert;
-	unsigned char __pad1;
-	unsigned char __pad2;
-	unsigned char __data[0];
-};
-
-#define optlength(opt) (sizeof(struct ip_options) + opt->optlen)
-
-struct iphdr {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8	ihl:4,
-		version:4;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	__u8	version:4,
-		ihl:4;
-#endif
-	__u8	tos;
-	__u16	tot_len;
-	__u16	id;
-	__u16	frag_off;
-	__u8	ttl;
-	__u8	protocol;
-	__u16	check;
-	__u32	saddr;
-	__u32	daddr;
-	/*The options start here. */
-};
-
-#endif	/* _LINUX_IP_H */
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index d35e92c17a5e..565ac5be7db3 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/ip.h"
 #include "../include/wifi.h"
 #include "../include/mlme_osdep.h"
 #include "../include/xmit_osdep.h"
-- 
2.32.0

