Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F3532BBB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443567AbhCCMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842530AbhCCIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8BC061223;
        Wed,  3 Mar 2021 00:05:41 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l2so15801813pgb.1;
        Wed, 03 Mar 2021 00:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=st1vx7fKQLzxFkGKwYEuz/lE5O4hxc+f/JnhKV6iha4=;
        b=od5bZTQKOk9miWkdziN+KibuenscYrT/Im69f8ugS3nBIxLH1knCm+7EIBuTPWRpfV
         BMYZGCfm/NdvN+UY3kBI8mpVmBxaNbWAUERnBEHyN9oLbp8qYtXC3LgvZquMatl7hT9k
         0Y7WpcFPhyRB/fA/BLViODjE8PSick43BiaGNBPOulozsqzfg26WbA4heJtgnv/VZSgy
         18XupCnYvplpSc/6B3DuCwYzynvB0DkFg8I9ohWENsMpEkkDfa5XoSJLK8uerQGerhYM
         jwGUgJqMBrJoCbWKrMq6gVb9GpdFnopVpTB1iUOxHaP0D2DPqvECh97PhAPpicXhMhTl
         HSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=st1vx7fKQLzxFkGKwYEuz/lE5O4hxc+f/JnhKV6iha4=;
        b=rAO8TYSdXUJFiMCSPd3oC6spx+ijekryI5REZbRXgIIjrme8APES8pmlgbTcJW+1bL
         Tu2HKZhEBiLQHMhWsZ6DrIoQQk2pdAkZEmPYIwq9kAVM172p5a2swLu7IHHzqR2Crlzx
         wJYmPGDBKmAE+tQxJKzIoDY0NZRUFGxm/EndFLcS+MJE1Cfb+RethE8qU61iwG7vsOqG
         0zJYadBViTr8mE5rOU4tQtl4Str1qaWfXA9pvMcpOrgGnz1iOnMgQQqJmpe/Ut3Yb/v1
         rYa3cUviTrSeE0cOlTxCOIEmUdUCVP85rTQKA84KIwcdectNXdOkhwOjtlKkgFO55MMW
         0mjA==
X-Gm-Message-State: AOAM532txnaSgCRzAp8pUyAlWdKjgnczQ9ovCuX++SVoflCrOMHEY+2t
        4pJEvc0TFBYnT98cBisQAh0=
X-Google-Smtp-Source: ABdhPJy1ohWbHQtNZLuoMaqeU0ZGZk8ZMkBTKH9qA5TBGWkq+iivUTkdhQjtl5lIYs/SKc6g2CNYOg==
X-Received: by 2002:a05:6a00:16c7:b029:1bc:6eb9:ee47 with SMTP id l7-20020a056a0016c7b02901bc6eb9ee47mr24245037pfc.0.1614758741273;
        Wed, 03 Mar 2021 00:05:41 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:41 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 6/8] ARM: dts: stm32: add stm32h750-pinctrl.dtsi
Date:   Wed,  3 Mar 2021 16:05:15 +0800
Message-Id: <1614758717-18223-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
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

