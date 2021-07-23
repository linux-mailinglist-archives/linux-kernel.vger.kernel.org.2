Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE083D30EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhGVXyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:54:06 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:25469 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbhGVXyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1627000481; x=1658536481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WjZhPfz6WGA+e7+W6h7hHSdZYaAsvQABJiyNAJlDjpE=;
  b=DpsWAv675HQscUWOYm4bE2aRfl/oR96f5VuFH3x3mTqwK9sf5ESCQq4T
   xVWdHqs7QZLDS/5CIKj0lw0n35NHaO4dKIrV53fw5z1eoWmEi47CVHNuY
   sBQBuv9vzlKba70i4CAqGrhmT3ZqdTmyZ6vX8VLyKpxX6mo1TOWtFBZfP
   decThME2EsuI0xbuCXAkJRrIzuzBv2sJeMrRf8Nz+SgE5TMsbnvDCjjIH
   rThOHJLWe7jSR0oTh7HNzeZ6/Xy3Z0Lj2glP73CbnDSQyqAv61W27rH2c
   d2cstCQ8nN8TPln18+WEDWITtI/5rDArGDWeljhHEP2JTfAszVYGXuTVG
   g==;
IronPort-SDR: sV0leLweAYBHxHPaUxgj01+4nsLoHUAFSVAPxylBcRtD9Xk8qfSqOVe3LmbXoOQTGQ4YjJEQdo
 TCf3SxT6sdSKvUtmv0W1ybZkXgNlEKy95By4CKLob2AI0rRWPfvg9/2SPiPxIIqafzCHSVwgva
 MWCMm3dj+ZOeMU1JEH/JDnAkGipapKe+edo6ozSTNyMuOb7UKgnI0TvJfYZlEGkG9wbdi2jOc2
 3q4ppxJDfFWW/QJoBkGQbRe3i5rnu4bPxVeHuo6BUmb2DxTCTWu6TsFzFR+ED+uqYEsUVLef00
 1kTJIEjmkgvUIo7hc+NmyeVn
X-IPAS-Result: =?us-ascii?q?A2FrBABBDfpghsbWVdFagmKDFmNVFpRmAQEGjCYYgQKGf?=
 =?us-ascii?q?IhmgXwCCQEBAQ0BAUEEAQGEVwKCeAIlNAkOAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?gEBAQEBAQUEAQECEAEBAQGBCgtZC2OBT4F5BgQ9gjgpg2UJAgEDEhVSED8SN?=
 =?us-ascii?q?AEFARwZIjmCFgGCYSYFnHCBBD2MMTOBAYgkAQkNgWMJAQiBKIh8hHAngRmBE?=
 =?us-ascii?q?IJQgTN1h2+CUASDHXsTgimBUAEBAZAxG4MGAYxmm2gBBgKDDByDEpsSRYZgj?=
 =?us-ascii?q?l2RJrsWAgoHBhAjgT2CFU0lgWwKgUFNAQIBAgEMAgECAQIBAgECCAEBAo41j?=
 =?us-ascii?q?jZBMjgCBgsBAQMJi1kB?=
IronPort-PHdr: A9a23:abcPAxK9kTpxvhQgXtmcuJxmWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFvbM20xSRAs3y0LFts6LuqafuWGgNs96qkUspV9hybSIDktgchAc6AcSIWgXRJf/uaDEmT
 owZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF5Ovn5FpTdgsipy+y+4ZPebgdHiDahY755M
 Qm7oxjWusQKm4VpN7w/ygHOontGeuRWwX1nKFeOlBvi5cm+4YBu/T1It/0u68BPX6P6f78lT
 bNDFzQpL3o15MzwuhbdSwaE+2YRXX8XkhpMBAjF8Q36U5LsuSb0quZxxC+XNtDtQLsqRTqt8
 btkSB7wiCcGKTE59n3Xitdth65fuR6tugBzz5LRbIyTMfp+f7jdfcgbRWpHUcZaSjJPDJqhZ
 IsBDuoOI+JYoJTgrFcKoxayGQygCeXoxTJUiHL6wbA23/09HQ3bwQcsG88CvXTRoNjzKawcU
 /26zLPQwDvDcf1YxDnz5ovPfB8jr/GBRq58fdbLxEUzDQ7JkkmcpIr4ND2VzOQNtG2b4vJiW
 uKuim8nqxxxoj+yzcoriojIh4IVxUrF9Sll3Io4K8a1SFNnbt6+CpdfqTyVN5ZvT84kXmpnt
 zo0xKcctp6nYCgF1o4nxxjHZvKHc4aE/x3tWeeNLTl4i3xoZLGyiha9/0Wk1+DxS8q53UtKo
 ydbnNfBuHAA2hPO58aIV/Zw40Ss1SqL2g3T9OxJJ10/m6nDK5M53LI8ip4evV7AEyL2gkn6k
 rKae0o+9uS17+nqYa3qqoKdOoJwkA3yLKojl8ylDegmMAUCRXaX9fqy2bDl4Eb3Wq9Fjucsn
 ancqJ3aIMMbqbOnDAJNyYYj7gq/Dy+h0NQFgXkLNFJFdwyDj4juI1zOJer3Dfa7g1i1iDdrw
 +3KMqTvApnQKnXOk63tfbl6605bxwozyc5Q64hIBbEGJfL/Qk7xtNrGAR8lKwG43frrBdFn2
 o4dWW+DGLGVPL7dvFOS++4iJ+qBaJcQuDnnKvgl4/DujWU+mV8YZaSo3ZoWaHCiEfRnP0mVf
 XThj8wcEWgWpAoyVvLlh0CfUTJLfXa9Q7o85i0nCIKhFYrDQoGtgLqc3Ca0B5FWZX5JCkqKE
 Xj2c4WJQOkMaC2MLc97iDAEVqauS5Un1R6wsA/20b1nLvDb+n5Qm4jk0Y1E5v/TiBZ6oS1mD
 82ciznWZ3x/hCUFSyJgj/M3mlB01lrWifswuPdfD9EGoq4UOjo=
IronPort-HdrOrdr: A9a23:pjn0ZqOwjRk9hMBcTvyjsMiBIKoaSvp037Dk7TEVdfU7SL3+qy
 nDpoV56fawskdoZJhfo6HnBEDoexq1nv5ICMsqTMyftWHd2VdAR7sSibcKrQeQeREWNdQx6U
 6jScJD4RHLYmSS9fyKmTVQ2uxNruW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="227850351"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2021 17:34:39 -0700
Received: by mail-pl1-f198.google.com with SMTP id c1-20020a170902aa41b02901298fdd4067so867429plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gm4YUZj/EvvmVEru6DPj42P4a48GvfDB+tH0wczqnc0=;
        b=nGKjr/EAieGfTilaVRTElX9aYrdyuCIQSMpeftJpFDINuN00IZLSuwfCLBtRjeX2ma
         AR3ZoZedWlgDHY/vVXDI7puWqbf8ANu/NuPNDjoB5+vBmgdrTsrq3sAqqnmbjVGlJDpI
         sMTLbP/Rj4uYGr1kCITIOt5YZtwzKmK/y4Xz7cW3GGxTgB+vfE7TOgYLRbrOVe6VoQYc
         wCjyFd247XV4zfftCe11Cod1S9WNwGc5F7YO2WL4h0VH+VuhzQ1/o3d15Vx0TowQJb/a
         yo/td8Vb43ViC/w4gfjrGV0by8Nz/FCvAyMoOwBZOD0S2s7poz20N0xXb8lidrSU+raR
         nQNQ==
X-Gm-Message-State: AOAM530rZCyYLoWFxbW606hmCOm+Zg+Xbhf4+xkBTU1lK8eF54UCvwHU
        9ivKV39mxF4/Az8UnumUzyPnQNoPXrWulpu05c9T94gvekMv0P58Y1EgsESk4kVFcUNR3O1O7ec
        DyqPE47Cl0uEH2MviwK013QNU0Q==
X-Received: by 2002:a17:90a:474f:: with SMTP id y15mr2247991pjg.2.1627000478320;
        Thu, 22 Jul 2021 17:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3T0RPoWuoz2nGgWu0oAbQM62TN09QruMzto43e2KyEy0LRuU/QLOYIutxXpEvtusHLp4qOA==
X-Received: by 2002:a17:90a:474f:: with SMTP id y15mr2247975pjg.2.1627000478123;
        Thu, 22 Jul 2021 17:34:38 -0700 (PDT)
Received: from kq.cs.ucr.edu ([169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b18sm4059224pji.39.2021.07.22.17.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 17:34:37 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Fri, 23 Jul 2021 00:36:04 +0000
Message-Id: <20210723003607.64179-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723085145.1ce7ee5c@canb.auug.org.au>
References: <20210723085145.1ce7ee5c@canb.auug.org.au>
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
Signed-off-by: Yizhuo <yzhai003@ucr.edu>
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
2.17.1

