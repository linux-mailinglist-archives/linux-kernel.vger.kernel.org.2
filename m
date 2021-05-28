Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D753944A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhE1O6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:58:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhE1O6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:58:04 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmduV-0004Ch-Br
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 14:56:27 +0000
Received: by mail-ua1-f70.google.com with SMTP id i33-20020ab042240000b029020adb6e9ffcso1984454uai.23
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+dadvxhKr9M8DJyOltCeC2IGkgvG/BUqwA8QIFSNMA=;
        b=J8jmB9aKuG9z4vvOFWIsX22aTAzi6wjkGu7njLc83cZP8swJ/QWA2zKqKM0sYQKG/E
         UO974A1gK4FUkMBkld7n8kjSKPVd5abWZUk9ylwEIka73Zp3Q1PpNAXqoLco8nLDXcR3
         ir7RJr/OtTraVfbUswJYlLJmAxMOMXGAVMN6akvW1TtrC51ej/4/uNyHA3iSg2ZrkpkL
         xLOira47HA4/MpywYp02RfQThdHpVkJSIL6ugKI4E0ttQ1svFXAoqW/ZXHoIYuEndlpH
         2LPJHXicaz0S6QlQ+fkinytk3PUftdCkKn8p8pftNfzDWhE85wrlRPL7c+kcgtkLCNNC
         2R5g==
X-Gm-Message-State: AOAM533SVav5VDBrVnRXncDNYEOLIxbTy881LPsJfC5mOt3NaRgJvTLf
        V11SZsA1JBh03H2dry/7LjO+jGChDO0EBQHYGbtFoYVYysRWoNeSsTYFTjW4UZS+Hnx5s+7ZOza
        eWUbKCfXIWUiutruyM0FVVhBQQdTWjsxlLZwC8hK1yg==
X-Received: by 2002:ab0:784f:: with SMTP id y15mr1771856uaq.60.1622213786528;
        Fri, 28 May 2021 07:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyHSIj3RddiIF4GdX53OPJYJVeWiyudWqy6hwbTM0Ky1LEO3HZhHoiUl8wApzZ3ufLbvD2yw==
X-Received: by 2002:ab0:784f:: with SMTP id y15mr1771838uaq.60.1622213786400;
        Fri, 28 May 2021 07:56:26 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id c15sm743661vko.15.2021.05.28.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:56:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/11] nfc: pn544: drop ftrace-like debugging messages
Date:   Fri, 28 May 2021 10:55:31 -0400
Message-Id: <20210528145534.125460-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528145534.125460-1-krzysztof.kozlowski@canonical.com>
References: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
 <20210528145534.125460-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the kernel has ftrace, any debugging calls that just do "made
it to this function!" and "leaving this function!" can be removed.
Better to use standard debugging tools.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/i2c.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index aac778c5ddd2..de59e439c369 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -241,8 +241,6 @@ static int pn544_hci_i2c_enable(void *phy_id)
 {
 	struct pn544_i2c_phy *phy = phy_id;
 
-	pr_info("%s\n", __func__);
-
 	pn544_hci_i2c_enable_mode(phy, PN544_HCI_MODE);
 
 	phy->powered = 1;
@@ -875,9 +873,6 @@ static int pn544_hci_i2c_probe(struct i2c_client *client,
 	struct pn544_i2c_phy *phy;
 	int r = 0;
 
-	dev_dbg(&client->dev, "%s\n", __func__);
-	dev_dbg(&client->dev, "IRQ: %d\n", client->irq);
-
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
 		return -ENODEV;
@@ -937,8 +932,6 @@ static int pn544_hci_i2c_remove(struct i2c_client *client)
 {
 	struct pn544_i2c_phy *phy = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __func__);
-
 	cancel_work_sync(&phy->fw_work);
 	if (phy->fw_work_state != FW_WORK_STATE_IDLE)
 		pn544_hci_i2c_fw_work_complete(phy, -ENODEV);
-- 
2.27.0

