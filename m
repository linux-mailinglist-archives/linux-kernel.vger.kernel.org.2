Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30F5456B85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKSIUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 03:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhKSIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:20:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:17:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so39291115edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UVE/SmMvdt/KzBGtQwwI3PvJQT0vr6EuaOqUqEpmdfc=;
        b=XyCQIjyvkYJLvCahvPPMLedBG+/hH/24KhG8Grgh4zgAJWRYGOFaMs93ZafhGAIHE9
         ZzpB4hN8vc9URyGIdz2xvkOttHOvO30/FmoLFIzpa3YRIjO6F+vg4G7CkIU4dywuBNl9
         x3qyALQDJjWPFTUw2FSSslMo+dagQBwmoYJbOy3NTfnZgw9xsS44av8ZiVhs4cPjiuzN
         5LOt3pfpSiG8fm6pp2jJG4dpV9eRoLIgpFo+NuIACi18Xp8PPFYFHHJcQD1bhu8UQtyR
         mg+8Z1NPBhK4sWDBhvSmCnVZKdwRZo1c5VKZ+cpUI1V2bcIQib0J3BiQTeBR3T/0SUGa
         3b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UVE/SmMvdt/KzBGtQwwI3PvJQT0vr6EuaOqUqEpmdfc=;
        b=dBuBooBBlEx+ZBWKOEeSO825JGDqg72d4RBQjvsDHCgaqHQD1JtlIuvF4Z0mxYc4Ux
         1NL8xfCe70+UTKXAjrNGan9OSMaQm+rKaOnDudEEWBX6gjKTQyzQfUilVm305HLMM3rU
         nsCf3zOyRyQ+p/QcksUaXs941ck8afcoDll9u9vlIhVIhb+YjcPm9R+XcpJFn5qU27aT
         kn+NJqYBiALxTO8zZL/4zCTKE7xPSyMmxAhEmeos+K9I2zVv1WeS0sT7/Mr7zx9H+Ibc
         vFVmdP/+v7aH6wyh0hLTjsV6+eBRmCb84XzHTXahTC/8W+5XAGfF2iExk9EApIyC8rWP
         palg==
X-Gm-Message-State: AOAM530h5SiN9yxbTM+2c9g8z+9DcRNQjAr5vOt+OtVT6cj7IWURB1mG
        i8O8cX6qRiKFhvunvZMFBer1mKYunkc=
X-Google-Smtp-Source: ABdhPJyfcAj2A+D5ftREj/B1OfArS9a3iZ2Fjrpsq1j+2LAGY4H/26F9u5zJklAwA3H4chGqSkSTDw==
X-Received: by 2002:aa7:d546:: with SMTP id u6mr22379452edr.311.1637309818833;
        Fri, 19 Nov 2021 00:16:58 -0800 (PST)
Received: from alb3rt0-VirtualBox ([151.22.100.250])
        by smtp.gmail.com with ESMTPSA id r3sm861190ejr.79.2021.11.19.00.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 00:16:58 -0800 (PST)
Date:   Fri, 19 Nov 2021 09:16:56 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        alb3rt0.m3rciai@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: refactor camelcase byMaxPwrLevel to
 max_pwr_level
Message-ID: <20211119081656.GA12982@alb3rt0-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hungarian notated variable "byMaxPwrLevel" with "max_pwr_level"
compliant with linux kernel coding style.

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/vt6655/device.h |  2 +-
 drivers/staging/vt6655/rf.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index f5dee7ad99cd..d2be83b611ae 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -159,7 +159,7 @@ struct vnt_private {
 	unsigned char byLocalID;
 	unsigned char byRFType;
 
-	unsigned char byMaxPwrLevel;
+	unsigned char max_pwr_level;
 	unsigned char byZoneType;
 	bool bZoneRegExist;
 	unsigned char byOriginalZonetype;
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 747d79265a7c..e8a9444c6833 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -611,11 +611,11 @@ bool RFbInit(struct vnt_private *priv)
 	switch (priv->byRFType) {
 	case RF_AIROHA:
 	case RF_AL2230S:
-		priv->byMaxPwrLevel = AL2230_PWR_IDX_LEN;
+		priv->max_pwr_level = AL2230_PWR_IDX_LEN;
 		ret = RFbAL2230Init(priv);
 		break;
 	case RF_AIROHA7230:
-		priv->byMaxPwrLevel = AL7230_PWR_IDX_LEN;
+		priv->max_pwr_level = AL7230_PWR_IDX_LEN;
 		ret = s_bAL7230Init(priv);
 		break;
 	case RF_NOTHING:
@@ -788,8 +788,8 @@ bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH)
 		else
 			byDec = byPwr + 10;
 
-		if (byDec >= priv->byMaxPwrLevel)
-			byDec = priv->byMaxPwrLevel - 1;
+		if (byDec >= priv->max_pwr_level)
+			byDec = priv->max_pwr_level - 1;
 
 		byPwr = byDec;
 		break;
@@ -831,7 +831,7 @@ bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 	bool ret = true;
 	unsigned long dwMax7230Pwr = 0;
 
-	if (byPwr >=  priv->byMaxPwrLevel)
+	if (byPwr >= priv->max_pwr_level)
 		return false;
 
 	switch (priv->byRFType) {
-- 
2.25.1

