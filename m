Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C0630932F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhA3JU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhA3JUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:20:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93829C0617AB
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 00:21:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m2so8495031wmm.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 00:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wlfadfbrmnq3giiUziIBDERuBfZMf0+CD1+IscHGj28=;
        b=itg+VnYcYZ38pClixocKf/g7MZFUQSeALN12A7EDaxvHyhTLZcv0TEmlnSfcZ+sjeg
         xRxmmEapWIorkKFiOGcoHFft0Fxus39O6UoGTXrkC1tibWEVQ0CrsQ45uO1JXC8uW4ln
         Ndu/6YezcaWA2AoIkJX7Y/AJK5cyxGZD9VKsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wlfadfbrmnq3giiUziIBDERuBfZMf0+CD1+IscHGj28=;
        b=XFeGFuvWm+mYCbU7fTWH1fFL/3FY5mOcbx9N/QPs5Q1FgsjVNLJ7C3DGK9rrdyspWE
         ofrfJ0RN9btJyaKeDm9IfQ55jdneEnItq9AGeAHW3V8c0JPFTYuhSU2SzsRfs/ZJKBzK
         fu+Gnru5Aiaz1moG/D1D2mWvfieDDywcn0QXt1caNQ/ErvfW/Yb6purie9HoBVN2Uwkk
         HnVObw98M14NUtRyQI92krREXdUctE/Hya4LIk2mdpNoInfr9NmTleKOcvAT5IxwuEC9
         8zqrCX01je3nm1GKDH+qURrs3quXszSmLMaW59B0Y93OYviPQKJO3qaD85/o3XzHUH2/
         FP5w==
X-Gm-Message-State: AOAM531wMESePwFbMpCcPWO8MIxU7Y2CmAvolMbtl53KX12JM4M4yFC9
        LcWL+5sZCkxbwfX5gOq5s3CwN/BN3cmiCQ==
X-Google-Smtp-Source: ABdhPJzYHbXsKSCcB7Vq3G4KWJWrzhFnlKKTTzTYTJpmoJJqCq+hSHWaU/GXgSa+7Cq9B5Ct1gr5kg==
X-Received: by 2002:a7b:c854:: with SMTP id c20mr6797012wml.127.1611994892074;
        Sat, 30 Jan 2021 00:21:32 -0800 (PST)
Received: from localhost.localdomain ([37.163.154.109])
        by smtp.gmail.com with ESMTPSA id j4sm16380560wru.20.2021.01.30.00.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 00:21:31 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: [PATCH] pinctrl: Support pin that does not support configuration option
Date:   Sat, 30 Jan 2021 09:21:28 +0100
Message-Id: <20210130082128.3778939-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the iMX25 pins have not an associated configuration register so
when they are configured the standard way through the device tree the
kernel complains with:

imx25-pinctrl 43fac000.iomuxc: Pin(MX25_PAD_EXT_ARMCLK) does not support
config function

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Tested-by: Angelo Compagnucci <angelo@amarulasolutions.com>
---
 drivers/pinctrl/core.c                  | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9fc4433fece4..7115b0b5689c 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1273,7 +1273,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 			break;
 		}
 
-		if (ret < 0) {
+		if (ret < 0 && ret != -ENOTSUPP) {
 			goto unapply_new_state;
 		}
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index daf28bc5661d..2c7c1de9cca7 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -356,7 +356,7 @@ static int imx_pinconf_get_mmio(struct pinctrl_dev *pctldev, unsigned pin_id,
 	if (pin_reg->conf_reg == -1) {
 		dev_err(ipctl->dev, "Pin(%s) does not support config function\n",
 			info->pins[pin_id].name);
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	*config = readl(ipctl->base + pin_reg->conf_reg);
@@ -391,7 +391,7 @@ static int imx_pinconf_set_mmio(struct pinctrl_dev *pctldev,
 	if (pin_reg->conf_reg == -1) {
 		dev_err(ipctl->dev, "Pin(%s) does not support config function\n",
 			info->pins[pin_id].name);
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	dev_dbg(ipctl->dev, "pinconf set pin %s\n",
-- 
2.25.1

