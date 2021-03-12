Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D23385D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhCLGZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhCLGY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:24:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391BC061574;
        Thu, 11 Mar 2021 22:24:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c16so11465367ply.0;
        Thu, 11 Mar 2021 22:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ow35VJCAyiM2ahQVLOKFiDoREaatNuXBdABSN/7hXxo=;
        b=rhxWSX6CcvyXICsK6BDSSieYqe40PCrdnRzZHtABqXSM3s+hSwYher+cyqfllv+WhC
         KY7aooUSbryYtIvO+giYXt3iDRDqChBPQPaa8LD8OgxZt/Is346J97150MecIFbIgv3E
         mv5g97HOYkLYE1b4HjikfsUqm+PPArtW02pL7UKQ6ifZzCJO3p6BX0cui5sp/qGXyZPR
         G5vOMq9OixiXCpnvDdEEjBWO0DJ8NwssZ4Q7ZhD3uJ28iW52qQqpTqxM+qNKtrhsOL+k
         UkdJ2s3xSCQ4boqbNfk4scrjUYvNmwPPsveRzfQ/soG9M32gWVXQNIdEls2suz+3vMBa
         4Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ow35VJCAyiM2ahQVLOKFiDoREaatNuXBdABSN/7hXxo=;
        b=lKLnppv8KNj6p/zh+gOEQc0ZjQozgokMiyDN6E+2NfClNdaBTjhab2IXYkIW1VUUkW
         Lvt7ld6OkEfB5a/7I8Ld16bGNYCbqo3okY3Ezfw6Gpz6yHka+O3bIdLe1Zh8tf57MBnI
         y0dJc2gg0TB/OBon0m19Z67OxuZoLLM5AD4ZFfuKq/rhGXf6SVT2UgmIEA8rRrQBWodz
         DGDx5uu06jGumlXbJ8peuKVzr7buTPz5UNNylDzgfTst2IfhevPK6lKYSaSLZHXRnCId
         BiAIwbgWmNwlSvbjUaZGfnL5w3/loO7hXScTgT5zE2RXA8DbnQn8FKq1DN5js/cCtVuM
         /bCQ==
X-Gm-Message-State: AOAM533DSFRj3Utyk1rROlmc77CA42XBn/8n8WoY5cKpDilyZI2piy/p
        BGAuDdSUs8ye5FRUxeKrQXI=
X-Google-Smtp-Source: ABdhPJyUMtijuEbCFPABICgGSbC+EGr890FDHd/+HYvvwtIkSNpgu32499FoNY51uB5a0HbKTNSzQg==
X-Received: by 2002:a17:903:22c1:b029:e5:f70f:b7a9 with SMTP id y1-20020a17090322c1b02900e5f70fb7a9mr11968152plg.15.1615530296820;
        Thu, 11 Mar 2021 22:24:56 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:56 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 5/8] ARM: dts: stm32: add stm32h750-pinctrl.dtsi
Date:   Fri, 12 Mar 2021 14:24:31 +0800
Message-Id: <1615530274-31422-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch add stm32h750-pinctrl.dtsi which just
reference stm32h7-pinctrl.dtsi

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2: no changes

 arch/arm/boot/dts/stm32h750-pinctrl.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h750-pinctrl.dtsi b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
new file mode 100644
index 000000000000..24e99970167c
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2021 - All Rights Reserved
+ * Author: Dillon Min  <dillon.minfei@gmail.com> for STMicroelectronics.
+ */
+
+#include "stm32h7-pinctrl.dtsi"
+
+&pinctrl{
+	compatible = "st,stm32h750-pinctrl";
+};
-- 
2.7.4

