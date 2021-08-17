Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1759E3EE1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhHQA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhHQAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:55:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58696C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:55:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q21so8573143ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdu5a/cMDbATqqiF4Vpee9GEfvuO3Zi0W+N+1NhGvAs=;
        b=KadqBNUFvId8+sROkIoWW2FnIiISPA/xpZWhqmtLgHDQHk5ltVM9Jgu60gY6RHkhhU
         LxZfK3sQvb2jKcgpbunWaDbUXqzuuNAoBiRd/+aZ6ZlKUbctO+qgDzwoU8spR3DMw9/R
         2ErU12GwvauMTdGSM+eBF1gUNlVHdg+JTKJ6WJ6UIq9jrevyeoLYCbT8n83RcBz5AgPA
         7ITGMU2aIZBqx+9cPVoj5uPuPEyFDbj3EsmIoCMwaCeme7ugesPolg0LvwnnyEYGVBd0
         HQkA6lOYvqUppAIJVQdlmtl51ODC6UeKWmNnXFk6X9c90iuFUn3oHF9d1QqEl3AV1jCG
         13Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdu5a/cMDbATqqiF4Vpee9GEfvuO3Zi0W+N+1NhGvAs=;
        b=dSR/Q7B2aPpe2JbOYO2fa2KKCFwnl1OVaTbOJ99n4LQbQw4Vt+//LUKs0wWQutqUyi
         4+kWREMKyUYaIam6hwan5S3BQIbvu6YH1K10REBmBqelbSfwg7+pG4F2fndpdX+5o30H
         6CDek/yJB4bskdChdwrVPYiWbTJDfJc3BRAP6btCF/xbvsT1r23mIHt6ErEHeEA6Tj8i
         yK5DT+H0KWM8DF2P4M3JB3SJbV6foIrY/V3LnzKOajjcfdjQfrEJMJEdN2388pDafdj+
         knZpTUDcvSLZgFGMOXkLyNFM6hzZpP21aKKljxW7KczAjdKCw2pMkr75tlRta1JOU8vg
         lVsA==
X-Gm-Message-State: AOAM533Tnahb9DOm3ezxIdhrNV53sAlz+pQitG4iFelgWbB2tHmkenpY
        Y88Od4JIIHJi8tdJKEts4LBfTg==
X-Google-Smtp-Source: ABdhPJyykVmUp2+uL524zpEVpdzv1pv0gVNB4w0uBgg1/3eS2V8TRDR8U1hnV+vjiLEctppv61IqLQ==
X-Received: by 2002:a05:651c:1257:: with SMTP id h23mr769675ljh.49.1629161716645;
        Mon, 16 Aug 2021 17:55:16 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z6sm40719lfb.251.2021.08.16.17.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:55:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC PATCH 04/15] ath10k: add support for pwrseq sequencing
Date:   Tue, 17 Aug 2021 03:54:56 +0300
Message-Id: <20210817005507.1507580-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power sequencing for Qualcomm WiFi+BT chipsets are being reworked to use
pwrseq rather than individually handling all the regulators. Add support
for pwrseq to ath10k SNOC driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 63 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath10k/snoc.h |  2 +
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index ea00fbb15601..870ed28d01a6 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/of_address.h>
 #include <linux/iommu.h>
+#include <linux/pwrseq/consumer.h>
 
 #include "ce.h"
 #include "coredump.h"
@@ -42,7 +43,6 @@ static char *const ce_name[] = {
 };
 
 static const char * const ath10k_regulators[] = {
-	"vdd-0.8-cx-mx",
 	"vdd-1.8-xo",
 	"vdd-1.3-rfa",
 	"vdd-3.3-ch0",
@@ -1010,10 +1010,17 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
-	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
+	if (ar_snoc->pwrseq)
+		ret = pwrseq_full_power_on(ar_snoc->pwrseq);
+	else
+		ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
 	if (ret)
 		return ret;
 
+	ret = regulator_enable(ar_snoc->vreg_cx_mx);
+	if (ret)
+		goto vreg_bulk_off;
+
 	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
 	if (ret)
 		goto vreg_off;
@@ -1021,7 +1028,13 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 	return ret;
 
 vreg_off:
-	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	regulator_disable(ar_snoc->vreg_cx_mx);
+vreg_bulk_off:
+	if (ar_snoc->pwrseq)
+		pwrseq_power_off(ar_snoc->pwrseq);
+	else
+		regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+
 	return ret;
 }
 
@@ -1033,6 +1046,14 @@ static int ath10k_hw_power_off(struct ath10k *ar)
 
 	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
 
+	regulator_disable(ar_snoc->vreg_cx_mx);
+
+	if (ar_snoc->pwrseq) {
+		pwrseq_power_off(ar_snoc->pwrseq);
+
+		return 0;
+	}
+
 	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
 }
 
@@ -1691,20 +1712,36 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_release_resource;
 	}
 
-	ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
-	ar_snoc->vregs = devm_kcalloc(&pdev->dev, ar_snoc->num_vregs,
-				      sizeof(*ar_snoc->vregs), GFP_KERNEL);
-	if (!ar_snoc->vregs) {
-		ret = -ENOMEM;
+	ar_snoc->pwrseq = devm_pwrseq_get_optional(&pdev->dev, "wifi");
+	if (IS_ERR(ar_snoc->pwrseq)) {
+		ret = PTR_ERR(ar_snoc->pwrseq);
+		if (ret != -EPROBE_DEFER)
+			ath10k_warn(ar, "failed to acquire pwrseq: %d\n", ret);
 		goto err_free_irq;
 	}
-	for (i = 0; i < ar_snoc->num_vregs; i++)
-		ar_snoc->vregs[i].supply = ath10k_regulators[i];
 
-	ret = devm_regulator_bulk_get(&pdev->dev, ar_snoc->num_vregs,
-				      ar_snoc->vregs);
-	if (ret < 0)
+	if (!ar_snoc->pwrseq) {
+		ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+		ar_snoc->vregs = devm_kcalloc(&pdev->dev, ar_snoc->num_vregs,
+				sizeof(*ar_snoc->vregs), GFP_KERNEL);
+		if (!ar_snoc->vregs) {
+			ret = -ENOMEM;
+			goto err_free_irq;
+		}
+		for (i = 0; i < ar_snoc->num_vregs; i++)
+			ar_snoc->vregs[i].supply = ath10k_regulators[i];
+
+		ret = devm_regulator_bulk_get(&pdev->dev, ar_snoc->num_vregs,
+				ar_snoc->vregs);
+		if (ret < 0)
+			goto err_free_irq;
+	}
+
+	ar_snoc->vreg_cx_mx = devm_regulator_get(&pdev->dev, "vdd-0.8-cx-mx");
+	if (IS_ERR(ar_snoc->vreg_cx_mx)) {
+		ret = PTR_ERR(ar_snoc->vreg_cx_mx);
 		goto err_free_irq;
+	}
 
 	ar_snoc->num_clks = ARRAY_SIZE(ath10k_clocks);
 	ar_snoc->clks = devm_kcalloc(&pdev->dev, ar_snoc->num_clks,
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 5095d1893681..16cfd72180cd 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -72,8 +72,10 @@ struct ath10k_snoc {
 	struct timer_list rx_post_retry;
 	struct regulator_bulk_data *vregs;
 	size_t num_vregs;
+	struct regulator *vreg_cx_mx;
 	struct clk_bulk_data *clks;
 	size_t num_clks;
+	struct pwrseq *pwrseq;
 	struct ath10k_qmi *qmi;
 	unsigned long flags;
 	bool xo_cal_supported;
-- 
2.30.2

