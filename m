Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7C145DD25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355970AbhKYPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349313AbhKYPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:18:07 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:14:55 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqGSa-0005zf-8s; Thu, 25 Nov 2021 16:14:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] staging: r8188eu: remove unused efuse defines
Date:   Thu, 25 Nov 2021 16:14:33 +0100
Message-Id: <20211125151436.5895-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125151436.5895-1-martin@kaiser.cx>
References: <20211125151436.5895-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some unused defines, macros and include statements
related to efuses.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    |  3 ---
 drivers/staging/r8188eu/include/rtw_efuse.h | 22 ---------------------
 2 files changed, 25 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 0cc3aa1b08b0..0e0e60638880 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -8,9 +8,6 @@
 #include "../include/rtw_efuse.h"
 #include "../include/rtl8188e_hal.h"
 
-#define REG_EFUSE_CTRL		0x0030
-#define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
-
 /*  */
 /* 	Description: */
 /* 		Execute E-Fuse read byte operation. */
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index cff9e748544d..2daf69f554d5 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -4,30 +4,8 @@
 #ifndef __RTW_EFUSE_H__
 #define __RTW_EFUSE_H__
 
-#include "osdep_service.h"
-
-#define	EFUSE_ERROE_HANDLE		1
-
-/* E-Fuse */
-#define EFUSE_MAP_SIZE      512
-#define EFUSE_MAX_SIZE      256
-/* end of E-Fuse */
-
-#define		EFUSE_MAX_MAP_LEN		512
-#define		EFUSE_MAX_HW_SIZE		512
-#define		EFUSE_MAX_SECTION_BASE	16
-
-#define EXT_HEADER(header) ((header & 0x1F) == 0x0F)
-#define ALL_WORDS_DISABLED(wde)	((wde & 0x0F) == 0x0F)
-#define GET_HDR_OFFSET_2_0(header) ((header & 0xE0) >> 5)
-
-#define		EFUSE_REPEAT_THRESHOLD_			3
-
-/*--------------------------Define Parameters-------------------------------*/
 #define		EFUSE_MAX_WORD_UNIT			4
 
-/*------------------------Export global variable----------------------------*/
-
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf);
 
 void EFUSE_ShadowMapUpdate(struct adapter *adapter);
-- 
2.20.1

