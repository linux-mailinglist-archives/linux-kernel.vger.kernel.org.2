Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0875F44808C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbhKHNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbhKHNvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:51:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA1C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 05:49:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bi35so36277609lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gjDtZyn15X3kTimy0RoEkC8ib1mpgy6W5NT1wcHcys=;
        b=feUQtXs9k99VsJAxmytIgDEH90K6qL0jZpgZCmKsXwLKLe6lZYJTXGsMtFhyMywlJk
         38WIHfQfPmDXfIhJ3QNr+MsFZf9F1NpOSGC0HtUE+zQgDVsr7WB/HfM8rgMd+Shkc62A
         RUvnUJoDT4tY2SJ+0oINotp5dgp4kahD9yN3VJ6YI9pFd+E3ZiHZhu/n29wTxenNc/cV
         QyxN6mofwdcKg/GnsjoAIjXdW3/4HF/7P2IpStfc2Vemm4IDcjT3qrVHhptn0roryxZ5
         YATTaWkKNaRfe7UYNxWvXtXN+U5d4Vrc2XIRslOaPNiQjXs4HHgoyTxe1jXR2QFQlDiq
         zUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gjDtZyn15X3kTimy0RoEkC8ib1mpgy6W5NT1wcHcys=;
        b=p4aPHxpYop7B2TzzSScklUCxgG3NzVEn46hnh0Pg0JojXqAzrZUm4bJ1+mfxkLwzea
         LbYFZ+uN0ADUMB3ceyOfd9eqqva1e5GI4FZLjKdStMJbA8EnHZ6jxgSGC9DcI2irfY1I
         mpbzOB5KPsqg2AzlYbY74PvSWVnhJE5lURIEVV8xuEAFq3T8cc/6SErPtOz0L0k8jOKL
         +kqSPxc7VxeMmA11RthLQPhKaaG8htuujYxihIOTigLPUFZ3B1Xbwthdz4IWqSZYZAQq
         +RsEk2e7t2T9f+SEgtRBPanjmJ4VR36h/jnjtoA0+TASCcEicDzcZKpc+KcUHpuB3erO
         AzJw==
X-Gm-Message-State: AOAM530wjKXkTtCHysF9M3dzvn8XNTjYpSJiSyxGJDWx6yLi7oKlj3Bz
        n5oB8gxtI0eBA96EZdCJWgqQUQ==
X-Google-Smtp-Source: ABdhPJz2mqqO5lcRy+OTg3aNweJ2v20tqd4fcl+GUINwIspD6PI5q/g372E2+f5rM+4O7+6jdZ25ug==
X-Received: by 2002:ac2:4313:: with SMTP id l19mr44994988lfh.132.1636379344522;
        Mon, 08 Nov 2021 05:49:04 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id c21sm1278437lfv.29.2021.11.08.05.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:49:04 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] arm64: defconfig: Enable Samsung I2C driver
Date:   Mon,  8 Nov 2021 15:49:01 +0200
Message-Id: <20211108134901.20490-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108134901.20490-1-semen.protsenko@linaro.org>
References: <20211108134901.20490-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c-s3c2410 driver is needed for some arm64 Exynos SoCs, e.g. Exynos850.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 545197bc0501..7c6a3b91e55d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -461,6 +461,7 @@ CONFIG_I2C_QCOM_CCI=m
 CONFIG_I2C_QCOM_GENI=m
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
+CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
-- 
2.30.2

