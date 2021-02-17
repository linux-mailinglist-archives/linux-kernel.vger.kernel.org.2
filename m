Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E356731E1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhBQWNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 17:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhBQWNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:13:32 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDFEC061797
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 14:12:30 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v6so18657024ljh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 14:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mikpPCKqiawoZCyFMz/JZszyNAgG2MWQqRABlKUmtPE=;
        b=TVpir0Uzqact4w7vvs9olQi66cswijB6qLToexaRGf73aHJ3lYbj9NvdtWJD3RSvC6
         FyA4+Bki02V+V2bFmNLug/6UpZdy5q02fVL175bEP/vcHnX60Usp0/MwIK4FWpLatUau
         EewiYeUk1P8OHbYu3fXyNIPyHltOhiKAwZ/131wvQgDg5BpObIrr4tG4EnF2MInw1HxW
         mHNwqfFRaAyieDUi3N6QmyewLN6Q16dUV9dZC8P46sMGaP0PMvy3cwt14UK4dMrvs5s7
         PAbfJtwAY+6gWk9J45jVB7kv4STrXwoHeDnT9ce15p80c6ylEC3TkBQ28aOfQuNllx0q
         WS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mikpPCKqiawoZCyFMz/JZszyNAgG2MWQqRABlKUmtPE=;
        b=MGeWcTncE/8aqf4YGiib8+nT+dzym0cC5O4AwG8mqloOq5BTRqIEGlBmUnvOaJnr3w
         UGpquQV1j8cX/4ZK91Epeh/LrAQ4/Mi9skdnXIFnLN0cxgRT+QeZamJ3Fgojh0bxOOeB
         KkJJRxphlTk41ryvo5Q82Q62h369ipuIJlaWgPhkDlFb5szrBmCrg4N7oxch2JNLbCIH
         DHl3/yzi3WFjMwtciX6bGepQdcpwXMz+TJTpfiLkNQi/ygevMFGbxPBN5uAtP/jgX3B7
         knwHha+XsAc0/PYocb8uQuAJdkHOdbobjZYWa5/Q93ofVxz+CybuFWAAbavBhQh+S9R5
         zuWA==
X-Gm-Message-State: AOAM531JGLsMqW4tXD1lj7bo4B+tUjJLSEJvW7CMqxMj6nSOx9obO/kz
        p8fD14ctHL6oMxb4R5dhhTZwJg==
X-Google-Smtp-Source: ABdhPJw4uHFM3vmsULvaYVI0JFQBIxOUVhijUlrrGPEhW2wZxBsAVU4ZhCpbc0JNnOqjm2hHcZEIbg==
X-Received: by 2002:a2e:505d:: with SMTP id v29mr694438ljd.393.1613599944665;
        Wed, 17 Feb 2021 14:12:24 -0800 (PST)
Received: from localhost.localdomain ([85.249.43.69])
        by smtp.googlemail.com with ESMTPSA id b7sm382926ljk.52.2021.02.17.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 14:12:23 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     junak.pub@gmail.com, robert.foss@linaro.org,
        sakari.ailus@linux.intel.com
Cc:     todor.too@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH v2 3/3] media: qcom: camss: Fix overflows in clock rate calculations
Date:   Thu, 18 Feb 2021 01:11:34 +0300
Message-Id: <20210217221134.2606-4-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217221134.2606-1-andrey.konovalov@linaro.org>
References: <20210217221134.2606-1-andrey.konovalov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <junak.pub@gmail.com>

Because of u32 type being used to store pixel clock rate, expression used
to calculate pipeline clocks (pixel_clock * bpp) produces wrong value due
to integer overflow. This patch changes data type used to store, pass and
retrieve pixel_clock from u32 to u64 to make this mistake less likely to
be repeated in the future.

Signed-off-by: Vladimir Lypak <junak.pub@gmail.com>
Acked-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 4 ++--
 drivers/media/platform/qcom/camss/camss.c     | 2 +-
 drivers/media/platform/qcom/camss/camss.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index fae2b513b2f9..b2c95b46ce66 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1112,7 +1112,7 @@ static inline void vfe_isr_halt_ack(struct vfe_device *vfe)
 static int vfe_set_clock_rates(struct vfe_device *vfe)
 {
 	struct device *dev = vfe->camss->dev;
-	u32 pixel_clock[MSM_VFE_LINE_NUM];
+	u64 pixel_clock[MSM_VFE_LINE_NUM];
 	int i, j;
 	int ret;
 
@@ -1194,7 +1194,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
  */
 static int vfe_check_clock_rates(struct vfe_device *vfe)
 {
-	u32 pixel_clock[MSM_VFE_LINE_NUM];
+	u64 pixel_clock[MSM_VFE_LINE_NUM];
 	int i, j;
 	int ret;
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index eb8fb8c34acd..d82bbc2213a6 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -578,7 +578,7 @@ s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
  *
  * Return 0 on success or a negative error code otherwise
  */
-int camss_get_pixel_clock(struct media_entity *entity, u32 *pixel_clock)
+int camss_get_pixel_clock(struct media_entity *entity, u64 *pixel_clock)
 {
 	struct media_entity *sensor;
 	struct v4l2_subdev *subdev;
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 86cdc25189eb..e29466d07ad2 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -110,7 +110,7 @@ void camss_disable_clocks(int nclocks, struct camss_clock *clock);
 struct media_entity *camss_find_sensor(struct media_entity *entity);
 s64 camss_get_link_freq(struct media_entity *entity, unsigned int bpp,
 			unsigned int lanes);
-int camss_get_pixel_clock(struct media_entity *entity, u32 *pixel_clock);
+int camss_get_pixel_clock(struct media_entity *entity, u64 *pixel_clock);
 int camss_pm_domain_on(struct camss *camss, int id);
 void camss_pm_domain_off(struct camss *camss, int id);
 void camss_delete(struct camss *camss);
-- 
2.17.1

