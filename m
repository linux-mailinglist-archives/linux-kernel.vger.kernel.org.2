Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49FF3E0970
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbhHDUel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhHDUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:34:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78585C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:34:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id kk23so1106923qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3URnXzA6Smvye6C/6i5qyn1fy++8nfwykxUppqU1pk=;
        b=gPbCicQYAGpeNOqDegdPFGk+hOrbEuokmjrQ85DpjFcn16ku6hN+HzbFgTht0V2TJg
         l0MQm4G9tX+9XVaZah6P6fCYi9ojl58ZKP6KUY7myyfRA8B4+ynKi1AayE/nAqMXX5kg
         o5IId1773mDMkbLlYs4uxEJ7XzI0FcXwpivmaH8QVTowcr2is3an07Nya0EyPQG7OE1v
         R6SGuEP6lttOiHoEpbxVilwDi43sJ9cpUU6EVe1GwKpVI9vYfiIwBFl3DXlCCIGHJUEH
         p1Gjhhcbbt3otjWFBMWwEsiV+ZV7ehWsCFaAJQU72eQddr9fpB1fKFv1FaAC4Tv/RgMx
         6e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3URnXzA6Smvye6C/6i5qyn1fy++8nfwykxUppqU1pk=;
        b=OIyFfRu3+NFSNAMgwvqh+kunL51qeCLdeo6nDiDc+WBLggF8LLaGQgEnCAD9rBrqNW
         d8+DMFxJVEUMOjhYPUjYtphHnCFIYSaga8WCY43NRU4qiO1dmY4AVdvIksoxJ4TL2Uso
         0dtPplMXDpHyWoLZ92VM21jE4F9l65iOyFDJPdWoZSg4rJ9mi8u2Ag1T9q6Sq/BHkoOE
         gsZPRilO/64rbnS7TTqlX3CVa27fH486Uu9wy5ZBCcblr5HF4DVjU5NYQfN/PK17XeBX
         Lr6JM3OQEAW/6mQg9ziQzzZQYkevh4Li/IbCESGEVqUWC8VXtpHU+sKoPwam+CEHGkP7
         X9Rg==
X-Gm-Message-State: AOAM5315otu7xPlLpL9mbLLTYwBw2TgT26+wJ+qC+w1ije2Uo274tJEz
        kIL8R5CSzyqZx/WEIZ65B6cxtg==
X-Google-Smtp-Source: ABdhPJwj+0aqaWHXrY6r0IkvWxsOQ0sQh4dja9i2liBox7l0KSX6K0iApH4QeU+AJibo9SkXVFsm4w==
X-Received: by 2002:a05:6214:c6f:: with SMTP id t15mr1413038qvj.52.1628109262339;
        Wed, 04 Aug 2021 13:34:22 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id f15sm1326625qtv.60.2021.08.04.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:34:21 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v2] cpufreq: blocklist Qualcomm sm8150 in cpufreq-dt-platdev
Date:   Wed,  4 Aug 2021 16:34:20 -0400
Message-Id: <20210804203420.2641463-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm sm8150 platform uses the qcom-cpufreq-hw driver, so
add it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

v1->v2: Replaced "blacklist" in subject header with "blocklist".

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9d5a38a91f10..231e585f6ba2 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -141,6 +141,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm8150", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.25.1

