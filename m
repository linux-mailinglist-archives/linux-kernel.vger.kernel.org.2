Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2E3239E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhBXJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:50:57 -0500
Received: from m12-12.163.com ([220.181.12.12]:51267 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhBXJtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qr4pL
        Jr+SrWspw/IWlbuHQg94Kpw0UYf/5wAB/8sh/o=; b=k+6aWPJaVXPa/8O9d8Ket
        cpKvimD+EKyUu5sAi3oK/sxkFHhrv4xtRErk5Pngw3ZfiY1+TWejsYvyX88pyHMf
        Md+Xh0IndGqHZiSqvlOBCwAVqvlHs2chkdQMURriyAQFLnrbrU4d2JgctNGUZKvo
        bTS3Ul9RxJCftkhBCSBc7c=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowAAXn+KzHDZgDCP+Rw--.25828S2;
        Wed, 24 Feb 2021 17:30:28 +0800 (CST)
From:   dingsenjie@163.com
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] gnss: ubx: Simplify the return expression in the ubx.c
Date:   Wed, 24 Feb 2021 17:29:47 +0800
Message-Id: <20210224092947.17724-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAXn+KzHDZgDCP+Rw--.25828S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4UXryDuryrtF13Cry5twb_yoWDXFc_Wr
        W0ga17Wr4qvFWFkry7Jr9xZryFqF4DXF1Fva1IqrZIgr98CFWDtr4DCFZxuryDXw4xGF9F
        9ryxCryayr1kWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1msj7UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiHhRDyFSIs6yghgAAsk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Simplify the return expression.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/gnss/ubx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 7b05bc4..7a22fc9 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -24,25 +24,15 @@ struct ubx_data {
 static int ubx_set_active(struct gnss_serial *gserial)
 {
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_enable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_enable(data->vcc);
 }
 
 static int ubx_set_standby(struct gnss_serial *gserial)
 {
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_disable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_disable(data->vcc);
 }
 
 static int ubx_set_power(struct gnss_serial *gserial,
-- 
1.9.1


