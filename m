Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95867358AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhDHRKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhDHRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A966C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:09:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i190so2286486pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+7WtA/iMqo224ipTmO7KcQmE9T7M+2JqZRPMh8YmdA=;
        b=Q7nW5obs1fYdI5l2SEPPtOGOsWtflj9tGcywYw9Lqhj7obtxXBdGVbWr3qbp0tFnNY
         qqY3o0O5vO4DmoMNGsYdmBSRKuY7b8DsblBbR5eqBkThXVCP/HSa41U3szd8ZHlZg6jt
         9wbdKUqLDoearm+SMM0QIBd/eGqBdoUyJpEDJnBgWQbXXCqEPAODBXJfuM0s6tAdNUl7
         Pm0kNTexsTic/8ArBGr8JekokriqaWfOl8bupQ/JMKXcWv0bfNKebw8it09YHvqAUlX0
         Mr4CzvrvuIcKB9Clh/e3eqSIexZxBoT6POPUQVqh4miH4u6O/mvGUSd86P/RNDeONeAB
         7HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+7WtA/iMqo224ipTmO7KcQmE9T7M+2JqZRPMh8YmdA=;
        b=U6Yx5wdKguuwfEy6vwzinn8o9FewR7t8PIWeO+LYyWTBuihoBOO0zWK7r8c+KJF8tm
         GF1+ScQucwEojko3P3OUVPft2v4WKXIGpRNPFxMZJt28wtoOgdRG+299fH8y/rh7GYEb
         1p/UsfYMVcKqsFzLgiUUTklqB8Eq2ZOOj3N4DfXr6LTfv6Xattd2D19VYhuznIj0WZXA
         BPefIYOl9WR1GzigVx7lL6NmPDWqj6dsfylAKRiPpVM43gHzBDOD+60S/2PX7WYiLyv8
         VhxaNOSsVqBP5ueU5HGtOlGpaOjid1Q+DSXFHZre359Pyt2SHAvy4Me1Br4Qf+LJM7E2
         66cg==
X-Gm-Message-State: AOAM5330M3wPWvd9IYXvP/AadPdsxnKZxmYN7i7wX+NOjoB854In23tu
        xDZsangxogoHVvhcVCrJiYGX
X-Google-Smtp-Source: ABdhPJxNhNQJrLxdXt5yxq35I5pE45qp+D86dWFJAkHO/oJOTRvHrbebqe314P6MsyUVuikkSjo0Yg==
X-Received: by 2002:a63:e541:: with SMTP id z1mr9199036pgj.59.1617901791572;
        Thu, 08 Apr 2021 10:09:51 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id a191sm57921pfa.115.2021.04.08.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:09:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/7] ARM: configs: qcom_defconfig: Enable CPUFreq support
Date:   Thu,  8 Apr 2021 22:39:26 +0530
Message-Id: <20210408170930.91834-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
References: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPUFreq and CPUFreq DT drivers to carry out CPU Frequency scaling
duties on platforms like SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 02f6185f31a6..47343d0ea586 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -302,3 +302,5 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_WATCHDOG=y
 CONFIG_QCOM_WDT=y
 CONFIG_ARM_PSCI=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
-- 
2.25.1

