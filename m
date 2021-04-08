Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F71358AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhDHRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhDHRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693CDC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v8so1367456plz.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ip5PiCXeJMTF74L2XmShdZvP7VmFmojAvEXdIoCfk54=;
        b=d7ilNP+IchuW7BTBlUdFQzLfcwKxQNapgKuWmNBWWi+M190BDNF1B7FD9yCpsWPz15
         icMifBOpt4dP4a7QmC68zbmJMz4zz8uKpFAR4CMzJL8kkh6zEYH1YRNO/JK6vdajDJrj
         t6o8XVxZvblSk3Rgc/l3us48ZMQxXOZgiYByvAf1Aawevlxd1P8asOXTc60o1pZVr4LN
         ljdEvjB+kuAFrlKXEC6/AiP8BrHYeeaJj8DOK91Id59oztmm3bONpHxMnjivPQc98Vkz
         L92JSSqAWuBTr9+LByVISyVQYjWdOcF7vVCazcPBpH1iuTbqXslAFTVvbyc2n9xJJ5pG
         8WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ip5PiCXeJMTF74L2XmShdZvP7VmFmojAvEXdIoCfk54=;
        b=A6vQ1aLhbfkdQoxL+44EREn+Q9tXZPzVKTOBvuyCNO/9aUt95ch9VfWQO78Gh061pR
         q3hmVfndJSLqpUrrTKVY7DC8hD8Nzxl60utZpaUr8BYo48h7DttNuzaAPwrFp0U0l+fk
         TPVTYkBxyKgTHpDbEZwDQsfNo0vZ643Y9C3HriK+JzoL02rK5DQd5v0WxAaHmsDsroCF
         XFsVkaAl+5QMtrR2jDrYDLrPE/p74Ge8LfC0iLS68OgzdzATT4De7VDzDRPAOVy8HTiN
         AHl9qpQ8QUbEJEgY697KpFypHTN1mNN+TyoZe3yZMZbiJSKZtsjJSTNm9DEs6UwGEd95
         FFFg==
X-Gm-Message-State: AOAM533RZElJE9DfMiibTiEK7fZhWthtlm5HJoXYmqs/5oMcNBkj29uh
        xBSPeXtZIa6X1EJmQz2RCnn1
X-Google-Smtp-Source: ABdhPJykbQ/yfM7yBa1HYViUp0h2zDnOgzGsPmDKCG3YeerqEmk2a28Iy5lBQGdG8JK7KSp9/txtOA==
X-Received: by 2002:a17:90b:1b42:: with SMTP id nv2mr9441228pjb.190.1617901516943;
        Thu, 08 Apr 2021 10:05:16 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/15] ARM: dts: qcom: sdx55: Add CPUFreq support
Date:   Thu,  8 Apr 2021 22:34:45 +0530
Message-Id: <20210408170457.91409-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPUFreq support to SDX55 platform using the cpufreq-dt driver.
There is no dedicated hardware block available on this platform to
carry on the CPUFreq duties. Hence, it is accomplished using the CPU
clock and regulators tied together by the operating points table.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 8112a5283ce2..20cb2c903a91 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -53,6 +53,35 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
 			enable-method = "psci";
+			clocks = <&apcs>;
+			power-domains = <&rpmhpd SDX55_CX>;
+			power-domain-names = "rpmhpd";
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+	};
+
+	cpu_opp_table: cpu-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-345600000 {
+			opp-hz = /bits/ 64 <345600000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			required-opps = <&rpmhpd_opp_turbo>;
 		};
 	};
 
-- 
2.25.1

