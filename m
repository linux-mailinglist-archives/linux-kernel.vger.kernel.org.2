Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3980037EB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380636AbhELTcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbhELRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:12:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF8C061349
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:04:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p4-20020a1709032484b02900e6aa6adc54so9649918plw.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PXODettiudEJAl3QLXIii2j1h/vSRPebc7EbOxNgBmo=;
        b=YsUrcbRSvGP7r8wr3p/YTr3sfiwR84Eox1a+e0b5ch6zT3CcgpN/wjeGFZeldTL/bi
         +bCoaARQIkB9fZT+J64BTwaHFc1Np71pq8JAAiGUrlSYagaTVvrfB5gNAHVTXsuaXnTC
         PO/xFB1UtKTgKFdviw+GjHk0msMWM4xN5yBzxcn6/S3JcmoRsr5z/Wqk/vt7RBTNiK0/
         gy+pGQ6FCCUv6YTY+Qc/jMMYj87U8Zjf777GFjB+N4pNWbyypbbyYEU1hZj0EwRdAhUT
         8HhP52aUDhteTTlNwltF62nDPN/ZAVYas8CZO0BAWhe9NUE6Mtr1+U7x39lEs+l3z/01
         576g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PXODettiudEJAl3QLXIii2j1h/vSRPebc7EbOxNgBmo=;
        b=WbamHFIKi4KFcgDvXmkF1FQhcyRtYgf6qkADCtdS7SLgMSM8lZTSelVrW5hpYhHV3M
         hrOjQ9T24gKGfOGRt++ipqCyVSfY1KTRfUG9rCdha5yj5aMHPmYiu0TTAVhkxPowHqZs
         rT6Ej8XnhSBnsGyIXkjiwcJ+2rAqJAf2ssjJctDWCSTGR64ZSo9PUM3LQpfNO8VXtk+5
         P27/niAcR2WESqUTVi2wdLpebEdGMXai/68yP/VeuJ7hDUNEc7/nkufwkt8ih6M0zPHK
         i9uJQG2VMy+RQzjS06VS84b963lSCEL08P+n/Ch/+kUf5mDmb/105hL1AaO/FymrAL7p
         YSKQ==
X-Gm-Message-State: AOAM532YdKrySUzG77ResWpNj5v7Wbxs1xsBqCC9MTxbAMmy2CJkzhSZ
        jaoGJMRHFIknBQNDSqu6lPBuC9Mh48TUR0k1
X-Google-Smtp-Source: ABdhPJwd0j4UsVE4TWxtvGAi4TakorUQiD2yBaCnagcZHFVavQmOMgNg+dV7Ss/lE3+683S0aUvoFL7wet6IEeAw
X-Received: from chu-dev-docker.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:80f])
 (user=linchuyuan job=sendgmr) by 2002:a17:90a:db93:: with SMTP id
 h19mr20948pjv.0.1620839061422; Wed, 12 May 2021 10:04:21 -0700 (PDT)
Date:   Wed, 12 May 2021 17:04:18 +0000
Message-Id: <20210512170418.2432278-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] Enable adm1272 temperature reporting
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@gmail.com, jasonling@google.com, zhongqil@google.com,
        linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chu Lin <linchuyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adm1272 supports temperature reporting but it is disabled by default.

Tested:
ls temp1_*
temp1_crit           temp1_highest        temp1_max
temp1_crit_alarm     temp1_input          temp1_max_alarm

cat temp1_input
26642

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/adm1275.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index e7997f37b266..0be1b5777d2f 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -611,11 +611,13 @@ static int adm1275_probe(struct i2c_client *client)
 		tindex = 8;
 
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
-		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
-			config |= ADM1278_VOUT_EN;
+		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
+		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
+		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
+			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
 			ret = i2c_smbus_write_byte_data(client,
 							ADM1275_PMON_CONFIG,
 							config);
@@ -625,10 +627,6 @@ static int adm1275_probe(struct i2c_client *client)
 				return -ENODEV;
 			}
 		}
-
-		if (config & ADM1278_TEMP1_EN)
-			info->func[0] |=
-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
 		break;
-- 
2.31.1.607.g51e8a6a459-goog

