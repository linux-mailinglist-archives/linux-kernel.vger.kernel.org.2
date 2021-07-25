Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959C3D4E77
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhGYPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhGYPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 11:19:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B900C061757;
        Sun, 25 Jul 2021 08:59:30 -0700 (PDT)
Received: from dslb-188-096-139-014.188.096.pools.vodafone-ip.de ([188.96.139.14] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m7gXI-0000SM-L4; Sun, 25 Jul 2021 17:59:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/18] staging: rtl8188eu: remove another unused enum
Date:   Sun, 25 Jul 2021 17:58:50 +0200
Message-Id: <20210725155902.32433-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210725155902.32433-1-martin@kaiser.cx>
References: <20210725155902.32433-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt_eeprom_type enum is not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/hal_intf.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal_intf.h b/drivers/staging/rtl8188eu/include/hal_intf.h
index 8aa4ebd6440f..4328431d6015 100644
--- a/drivers/staging/rtl8188eu/include/hal_intf.h
+++ b/drivers/staging/rtl8188eu/include/hal_intf.h
@@ -105,12 +105,6 @@ enum hal_odm_variable {
 	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
-enum rt_eeprom_type {
-	EEPROM_93C46,
-	EEPROM_93C56,
-	EEPROM_BOOT_EFUSE,
-};
-
 #define RF_CHANGE_BY_INIT	0
 #define RF_CHANGE_BY_IPS	BIT(28)
 #define RF_CHANGE_BY_PS		BIT(29)
-- 
2.20.1

