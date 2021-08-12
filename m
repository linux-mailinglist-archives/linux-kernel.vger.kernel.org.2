Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FC3E9D94
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhHLEge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhHLEgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:36:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F4C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:35:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a8so7333704pjk.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5B6LAGyn6qpvhvvXqvmp0F5nk8/QX8RYvQTVx1M0/gM=;
        b=QP4d91nKyPuYgkXOj2993WRqr7vFWjzAt2pAYEpOqBJrX79KK7X7Lye9RW33nVemOS
         glTh3230AbIEle58TNmDHg+mGlObfxcChEqEIgpM51UFcNuoT5t2gwEZYo9rstSe+BUh
         G8oAVPZc4Or2lHFxR9TnUcIaCZpTTeNW497UmbMV9rdrFsDQX3C4DbEyHzT9ETDcJuHH
         44M487nZNgj5a1TirMtTv5x8vkPi0ZRWgBVRFM/hm1MZ4gPWlnqSsL9XbuORZM21Fqvq
         2Kb9HOtRennF8T/9AvDxP+8H2lNL1JiYws1Z/YqfyQ//45J/2m8OCM9lP/bKaiSF0mx/
         SA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5B6LAGyn6qpvhvvXqvmp0F5nk8/QX8RYvQTVx1M0/gM=;
        b=RbTTTpywN/a/rNeOdxahaT3mzRU85dGtEgi+YPVekKKO9fMWyAA5UfyivE+0fpxG6X
         UNQjNksP9GgEU1NBIp5r9TZWtXRZEi14am54WvaZ4nXHp1pBsOC2IZvvgABJathCBKvM
         VH47J2Ll75rYe1Fg5mjbAyIp4kW0zIHXDoVHcFG9uZPaDlE4SrAjBbcoL5xDyrZoSOQC
         dG7HX8QSf6UEUopkUvOvpl+osiuKVPDbXxXZRdhOwzl4lspX0EYhr98IwGHLFhf2w3Lm
         XFXZvJ/t/qL5UzTSWB7CWq1SppvK6pHJ+Z4xItp7Mo00FDOYw7IWBpE2EckPqtoX0wws
         PTnQ==
X-Gm-Message-State: AOAM530Pik97MD5/tOCrdtiBLohwe+KbVPFKtltL4H/OmiHtr5gbImjZ
        F9hmEZNFuem4UsHWiH2HwABN5Q==
X-Google-Smtp-Source: ABdhPJywxltlmffoNhquAq7k75/erYD2KPWkiClGULINl/c/3BgHh8iADap4QiF3r0hcPTmn6BYUhg==
X-Received: by 2002:a17:902:bc41:b029:12d:3f9b:401e with SMTP id t1-20020a170902bc41b029012d3f9b401emr2042045plz.47.1628742957070;
        Wed, 11 Aug 2021 21:35:57 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id v31sm1420379pgl.49.2021.08.11.21.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:35:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH V3 4/9] cpufreq: mediatek: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:17 +0530
Message-Id: <3701fd64a3fb947fc805ca0d108ab87562a9659b.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to register with the EM core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 87019d5a9547..866163883b48 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -448,8 +448,6 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = info;
 	policy->clk = info->cpu_clk;
 
-	dev_pm_opp_of_register_em(info->cpu_dev, policy->cpus);
-
 	return 0;
 }
 
@@ -471,6 +469,7 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
+	.register_em = cpufreq_register_em_with_opp,
 	.name = "mtk-cpufreq",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.31.1.272.g89b43f80a514

