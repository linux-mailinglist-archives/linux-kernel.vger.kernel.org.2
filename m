Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32B3CC890
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhGRKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhGRKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F17C0613E1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d17so1100042ljq.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJaDlSnC/hNhPjnByAZZc7+i+wuzXCs6r81DcH7ZrtQ=;
        b=fOrwFKO8hCB4KF5iZ77VIRLzhnDn5dNI/OjCTxBsZ0asUn2D4nousCeDDGiL+dgaAn
         fRMtB2ck1sUEEs28HAPX+yW4tFI+QoSf1FBQDI05XrUWBO/W+QJiXIsC/qcqrROobv8X
         7z66KaR4fC7GdcPW7CdMZKgNO9r2LN5nGPh36aUYCzUiWRCKWZhWGOGVRTTY5REt4OkQ
         iUU6QdTthfxbFXynV97MPcM7RhCN8ALl7pFRAjDEpCXcZx3dDX7TPzRCh3z6ACBnMTRa
         t7BJyYDlAH5JgXEFtvSSX7AzJK7VFJa+IYTkb5ndXNAeq4tYKT3tT6h6fJBY+w+MK/ZQ
         Nj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJaDlSnC/hNhPjnByAZZc7+i+wuzXCs6r81DcH7ZrtQ=;
        b=pW7S2UTj9GOBeZeTxSpAwux+qbQbp7xHFaVZ1WbxgN2zKyLxyF8EY47Wq0cru+du/9
         kH34Vn0jODBz8BYwAh/JGCUc5C3uwAM2g0MjBJhQdcGd/TI52qIy7YWYe+jBT7VuCbEu
         IA0ocaTRvdLPOmJdGotsjAvR+nyeEvEY9JnYY3vB4FHo1UbTFk/fgns6zbH6mvgU+bQH
         7hEP0djE1pzH7YQpRXkp9xJbM/Lph8daDmAevCyj1txtfBoJxBzY5PHQjznckXxOirgU
         st4HvPtPzUkBvoCSODpKw3MXva2ItcBUpvivu9hCUdPaUz057QEIa+THUmyNcpzerIpI
         S+Xg==
X-Gm-Message-State: AOAM531tGZDzDOY3rxqnhal++beQWlf7FPReJvs6mZVacfzuTpTbjoM2
        6x3PIGnEr5sGQWTCZzpbn95kIw==
X-Google-Smtp-Source: ABdhPJyMQquMJjidV1UHOgUkuaiISk2VANqD+GcTanBH8fW5PnvtIqRQQ9e8ceMkwSQ8b4gJNfSfDg==
X-Received: by 2002:a05:651c:488:: with SMTP id s8mr17854625ljc.328.1626605349861;
        Sun, 18 Jul 2021 03:49:09 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:09 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/9] PM: runtime: add devm_pm_runtime_enable helper
Date:   Sun, 18 Jul 2021 13:48:55 +0300
Message-Id: <20210718104901.454843-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
References: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function handling typical driver action: call
pm_runtime_enable at the probe() time and disable it during remove().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++++++++++
 include/linux/pm_runtime.h   |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8a66eaf731e4..ec94049442b9 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1447,6 +1447,23 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_disable_action(void *data)
+{
+	pm_runtime_disable(data);
+}
+
+/**
+ * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_enable(struct device *dev)
+{
+	pm_runtime_enable(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index aab8b35e9f8a..222da43b7096 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -59,6 +59,8 @@ extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 
+extern int devm_pm_runtime_enable(struct device *dev);
+
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
@@ -253,6 +255,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
-- 
2.30.2

