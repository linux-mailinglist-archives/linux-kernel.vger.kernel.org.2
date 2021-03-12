Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32F338476
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhCLDlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhCLDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:41:15 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92462C061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:41:15 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so731777ota.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFFCpBkdUp9drXVA99cMePeD3CLCa9WqYT6b4rIx/GA=;
        b=Y4gDstC/P8pWS5HglAA12pf8rJs8HdBrV0Cz87PPkOeq3NBr5a8hQ3K5PXE+aBgqG3
         8aSn0emBd2roPFZnLU3sFPsH3D2+r7BvBsOdDLcLZWB0ko61P9WO6V85qcn8NuedxKjy
         LokMenJn+0CAwq29WJ+8w8yRyT2OsFrm5hI53RtNhLG2bkdBBRIQE6tGJgAAF9isXCJW
         haQr9HwqEJpSBW/Yhg0e5PvJGXfrJWHZNztbneNL5BTa4CA25zrwgJIt7nD05uIRUM0E
         slrXFqXhR0CcFt/X1tA3TjKYBELgHsqnfKGxv7LWMQm1Qingk2RTG6HXWTP46kQ+PJtl
         LXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFFCpBkdUp9drXVA99cMePeD3CLCa9WqYT6b4rIx/GA=;
        b=LDQNwcDceMBslrbHoZXVbhVD39aCdQcDR9DwWSUtePxBtWAZSoOxTayR+OBuylkz0s
         DBSmLiG0cbct1bb7H8sve5axImNqq18bxeGEjOazJqtnuoDKK12dQ1Yeu82GNfqEsin0
         uUef2N3Iz+zSS5GfzjCocY0gE3XrONG5nFZJa7CND1N0gyApS/EFpYPasO0EShUnVFt+
         LrKpo1zmVQoDjHTW2ti/kyJPVLszT8OGhuZVqZ9/mNBIAtU5j20XGJprodUWCOMtM1BZ
         78NjiuPIpiZSCT4XJM8qlG3UvhHCfNf8THXLFj9n1HER9UY06a8AF9yma06V2oA4s4j5
         7jbQ==
X-Gm-Message-State: AOAM53216ARXWgwOXkbzyhoGQZ6fuiTWNWlogY9hCusVFUAUGLae+sfR
        rkL/ooL4jYYVE4Icr+gzg0K0ma5/3MEjDA==
X-Google-Smtp-Source: ABdhPJwx65Fxthu2DAxAeaBNvCg1d17/35dnAH3BVfk3I0bk4CrrA7cAOqsQ/3HWYaHciTpxcC32Ag==
X-Received: by 2002:a05:6830:149:: with SMTP id j9mr1862619otp.66.1615520475014;
        Thu, 11 Mar 2021 19:41:15 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 18sm376829oir.4.2021.03.11.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 19:41:14 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8350: Add wakeup-parent to tlmm
Date:   Thu, 11 Mar 2021 19:42:18 -0800
Message-Id: <20210312034218.3324410-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312034218.3324410-1-bjorn.andersson@linaro.org>
References: <20210312034218.3324410-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that TLMM has the wakeup table, specify the Power Domain Controller
to be the wakeup-parent of TLMM.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 2c02f451379b..d6295212acf7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -642,6 +642,7 @@ tlmm: pinctrl@f100000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 203>;
+			wakeup-parent = <&pdc>;
 
 			qup_uart3_default_state: qup-uart3-default-state {
 				rx {
-- 
2.29.2

