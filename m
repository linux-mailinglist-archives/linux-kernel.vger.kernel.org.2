Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E537AE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhEKSKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEKSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC487C06138E
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f29so7427977qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nauncHVfZ4iPve0AJPZMC4lIF+t0IxJHgwWKTrYrMM=;
        b=siDMUfadrZaiaKu+hssFdQTApaZbrseL2plfnZpnozqTzddVQ0OL7lyd+qcMGgnROq
         B+MFGmoqsmqlcApUk2QtnGTB0+I1vFzsW8jgQ0Jod9rpi5LlcL2NklGI31W0FGyCdHxx
         Touew0CWnkk6xO26J897akHpzh52YFfZnhJQytJ/G81mXTrRHgQmg4LRPsk95pxrJsx9
         1u3FFU8NyvYp8Ylkclmu5H+GHAEXlaLWDka5tdzt7hT1oR6MxSHpOyOQ0ZjC4BIXWJk1
         VGQMsjUiLUkfaM3q8Gl8TknK9tA6kdYzvU+sLaJtQLniOpKZeEUe62RQ+fXx9uS00iSQ
         ywlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nauncHVfZ4iPve0AJPZMC4lIF+t0IxJHgwWKTrYrMM=;
        b=lA8d0aOhBmtqJnUzi4dONADwVmx9joiOhFW2vg2YxcRPJG9imPoFFYOslH8riZoP2s
         44ZEFzcRQOhStrY0Y7i6UmMqfmdXuSkEG3cyqqhy5YseugfowxZClyanxlTuA4an044f
         3jiSSbK+vWjUImlhht8S+oA/9llrRr45dNtmxfwCDz6Tvy/pOA2us6cppNf7oY/fd3EP
         8yd5qmSvKoklII4l4DgdPXgJY516vU148fZByFOT9mnCfWoTr+0FUFAv/cwFdGbWw34E
         usrQU5+6anrhBgaPJwAaMC0YfQcOhmpZ7fxUtDdP3PSBHDrjZr3yVrH5/NGdBLLEo1jM
         dpJQ==
X-Gm-Message-State: AOAM5324zAekDv/A+SO5NGNpXwVW5+7G0uTnXXXNxqEStOpcRDKrBQB2
        64OQvIdtAZhWQODFHsTnXvgqoQ==
X-Google-Smtp-Source: ABdhPJwOoMAE6+xdicickpMIH7oEhGovTMHZd8fZPkoF4HVwmnu0FvsWl4dtr5iaHjl8tM6cDWvCiw==
X-Received: by 2002:a37:9206:: with SMTP id u6mr29852994qkd.7.1620756497888;
        Tue, 11 May 2021 11:08:17 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:17 -0700 (PDT)
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
Date:   Tue, 11 May 2021 14:07:16 -0400
Message-Id: <20210511180728.23781-10-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least for titan HW, CSID don't have an associated regulator. This change
is necessary to be able to model this in the CSID resources.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index cc11fbfdae13..528674dea06c 100644
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

