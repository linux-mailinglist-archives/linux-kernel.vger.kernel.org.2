Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A23AAACD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFQFUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFQFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:20:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6CC06124A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:17:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v7so3984258pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/10lSEnqxmZU389TyEm0ftHJEmxcBUG8gGtRVqkHKNQ=;
        b=EZ6HKpKNb1vR7EfW8MaKdXZNXQaTQtFcDG2zFR4d5N+IFa0kFhQ4XhVHerzc+NGfTD
         9M1QvtQc7eGCYLyvPtsdnRmYBRzGW26GWvSJrN7I+fulF5ppdmTLelRksTmT8B20sFer
         qGlq61MrldTjWQ/fiLCGmWess8xTwPTckvyx8016DFHQphB5lbl1YQRCjprM/Qr/WeBW
         WIsc2/2VnebhU9sWIUL4tUWfxDMi/gD1GqSLoujMmllU+EdGcxP/ycwzfj1/d2Uqiq3P
         f6nYOPxFL7SULghvGsryyPQ5rkfOfIPclNabl2iLwINvM65xdQdisJjNfgMIgk3mYu5u
         Zcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/10lSEnqxmZU389TyEm0ftHJEmxcBUG8gGtRVqkHKNQ=;
        b=T37hlZmKhtOFiguG7hz4JZS7MJGBJqY065ANk8EWJpo/zgZafWbRbermUK6ONRl7Wq
         dGMiwPV1gvfbdk+FzYB8Q3sf9mx4kUcVYxhNlkvpXaOIb55s45x7qZs1dZyoH8zX3Wxj
         yf1IK906n9rkz87o3sP3bUeamhMfbqe7W69G1CxjKukpzIfIl50iSyiFBLS5K4ixfX25
         /p7DO9qKRzA7U/edjd4CMebc+Ls9Yr1tGvLcpuCPenTGPp2dW5fVDY9aw/BRat9hJS8x
         RQ13tx7z7oFyIZoLqDbqQaPlPa05JeVj5gQaHC6rx9mfBi3NQza+hKAlIf4wNuNxAqYo
         DIeg==
X-Gm-Message-State: AOAM530RBeqyV8O6ZQfZQPu0E2SpAH+OEGerc73kM9QNaVXgXFw4wuWN
        NJiCXUUrUfhGSZBQKeDS56ymTg==
X-Google-Smtp-Source: ABdhPJyC7pfLaL4h+0iTWzIbGXY4KHz5novuxT8CXSRL+P8Lq8P/K8ULcHhITt0J0qSAS3yJLRhtiQ==
X-Received: by 2002:a65:4244:: with SMTP id d4mr3287012pgq.83.1623907069625;
        Wed, 16 Jun 2021 22:17:49 -0700 (PDT)
Received: from localhost.name ([122.177.46.2])
        by smtp.gmail.com with ESMTPSA id 188sm3900893pfz.146.2021.06.16.22.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:17:49 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 3/5] regulator: qcom-rpmh: Cleanup terminator line commas
Date:   Thu, 17 Jun 2021 10:47:10 +0530
Message-Id: <20210617051712.345372-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617051712.345372-1-bhupesh.sharma@linaro.org>
References: <20210617051712.345372-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the qcom-rpmh regulator driver to remove comma(s)
at the end of the terminator line(s).

Cc: Mark Brown <broonie@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 22fec370fa61..6a8b7ac67bbe 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -811,12 +811,12 @@ static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
 	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd-l16-l28"),
 	RPMH_VREG("lvs1",   "vs%s1",   &pmic4_lvs,       "vin-lvs-1-2"),
 	RPMH_VREG("lvs2",   "vs%s2",   &pmic4_lvs,       "vin-lvs-1-2"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pmi8998_vreg_data[] = {
 	RPMH_VREG("bob",    "bob%s1",  &pmic4_bob,       "vdd-bob"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8005_vreg_data[] = {
@@ -824,7 +824,7 @@ static const struct rpmh_vreg_init_data pm8005_vreg_data[] = {
 	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
 	RPMH_VREG("smps3",  "smp%s3",  &pmic4_ftsmps426, "vdd-s3"),
 	RPMH_VREG("smps4",  "smp%s4",  &pmic4_ftsmps426, "vdd-s4"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
@@ -856,7 +856,7 @@ static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
 	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
 	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
 	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
@@ -880,7 +880,7 @@ static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
 	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
@@ -906,7 +906,7 @@ static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
 	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
 	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
@@ -934,7 +934,7 @@ static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
 	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l1-l12"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
 	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
@@ -947,7 +947,7 @@ static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
@@ -960,7 +960,7 @@ static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo7",   "ldo%s6",  &pmic5_pldo_lv,   "vdd-l7"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm6150_vreg_data[] = {
@@ -988,7 +988,7 @@ static const struct rpmh_vreg_init_data pm6150_vreg_data[] = {
 	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
 	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
 	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo,   "vdd-l5-l16-l17-l18-l19"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
@@ -1012,7 +1012,7 @@ static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
 	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
 	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
 	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pmx55_vreg_data[] = {
@@ -1039,7 +1039,7 @@ static const struct rpmh_vreg_init_data pmx55_vreg_data[] = {
 	RPMH_VREG("ldo14",   "ldo%s14",   &pmic5_nldo,      "vdd-l14"),
 	RPMH_VREG("ldo15",   "ldo%s15",   &pmic5_nldo,      "vdd-l15"),
 	RPMH_VREG("ldo16",   "ldo%s16",   &pmic5_pldo,      "vdd-l16"),
-	{},
+	{}
 };
 
 static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
-- 
2.31.1

