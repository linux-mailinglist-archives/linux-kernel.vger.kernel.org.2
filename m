Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B673E8906
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhHKDyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:54:43 -0400
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:19595 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhHKDyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628654059; x=1660190059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+r6J+pkHEbVFSGHQElxJnDO6jFts9TCA3QpIXRznslM=;
  b=qS2Qg/T9bs1E5OqJAYnxBh3q1eGCCZzGcVakfxMFdm8ubDyYxm2KjIUA
   FM2mTVi7ZpcJv2AEpxknor8NIkWaZTbo/kJyYhNJg0AXpuSekgl/VURtK
   mbI8t8ThnQ7UBgFCAeyoHD72R4vnpOidw8rEJ3Al2wg7mOrWTG3vzqIno
   NkrBlqAu9l38ud5CzcKrLqWM18JKsk2IyRkPmG3hZUl87Xao4AvDZ1mWX
   aGovB+Y7U67NM9JbKdSFL9pPqLOni2NJt5iiKHZn4+lCLT0fWAR7IMCJl
   kOsIfPpBHpPfc8Es80iUQugsBoE8Uu/yOal4Wkta8nszZHVPOCG1WqSzz
   g==;
IronPort-SDR: mNPBNFDsdAQDfF2yd1IHtU8f0PLKB/WpHzHvQFdedHupzOBJFXFJos6lHPyWjFUN2hsgxXlHUG
 sOUWi72BodCfUQeelMHvooINs4dv0nSz8NJXrwCsiiQjgHeq5NZ8Wqtm4Cz5AVHu79+4iVlrzf
 8W/gqGTeiFxUdTihPLxGyArzaAVtZDhMfLy8P1J/NGipDm5G0GpAehfWEYICxNNSkzLCadjs1Q
 AD1BYBIyJPSy7ddPitPHZ0bJad8DPIcKH2dX+jelUfNli/DNGA6ZVu3jdQCoC4Kc9QtPdMKxZ3
 31T1kmjWs8PRHZkZIZvnon5c
X-IPAS-Result: =?us-ascii?q?A2EiCQCjSBNhhsXWVdFaHAEBATwBAQQEAQECAQEHAQGBb?=
 =?us-ascii?q?gKDd1UWjUyIaoplgRqGfIhogXwCCQEBAQ0BARITHAQBAYRYAoJkAiU0CQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBgEBAQEBAQUEAQECEAEBAQGBIAtZC2OBT4F5B?=
 =?us-ascii?q?gQ9gjUpg2UJAgEDEhVSECAxNAEFARwZIjmCFgGDB50dgQQ9jDEygQGIFgEJD?=
 =?us-ascii?q?YFjCQEIgSgBiH2EcSeCKYJQgTN1h2+CUASDW3sTgimBUAEBAZA6G4MGAYtRg?=
 =?us-ascii?q?SabcQEGAoMOHJ4xRZVFkSq7KgIKBwYQI4E9ghUzGiWBbAqBQU0BAgECAQwCA?=
 =?us-ascii?q?QIBAgECAQIIAQECjjWOViEyOAIGCwEBAwmIeAE?=
IronPort-PHdr: A9a23:5+QGbhFxVuRxer/16YT9L51Gf+pMhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31BmZBc6FurptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys55HfeQZFiCaybb5zK
 Bi9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+88
 6lkVgPniCYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4e6PdfMgaRXFAXsZXWCxKH52yY
 ZISBOoPPOZXsY39qEYTphe6CwSgGObjxzlPiXLq06A2z/ktHRja0AA9AtkCtGnYodXwOKoUT
 Ou7zrTHzS/bYv1Wxznz9YbGfBMmr/6OU7J9atbdxVU1Gg/ZlFictZDpMjWI3eoNqWib6O9gW
 PqthG4mqgBxoiWvxsAxgYbKhoIa0FHE/jh+zYc1JNy4SFR0Yd+4HJdMuSyXLJZ2Td84Q21yp
 ik116AGtIe9cSMXx5sp2wTRZOabc4iU/B3jTuCRLC9kiH9hZb6xiAi+/0i9xuHhWce63lhHo
 yRFn9XQuH4AywDf58aIR/Zz/Eqs2TeC2Q/P5u9LI005i6vWJZEhz7A+kJcYrEfNHjfulUnok
 KObcl8o9+uo5uj9fLnqu5CRO5Vphgz6MKkigtGzDOU8PwQUQWSW9+Sx2Kf98UD7WrlGkOM6n
 6ffvZvHP8oUvLS5DBVQ0os77ha/CCqp38oAkHkcKVJFZAqHj4/0O1HSOPz4Demwg1CrkDpzw
 vDJJLzhApHUInjblLftYK9x60BBxAc3z91T/Z1UCrYGIPL8Xk/+qsbUAQM+Mwyx2+rnCdN92
 Z0CWW+XHKOVLKffvUWL6+8vOeWAepIZtTnnJ/Q44/Pjj2c1mVoHcqmo2ZsXZmq4HvNjI0iBY
 Xvtg9cBHn0LvgYiUODnhkaPUSNPaHaoRa4z+Cw0CJ++AYfZWo+tmKCB3Du8HpBOYmBGC1aME
 WrndomdWPcDdjiSIsl/nTwATrWhVYAh2g+0tAPgyLpoMPDU+isGupLnztR14PfTlR5hvRJuC
 MHI4mCfT3xz1lEITj5+iLFtoUV8kg/Y+bVzmbpVGcEFtKABaRszKZOJl78yMNv1QA+UO4rUI
 Gs=
IronPort-HdrOrdr: A9a23:Zbb0qa0qtgGvZYwMWuniRQqjBIkkLtp133Aq2lEZdPWaSL3gqy
 nOpoVi6faaskd1ZJhNo6HjBEDEewK+yXcX2+gs1NWZLW3bUQKTRekI0WKh+V3d8kbFh4lgPM
 lbAs5D4R7LYGSST/yR3OB1KbkdKRC8nM6Vuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="59655351"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2021 20:54:17 -0700
Received: by mail-pl1-f197.google.com with SMTP id p7-20020a170902b087b029012c2879a885so545699plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lSccYX79bCga8PfiO71I5eGOlFYRkHyS4P+krasVmlI=;
        b=oRUClnIQNvelOLO39KT3aPsNycQydA387tXUozyKguwHYHvtyBYcLkopMyNZH3MlR+
         0WzAdnpIes/lLP2T4M3QFiI2UQRMCZOcSDy08HGWHqaObDk5j+vZjICSgqMSLW7ldrrY
         u01SBjYPWUErviwiTYzf1DE8jn8qodQ1MhmT+MtIY03JPZxFFE3e8dahy4qbatALlheg
         NiFcx4L0BQjHS6KddSTokXHkii84VsNF5Z4gLRsaZ5q915EXdYIyfiXCAAEzcXER9LD0
         gllrqthjTuuwvOC4CB0oky+zsAsjGngl7SReCYIt5xtRmvlxNhDLWiGEVEDZkNnwARNe
         3fLQ==
X-Gm-Message-State: AOAM530pCphY8D0KSBYvYgC78PVtac6o7Bp3E1FRIGZ/eXgacVDKfLir
        5rVZNeAmbxuqmN5hd6/YWCTBmrCmnDyg5r4C7wcHPvtRd6c1xBJRn/VDk1JgAQgX84Qq5HNAWXW
        wGE0s9IxE+B18yYAltlgi+MOnHg==
X-Received: by 2002:a17:90b:f17:: with SMTP id br23mr8156311pjb.60.1628654057100;
        Tue, 10 Aug 2021 20:54:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqbNjbWkU4ar3037qpQVx+m8hnhLSTWWK+YqOhqq7Z85m2c+hqh7j8OGYm44oN3HtAPxORMg==
X-Received: by 2002:a17:90b:f17:: with SMTP id br23mr8156299pjb.60.1628654056896;
        Tue, 10 Aug 2021 20:54:16 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id 143sm21100364pfx.1.2021.08.10.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 20:54:16 -0700 (PDT)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Tue, 10 Aug 2021 20:54:03 -0700
Message-Id: <20210811035405.17382-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723003607.64179-1-yzhai003@ucr.edu>
References: <20210723003607.64179-1-yzhai003@ucr.edu>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

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
2.17.1

