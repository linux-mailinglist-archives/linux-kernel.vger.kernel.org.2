Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7F3F5E15
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhHXMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbhHXMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:38:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5128C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:37:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so1766628wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYvM//XflDl5luddIn4dvmOvBEGYHudcWi9V4yu/ZCI=;
        b=kLJesp6ConjLgN2EzEvuxqiKi2o+uBpMiVR5QKrpVBtQGAcPMcUPW8P83Ha0EgPmCt
         zX+M30lqkS5mhS+6EQ2lmftElUH7NxYNgMv1uUeRpEEzAeLyRKkRQhjBSZgy+UqkL3XJ
         Tu24gri8QahTQZE5HHgW7rvti8bycJ6U40R9JF5Oy4a3EKeZXaSxWVkCGXZ0O2uwSMSM
         7fzqvvHBWbcq312uMC813Ff6BA/OOLqpLsOhPeOE42YxoY66wr8x009d16zxr77bu0ft
         aS/wz0LaKiU1u8sEM6Ti+khjRA7tTH1i6N7h8DECNVioj0yi0sXYSfi4TtHf5cI4fXtr
         7KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYvM//XflDl5luddIn4dvmOvBEGYHudcWi9V4yu/ZCI=;
        b=ZDI601ySxtcI0tu3cbYXDFMGOZlVgFvmKo70l62JVs7sJAKJ9gkkXc8Ft6kTscoX66
         byuTpgkunDOYRqKQLoETWUr4Ck/pSaiLmpfquPccZzyKpc3ms6/q2Ax+1VFouzqrP+Q0
         OgB4xe1jkY/b892jG9LNvO61SzedL1VZ2POKybYrfuLVf2G9Paa3Na0+Qz3MJ/5515iP
         I4a5+MD6NT4KFLODXUn0dkFm+/WTi1ZvwZjjG3igEeG2xf5IC7LVap135SPn1ndo5MsS
         aCgeYpFVLVO1OygILQgCjp6JoiN9wkSv0ivDUofOjWnIZpE5kSTIoasFPCVVag0N55r8
         DpHw==
X-Gm-Message-State: AOAM532yXzFkGU70XCxUGLABBFFEVTyvA7j+s3qLIkkcoknPJnDgVJa4
        If079cxriGK43zCyEXyoQXuF9knVeO4=
X-Google-Smtp-Source: ABdhPJw7oOfGpEle1+pu4YSBOJM6JkszxaT3l1W3kyqXRoKl9wcWX+sLqxXOZ6F3TR6ezuzbeN1H1w==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr3930064wme.125.1629808653300;
        Tue, 24 Aug 2021 05:37:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d87])
        by smtp.gmail.com with ESMTPSA id u23sm2137450wmc.24.2021.08.24.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:37:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: remove ip.h header file
Date:   Tue, 24 Aug 2021 14:36:20 +0200
Message-Id: <20210824123621.10801-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824123621.10801-1-straube.linux@gmail.com>
References: <20210824123621.10801-1-straube.linux@gmail.com>
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

