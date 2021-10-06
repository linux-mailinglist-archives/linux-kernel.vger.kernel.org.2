Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450D7423A43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhJFJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhJFJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:12:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8FC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:10:22 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mY2wM-0006je-TM; Wed, 06 Oct 2021 11:10:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: r8188eu: merge two signal scale mapping functions
Date:   Wed,  6 Oct 2021 11:09:49 +0200
Message-Id: <20211006090949.1694-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211006090949.1694-1-martin@kaiser.cx>
References: <20211006090949.1694-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the odm_SignalScaleMapping function and remove
odm_SignalScaleMapping_92CSeries.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index c9c2bc35906c..2ae1a001d339 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -17,7 +17,7 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 		return 100 + AntPower;
 }
 
-static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 CurrSig)
+static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 {
 	s32 RetSig = 0;
 
@@ -41,11 +41,6 @@ static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 Cu
 	return RetSig;
 }
 
-static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
-{
-	return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
-}
-
 static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
-- 
2.20.1

