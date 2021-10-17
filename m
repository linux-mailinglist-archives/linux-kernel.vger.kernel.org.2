Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD3B430C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 22:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbhJQUlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 16:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbhJQUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 16:41:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F120C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 13:38:50 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y207so21599555oia.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaGvfY3IqblYxtF1dOKvBwFgcky9hdAU3fQd5ouClr0=;
        b=jmfiKiG2pafs8OTavdnFa3dbfQnrKWuAHMls74HqLywnGVAgK225o+wyB8E1mE4pGw
         zMMvxmZY70xNizzbXjGuu4ocLBcijCsuhV9Rn+Bzt8XcOhs3DTuhoAmWeUlYlD6G+ung
         jSHFOl1NNU5RjXDwVHoMGtVpNKuF9ss4neXegaSEDnDnM4eEU3ZNX/28nk01xj48wwrQ
         ek0ztlbthdGUPt7ueLgqziTOrk/uLkSYX9Gz3CM3QbqGyVB1TnwnTzd/BAYtqmP361wf
         rmgM3EDGrzY19dZfrS1OSyw+qqL1LPC+mFiVU3Qn1MlpV6u23rC8SiMh5rlosnkbQSvn
         VnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaGvfY3IqblYxtF1dOKvBwFgcky9hdAU3fQd5ouClr0=;
        b=5WJLd8oYAbunWdPdJ58sxW+sFapab0KanxIFBK1uwh0rjuTBK4iRgkhFKAhQkCjs/m
         2gbMkH+Nx2Rkjj3OPB3/xUCxMme9EAhHXw1a+mZ0R1jtZ/oJ/qvE3gad605vnFX2t0/C
         f3ujmu9YSMB8tGHzfeKa2MbajN4QngRwaeUHYShP9L2Y2548VWOz8/+fFpoLecllAhAH
         6Rz22YRtumS5P5ZCL9kR11tD0xQIfEcr26okaLCKq+/4rO497+l2MqTx6QNy2aWV6WIO
         jzjGhxTS1WKmsoMk5lzDkpNBhjtBjeP++3iZPPFrxD23CoYrilBsL66epmAGo+KsCuOO
         aYLA==
X-Gm-Message-State: AOAM531+3ED38hU795T5/ksbM6fJVw3Q4caa9hRHARN3t4RVmOJvXWkU
        Vw/KUr+kZloA02kMPxPu8EuUUw==
X-Google-Smtp-Source: ABdhPJxWNhNj+p/C8KWNzF6gwqtNUJl6DTVLWdnaw2eblaWmG+FNum93/5Tebybr7P1cRDBSAWaPPg==
X-Received: by 2002:aca:ad45:: with SMTP id w66mr17048263oie.148.1634503129850;
        Sun, 17 Oct 2021 13:38:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id m7sm2382010oiw.49.2021.10.17.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 13:38:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm LMH driver
Date:   Sun, 17 Oct 2021 13:40:36 -0700
Message-Id: <20211017204036.2761122-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of LMH in '36c6581214c4 ("arm64: dts: qcom:
sdm845: Add support for LMh node")' the CPUfreq gained a reference for
the two interrupts from the LMh. This means that if the LMh driver isn't
enabled CPUfreq will not probe and there's no frequency scaling.

Enable LMh to make CPUfreq functional again on SDM845.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86224aa3a74b..0ae6cd2748d2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -577,6 +577,7 @@ CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_QCOM_TSENS=y
 CONFIG_QCOM_SPMI_TEMP_ALARM=m
+CONFIG_QCOM_LMH=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SL28CPLD_WATCHDOG=m
-- 
2.29.2

