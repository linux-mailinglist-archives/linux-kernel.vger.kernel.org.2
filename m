Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE33AFA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhFVAmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFVAmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:42:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9815C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:39:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g192so7354390pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s0hSFyBOMIAWlCuSu1vBbDo1kcTnOHZBktwNR9sfYvA=;
        b=qPJdSN7g1AsTCXEWl0N7D5lxwqBZepXT3xL4VOp1k3OpauOOUFtJUck7NEIAOh9UWY
         pAjIzFSmKm2YCTX+CTW0dyhaW53po289RV/eVDwTpEWi0lDhxs/XflWq7fLhopWl3AZh
         V24oVr/ZKaElrwBOdqDzwE4cXevRsoRvu3OKPpdiL6UwEkfliqTMPtJYH+ARZInZHAbY
         23JzTiG2ynK7AwYqVPwbPK2VmSjFzPlHlN2sYRvIEl1q8lFeS0U37kDLJ2lpaKsD+Y7C
         YXlFPLDaMKFH8P1ceC9Qhr50FDDpMTl1V1GfmW1BbCtiv4Rx043gIP3kLQjLIfieQG75
         4uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s0hSFyBOMIAWlCuSu1vBbDo1kcTnOHZBktwNR9sfYvA=;
        b=ETYHMrz9voNPzdFH6Ttnqdlr69ZVg6P4EKa4V1BkVw0Tam/TQBLp24rARaHWZOqfsW
         rj40p+Fsx8HaNGPZ5/9DJMa2c2YA6pze48zyA5G4CKtEx09gCEQU/Vaoq4yO5VJwd2xe
         qjT6uD/t8+8c0AMWMK6SN4s0aOs1gKfjdOz0Mxcjkf8Qc8oiIOX7l8cf+pMJVH+jqlgW
         rgg/RgTM1r7w78ga1zPreIrM/0TIKen6CekATjDe2LIf1PQctoBhDpq1CqL3qIWqvxX9
         uTB3R4VeaCGDNPEsVKY+txP/XDVSy0LUXZKHhl396wOFfYrKaGZxuIuT3ZVI2755FsBq
         nLzA==
X-Gm-Message-State: AOAM531Rq0mHBKbvR8E70YmRBwgnpDe4m1tEcp7nMfMuNTzkzx3Z7Wa+
        L4/lzKYxNLOO5l4IcQDj1NU44A==
X-Google-Smtp-Source: ABdhPJxlEhuoFcHTsQnLHecAqG8hLUmDQm1gRFgQQWrBkWCoX6wr4nEvTWJDiCqzeSm2SPW35s7ZZw==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr1142770pgl.118.1624322390352;
        Mon, 21 Jun 2021 17:39:50 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id h11sm17722762pgq.68.2021.06.21.17.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:39:50 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Li <benl@squareup.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/3] mailbox: qcom: Use PLATFORM_DEVID_AUTO to register platform device
Date:   Tue, 22 Jun 2021 08:39:18 +0800
Message-Id: <20210622003919.10442-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622003919.10442-1-shawn.guo@linaro.org>
References: <20210622003919.10442-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In adding APCS clock support for MSM8939, the second clock registration
fails due to duplicate device name like below.

[    0.519657] sysfs: cannot create duplicate filename '/bus/platform/devices/qcom-apcs-msm8916-clk'
...
[    0.661158] qcom_apcs_ipc b111000.mailbox: failed to register APCS clk

This is because MSM8939 has 3 APCS instances for Cluster0 (little cores),
Cluster1 (big cores) and CCI (Cache Coherent Interconnect).  Although
only APCS of Cluster0 and Cluster1 have IPC bits, each of 3 APCS has
A53PLL clock control bits.  That said, 3 'qcom-apcs-msm8916-clk' devices
need to be registered to instantiate all 3 clocks.  Use PLATFORM_DEVID_AUTO
rather than PLATFORM_DEVID_NONE for platform_device_register_data() call
to fix the issue above.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index f25324d03842..15236d729625 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -132,7 +132,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	if (apcs_data->clk_name) {
 		apcs->clk = platform_device_register_data(&pdev->dev,
 							  apcs_data->clk_name,
-							  PLATFORM_DEVID_NONE,
+							  PLATFORM_DEVID_AUTO,
 							  NULL, 0);
 		if (IS_ERR(apcs->clk))
 			dev_err(&pdev->dev, "failed to register APCS clk\n");
-- 
2.17.1

