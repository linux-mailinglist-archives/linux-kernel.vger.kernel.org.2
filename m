Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E097395665
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhEaHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:41:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60636 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEaHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:41:04 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncWA-00039R-Ue
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:39:22 +0000
Received: by mail-wr1-f70.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so1547615wrp.23
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4J89KlzzqThKgmZLnM37DvaB3SqI47fv9hR1FCtpA64=;
        b=XtvRcBHyd+OsOJ4HlG74Lz7RQbQ28tzIdyaPn/pbTDXoB22VSi2iYAGmV+vZhw8Ffl
         7VFyUlVsF2wge1/fd0dTM6oTgiMiZ4c/dTEMbXkwA/KyjgV2JUdHmZ/Kifwxz1/iwIvi
         epsOzdHM9GXOrq4v+qgSrz5aB6Bte+8f68RcKPcU1TwqITUc6MyZ3o0Ms6YfN8spNjar
         EfBfwdlaHsKPGf77TbQAEXUs8tAqW2mAzTIpjc399jWYgRi01Hpeh6TxAwVhjjZHUp4f
         WE+R439amMuWpyrZMjaf/KUS/LwJg6CuYRT1ZO5efBXXHhumWqC5m0vCHlfwAOWoSBpP
         JmGQ==
X-Gm-Message-State: AOAM530es5mv+C7rCjqw1JhwOI3NMnkONuGP3JMgCzn5Mpt4pxcl3coY
        ssi6ltzBqKksErZVTi5JSMyQeno4lR0FSPa4kfaEiMbRE/5VEyQod9nFdj9uHI6PftH1Hu8bjJ6
        rRPa2TewXOaeVsSpzvSmjhp7B8akIaRzcYi+RHwYpmA==
X-Received: by 2002:a05:600c:2948:: with SMTP id n8mr24706747wmd.95.1622446762291;
        Mon, 31 May 2021 00:39:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoc0eYdm0Gad3jKfILWO0BlkrBHmb4+ihv28lP2KSvG+Az7qWFv7kizSOlAt+HwZQaPXWCeQ==
X-Received: by 2002:a05:600c:2948:: with SMTP id n8mr24706734wmd.95.1622446762165;
        Mon, 31 May 2021 00:39:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id a1sm9168911wrg.92.2021.05.31.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:39:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 09/11] nfc: st21nfca: drop ftrace-like debugging messages
Date:   Mon, 31 May 2021 09:39:00 +0200
Message-Id: <20210531073902.7111-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
References: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/st21nfca/i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index cebc6c06a1b6..7a9f4d71707e 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -502,9 +502,6 @@ static int st21nfca_hci_i2c_probe(struct i2c_client *client,
 	struct st21nfca_i2c_phy *phy;
 	int r;
 
-	dev_dbg(&client->dev, "%s\n", __func__);
-	dev_dbg(&client->dev, "IRQ: %d\n", client->irq);
-
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
 		return -ENODEV;
@@ -568,8 +565,6 @@ static int st21nfca_hci_i2c_remove(struct i2c_client *client)
 {
 	struct st21nfca_i2c_phy *phy = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __func__);
-
 	st21nfca_hci_remove(phy->hdev);
 
 	if (phy->powered)
-- 
2.27.0

