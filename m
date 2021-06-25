Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9361E3B3C49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhFYFjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:39:46 -0400
Received: from mx.ucr.edu ([138.23.62.71]:26674 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhFYFjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1624599444; x=1656135444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G2oig34TGgKGc+PsnU3ZBFvHpvFyfTN2H3X7vZGztVI=;
  b=GCKI3alGiVEj1BdGVppofLbh9kDcP5kqgec3X3uOWlwgmLAwpeq8yP21
   V8He270rrA3e6X+Cn9L3Lcg6+yt9GRShKeujlNlbH5zyWYaK8rqZlN3u7
   BVIhz5dIg1I2mD3lRXyAkPm3Em7jdKVosGadcs3neOak5L0mxec7nWBIV
   7eMi7c37rUXpWX1x6B37UEroPfVIU5w4dOEAw0Ll7slmghvIxqs/6sNob
   Uf05Jhma8nNZJk+GqXP/tXRmHwfw2i91cwAgUdl7W/H8/f8uyeb7ZShQG
   D8/zyfSBfFTcftRrUW22UIpxvrk+Eg2MBtrUigC1TzN7a/lFn5uTUCrEJ
   g==;
IronPort-SDR: S9P4pnI3yWb2OxF4GM/rUrhZx+az0UQPSDh24Gz+XfLzavOdDxlWxygBDZE2T0SsCqMrE/+Bmo
 6qOsZPpZi7yPXYaAU/k91mStR7tpi/2PANL+Dsydyo9UdyulDi3rBWfp0U0z5wMKZ1jvcZbdbh
 Hov2rUNR6jdCh0R/xoU5knX1nh9LVKlqMgnFsMmNG8xZXtDq+Uf0pInqXOeBXEmEhK4QsIPLAx
 nWOXAyVAz7fRW/x5N2Cx9MBeECrI5WLVqsV848H6NbrZJDtRKd8JoRGpLc6ayrySaPEn13s6Ar
 6kE=
X-IPAS-Result: =?us-ascii?q?A2EUBwDzatVgh0XYVdFagmCDeVUWjUyHMAEBBowaGH+Ge?=
 =?us-ascii?q?YhlgXwCCQEBAQ0BAUEEAQGEUgKCcAIlNAkOAgQBAQEBAwIDAQEBAQUBAQYBA?=
 =?us-ascii?q?QEBAQEFBAEBAhABAQEBbIUvRoI4KYNlCQIBAxIVUhBRNAEFARwZIjmCFgGCY?=
 =?us-ascii?q?SYFmwSBBD2MMTOBAYgqAQkNgWMJAQiBKIh6hHAngRmBEIQCdIdvglAEgx97E?=
 =?us-ascii?q?4N2AQEBkBMbgwQBjDybRwEGAoMFHIMAmnBEhlSOJ5B+ujICCgcGECOBMYIVT?=
 =?us-ascii?q?SWBbAqBQVAZDo44jjVBMjgCBgoBAQMJjG0B?=
IronPort-PHdr: A9a23:SYxabBCKhTP5y0NwJqW0UyQUlkMY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZuaw8ygSVA86FtrptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uyv/5DfeQtFiTW8bL99L
 Ri7rRjau9ULj4dlNqs/0AbCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3T
 bpDDDQ7KG81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjm58
 axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7deNIaRXFaXsZQUSxBDZ63Y
 ZUWAeEcM+ZYrpfyp18TohCjAQWhCv/jxjpOi3DxwaA33fgtHRzf0AA8At4FrXDYoMj1OasXV
 +2+0avGwijZb/5O2Tnz9pXGfB4ir/+LX71wf9HcxVUzGw7fklmds5DpMy+T2+8Qs2ab9e1gV
 ee3hmElqgFwozivxtorioLUgY8UylHF9SVjz4Y0OdG0VEB2bMW5EJRMrSGWLZV5Td4/Q2xxv
 isx17IJt4KhcicQ1JQn2wDQa+aBc4WQ4hztVPudLzh5iX55eLyxiAq//Eugx+PzUsS5zUtHo
 ylYn9TMqH0D2RLe58iIR/Zg8UmsxCuC2gPP5uxAIU05i6zWIIMizL4ojpcfr1jPEyvslEj1j
 KKabFso9vWp5uj9Y7jrooeQO5J1hwz6KKgihMKyDOQiPgQQXWWX4/qw2KPt8ED/Xb5ElOc5k
 rPDv5DfPckbo6m5DBJL3Ys78Ba/Cium0MwfnXkaMFJJYBKHgJbtO1HJOP34CO2wg1WokDty3
 /DGPKDtDozDLnXClLrtZ7l960lbyAo8ydBQ+YhYBa0GIPL2QkPxtdrYAQElMwGs3errFNFw2
 pkdVG+PGKOVLr7evF6S6u8uJ+SAfIoVtyz8K/gh6f7ul3g5mVoFcKip3JoXaGq3HvV6L0mFb
 3fhmcoBHnsQvgYkUuPllUCCXSZJZ3muR6I8+i07CIW+AIfHR4CthqGB3SiiEp1VeG9GEFaMH
 mnsd4ifRfcMZzydItV7njwHS7ehUYkh2g+qtAPgzLpnNOXUqWU2r5Xmgel09e3Okllm5C50B
 sXFizqlUmpu2G4EWmllj+hEvUVhxwLbguBDiPtCGIkWuq4hbw==
IronPort-HdrOrdr: A9a23:ywJm26H684XPhGVApLqE1ceALOsnbusQ8zAXPo5KOHlom6Oj5q
 eTdZggpHzJYXMqKQkdcK67Sc+9qBrnnPYfgbX5f43SJzUO0FHIEGgI1/qH/9SPIVydygef78
 pdmmpFYuEYwWIUsS+D2njALz/o+rXozJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="224719272"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2021 22:37:23 -0700
Received: by mail-pj1-f69.google.com with SMTP id b3-20020a17090a8c83b02901703601b0afso220674pjo.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 22:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xtwG69GQCPYiiB5WlVucW+OBGTJgS4kN+uKVm3Qcm3Q=;
        b=FB/uLDnYdlxiPrlRSnMxEmYexLjZ1/rQZmrcB2tJvDVBWH71Dy9J0lOfBbPta0CXRn
         /g1grZSM592Ui68gigJT+78DNTosF08YUJdgLLSLhSR9YKDsja7Km0nKWP9y6+zcplzb
         ddIPW/eLx4kDzL2mw32wfZseXMXCVloHktV3MQrqkP52g4q+f+9VVL8VtduzeOPmiDQq
         MMGeyGfS5vzrW30yC4Q8PffUeyfXwtA7MhbghnYvLNOQWOKGLVBcjB0tGqtI/Pk8FIY/
         jiZbz8+5SpUowuSTxNQSpUAMhzt7vwynCfoDPrtIzHdQAPK9g8QM/swgY39SqL99r/Np
         Sufg==
X-Gm-Message-State: AOAM530v98dWbTv2yIGozWlbbAVurMU0R7L3he+2hBJssHdAx172yvIF
        HAxwC1n+xmMFzuKmUxJNjTN6uM/5bTEOu9X71pWx3hpcRXYCvAbC7wh1xcNRRYiBBe4vTpcW+IT
        rW57ZWmKnUux5znX3W1pt2Ddkuw==
X-Received: by 2002:a17:90a:af95:: with SMTP id w21mr19507061pjq.72.1624599442525;
        Thu, 24 Jun 2021 22:37:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqRTmcqC4vi40EHsgDckYDej90aX9OSDH8R6PN5TIdXSwHdDOECqZKmcofW6Yn2pEh34YR1w==
X-Received: by 2002:a17:90a:af95:: with SMTP id w21mr19507045pjq.72.1624599442356;
        Thu, 24 Jun 2021 22:37:22 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id z26sm260933pfk.112.2021.06.24.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 22:37:21 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: atomisp: fix the uninitialized use and rename "retvalue"
Date:   Fri, 25 Jun 2021 05:38:56 +0000
Message-Id: <20210625053858.3862-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624031719.11157-1-yzhai003@ucr.edu>
References: <20210624031719.11157-1-yzhai003@ucr.edu>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function mt9m114_detect(), variable "retvalue" could
be uninitialized if mt9m114_read_reg() returns error, however, it
is used in the later if statement, which is potentially unsafe.

The local variable "retvalue" is renamed to "model" to avoid
confusion.

Fixes: ad85094 (media / atomisp: fix the uninitialized use of model ID)
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

