Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADC23E9E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhHLF4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:56:23 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:29119 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbhHLF4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628747757; x=1660283757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dih/syqAoRh+zFSVP5ghlcBWDYRkM3algk3/KHqQrKw=;
  b=ej/DfU9Fhh5uniQAmRCTRSUeWeYGk1AA6HE8EL2IRzifNFPMAeVvbleS
   k6Ch4gxyY+8Hjd0HOuvY8tVyt1MlkmAMiQ0NjY36YLQTO0QtQEExSBoqs
   g0seFU6WRJvOfR9DZ2Ez6a3AWHHLYEUnQO0ZmgI+s4SalCXEekJkcRosL
   c39kRqKomYGohRtxNvbJ/ObLqiyf1dnu+CR34IUUFXKhnrFEf0UDZ8DYI
   yfJ76VvUCKgqsdIHNhPlOuN4+RBs9hCQaqwAKNRhXuPuVg7j4Uvz/Jno0
   I6w3/UY0ZnPWRTdIjMics7nmglbtGwtNe5eOVNQ5063L1xn46jh6UrM2p
   Q==;
IronPort-SDR: +AThEPHZHm5zv9F3g8b6lXcUv33xWlV/bjrNOcUG4zTaQ9GN9tiSM9dvfm27RUF0rB9UsYBHid
 6jU/VEB8TJtwyh+Ggu1X9PB1wXzWJ6R9mLIUmhDukHsZ4WEJIgQ9GT9qYA9qyYAWOXkQjfyAqS
 TsCmH4f7ExH+jofmFUNrfQM8sYQadncdkkWtrmqswisriVfnJSgyK0pBnOf6pfo9SpyW8sR4E0
 3zX3poJUZW0lpTReYexlTsrzTIwSZyrM6q674G7VbOChenCcdC5ltOGNOEbPmGUoA+bWHhntc9
 mbMp6hma6ZamkkNapP70pkJz
X-IPAS-Result: =?us-ascii?q?A2FmBABEtxRhf0jYVdFaHgE8DAILgW6DeVUWjUyTUYEah?=
 =?us-ascii?q?nyIaIF8AgkBAQENAQFBBAEBhFkCgmcCJTQJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEGAQEBAQEBBQQBAQIQAQGBIgtZC2OBT4F5BgQ9gjUpg2UJAgEDEhULAUYQU?=
 =?us-ascii?q?TQBBQEcGSI5ghYBgweeHYEEPYwxMoEBiBwBCQ2BYwkBCIEoiH+EcSeCKYJQg?=
 =?us-ascii?q?TN1h2+CUASDansTgimBUAEBAZA6G4MGAYtVgSabcQEGAoMOHJ4zRZVFkSu7L?=
 =?us-ascii?q?QIKBwYQI4E9ghUzGiWBbAqBQU0BAgECAQwCAQIBAgECAQIIAQECnQwhMjgCB?=
 =?us-ascii?q?gsBAQMJiRYB?=
IronPort-PHdr: A9a23:4FLv9RSD/zjx4sc5cy/IdQOzi9psonWfAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBcOLsbkU16L/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNfwlEnjmwba19I
 Bi1ogjaq9Ubj5ZlJqst0BXCv2FGe/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q
 7pYDC87M28u/83kqQPDTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54
 qx1VBHnljsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7beNMaRHFBXt1QVyxHDYO3c
 pUBAfMcNuZWronyuV8OogajDgWoCu7j1jpEi3nx0qAm3ektDRzK0BU8E94TrX/YqMj5OacXX
 e2z0aLGzyjMb+lO1Dn99obGbx4vr/KLU71yf8rexkYhGhjZgliTs4HpIymY2vgRv2Wd8uFuV
 fivi2kiqwxpoDevx8YtionUhoIS11vL9iV5z5w0JdalT0N6Yd+lEJtKuCGbK4d6Xs0vTnp1u
 Ckm0L0Ko4C0czUXyJk+wRPUdvOIfZSS7B35SOaRPSl3hGhjeL+nmxu/70euxO3zWMSp0VtHr
 ipLn8fRu3wTyxHe99aLR+V+80qh1zuC2A/d5+FaLU47mqfWKposz6Mum5QdtUnOESn7k1j1g
 q+Obkgo5PSk5uD9brjlppKQLZF4hhz/P6g0mMGzH/w0PhUPUmWf4+iwyrPu8E3jTLlUjPA6i
 LfVvI7UKMkdu6W3GRVa0pw55Ba6Fzqm1dMYkmQZI19dYxKHipTpO0nJIPDlEfezm1Ssnylvx
 /DBJrDhB4/CLnnHkLv4ZbZ96VNQxBM9zd1d+Z5YEL4BIPX0Wk/+sNzXEAU1PBCzw+biENl91
 4UeVnyTAqKBLq/erVuF6vgsLuSMfoMZpivxJvk/6/Psk3M1gVodcrOo3ZsTZnC4BPNmI0CBb
 Hvsg9YBEX0FvgsiQOD2hlCPSiNTaGqoX64m+D40FZ+mAZ/ZRo+xmLyBwDu7HppOa2BCC1CMF
 2rodoqdV/cPdi2SOMlhnSIAVbW6VY8h2g+htBXgx7pkMOXU4CsYuozn1NRv4O3Tjx4ypnRaF
 cOYhlCMXWFpmSs6RzY3lPRus0x0yw/bioBliOYeGNBOsaAaGjwmPILRmrQpQ+v5XRjMK5LUF
 T6b
IronPort-HdrOrdr: A9a23:Nv9LvKj61/xFCKJ59kbNdgbLyXBQXvMji2hC6mlwRA09TyVXrb
 HKoB19726ItN9/YgBGpTntAtjifZqYz+8M3WBzB8bZYOCZghrPEGgK1+KLqF3d8m/Fh5VgPM
 9bEpSWY+eAaWSS4/yKgjVQ0OxM/DBEysqVbCvloEuFNTsaEp2IJj0UZDqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="170700629"
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2021 22:55:55 -0700
Received: by mail-pj1-f72.google.com with SMTP id o13-20020a17090a9f8db0290176ab79fd33so7223976pjp.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rubSw9FCX3UYPP3qCFnQoWoTCnQrhAdQYI5e/tU4EqY=;
        b=r8MO7Z3KCvzoVGeWiiUkF7dg+7JZf4nEjdcUyM/AX9w7VnR5bdMV+K0+ABDOYn6ms3
         TN9oSKCh19FZ3dTeF6tikK3MLImPelnmTA0cPeE4hkL+Y7FWqDlnoHvibeezBBhP70UQ
         l3gjTIuHR2SQMe3ZDKb881ijIeOo4BwtCT9ZPWoxIWFMvJGKdo9CGtoHo6cI+q5y/V3m
         BzUcQlwBmnC0xVhGEDpGHxy7tZx8XzMMXiFzYuhQju5YPfGqv+i5QlqtffWKeI0xyBJT
         EKaFUOgO0KxVMB2mqhFa3eS4tkJayeitLjGNIu51kQUHPrZJUmj/C0dQgRYvGG666zfe
         3kkw==
X-Gm-Message-State: AOAM530rzlFrBvuwdSc8yXDKLbFb/7nkNgTfirGYVIqADPFlJpH/EQSQ
        PVDqJi2Z4QwsFksr234PB6UDUH6Be5pPe6LOFBv1K5+6z0BgjahG0AgUceckwejhd1epD+9DWvl
        zS97iCrycQVklqnX43SKEZqL/Ag==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr2410938pge.37.1628747754102;
        Wed, 11 Aug 2021 22:55:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOygrKV5WhARieKOIood/QYvjnnVnFyEKRNwCN5hxkQkZt74kl1r/JcDId5gGmRbEWFlUyOw==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr2410923pge.37.1628747753894;
        Wed, 11 Aug 2021 22:55:53 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id j6sm1659165pfn.107.2021.08.11.22.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 22:55:53 -0700 (PDT)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Wed, 11 Aug 2021 22:54:17 -0700
Message-Id: <20210812055421.44450-1-yzhai003@ucr.edu>
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
Signed-off-by: Yizhuo Zhai<yzhai003@ucr.edu>
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

