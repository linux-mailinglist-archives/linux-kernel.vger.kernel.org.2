Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1B31FAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBSOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhBSOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:32:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86D8C06178B;
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n8so8762140wrm.10;
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ssjhZYKOt8M00Ph0p7VdDvR/5gGjlMWxAFoybb/5n4=;
        b=WAsm73jHKRr8umeExA9TAk9iPclCO+LNyzCjGOkm6uAouAmBwdFMcfbMrpZGklqu1h
         hCHMS33vZN+cb0jyOF0b9t8X+jmM41MXB+x2bb2ArOGW9lOFYp4uEqTpEq8IMRp2J8nh
         Se1cAyrHPi9wjcc0/mjf6zA/DBR4B9CF/rqVrkCPU1TXfuLEQp97QOYQXw3vOZ7eyvpM
         HmqDKheF5VNHKiagDrynt06oxTAuOdusPY2uIm1xEe+J/L2JrdkkILfJu+2cfAoq39qB
         EEaGs4Y116I9kb3uhPmZV7q2EuOBFHASDem0xPqI+zgXUm1L3GTc/BWGiRvMK0Fl0Gut
         CDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ssjhZYKOt8M00Ph0p7VdDvR/5gGjlMWxAFoybb/5n4=;
        b=gEpNknsioUl+bGLPBzaQasOcR1XpxMpV8ZgrYe/lHLSxDzIgxRXTIa/c8BDdz8lbLp
         CQ3uJdfoaqToUyyzKe5GselAx5pMOeNjWAQdWcAj/eJ4kJZmuIB8lLH/alwdOf75AwDk
         4ES0gT/gXuNCPZeRy5Y1OU+TjCiA2JS4LdD5emeogI2yOhHor1i0IBwB4ldwWJXly83d
         QlD3GjSYgLCqo6ZRg3jqDw+5qOnKIoY8Y1kGLsoc2v8iRLe0UAaxpEv4ghrk4RJdfrBV
         MlNelT8k8yO2RSpByj5x7HSd94bk71QmPNI9adSIjAdGibyqCFJrmqwcNapfopPpih9l
         OmFA==
X-Gm-Message-State: AOAM531P/6Wzs3aJ64cDqmzqdO3t7RFmxGbX6G9rCQLqZxKl2NMzBcwO
        nChCHBSR5oFkFP8c6OiQN88=
X-Google-Smtp-Source: ABdhPJxYToXGyW64UO4KcipxrIwM1F23pZnV/FPl7tcs5dsOI7DbkegTHhXp8i4iF/bu8JxQJZ+MFg==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr1797725wrn.286.1613745039479;
        Fri, 19 Feb 2021 06:30:39 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:39 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 5/9] arm64: dts: imx8mm-nitrogen-r2: rework UART 2
Date:   Fri, 19 Feb 2021 15:30:24 +0100
Message-Id: <20210219143028.207975-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless clocks in UART 2

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 9ef1c4994e8c..5c4085a8e76e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -216,8 +216,6 @@ &uart1 {
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
 	status = "okay";
 };
 
-- 
2.25.1

