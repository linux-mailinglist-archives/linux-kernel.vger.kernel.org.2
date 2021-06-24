Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B233B3B2550
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFXDSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:18:06 -0400
Received: from mx.ucr.edu ([138.23.62.3]:25223 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhFXDSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1624504547; x=1656040547;
  h=from:to:cc:subject:date:message-id;
  bh=SblKopDqFHSiwCfGDOMHISY6FX5IDGcC7lO8ql3WkLo=;
  b=P/QAnZ/2S0XhCdWPAretLFz0TXPej9aD5IgtSh32GRX+d++mnOsN/NdM
   tWLWSb2nEuZi64kWmkWvC9x7xIwT/vCFBJ8YdfzqZCc3NNEzL2K/XrutG
   nDznNLdt3iTXkbKQDHVL3NafL5I+6K+9TGnnrV2t27nCQd0Gmsqy0+LSv
   G7WRz54F6Q36PrPWG+XLLmTwo4bGVFVTpfyFbn+MGX7I8EvYAB3efsgc/
   nFZDxqVrOdhhBtjaCC+Xb/JEYJ7fIb8g1jkcyMrnd5QQPClYj/sFc4KuT
   umRLI3DUZ58E4kVC7Cs1KcZOoWIV/ItD8v6LfSS6EwGEEgSiurHDwSLHi
   Q==;
IronPort-SDR: GEkh8OYbB/BBcyHZIjEremwbHyKkOk0XK89FG/LpJK08M++NeG+rPk587OGbEkGt0BwEmvtKG+
 DDVE90rrNFfSAXmWWQJkFvycW412+2Wur+p41hOJcHpPEtWXh7fMWq9FcS8s6fgwvAVZCDpv4n
 uYhXwse7Ez2D7cEOtvYNNwLJ6vLwMKgPM2grecrv2Zs/fp/T5NuGs0Iy3YIN/JDSitvM7Pb0FF
 /P5QDipfD+QmCMPm8hPnK3PSfjf9cLW3YfbFSqWCDQYVR/24XHT463/DtlS1opn8+F3Zug+5xI
 pkE=
X-IPAS-Result: =?us-ascii?q?A2FJBQD799Ngh8fSVdFagmCDeVUWjUyHMAEBBowZGH+Ge?=
 =?us-ascii?q?YhlgXwCCQEBAQ0BAUEEAQGEUIJwAiU0CQ4CBAEBAQEDAgMBAQEBBQEBBgEBA?=
 =?us-ascii?q?QEBAQUEAQECEAEBAQFshS9Ggjgpg2ULFhVSUEUBBQE1IjmCFgGCYSaaH4EGP?=
 =?us-ascii?q?YwxM4EBiBoBCQ2BYgkBCIEoiHqFF4EZgRCEAnSHb4JQBIMbexODdgEBAZAQG?=
 =?us-ascii?q?4MEAYw7m0YBBgKDBRyCfppuRIZUjiWQfromAgoHBhAjgTGCFU0lgWwKgUFQG?=
 =?us-ascii?q?Q6NdQFCjjVBMjgCBgoBAQMJjCsB?=
IronPort-PHdr: A9a23:j0cSFx3qcqGNzqm2smDOUwQyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BWOo64x0BSVAs3y0LFts6LuqafuWGgNs96qkUspV9hybSIDktgchAc6AcSIWgXRJf/uaDEmT
 owZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF5Ovn5FpTdgsiq0+2+4ZPebgpHiTaybr5/L
 gi9oBnMuMURnYZsMLs6xAHTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjT
 bxFFzsmKHw65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz+s8
 7lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvd+e6LdfcgBRWpAWMZRWDFKDJ2lY
 YASAeoBPPhXr43gqFATqRezCxWgCObpxzBPmnL707E23/k4HQ3awQArAtYCvGnUodnwMqoZT
 OK7w7TSzTjbb/1Yxyrz5obLfB4muvyAQa58fNDNxUQ1Cw/JklOdopHlMTOP0eQNtnCW4OhhV
 eOui24ntgZxqSWoy8Ysi4jJhpgaylHY+Sllzos4PsC4R1JhYdK+DpRfqjyaOpJwT8g/TG5mp
 Dw0xacauZ6nYicK0pInygbQZvCZcYWG4g7vWeKRLztmhH9oe7yxigis/Uagy+DxVNS53VdIo
 ydBk9TBt24A2gDQ58SbVvdw/Fqt1DmR2w7T7OxPPEM6lbLDJpI/3rI9koAfvEfDEyPshkn6k
 bOael859uWs7+nreqjqq56YOoNulA3zPKQjltahDek6KAQCQXaX9Oq62bb+50P2Wq9Kgeczk
 qTBtZDaItkUqbChDg9O14Yj9w6/DzC70NQEhXUHLExKeBaAj4XxPlHBOvH4DfOmj1S0njdn2
 unKPrP8DpjJKnXPirjhfbF6605TzAo808pT6I5TCrEEOP7zW0nxu8LEDhIhLQC43+LqBM9+2
 44eQ26DHLKVPL/IvVOV4u8iJ/GAZIoPtzb8L/gl6eTujXg8mVIFfaio3JsXZ2q5Hvh6P0mUb
 2HhgsodHmcQpAYxUvHliECaXT5Je3myR7485i08CI++CYfDR4atgKGO3SuiHZ1ZeHpGClaSH
 nfsbIiERfgMZzyIIsN7kTwLS6KhS4k/2hGqrgP6zKBnLuWHsgMCspe25dln5/DU3UUj5zx9D
 pzFiEmQRHsyk28VEWxllJtjqFBwnw/QmZNzhOZVQJkOupt0
IronPort-HdrOrdr: A9a23:+VekoKPjCD+S1sBcTsCjsMiBIKoaSvp037Dk7TEVdfU7SL3+qy
 nDpoV56faLskd2ZJhIo7npU8m9qBvnlKKdirNhWYtKMjOW2ldA77sO0WIh+Vfd8uHFmdK1rZ
 0QCpSWweedY2RHsQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="160618692"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2021 20:15:46 -0700
Received: by mail-pf1-f199.google.com with SMTP id 7-20020a6215070000b0290301d427d4baso3028067pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+IbvtWPOhTjlxqwR4MNXPf2er5NRjM2nXY4Wvi5w5Z8=;
        b=LX5HWSIrDisspl1eU0BjcsXksYB14lipYo2o9WpGA2Xc39XhhoN2+B65/0tqVGltbY
         SV4Gaa0B1ZT3UwBn15cFt75IzAcntEx+sKSnBY11qTis84hKWAaB+3ZcACXIroDLMEFu
         ui+LNOs4cbDhuEhsk7Yga7TN8S13Hw/C3EtC6RXySldDMyZnv4bHhj5eEMrmg6gv0593
         btWtNZiakpIbRgsiujmZNXOUhGwjka2KifbT1LSQc5P6WOJKgacK2MOKFOT5Pf7koqQ6
         XoZHTKNr+sj5bNT/1papSEWJaNHVGYkKhbN+GFmK1Mzwc7GWZLmiwCN7h0I8kV6H6R8u
         xNVA==
X-Gm-Message-State: AOAM5334oe0aNuGsKoSgjhjvPzQLJK10PAzTd1ypPsh0Al2C2/8EPBRQ
        oe2PuQjDb+SmilWiF9+O2pxp+nTfK2IOYOhQI5xpUJkTRTXB5FMPD+H2xBmklam2JVacft4a15p
        yUio+PKkPdruPmrWlXTXHa4FY8Q==
X-Received: by 2002:a17:90b:1291:: with SMTP id fw17mr3008326pjb.105.1624504545076;
        Wed, 23 Jun 2021 20:15:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4C+kYv2hUl0KJDQVzoA3q03zbeF8vVcB+7UTZ0fKdC08nXOLdUMs3yBBA0ckjCw+LxUv8Zg==
X-Received: by 2002:a17:90b:1291:: with SMTP id fw17mr3008313pjb.105.1624504544896;
        Wed, 23 Jun 2021 20:15:44 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id u7sm811917pjd.55.2021.06.23.20.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:15:44 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Thu, 24 Jun 2021 03:17:17 +0000
Message-Id: <20210624031719.11157-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function mt9m114_detect(), variable "retvalue" could
be uninitialized if mt9m114_read_reg() returns error, however, it
is used in the later if statement, which is potentially unsafe.

The local variable "retvalue" is renamed to "model" to avoid
confusion.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index f5de81132177..b02a8cd3dde7 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -1533,16 +1533,20 @@ static struct v4l2_ctrl_config mt9m114_controls[] = {
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
+	ret = mt9m114_read_reg(client, MISENSOR_16BIT,
+			       (u32)MT9M114_PID, &model);
+	if (ret)
+		return ret;
+	dev->real_model_id = model;
 
-	if (retvalue != MT9M114_MOD_ID) {
+	if (model != MT9M114_MOD_ID) {
 		dev_err(&client->dev, "%s: failed: client->addr = %x\n",
 			__func__, client->addr);
 		return -ENODEV;
-- 
2.17.1

