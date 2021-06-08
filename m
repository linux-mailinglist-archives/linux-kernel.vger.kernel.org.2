Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2861D3A0714
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhFHWkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhFHWkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:40:07 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5207EC061795
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 15:37:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z4so13537822qts.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLu63O/FGB3OwQJYCj3q5EMOUKS51/xFISH4Nn/2C/8=;
        b=NNCx0Pc95kM1qAdnhBuhr8Qi71A0x+RgFhiiW99y4ByAqG7QJz+3TDkoj328ubWj+y
         ugL5/mZV567+inWIlTXxCSKZnnjVsGzlxqRz9YggP8lwOQ4sEcYw88/+NcyfmhoPyFuL
         LVZnmuAinEQj2DxOAO1AG2pbd9fLqHhrFHd858l03w94qRVZxgeBXfITet8wxfibqadb
         nywBSrOMKgEhhDaZpl+FilYr8AZxdIyILYsYrDAjcXH8UlxT4EFXSWmQr9xCzGj6Dtq9
         qTgBEsxIjXD8bJOTx74UatsFsB7jRoo+nR7MbLsU9eRL9sI4UyyxJp74G3+rlGRf+Km/
         eSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLu63O/FGB3OwQJYCj3q5EMOUKS51/xFISH4Nn/2C/8=;
        b=Vlwt4ozvsN9VONA19VCPJDgNhGR3FuuhddInq6slsW1ajW8q96ccVvRX2NM3NAKLoh
         alS8IWZ7HE7Pb7BvR4W+Fi2EW+1iqwtY9/AAhTZUDonIIaDs/DGlHeJZm3hzCIsGvbQb
         MJ8vQdcwuLc5QAuoKMerKBImtK136tLAnbVETdKHbj2sVr82Cscvbl8DCeFkmVzOBl1V
         vzBe596/Vh4fXL+093e3fzZrWWpos/h/eAQato2+xwli5ef9rZ4N/RRCgJ7NjhQrpO2K
         r+kXxczvAFIQjAhD6p0N6lBHKPKtDD4AdMII+VTxjBi5C2NR5WAffBRHKqu6Sypc1KYY
         YAEg==
X-Gm-Message-State: AOAM532npCh41G5mtxJzcJPoySweRhUYp/FX0Y5Y8wu1wmDbjohkZWDJ
        aDkFEnQZ57WtYeIajnezWh5oig==
X-Google-Smtp-Source: ABdhPJxqi6iboRcr63hnvz7UyaJR2v9uH5MlRCqu/2mTBGBMLzPY/mDRaMIk8k3lE8sifG4JsZy/TA==
X-Received: by 2002:ac8:580b:: with SMTP id g11mr23488425qtg.244.1623191876554;
        Tue, 08 Jun 2021 15:37:56 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id m3sm2324266qkh.135.2021.06.08.15.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:37:56 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 09/17] media: camss: csid: allow csid to work without a regulator
Date:   Tue,  8 Jun 2021 18:34:58 -0400
Message-Id: <20210608223513.23193-10-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608223513.23193-1-jonathan@marek.ca>
References: <20210608223513.23193-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least for titan HW, CSID don't have an associated regulator. This change
is necessary to be able to model this in the CSID resources.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index cc11fbfdae132..528674dea06ca 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -162,7 +162,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 			return ret;
 		}
 
-		ret = regulator_enable(csid->vdda);
+		ret = csid->vdda ? regulator_enable(csid->vdda) : 0;
 		if (ret < 0) {
 			pm_runtime_put_sync(dev);
 			return ret;
@@ -170,14 +170,16 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 
 		ret = csid_set_clock_rates(csid);
 		if (ret < 0) {
-			regulator_disable(csid->vdda);
+			if (csid->vdda)
+				regulator_disable(csid->vdda);
 			pm_runtime_put_sync(dev);
 			return ret;
 		}
 
 		ret = camss_enable_clocks(csid->nclocks, csid->clock, dev);
 		if (ret < 0) {
-			regulator_disable(csid->vdda);
+			if (csid->vdda)
+				regulator_disable(csid->vdda);
 			pm_runtime_put_sync(dev);
 			return ret;
 		}
@@ -188,7 +190,8 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		if (ret < 0) {
 			disable_irq(csid->irq);
 			camss_disable_clocks(csid->nclocks, csid->clock);
-			regulator_disable(csid->vdda);
+			if (csid->vdda)
+				regulator_disable(csid->vdda);
 			pm_runtime_put_sync(dev);
 			return ret;
 		}
@@ -197,7 +200,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	} else {
 		disable_irq(csid->irq);
 		camss_disable_clocks(csid->nclocks, csid->clock);
-		ret = regulator_disable(csid->vdda);
+		ret = csid->vdda ? regulator_disable(csid->vdda) : 0;
 		pm_runtime_put_sync(dev);
 	}
 
@@ -634,7 +637,9 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
 
 	/* Regulator */
 
-	csid->vdda = devm_regulator_get(dev, res->regulator[0]);
+	csid->vdda = NULL;
+	if (res->regulator[0])
+		csid->vdda = devm_regulator_get(dev, res->regulator[0]);
 	if (IS_ERR(csid->vdda)) {
 		dev_err(dev, "could not get regulator\n");
 		return PTR_ERR(csid->vdda);
-- 
2.26.1

