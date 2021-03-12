Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484313386B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhCLHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:43:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCLHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:43:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C7e3e4078909;
        Fri, 12 Mar 2021 07:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=lyEZtZhJ6VLIa+jofD9oSfp10CCjvgkhQQDicleKipo=;
 b=yvVwEtdPfPetx/RdUs5lmtzwhQhrUshlKsB+2it5jDyhva8BHUYJgAeMTCjZvGHvXf/c
 yRFWV3H/kBmFX4/MJgjA0pdItsLCp6XqzA3a9p3rdpOb4c8CmP04qagyoboXNQTFVbaM
 XIFUShA94KMrYmnRLk4IfWZWLt3ecW5uUFYKsS3vlT9es3bbMcam/XdYLQndn7YksdSO
 h/rTgUTtlP9mXJ8Lj/+G9N0Bf/DJSblP18MO0y7s7PcyE6nBQrr3yAdrXNK0UrtMbKfC
 dnIOddo8/Q9J6mXWBM9kFgz61SRlMtAV/evHSiIiuOX5VvNOlNxaS6E7ETkFrbwvoaam ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3742cnh2gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 07:43:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C7dYhS149023;
        Fri, 12 Mar 2021 07:43:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 374kp26da9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 07:43:07 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12C7h0uB017076;
        Fri, 12 Mar 2021 07:43:00 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Mar 2021 23:43:00 -0800
Date:   Fri, 12 Mar 2021 10:42:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: bd9576: Fix return from bd957x_probe()
Message-ID: <YEsbfLJfEWtnRpoU@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe() function returns an uninitialized variable in the success
path.  There is no need for the "err" variable at all, just delete it.

Fixes: b014e9fae7e7 ("regulator: Support ROHM BD9576MUF and BD9573MUF")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/regulator/bd9576-regulator.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index a8b5832a5a1b..204a2da054f5 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -206,7 +206,7 @@ static int bd957x_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
 	struct regulator_config config = { 0 };
-	int i, err;
+	int i;
 	bool vout_mode, ddr_sel;
 	const struct bd957x_regulator_data *reg_data = &bd9576_regulators[0];
 	unsigned int num_reg_data = ARRAY_SIZE(bd9576_regulators);
@@ -279,8 +279,7 @@ static int bd957x_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
-		err = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	config.dev = pdev->dev.parent;
@@ -300,8 +299,7 @@ static int bd957x_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
 				desc->name);
-			err = PTR_ERR(rdev);
-			goto err;
+			return PTR_ERR(rdev);
 		}
 		/*
 		 * Clear the VOUT1 GPIO setting - rest of the regulators do not
@@ -310,8 +308,7 @@ static int bd957x_probe(struct platform_device *pdev)
 		config.ena_gpiod = NULL;
 	}
 
-err:
-	return err;
+	return 0;
 }
 
 static const struct platform_device_id bd957x_pmic_id[] = {
-- 
2.30.1

