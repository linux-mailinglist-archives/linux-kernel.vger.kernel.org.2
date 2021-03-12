Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0923385D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhCLGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhCLGZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:25:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10403C061574;
        Thu, 11 Mar 2021 22:25:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e26so1149941pfd.9;
        Thu, 11 Mar 2021 22:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbiM/HSzZZ4GI01XA3bmT/NtzjcaG6At7TJMeyRi268=;
        b=kfnoYzxJyQsGQs930o9zjPIkVNdy8UqKB0m4fz/eL1sWabAQXHRCaevIb6Egk4HYWP
         Y7G+sloPPvSWY50jOt036lGYJzLI0iTGffdFbNli6mAh5doJh1e5Dln/MpJfrY4Tu7lp
         SBGiGMLwrQhlxFmbURWr3E0UzUvKhSU8cVhdQ8OjNfaVH4qpGcVhfmggdLsHLxkfRU69
         SlQPyg0ah8dAseYuPHvGmJt+mF90Fe/PiirQEQT+BYk+xAq0s7JnFIALln6HdHYLETJ4
         dPCmrSRkxP5BvHGk+JNt+096ocZXD9kTXCZ/lIY82TwhIOGrTmif09isqZ4zFJCuaLt1
         vkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DbiM/HSzZZ4GI01XA3bmT/NtzjcaG6At7TJMeyRi268=;
        b=Qr5UDrzG3Pse7/TkYp4bpRoCNV36BvJKO75UT3YX6+R4M+Xo0KsAZUdE93diLK7p/h
         j/BuP75ltM8E7HbTvoxVJGHlBijpkQw151K9Wg63LfD8p01zUTxiDKJTEdYjxJwJrObT
         rRnD9wJa6yaD8sG/AsF6ds0XoCXSTaE+gLpG5trsvQWgGw9tO/e1xW71Ibj7BNbMV5+4
         nQFgc2GQrv0ilPqa9tV1O8BokQgUEjIqnLfuMtZSXr+AY8NhzMZD+MLujyOwL9vAMM2g
         DJ6x86e0d0AePuG9i1ZxxPloGb9evKtVZlGnb4iPx0KVVSZVNdN1aiAe2BH6riIKUjDP
         g+kw==
X-Gm-Message-State: AOAM533OXcwKvFwVif7oxT0R0vTtNcDXhRBeiy+96l1y1BDh6BgLZ0UD
        EXzfMN4yvp4bI7exmoQJeW0=
X-Google-Smtp-Source: ABdhPJyevqSj5NqnClRsZ57pwxDoj08fTSg/6sAIzVoEMDnSjCaUc7k9Ay3ZVDGHcDGMXWlL5klGeQ==
X-Received: by 2002:a63:a512:: with SMTP id n18mr10488698pgf.198.1615530306718;
        Thu, 11 Mar 2021 22:25:06 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:25:06 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 8/8] pinctrl: stm32: Add STM32H750 MCU pinctrl support
Date:   Fri, 12 Mar 2021 14:24:34 +0800
Message-Id: <1615530274-31422-9-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds STM32H750 pinctrl and GPIO support
since stm32h750 has the same pin alternate functions
with stm32h743, so just reuse the stm32h743's pinctrl
driver

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2:
- add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
  have same pin alternate functions
- add STM32H750 to Kconfig description

 drivers/pinctrl/stm32/Kconfig             | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index f36f29113370..fb1ffc94c57f 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -35,7 +35,7 @@ config PINCTRL_STM32F769
 	select PINCTRL_STM32
 
 config PINCTRL_STM32H743
-	bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
+	bool "STMicroelectronics STM32H743/STM32H750 pin control" if COMPILE_TEST && !MACH_STM32H743
 	depends on OF && HAS_IOMEM
 	default MACH_STM32H743
 	select PINCTRL_STM32
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
index ffe7b5271506..700206c7bc11 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
@@ -1966,6 +1966,9 @@ static const struct of_device_id stm32h743_pctrl_match[] = {
 		.compatible = "st,stm32h743-pinctrl",
 		.data = &stm32h743_match_data,
 	},
+	{	.compatible = "st,stm32h750-pinctrl",
+		.data = &stm32h743_match_data,
+	},
 	{ }
 };
 
-- 
2.7.4

