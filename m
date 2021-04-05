Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8273545B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhDEQ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhDEQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:56:30 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F677C061756;
        Mon,  5 Apr 2021 09:56:23 -0700 (PDT)
Received: from dslb-188-096-137-079.188.096.pools.vodafone-ip.de ([188.96.137.79] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lTSWO-0004zD-Kb; Mon, 05 Apr 2021 18:56:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: rtl8723bs: remove unused dvobj_priv members
Date:   Mon,  5 Apr 2021 18:48:55 +0200
Message-Id: <20210405164855.30264-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

InterfaceNumber und NumInterfaces in struct dvobj_priv are not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index a454a6390537..cec8d5ac0e2e 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -295,10 +295,6 @@ struct dvobj_priv {
 	struct cam_ctl_t cam_ctl;
 	struct cam_entry_cache cam_cache[TOTAL_CAM_ENTRY];
 
-	/* For 92D, DMDP have 2 interface. */
-	u8 InterfaceNumber;
-	u8 NumInterfaces;
-
 	/* In /Out Pipe information */
 	int	RtInPipe[2];
 	int	RtOutPipe[4];
-- 
2.20.1

