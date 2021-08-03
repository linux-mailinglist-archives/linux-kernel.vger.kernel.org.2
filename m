Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35F43DEF61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbhHCNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhHCNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:53:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982CC06179F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:52:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q6so28185208oiw.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpwzFW0EAiPKRSLYQnqnvltQMO0ehvzjEwDrtXLZCWc=;
        b=VB1JAGRi+DbGpoH/wCIkSpiu9P6Lc/sE6BTjOgxlTzlWHKLjDmy2sbmabAkCltTsE8
         E8Us1SNO/Fw+SMT2Yfe1D4xZVfGH78o7vWfCfQIxKu2EMxuyb1tbL5FJjkdZFpw19fBY
         twQnQ9L/gtEOKqhIDOC70/dHji4snM7t+nI1qV1MhXQp1MNh2NbXa13bedrLMTh8CSLm
         fAWHZo0y27SoxCssPXtzCV8PJEJuQ3L6li+qewqBxIHEmtB9RS6ZSyKExQse0x4G++F+
         Uql3AFLdIelkXjag7857Rbj9JiDe9fsSUWECdf8v4Ie7mCbU4txDTp7qyOBORCzF5/n8
         8ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GpwzFW0EAiPKRSLYQnqnvltQMO0ehvzjEwDrtXLZCWc=;
        b=FqD9z3k40G3GQaMg3I1ET8FC5tV/KAYKLoKbtI6cAlnxxGOt2DK/SDD17ngcsAqQYa
         97J/xynL8KhPrqy+/WnpdQcse5mJzIcIkgHnaC3/lgZn910sWuGxG2N56jkgmO5m0dtB
         TkUXoxa/XKMjzg9hZdH7rupdUS/YXn2EM1Om46XcNLPRk+DsIOfU72GNyjp+cdVvlv5x
         3fUbA4+I+JoVfGG2ByXfa3lXaIXfO6D8ibG0fm+0MQdfTIDo4s8tle0JwRzAetiNFL4A
         qzRpXFyBJxpQ4+ntIRMQecwwjhu5N+W9u96SV+MB7CVvV02G+Qq1Lx4/fyMK/J0h2Wra
         jksA==
X-Gm-Message-State: AOAM530g9lQUgLgsuQv1qLanbDsXE1a53aQ3biEfCnJOpx7IU8r12yxr
        6IWUbUchM/EW5E4PAgglGjs=
X-Google-Smtp-Source: ABdhPJxoVlpyymM/aafibLMfDv3snZlK91KlMyJhaguWNpAI8GvlItD+2qAovCN6q0eFW7cX9X9oAA==
X-Received: by 2002:aca:44d4:: with SMTP id r203mr1847384oia.126.1627998769144;
        Tue, 03 Aug 2021 06:52:49 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id y26sm2504106otq.23.2021.08.03.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:52:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 10/10] staging: r8188eu: Remove some bit manipulation macros
Date:   Tue,  3 Aug 2021 08:52:23 -0500
Message-Id: <20210803135223.12543-11-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
References: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver defines a set of macros that get or set a bitfield in the
RX and TX descriptors. Most of these have been replaced by the appropriate
use of the system macros BIT() or GENMASK().

While reworking these routines, I also fixed camel case variables and
missing spaces. Some comments were also converted to the
drivers/net/wireless preferred format.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  2 +-
 .../r8188eu/include/Hal8188ERateAdaptive.h    | 59 ++++++++-----------
 drivers/staging/r8188eu/include/basic_types.h | 45 --------------
 drivers/staging/r8188eu/include/odm_types.h   | 12 ++--
 .../staging/r8188eu/include/rtl8188e_xmit.h   | 26 ++++----
 5 files changed, 42 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index d41bfbe8ec9c..e00b38381762 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -626,7 +626,7 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 		if (valid) {
 			pRAInfo->RTY[0] = (u16)GET_TX_REPORT_TYPE1_RERTY_0(pBuffer);
 			pRAInfo->RTY[1] = (u16)GET_TX_REPORT_TYPE1_RERTY_1(pBuffer);
-			pRAInfo->RTY[2] = (u16)GET_TX_REPORT_TYPE1_RERTY_2(pBuffer);
+			pRAInfo->RTY[2] = (u16)GET_TX_REPORT_TYPE1_RERTY_2((u8 *)pBuffer);
 			pRAInfo->RTY[3] = (u16)GET_TX_REPORT_TYPE1_RERTY_3(pBuffer);
 			pRAInfo->RTY[4] = (u16)GET_TX_REPORT_TYPE1_RERTY_4(pBuffer);
 			pRAInfo->DROP =   (u16)GET_TX_REPORT_TYPE1_DROP_0(pBuffer);
diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
index ce4c96d4b84a..d5ced507a648 100644
--- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
+++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
@@ -3,19 +3,11 @@
 
 #ifndef __INC_RA_H
 #define __INC_RA_H
-/*++
+/* Module Name: RateAdaptive.h
+ * Abstract: Prototype of RA and related data structure.
+ */
 
-Module Name:
-	RateAdaptive.h
-
-Abstract:
-	Prototype of RA and related data structure.
-
-Major Change History:
-	When       Who               What
-	---------- ---------------   -------------------------------
-	2011-08-12 Page            Create.
---*/
+#include <linux/bitfield.h>
 
 /*  Rate adaptive define */
 #define	PERENTRY	23
@@ -23,31 +15,26 @@ Major Change History:
 #define	RATESIZE	28
 #define	TX_RPT2_ITEM_SIZE	8
 
-/*  */
 /*  TX report 2 format in Rx desc */
-/*  */
-#define GET_TX_RPT2_DESC_PKT_LEN_88E(__pRxStatusDesc)		\
-	LE_BITS_TO_4BYTE(__pRxStatusDesc, 0, 9)
-#define GET_TX_RPT2_DESC_MACID_VALID_1_88E(__pRxStatusDesc)	\
-	LE_BITS_TO_4BYTE(__pRxStatusDesc+16, 0, 32)
-#define GET_TX_RPT2_DESC_MACID_VALID_2_88E(__pRxStatusDesc)	\
-	LE_BITS_TO_4BYTE(__pRxStatusDesc+20, 0, 32)
-
-#define GET_TX_REPORT_TYPE1_RERTY_0(__pAddr)			\
-	LE_BITS_TO_4BYTE(__pAddr, 0, 16)
-#define GET_TX_REPORT_TYPE1_RERTY_1(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+2, 0, 8)
-#define GET_TX_REPORT_TYPE1_RERTY_2(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+3, 0, 8)
-#define GET_TX_REPORT_TYPE1_RERTY_3(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4, 0, 8)
-#define GET_TX_REPORT_TYPE1_RERTY_4(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4+1, 0, 8)
-#define GET_TX_REPORT_TYPE1_DROP_0(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4+2, 0, 8)
-#define GET_TX_REPORT_TYPE1_DROP_1(__pAddr)			\
-	LE_BITS_TO_1BYTE(__pAddr+4+3, 0, 8)
-
+#define GET_TX_RPT2_DESC_PKT_LEN_88E(__rxstatusdesc)		\
+	le32_get_bits(*(__le32 *)__rxstatusdesc, GENMASK(8, 0))
+#define GET_TX_RPT2_DESC_MACID_VALID_1_88E(__rxstatusdesc)	\
+	le32_to_cpu((*(__le32 *)(__rxstatusdesc + 16))
+#define GET_TX_RPT2_DESC_MACID_VALID_2_88E(__rxstatusdesc)	\
+	le32_to_cpu((*(__le32 *)(__rxstatusdesc + 20))
+
+#define GET_TX_REPORT_TYPE1_RERTY_0(__paddr)			\
+	le16_get_bits(*(__le16 *)__paddr, GENMASK(15, 0))
+#define GET_TX_REPORT_TYPE1_RERTY_1(__paddr)			\
+	LE_BITS_TO_1BYTE(__paddr + 2, 0, 8)
+#define GET_TX_REPORT_TYPE1_RERTY_2(__paddr)			\
+	LE_BITS_TO_1BYTE(__paddr + 3, 0, 8)
+#define GET_TX_REPORT_TYPE1_RERTY_3(__paddr)			\
+	LE_BITS_TO_1BYTE(__paddr + 4, 0, 8)
+#define GET_TX_REPORT_TYPE1_RERTY_4(__paddr)			\
+	LE_BITS_TO_1BYTE(__paddr + 5, 0, 8)
+#define GET_TX_REPORT_TYPE1_DROP_0(__paddr)			\
+	LE_BITS_TO_1BYTE(__paddr + 6, 0, 8)
 /*  End rate adaptive define */
 
 void ODM_RASupport_Init(struct odm_dm_struct *dm_odm);
diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
index 9c34e2dad6bb..d82b2171d584 100644
--- a/drivers/staging/r8188eu/include/basic_types.h
+++ b/drivers/staging/r8188eu/include/basic_types.h
@@ -117,51 +117,6 @@ value to host byte ordering.*/
 		BIT_LEN_MASK_8(__bitlen) \
 	)
 
-/* Description:
- * Mask subfield (continuous bits in little-endian) of 4-byte value
- * and return the result in 4-byte value in host byte ordering.
- */
-#define LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		LE_P4BYTE_TO_HOST_4BYTE(__pstart)  & \
-		(~BIT_OFFSET_LEN_MASK_32(__bitoffset, __bitlen)) \
-	)
-#define LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		LE_P2BYTE_TO_HOST_2BYTE(__pstart) & \
-		(~BIT_OFFSET_LEN_MASK_16(__bitoffset, __bitlen)) \
-	)
-#define LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		LE_P1BYTE_TO_HOST_1BYTE(__pstart) & \
-		(~BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen)) \
-	)
-
-/* Description:
- * Set subfield of little-endian 4-byte value to specified value.
- */
-#define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
-		*((u32 *)(__pstart)) =				\
-		(							\
-		LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
-		)
-
-#define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
-		*((u16 *)(__pstart)) =				\
-		(						\
-		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
-		);
-
-#define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
-		*((u8 *)(__pstart)) = EF1BYTE			\
-		(						\
-		LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u8)__val) & BIT_LEN_MASK_8(__bitlen)) << (__bitoffset)) \
-		)
-
-/*  Get the N-bytes aligment offset from the current length */
 #define	N_BYTE_ALIGMENT(__value, __aligment) ((__aligment == 1) ? \
 	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
 
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index e2e5aa8e8054..53a2fee55e35 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -29,12 +29,12 @@ enum RT_SPINLOCK_TYPE {
 
 #define DEV_BUS_TYPE	RT_USB_INTERFACE
 
-#define SET_TX_DESC_ANTSEL_A_88E(__pTxDesc, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pTxDesc+8, 24, 1, __Value)
-#define SET_TX_DESC_ANTSEL_B_88E(__pTxDesc, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pTxDesc+8, 25, 1, __Value)
-#define SET_TX_DESC_ANTSEL_C_88E(__pTxDesc, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pTxDesc+28, 29, 1, __Value)
+#define SET_TX_DESC_ANTSEL_A_88E(__ptxdesc, __value)			\
+	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(24))
+#define SET_TX_DESC_ANTSEL_B_88E(__ptxdesc, __value)			\
+	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(25))
+#define SET_TX_DESC_ANTSEL_C_88E(__ptxdesc, __value)			\
+	le32p_replace_bits((__le32 *)(__ptxdesc + 28), __value, BIT(29))
 
 /* define useless flag to avoid compile warning */
 #define	USE_WORKITEM			0
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index e9b71de0d165..95fb1ca69d46 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -18,24 +18,22 @@
 #define QSLT_CMD						0x13
 
 /* For 88e early mode */
-#define SET_EARLYMODE_PKTNUM(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr, 0, 3, __Value)
+#define SET_EARLYMODE_PKTNUM(__paddr, __value)			\
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(2, 0))
 #define SET_EARLYMODE_LEN0(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr, 4, 12, __Value)
-#define SET_EARLYMODE_LEN1(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr, 16, 12, __Value)
-#define SET_EARLYMODE_LEN2_1(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr, 28, 4, __Value)
-#define SET_EARLYMODE_LEN2_2(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr+4, 0, 8, __Value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4))
+#define SET_EARLYMODE_LEN1(__paddr, __value)			\
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16))
+#define SET_EARLYMODE_LEN2_1(__pdr, __vValue)			\
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28))
+#define SET_EARLYMODE_LEN2_2(__paddr, __value)			\
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0))
 #define SET_EARLYMODE_LEN3(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr+4, 8, 12, __Value)
-#define SET_EARLYMODE_LEN4(__pAddr, __Value)			\
-	SET_BITS_TO_LE_4BYTE(__pAddr+4, 20, 12, __Value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
+#define SET_EARLYMODE_LEN4(__paAddr, __vValue)			\
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
 
-/*  */
 /* defined for TX DESC Operation */
-/*  */
 
 #define MAX_TID (15)
 
-- 
2.32.0

