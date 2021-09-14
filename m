Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E872C40A2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhINBz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhINBzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:55:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A03C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:54:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w19so6251783pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFh8IdunLG//5DDYuqmMORnNhMToSqUrMV0dgzC94Ew=;
        b=wFZbbmdG7M7RKdvMHX5z7ppoUF4nB5PN/E8KCaRBvyNPk7b4bWbpK6ZFqtdyTof6xi
         Dl8YB23VR0YKXfmLNWP2QUuNEYNLbIvKnS/l/fweMQ2e6H/ExTMV9bU5n5+bgEV1y0Wt
         x+OoPyCuGATLCBJtvL6ZIBh2eteVc6X9rmn8sHsTuB3X62XayeYeE2RatB9O3dg9zw0E
         k5dEwNBVVmvCmIHifpOyDks6K0dD110rRDrtx+7AoqThZNZQJZ1uZxqEMY02riJldqDW
         QPOmywa6Zan9UhPofkqRnI/V9pPthBAz7R0ef0DZogncdmQPLvXjVrQ+lCxARU4Q0AW+
         y4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFh8IdunLG//5DDYuqmMORnNhMToSqUrMV0dgzC94Ew=;
        b=tPFyjsQ8yfBoSRJLz56xkiJYzX0F/sZTKiV0pNFlwrTdf53BesBNEWE/FXHHGmvSjO
         GA7La1q5p7LpvhDJEkMLM7zTQVdIILFNuVgBUh5sg7ng2NUjv9vqwgu3NLwab8AsMq1j
         YAVGAsN9sp2f0LLbXLzZSfloWCZMa5IqUsn49tjPLoXmVkB4zqaQ212MEt46HlyyxN5A
         O+GFtEQMfQweDfIGEwVYCYFdfNZ7wcmPphu9d26Fe5xiWjP25h/V6OLD/mnYkTzg7erb
         DEVdJOEHqsgTqHYOJkZnlYX+ZXT1HdLROLXlW5PX+V7Y6GnRlYJYDLB37NUev1MScCmN
         tnaA==
X-Gm-Message-State: AOAM5321GN6ol5xinLlvwYFAth07gxJ1vcy8i56DmSa1fQublB79Kjmv
        mBaGC2JtU3VFy8KovR1yYRLKwg==
X-Google-Smtp-Source: ABdhPJx/hME72qzQHWN4AaPpXERrQ055xtzAXpNXhZOZb7pjOgAzGJMZCCbwPaHvLB3TOAqWsTGQBg==
X-Received: by 2002:a63:20f:: with SMTP id 15mr13302037pgc.319.1631584444293;
        Mon, 13 Sep 2021 18:54:04 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id fh3sm8089088pjb.8.2021.09.13.18.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:54:03 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] soc: qcom: smd-rpm: Add QCM2290 compatible
Date:   Tue, 14 Sep 2021 09:53:49 +0800
Message-Id: <20210914015349.29295-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914015349.29295-1-shawn.guo@linaro.org>
References: <20210914015349.29295-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for QCM2290 SoC support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/soc/qcom/smd-rpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index dfdd4f20f5fd..e3aea5c6788e 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -244,6 +244,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-sdm660" },
 	{ .compatible = "qcom,rpm-sm6115" },
 	{ .compatible = "qcom,rpm-sm6125" },
+	{ .compatible = "qcom,rpm-qcm2290" },
 	{ .compatible = "qcom,rpm-qcs404" },
 	{}
 };
-- 
2.17.1

