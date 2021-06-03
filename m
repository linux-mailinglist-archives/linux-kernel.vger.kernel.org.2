Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38CB399DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:36:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE045C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 02:34:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so7828898lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rVASeO6Y6OcFufLMrsc56Y+VubvwdMfYIrrp6oq4r4=;
        b=ttTV9dS3FVDeh8gdxlsfE9fqeYyL4RbcrkOc2YpayXaxhjHVSYzHdSkYf8gZGF03ao
         FTogbxZRc6drk/Se9oX7peJvwggvDgXeGtDkyw/3Xv08d9EXgUxfFAxWP7R44czFhBxy
         YRp8d1xzO9W2w2WTbeLM/SXB4WmVUNrPmKHSY+ytmhEPVMbT1SAjeWGwL5t2SWQJjQuO
         EtV3pNVRyEYfFSK8vxVt+DnxeT0KTLj7s7EYNRrVYfL+2GZ7WUeOnjOue+Sp5vkkozMK
         JpZ6S/xnkX2a8JkxH42ozOzEKXBVmz9TURd2ykPpNXhzqc0krruQGo/0dWSw05UgWUqD
         SW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rVASeO6Y6OcFufLMrsc56Y+VubvwdMfYIrrp6oq4r4=;
        b=ZHjb+741A4WcKMJmNgRAQdTDQ8w8kYr2YLxT4hKSUE8KdfIosfp6oRa77hGzhE357R
         Yh6A6vc17uIHaCE2VYLUDl3+MtOhx1z8CFQdlcmrxPJsqYmXUn6B0mieO4xX59gpxISX
         LG16ZhckTuuAtCtft27/Bk6ZCFOmeemFBvlSzBYdUp/V8c/iQINYSrA/qQR0dXRLC3nl
         eXEvys0dcjTpSGy3C0mrkYaSnpxGFQA5W/zqXcHfo458gsk6lADl/DCE9wcQLCIycRRb
         mSGicJIrGqnK+kzqG+75jN5cUolpM2AOLWQm3g8jTPXFXGJkyg4VsOjAzJNJB5d4Nww7
         9Zhw==
X-Gm-Message-State: AOAM531ABaI/sEl3/rxtvcoh6c+3QqBYe7lI4RyA3fVDCS3qpumI5tqc
        4FlHPM4WM0vyL7NxK0x5GIvcog==
X-Google-Smtp-Source: ABdhPJwTfUiqI1PTAa4Ti9ScSuSpJMZh9fZH533X9DuesqyiUwYZtT+W7JazvFs90129yoD0c46yiQ==
X-Received: by 2002:ac2:5a4b:: with SMTP id r11mr18051551lfn.338.1622712886936;
        Thu, 03 Jun 2021 02:34:46 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q4sm263373lfc.172.2021.06.03.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:34:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] PM: domains: Split code in dev_pm_genpd_set_performance_state()
Date:   Thu,  3 Jun 2021 11:34:35 +0200
Message-Id: <20210603093438.138705-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603093438.138705-1-ulf.hansson@linaro.org>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare some of the code in dev_pm_genpd_set_performance_state() to be
re-used from subsequent changes, let's split it up into two functions.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- A small cosmetic update and added Viresh's tag.

---
 drivers/base/power/domain.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b6a782c31613..5c476ed1c6c9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -379,6 +379,24 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	return ret;
 }
 
+static int genpd_set_performance_state(struct device *dev, unsigned int state)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	unsigned int prev_state;
+	int ret;
+
+	prev_state = gpd_data->performance_state;
+	gpd_data->performance_state = state;
+	state = _genpd_reeval_performance_state(genpd, state);
+
+	ret = _genpd_set_performance_state(genpd, state, 0);
+	if (ret)
+		gpd_data->performance_state = prev_state;
+
+	return ret;
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -397,8 +415,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd;
-	struct generic_pm_domain_data *gpd_data;
-	unsigned int prev;
 	int ret;
 
 	genpd = dev_to_genpd_safe(dev);
@@ -410,16 +426,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 		return -EINVAL;
 
 	genpd_lock(genpd);
-
-	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	prev = gpd_data->performance_state;
-	gpd_data->performance_state = state;
-
-	state = _genpd_reeval_performance_state(genpd, state);
-	ret = _genpd_set_performance_state(genpd, state, 0);
-	if (ret)
-		gpd_data->performance_state = prev;
-
+	ret = genpd_set_performance_state(dev, state);
 	genpd_unlock(genpd);
 
 	return ret;
-- 
2.25.1

