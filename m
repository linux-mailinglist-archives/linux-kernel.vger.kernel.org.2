Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B2323493
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhBXANH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhBWXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:42:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1886C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:41:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w11so106310wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivtcAcwQWmGrm6490xrL+jxa5SoD16u6STwUQ2bWY3Q=;
        b=BULrNi7p1JtqhjQ5ZrzbKfsDyTzp1gaO8yxtkAYZ3SzkgPX3IJOcZ27dSSqqJAUUn2
         h4RkgrDY98XqkAtnVH4zrGfycSnd2Vxz5+gY3xsGlpYfUyQ8JTktpsRJI/mbLQw5d6nv
         iRqOFW5nFwoHxxJRmU7Hl6iaeLuIYeDOkwJz9gdJRaFs0NNA5N2ZLtn57OrqfmwpP59H
         sU829jD6sIDZS3/AtSo+mmgmq3dtHiWSSqXxnxAd5FFVZw2B7D8CGpZZ6QdbAeXT8+PH
         MFTFr8VR57LUuQwyPXITue59+/u3JXAWs0Fo0HsxngQZ1uRfe/sJfxhl+w5WKEDbYXMx
         9/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivtcAcwQWmGrm6490xrL+jxa5SoD16u6STwUQ2bWY3Q=;
        b=nI3EFj7i/FdegvkFX8x13QVenv/cyebJYn2TDCXWmj+77F0Lmv9bvn1Zx66spPPc8K
         fDHdLH4ySaX6QgnSBg6Q6cQiSrOffHT8cFPnFGBZ8N2jRPP6n0AvI60628bgRIudj3Fw
         zKgZXyInlWomjo0J/Jq/gqS+dhT0oi9Rv6wAEiEN/52H7EJmW1J4jiIT1O1hZRCL+c4O
         vZ7peBa8BzHC8KfiqWQTyiWL6VCnaNZdwtiGpQXRD3biZOXs0oaKeps3Squd4D3DwaoC
         kKLCeDfDkngF6Lby5S064vJxRtkqAxD7FMK1/ZkUQ+7YfUm4n6UShaV6Y7YMduvdvECI
         FrOw==
X-Gm-Message-State: AOAM532TbhbKWr4dPBuFvwcv1L5/e6pTfcF38RJbLPF+5PVwfqzNIhck
        JBsJV441Q1Bk7Mz1jkGrBGs=
X-Google-Smtp-Source: ABdhPJw98GxEM/T8w5qdluZDdfq4QEvMwCdPgh/d3I2Ay/HsXGkIrBX/P/vMh6cicQAvXd3erEHpZw==
X-Received: by 2002:adf:e64b:: with SMTP id b11mr7908053wrn.272.1614123680704;
        Tue, 23 Feb 2021 15:41:20 -0800 (PST)
Received: from simone-latitudee5440.wind3.hub ([151.24.203.213])
        by smtp.googlemail.com with ESMTPSA id k1sm338618wrx.77.2021.02.23.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:41:19 -0800 (PST)
From:   Simone Serra <serrazimone@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     Simone Serra <serrazimone@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rt8192u: Move constant in comparison to the RHS
Date:   Wed, 24 Feb 2021 00:41:02 +0100
Message-Id: <20210223234102.15784-1-serrazimone@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning:

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Simone Serra <serrazimone@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index d853586705fc..175bb8b15389 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -726,7 +726,7 @@ static int r8192_wx_set_enc_ext(struct net_device *dev,
 			idx--;
 		group = ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY;
 
-		if ((!group) || (IW_MODE_ADHOC == ieee->iw_mode) || (alg ==  KEY_TYPE_WEP40)) {
+		if ((!group) || (ieee->iw_mode == IW_MODE_ADHOC) || (alg ==  KEY_TYPE_WEP40)) {
 			if ((ext->key_len == 13) && (alg == KEY_TYPE_WEP40))
 				alg = KEY_TYPE_WEP104;
 			ieee->pairwise_key_type = alg;
-- 
2.27.0

