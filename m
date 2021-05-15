Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20538381759
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhEOJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 05:52:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52666 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhEOJwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 05:52:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14F9ooUX015223;
        Sat, 15 May 2021 09:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2wenIP4PRtmI//nVjFMumKuzna/LNMbkOwCNVqgYZ+A=;
 b=MsbW5sl/d5BBtOV/VxuOpO5yA1dcHGP2iH5VRFTeAqNAo5sz2kjhWqt5NEkYPP/QWgmV
 +AEty+G4mnMuSZ/W45W8WxIgYFeYi0jLsrPLNEZSG5RSBvE/Iuil/kQR51yFMHpXI8If
 ViSZbdT6eRpMBIGBDjo/Hygr5dMk7DhpleTF3LONHxe2ubqyMM4oeQR6r9vaw7DSlvfX
 y2o/Ae/iRrCLa+ySAi5kb1oju0ZgdVFsAU4mkoZ+08nD3zRU6sLkXp4ZRZxVKj8lXBQ/
 ltRRD8qSZhS/EcmK5MBDybVOVlD8MiGieo3I+7FaLK6O20G+RcYI7I5BT7Bv0zbIEfyY rQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38j4qc034y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:50:50 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14F9onOt104264;
        Sat, 15 May 2021 09:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38j641ffhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:50:49 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14F9nGeE099425;
        Sat, 15 May 2021 09:50:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38j641ffhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 09:50:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14F9oVI4017322;
        Sat, 15 May 2021 09:50:31 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 May 2021 02:50:30 -0700
Date:   Sat, 15 May 2021 12:50:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phong LE <ple@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] drm: bridge: it66121: fix an error code in
 it66121_probe()
Message-ID: <YJ+ZX3BdKPAN0pUZ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: ZVeIseb27CAkdyVJGUdYBdF7rUYQVh-_
X-Proofpoint-ORIG-GUID: ZVeIseb27CAkdyVJGUdYBdF7rUYQVh-_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is passing the wrong variable to PTR_ERR() so it doesn't
return the correct error code.

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index d8a60691fd32..6980c9801d0d 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -943,7 +943,7 @@ static int it66121_probe(struct i2c_client *client,
 	ctx->regmap = devm_regmap_init_i2c(client, &it66121_regmap_config);
 	if (IS_ERR(ctx->regmap)) {
 		ite66121_power_off(ctx);
-		return PTR_ERR(ctx);
+		return PTR_ERR(ctx->regmap);
 	}
 
 	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
-- 
2.30.2

