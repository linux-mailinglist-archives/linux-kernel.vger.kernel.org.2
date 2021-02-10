Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AD31674E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBJM6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhBJM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:56:31 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E03C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:55:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id l25so3964869eja.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QP3xask6OD7k8KSQ5tVVcC2So9/tpald+pKQ9QG/+P8=;
        b=HjJ6Lp/AhwITcJlB6qLHzWAJY/BrcnEYgKc4a+8TzLCZ5CCXAWI50E7ZohLrJGmbNh
         vJrTk3rv9gio+BQgS8wQLCxK71fcPm4j7kUztMMCdcVx/oTZX9NlArdOQaVP7cWrf4O9
         GwQ0TONto3hfchlvQ64hAmFR9JDfWwa/PSQobPThflThTbPoWGazrjdNbtRIidAB3yRg
         nxZgEs+dFWA85wunPG6kzc023yG4EgtDXPtOazdvsunr0wY4BaDYGMfNUx4VVEuuRKhH
         uVE2hurMQquNBrpsxDYaWpM95IBONWC3y795H39kYzccBfOuawpXw9sIVli4PaGufh6n
         l54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QP3xask6OD7k8KSQ5tVVcC2So9/tpald+pKQ9QG/+P8=;
        b=AUkN41J7X4Im47GnGDfos8oZQTuR9cE4NVSracg3uG/Y70QElqBbL5diF4hyMBpGIO
         A0fe+2al08YQ6UsYY963Oxd3NkGxqNiYaW6GSKna1vqwFNJXqNj4SzpJhLePsl6aiRQw
         vbUu2eamj/OvTVbaqfpAChnNA5/DdJQp2Ulhjnpp32flSuwjugxWJXL60OQBcv7artGj
         s9lyI7qf2ondlCFDwtojljfAPV3j5stYOb294GnUnLNgBz5TW+o3S17CZ2CFixMRh2lP
         OiDjP0PBJNwvKPVMJwgDTtMCcAk07isH5UMVHidfEMt8kEstupNbe8363/F4qtARyxCy
         YuJA==
X-Gm-Message-State: AOAM532+hBybDzEve06pfAJ/gHT3IiBioqNaBGQD9aEEkMbaPtRcTDf2
        TGf5OE8N5UOgin3r8ewQ6yfFfQ==
X-Google-Smtp-Source: ABdhPJySVHbEy7cRf3FVEZU38MkaaqoQGA40nPFPDQevnBQvfDLbeE2YY+LPPPi8oagsbkMesjJCnQ==
X-Received: by 2002:a17:906:2b16:: with SMTP id a22mr2792396ejg.291.1612961731916;
        Wed, 10 Feb 2021 04:55:31 -0800 (PST)
Received: from localhost.localdomain (dh207-97-164.xnet.hr. [88.207.97.164])
        by smtp.googlemail.com with ESMTPSA id u5sm1084900edc.29.2021.02.10.04.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:55:31 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 net-next 1/4] dt-bindings: net: Add QCA807x PHY
Date:   Wed, 10 Feb 2021 13:55:20 +0100
Message-Id: <20210210125523.2146352-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210125523.2146352-1-robert.marko@sartura.hr>
References: <20210210125523.2146352-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Qualcomm QCA807x PHY series.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes in v2:
* Drop PSGMII/QSGMII TX driver defines

 include/dt-bindings/net/qcom-qca807x.h | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

diff --git a/include/dt-bindings/net/qcom-qca807x.h b/include/dt-bindings/net/qcom-qca807x.h
new file mode 100644
index 000000000000..a5ac12777c2b
--- /dev/null
+++ b/include/dt-bindings/net/qcom-qca807x.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Device Tree constants for the Qualcomm QCA807X PHYs
+ */
+
+#ifndef _DT_BINDINGS_QCOM_QCA807X_H
+#define _DT_BINDINGS_QCOM_QCA807X_H
+
+/* Full amplitude, full bias current */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_BIAS		0
+/* Amplitude follow DSP (amplitude is adjusted based on cable length), half bias current */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_HALF_BIAS		1
+/* Full amplitude, bias current follow DSP (bias current is adjusted based on cable length) */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_DSP_BIAS		2
+/* Both amplitude and bias current follow DSP */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_BIAS		3
+/* Full amplitude, half bias current */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_HALF_BIAS		4
+/* Amplitude follow DSP setting; 1/4 bias current when cable<10m,
+ * otherwise half bias current
+ */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_QUARTER_BIAS	5
+/* Full amplitude; same bias current setting with “010” and “011”,
+ * but half more bias is reduced when cable <10m
+ */
+#define QCA807X_CONTROL_DAC_FULL_VOLT_HALF_BIAS_SHORT	6
+/* Amplitude follow DSP; same bias current setting with “110”, default value */
+#define QCA807X_CONTROL_DAC_DSP_VOLT_HALF_BIAS_SHORT	7
+
+#endif
-- 
2.29.2

