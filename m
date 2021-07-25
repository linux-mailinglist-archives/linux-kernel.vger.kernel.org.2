Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065C03D4E73
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhGYPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhGYPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:19:01 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82282C061760;
        Sun, 25 Jul 2021 08:59:31 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXJ-0000SM-J0; Sun, 25 Jul 2021 17:59:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/18] staging: rtl8188eu: remove a bunch of unused defines
Date:   Sun, 25 Jul 2021 17:58:51 +0200
Message-Id: <20210725155902.32433-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-1-martin@kaiser.cx>
References: <20210725155902.32433-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RF_CHANGE_BY_PS is used by this driver, the other
RF_CHANGE_BY_... defines can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/hal_intf.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index 4328431d6015..8396659f6acb 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -105,11 +105,7 @@ enum hal_odm_variable {
 	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
-#define RF_CHANGE_BY_INIT	0
-#define RF_CHANGE_BY_IPS	BIT(28)
 #define RF_CHANGE_BY_PS		BIT(29)
-#define RF_CHANGE_BY_HW		BIT(30)
-#define RF_CHANGE_BY_SW		BIT(31)
 
 enum hardware_type {
 	HARDWARE_TYPE_RTL8188EU,
-- 
2.20.1

