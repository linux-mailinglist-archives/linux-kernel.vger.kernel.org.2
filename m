Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D93B1385
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFWF5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:57:21 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:8796 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWF5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1624427703; x=1655963703;
  h=from:to:cc:subject:date:message-id;
  bh=HeroiO/f70kMSW1+IDvJqEJ6G7TytY2YJRExDN92zzI=;
  b=L55m4VKLRQZVIuA1zjcebYqaysZozTLJu3wj4IuskgfKerC7S6LONspA
   02Ero9pP0iZYQbXTUNRHZV/aVDZAu4ZMqCcAGaHsm9aiT9Kwjvgjfa684
   jELtf4p4MQCzqtztq7FC9lXbC5+BM9MNLr/6Nbv/0kOM3regWE8u/b/OW
   ocFzDoVi2J+/cOrPCjYsTb53XSV7P+NDs+0TGi81oqnUBBZDFTODqm8Qn
   TeAFlg1tFir9JfoqAleWwtlPrCBVUY3IbKp634xsRRuUkgqG4hWox0JRq
   IwrYEbYJrqTu+2M+3bNlPGIRHXkR6jiL4D5SQqVRVfBpky3jeCPRuHao0
   A==;
IronPort-SDR: UfJUe6UjWlytXeDZk27n87nRr50PtenEx4UmiZZohgO/V2jfB0pbkF13jzxmj4BF8JUdwxK6Oc
 2Kw2FfkNU4oy4H3q/dzlmBF1YfL2J1Y9tBUs+khftk/7E6sWh06ad6wEznLuEIad3rWwksxpyk
 0iWhwfINf3ekHL9pfLRfZwfJ2ks3eaOhjMFgNmx67mZpnxgV0tPMqDFhHFK4psJAACP8pgjZ9+
 d/TumpUq9D1eoxbuvQmEWEKAXX/XT8VOJo8kjl5hSS9Br+Pb1lHRHV+oq4T70RlS+ZxPa1iS/N
 IXA=
X-IPAS-Result: =?us-ascii?q?A2HoBAD1y9Jgf8XXVdFagmCDeVUWjUyHKgEBAQaMGRh/h?=
 =?us-ascii?q?nmIZYF8AgkBAQENAQFBBAEBhFCCbgIlNAkOAgQBAQEBAwIDAQEBAQUBAQYBA?=
 =?us-ascii?q?QEBAQEFBAEBAhABAW6FL0aCOCmDZQsWFVKBFQEFATUiOYIWAYJhJgWaFoEEP?=
 =?us-ascii?q?YwxM4EBiBMBCQ2BYgkBCIEoiHqFF4EZgRCEAnSHb4JQBIMdexODdgEBAZAPG?=
 =?us-ascii?q?4MEjDubRQEGAoMFHIJ+mmpEhlKOJZB9AbodAgoHBhAjgTGCFU0lgWwKgUFQG?=
 =?us-ascii?q?Q6NdQGOd0EyOAIGCgEBAwmMVAE?=
IronPort-PHdr: A9a23:WXC1CB1pRT5mSnXksmDOUwQyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BWOo64x1hSZDc3y0LFts6LuqafuWGgNs96qkUspV9hybSIDktgchAc6AcSIWgXRJf/uaDEmT
 owZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF5Ovn5FpTdgsiq0+2+4ZPebgpWiDayYr5/L
 wi9oBnMuMURnYZsMLs6xAHTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjT
 bxFFzsmKHw65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz+s8
 7lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvd+e6LdfcgBRWpAWMZRWDFKDJ2lY
 YASAeoBPPhXr43gqFATqRezCxWgCObpxzBPmnL707E23/k4HQ3awQArAtYCvGnUodnwMqoZT
 OK7w7TSzTjbb/1Yxyrz5obLfB4muvyAQa58fNDNxUQ1Cw/JklOdopHlMTOP0eQNtnCW4OhhV
 eOui24ntgZxqSWoy8Ysi4jJhpgaylHY+Sllzos4PsC4R1JhYdK+DpRfqjyaOpJwT8g/TG5mp
 Dw0xacauZ6nYicK0pInygbQZvCZcYWG4g7vWeKRLztmhH9oe7yxigis/Uagy+DxVNS53VdIo
 ydBk9TBt24A2gDQ58SbVvdw/Fqt1DmR2w7T7OxPPEM6lbLDJpI/3rI9koAfvEfDEyPshkn6k
 a+bel859uWs6enreqjqq56YOoNulA3zPKQjltahDek6KAQCQXaX9Oq62bb+50P2Wq9Kgeczk
 qTBtZDaItkUqbChDg9O14Yj9w6/DzC70NQEhXUHLExKeBaAj4XxPlHBOvH4DfOmj1S0nzdn2
 unKPrP8DpjJLHXPirjhfbF6605TzAo808pT6I5TCrEEOP7zW0nxu8LEDhIhLQC43+LqBM9+2
 44eQ26DHLKVPaPIvVOV4u8iIfGAZIoPtzb8L/gl6eTujXg8mVIFfaio3JsXZ2q5Hvh6P0mUb
 2HhgsodHmcQpAYxUvHliECaXT5Je3myR7485i08CI++CYfDR4atgKGO3SuiHZ1ZeHpGClaSH
 nfsbIiERfgMZzyIIsN7kTwLS6KhS4k/2hGqrgP6zKBnLuWHsgMCspe25dln5/DU3UUj5zx9D
 pzFiEmQRHsyk28VEWxllJtjqFBwnw/QmZNzhOZVQJkOupt0
IronPort-HdrOrdr: A9a23:+EQGW6lazgHaw9s/qTnnXnHJDRPpDfIt3DAbv31ZSRFFG/FwWf
 re+cjzuiWE7wr5NEtQ+uxoRpPwJ080nKQdieJwAV7LZmjbUQCTXeVfBOXZsl/d8u7Fm9K1F5
 0LT0GzMrLN5CBB/L/HCcCDf7gd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="221745220"
Received: from mail-pg1-f197.google.com ([209.85.215.197])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2021 22:55:02 -0700
Received: by mail-pg1-f197.google.com with SMTP id x9-20020a6541490000b0290222fe6234d6so681492pgp.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dZ01YeGO36ttJa1EkqeDzGCMLruDwsRboZArrpn5SFM=;
        b=WKQ/3RqyrMt3RAJ83w6TRgOu8jcg5Z1xAwgsa8uObqUurw4M9Kq/UmgzEIfuv0HBqw
         s0CU6BTVm1lpOuIUbV3VM9zGsIF/un5ZPSfJoO/haHAj9Yn0ttmhrNgONryN4U/KugSq
         720cVc3R+aXA0g01r+olXpSSNjtXqov3MI6aLNhSH3ESHMEnX5YqUYMaComvRHX+8TGu
         1k6ueF5atZmR3RM+zv/6C8DAl+d5YztWS/RXuelntjUJxOyJ5g82G/++3oOJMQ7SHpSu
         qQEWOBXE3OqCGbW2ncthT8iBWIPTesERF6kMAIEVYoSsW3FApLVsxBpyG5a1iOl3sff8
         1t5A==
X-Gm-Message-State: AOAM533c2mfISk22iDlAzjDUFfnisCv8mzJ4L9n2Li/BPzZuaTjfUcf3
        PTNGyXvvkgLlMKRjopLJi574U1jdKIfWxPozmkdIxCP+QnpBk6QKnO+z1PLvK0FEyg0DdisSNd2
        whSAwa65w6ZoUBux1ilR2+RnXAA==
X-Received: by 2002:a05:6a00:2395:b029:304:7a51:6f1d with SMTP id f21-20020a056a002395b02903047a516f1dmr7387060pfc.53.1624427701885;
        Tue, 22 Jun 2021 22:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZcMZuv9nHzaTSg9WiNWU0DHaItTgV98zNDYoD4whsou4ZO9Ewniqbv6pxQU3GccP+KRXscw==
X-Received: by 2002:a05:6a00:2395:b029:304:7a51:6f1d with SMTP id f21-20020a056a002395b02903047a516f1dmr7387023pfc.53.1624427701428;
        Tue, 22 Jun 2021 22:55:01 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id ml5sm3980846pjb.3.2021.06.22.22.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 22:55:01 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     yzhai003@ucr.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Wed, 23 Jun 2021 05:56:31 +0000
Message-Id: <20210623055634.12603-1-yzhai003@ucr.edu>
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
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
index f5de81132177..fbd6c6cd84c8 100644
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
+	ret = mt9m114_read_reg(client, MISENSOR_16BIT, (u32)MT9M114_PID, &model);
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

