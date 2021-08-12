Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6513E9F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhHLHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:35:56 -0400
Received: from mx.ucr.edu ([169.235.156.38]:8344 "EHLO mx-lax3-3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhHLHfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628753730; x=1660289730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ih509MZfBFgCEEZtNiCc3rKR+7wk2Y1qBqpU/o2sR8I=;
  b=eDCsTpKc72Wmivex7Ucy89Rlaut7cU0I/4xn9a+jmt6S41qSOKeXFzGY
   OSEDq9mfExUsGJ1tIigFsmefjeR3Ri6VTQ41itXUXeNO/2eiN4U6VqitJ
   QirKSM0rzgcadzT9VXMIOLb0++RqfLyQqhTstq9niLgeRqANVV92a1clp
   wJJo5FTuoDCDS+1CGfmLPReOgj4brUNs+xZ33GR/ZQuMsdTviWqn/8Foe
   iWe18ZTUdKcBtvj9q250U+QZTUpk+0gevxnrfM4FpEQKa+gjRn56IRBl6
   NSqpu7/cXdsOYp4bQR5lTTkHWzx2EbeX+sS/xBPMc+BEFrtSvJ+qWaTfF
   g==;
IronPort-SDR: jmnrK9UjCkOrQplTKJIthzEEd4vq217xHIdaNQJD1xWJDVIlPuQExC29KGFEZdv7HodWoILm4z
 TiMYVbxPg7JRvvdlsF8WeBVtWRpzuOhymBnRxjg4xpjbpsB/7zcRa8GLTfxm2fWvURoLmIDZpk
 gaZ7L7R7tStXdg/sk/iYmK8knVllXs5WVMT15TwKvLJqsZL+nGYwhwDg1ELTFzXQ8zTiKjVpd3
 eBBgxaqWtkOzGxdMCF16mvqd4EJB6AfjXh4s7E+Z6qxj3Wbr4U1A9UHuBccdfCoNtPZYDFxAId
 DZv387wb76P391uaga7rHKPT
X-IPAS-Result: =?us-ascii?q?A2E4DQBUzhRhh0bYVdFaHAEBATwBAQQEAQECAQEHAQGBb?=
 =?us-ascii?q?gKDd1UWjUyTUYEahnyIaIF8AgkBAQENAQESExwEAQGEWQKCZwIlNAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQYBAQEBAQEFBAEBAhABAQEBgSALWQtjgU+BeQYEP?=
 =?us-ascii?q?YI1KYNlCQIBAxIVCwFGEFE0AQUBHBkiOYIWAYMHnhaBBD2MMTKBAYgcAQkNg?=
 =?us-ascii?q?WMJAQiBKAGIfoRxJ4IpglCBM3WHb4JQBINqexOCKYFQAQEBkD0bgwYBi1iBJ?=
 =?us-ascii?q?ptyAQYCgw4cnjNFlUeRLLsuAgoHBhAjgT2CFTMaJYFsCoFBTQECAQIBDAIBA?=
 =?us-ascii?q?gECAQIBAggBAQKONY5XITI4AgYLAQEDCYkMAQ?=
IronPort-PHdr: A9a23:YOeQZROnvVQMaoBTlggl6nbNDRdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv60r3AWCDdmTwskHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yfy+94fQbglWizawYrx/J
 wiqoAvMscUbnZFsIbsrxBvTpXtIdeVWxWd2Kl+Wgh3x+MS+8oN9/ipJo/4u+NJOXqv8f6QjU
 LxXFy8mPHwv5M3qrhbMUw2C7WYBX2oMkxpIBw/F7AzmXpr0ryD3uPZx1DWcMMbrVr0/Ryis4
 Ll3Rx/pkCcHNiA28GfLisxrkalXpAutqwFjz4LIZY2YMv9+fqLGfdMBRGpBWMlRXDFfDI2lc
 oAPAesBMvhcr4bgulACqRWzCRWpCO7pzTBFmnH70bEn3+g4DQ3KwRErE9YTvHnUqdn4MroZX
 +Kow6nS1TjNb+1Y1yrz5obLdR4uo/+MUr1/f8fK1UUiFBnIgkmKpID5Iz+Y0PkGvWiB7+pnU
 OKik2woqwBwoziv28csjZTCiYEVyl/e9CVy3YE4JN25SU57e9GkEYdcuz2UOoZtX8MtX3tot
 DwkxbIbpJ62ZS4Hw4koyBDDcfKIaZSI4g79W+aLJzd1nG5odaywiRiy/kat1+zxW8m03ltUs
 ydJjMXBu20T2xHN6cWKSvVw80iu1zuPyQzd5e5JLEEwmKfGNZMvzLo9m5UVvE/eHSH2gF37g
 LGKekgg4OSl6OTqbq/4qpOBNoJ4kAPzPrg2lsCiAOk1NhICU3aV9Om8zrHv40/0TK9UgvEon
 KTUto3RK94Bqa6jGQBV154u6xO4Dzi7ztsVhWIHLFdZeBKfiIjpJk3OLOj4Dfihh1Ssly9mx
 /XcMb3gBpXBN2DDkLX8cbpk5U5RyhY/wcpQ55JTDbEBL/bzVVHruNPECR85NhS4w+fhCNpjy
 oMTQXyDDrOdPa/IslKF5vgjL/eRaIIUojrwKeQp6+brjXAjmF8deaep3YEQaHC9BvlnI0SYY
 Xr2jdcADWsGogQzQff3iFKeSz5ffWi9UL8h5j0jEoKpEZ/DRpyxgLyGxCq7GpxWZmZbClGDC
 HvodJuLW+0KaC2MJs9siSIEVbe/RI87zx2utxH1y6BhLuXK/i0Ur5Xj1MJ6576buws18GlFD
 tadzmbFfWF9nytcVi021aEn+RdV11yZl6V0nqoLRpRo+/pVX1JiZtbnxOtgBoW3B1+pQw==
IronPort-HdrOrdr: A9a23:pvLSYKoiPKvI1+afDkEXzFYaV5oCeYIsimQD101hICG9vPbo8v
 xG+85rqCMc5wxhP03I9erwW5VoBEmsjaKdgrNhR4tKIjOW3ldARbsKheCD/9SjIVyEygc078
 ZdmsNFebnN5DZB/KTHCcqDfurIAuPszEllv4jjJg9WPHhXgmhbg2lENjo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="63066938"
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2021 00:35:29 -0700
Received: by mail-pj1-f70.google.com with SMTP id 2-20020a17090a1742b0290178de0ca331so3652035pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kccsi7K3Q0d7ZEGUYI767ae2qeNpNVR9x1RI+mNTwAU=;
        b=uEQCw8/Br6mVmstOj346i6Ux3IYe88qDtYronBb1R2Kb2wpdYmbHONKP5FteFA6G+b
         fdB29eGgoqo3ymTfm0zZudn7uizbLGA8YsXthvsqCRe/5wI8gm40hds0HVOT9fDNdusi
         yvQnB5w/zaVuZLBiYncm/4O2FK5M+XASOlfZglPPIeUmT6TMzJTJgc7MktBn2P2xU/ze
         WnLMa/lUrIJuZf0mp0N5geng0a4esXWxUgSPkmDcVtCBbf/7FGqvFqAQf5GbwzJMBZJ/
         PrRK4XJvF52NLWShqgegfNAE2OdJdrR85Klz2P7ibhg26mkqbjg+FeXMLBSFJLOWlAzZ
         e2oA==
X-Gm-Message-State: AOAM531pfzJp30iPN2FF0TDN/UV+lBb/AC4dtUM+sG0D3bZH0Z3lvzBS
        SKKXYz1ed3lMRLgmRX8cS37wbxLvuNL4/62/9HObztMaoPfEbr0AbLfqzFozpRLCSC4u1FJX+Ll
        buY5DM1uGRMq1A6tZ8qrkgWJm0Q==
X-Received: by 2002:a17:90a:1d05:: with SMTP id c5mr15695409pjd.175.1628753727678;
        Thu, 12 Aug 2021 00:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlN3QIKxpfS3sp2zQl+zNyzHUDzfrTSRi+p5FZ6+O5COzp/wL3UQAMaJrRFiVp810LR6P+ow==
X-Received: by 2002:a17:90a:1d05:: with SMTP id c5mr15695395pjd.175.1628753727504;
        Thu, 12 Aug 2021 00:35:27 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id s5sm1879447pji.56.2021.08.12.00.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 00:35:27 -0700 (PDT)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Thu, 12 Aug 2021 00:34:46 -0700
Message-Id: <20210812073447.127193-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723003607.64179-1-yzhai003@ucr.edu>
References: <20210723003607.64179-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function mt9m114_detect(), variable "retvalue" could
be uninitialized if mt9m114_read_reg() returns error, however, it
is used in the later if statement, which is potentially unsafe.

The local variable "retvalue" is renamed to "model" to avoid
confusion.

Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index f5de81132177..77293579a134 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -1533,16 +1533,19 @@ static struct v4l2_ctrl_config mt9m114_controls[] = {
 static int mt9m114_detect(struct mt9m114_device *dev, struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	u32 retvalue;
+	u32 model;
+	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "%s: i2c error", __func__);
 		return -ENODEV;
 	}
-	mt9m114_read_reg(client, MISENSOR_16BIT, (u32)MT9M114_PID, &retvalue);
-	dev->real_model_id = retvalue;
+	ret = mt9m114_read_reg(client, MISENSOR_16BIT, MT9M114_PID, &model);
+	if (ret)
+		return ret;
+	dev->real_model_id = model;
 
-	if (retvalue != MT9M114_MOD_ID) {
+	if (model != MT9M114_MOD_ID) {
 		dev_err(&client->dev, "%s: failed: client->addr = %x\n",
 			__func__, client->addr);
 		return -ENODEV;
-- 
2.25.1

