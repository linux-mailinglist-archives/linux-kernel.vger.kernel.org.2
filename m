Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABE3F3632
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhHTV4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTV4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:56:19 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBD3C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:55:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so10471872otu.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KblwPmiHBhylSYmizpG5xsAGTHqdQ0PFtDpHENws1SA=;
        b=ud0UkycghEG90duRWw53xDdlOx2cit2bN3o/e5FmKAvXNmS1aGpkaoU1077mIgU95O
         uPyRk9e/DRfC5CMxAqFeCjvT2HNV/I8i8z9yBf2npG3a2SQIKc5UeLgQifEmianiR3tE
         iAe66JgiJ7PCBgvxirKT1JAdkuQ1+qYjOyYVUU8DiYHMct030TnCbGLcUyl6019JY3lJ
         XBWY/+e4s19T2uiOW9ZfcIsRjBM6Kq5JcQg+VUo32M3G82OoQe4GEBeXmhBlaFd5dIya
         CnyHfZIN0RSYPNVLidPSGgu51e1AcP4aQWpGW8bWz4sAaSvsLugZ2RED+SD2fPtLnT/7
         BvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KblwPmiHBhylSYmizpG5xsAGTHqdQ0PFtDpHENws1SA=;
        b=DnDq5FkVPQyps4bDaEJCL0ZmPILDmjvEtaEQaYnzYs62C8tivgq9DiI5bkNgllmMvJ
         FzNAc1zJbvvr9uzWAhB1U4z895wqLiwBnCAE4MrQpq8x84K3mGZ21nyb71xpO9t5HMIc
         teKBIUjBJX7XfF86uHCGo4YGHV3Y/hc7qdZQrmSbD55nT80xHmxGTDTc+wWSLJcB1Zvi
         lNHCGcCRkurtaAMwJZMJjQhbQl4EptS7+H7YOn/buND/nV9rHq4Zr1Cil4fKtt8FhbIM
         3WrAET6jubBX0UKYwsi8gw2rL4fKFd779bZJT6sbL6rdJOw2eoWfzs8WUN4fVCR/hXNf
         PTjg==
X-Gm-Message-State: AOAM530y6ZSoisVD4aMCfKCaTWjnOLzzy5AtrGEdmg+cEDKcdpykSa40
        tKN9bwV7k4Xt3muTHOUv9OWnuQ==
X-Google-Smtp-Source: ABdhPJxDcnSXZpY6iwxnZRsIZhUMFzjIxcrKNwrTrcFmM8qXBHhYFof7YBRRiMquso8BMSGWNx54jg==
X-Received: by 2002:a54:4686:: with SMTP id k6mr4665691oic.54.1629496540907;
        Fri, 20 Aug 2021 14:55:40 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i19sm1643630ooe.44.2021.08.20.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 14:55:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: [PATCH] cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev
Date:   Fri, 20 Aug 2021 14:57:00 -0700
Message-Id: <20210820215700.130575-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm sa8155p, sm6350, sm8250 and sm8350 platforms also uses the
qcom-cpufreq-hw driver, so add them to the cpufreq-dt-platdev driver's
blocklist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 231e585f6ba2..ca1d103ec449 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -137,11 +137,15 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
+	{ .compatible = "qcom,sa8155p" },
 	{ .compatible = "qcom,sc7180", },
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm8150", },
+	{ .compatible = "qcom,sm8250", },
+	{ .compatible = "qcom,sm8350", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.29.2

