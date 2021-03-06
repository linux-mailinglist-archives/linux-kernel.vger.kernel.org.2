Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3833732F7C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCFCJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 21:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCFCJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 21:09:16 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247CFC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 18:09:10 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id s23so901122oot.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 18:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpW8AgcggMi37Kh1va9pAJtKdZcmSmLgmqgQgQCGXuE=;
        b=sGydEBgzuauqvvBqPw8Z+yYb2oMgwVhixQIqKli2S318aWmv2Nr/bmBOGzOKp8zzEZ
         PR7R4EihfCfm8r2QSqU/mORh1/UURE2+ED0Oa8aL3tsPa0GXUOhnDX5KF2qtpYi6/Z8m
         I1/ijzvYiGva5dJYr0sHRN+BCB5ay2vJQeK4ASOir2DJnd1WYZDXP+fUUNPqKDZAuwEG
         hAsHZwc/KCYLK54RPDyl6NKhIAINaG3ANxnPjifp2rqrmGZa0gb+xGvXWfLrS5vfCFJm
         sYaeYkVeQK6nF1fxvrCV6kEC+MK9+2Qm3L2nPCm6gd7c5ROlG9PwUxACNEeIVJIgGGm9
         sZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpW8AgcggMi37Kh1va9pAJtKdZcmSmLgmqgQgQCGXuE=;
        b=rn3PZMLA7j6abiy9d0bABrpCbGJUpQFO9Lfk8/Fr19zk8VL9zfDVHRaa4agXshXN8N
         Eig52hM3vpqh1bUdm2SdJd0Rsbs/9qDcR7zU6tMxOUlMjd9ELVi/E7cvLrENjOv66t7J
         50BdVvNOqBs+Q3fHzF5+WRDtNJ6kM8ZjPxonzXkCITre5LhQE8gySm/f29Ybarq77gVl
         c+JRAPe4VXgyQ9S+LZyL968/I7WpYBmHlNzJpu6C6jLowfp8gClIRZbAmmdTZ77OomXB
         8+IepsZYp27IRGTu7grniET1NO6J+DgoI8YKUfTgTjktFNJKKmVae9L+wxqHxRf+3TBQ
         t65Q==
X-Gm-Message-State: AOAM530cUjaPD9gMrNRDo61V2LN8z9ar5OzjxfB4tIzPxIm2mAYpjbBe
        s95AOI2zxlu21ZpkxPySZiHNCw==
X-Google-Smtp-Source: ABdhPJxkkuoPBEwEqSEZ2TjvGhwkmhjfgEPHIebE2oEVPGvk1TTIzUQ+kFX/QgQCJEhHssT+vmfq9g==
X-Received: by 2002:a4a:b787:: with SMTP id a7mr10318457oop.18.1614996549570;
        Fri, 05 Mar 2021 18:09:09 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y27sm925781oix.37.2021.03.05.18.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 18:09:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SM8350 TLMM and GCC
Date:   Fri,  5 Mar 2021 18:10:21 -0800
Message-Id: <20210306021021.1173860-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm SM8350 TLMM pinctrl and GCC clock drivers. They need
to be builtin to ensure that the UART is allowed to probe before user
space needs a console.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..029edddb50df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -510,6 +510,7 @@ CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
+CONFIG_PINCTRL_SM8350=y
 CONFIG_PINCTRL_LPASS_LPI=m
 CONFIG_GPIO_ALTERA=m
 CONFIG_GPIO_DAVINCI=y
@@ -957,6 +958,7 @@ CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_SM_GCC_8250=y
+CONFIG_SM_GCC_8350=y
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_SM_DISPCC_8250=y
-- 
2.29.2

