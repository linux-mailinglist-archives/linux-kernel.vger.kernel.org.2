Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6208A3944A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhE1O62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:58:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47181 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhE1O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:58:05 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmduX-0004DW-RB
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 14:56:29 +0000
Received: by mail-vs1-f72.google.com with SMTP id b24-20020a67d3980000b029022a610fc6f2so1087918vsj.22
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4J89KlzzqThKgmZLnM37DvaB3SqI47fv9hR1FCtpA64=;
        b=jneMadRVckGORGJOjuN/G588A5CAM+e7e8ob8uB8xFANQjlpipkrPMefEgCYjnaKfj
         yatTvTyS5ieM37Jmofnim7kwumFXhJ+euJaUNekeTfKeEaHIFTL+HjxweHon+dfJNJfg
         PhNkjY5p83xGURd0KGvwqg/fcbVKcEa5+AEtaF9VtD74mns8FDNN+H4aoXS4N09DiPpa
         dyZSUe5NBsTzgqTIQdBsLURZPv8PMsQYk2Mt6u+gi5IJaX9xU2crnoh7ysTtWK8dUPMt
         fNZOEUTt+CmNk4es9Q1KwAwOkLvJ5JvSs3rC4pfhRgJqICXmuoj8mjqHVmk5/rx8zirz
         7yzw==
X-Gm-Message-State: AOAM531uZf4XIVJsEtD3eEEFza/RhDGABMZQfrJoVO5xqSPmI1CA7CNA
        I1SPiJG5mi0L5EsXk6ABxDBeRO8CWWNPRjGbKfMNwfIoTLWv4LJJp4v41Ty0Nc42ohTa7Rg3oam
        6HeFh1Wb1ssaitf/yhxjRdBjICIQPDpHbYL5BMHna1g==
X-Received: by 2002:a67:fe57:: with SMTP id m23mr7736103vsr.47.1622213788965;
        Fri, 28 May 2021 07:56:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfP6IRN4IcIxf2t6eEShocPoP23xgflYrdiX1LN2LPsh2qCqRV1RB9l96ev0kp0bJKZkT0Qw==
X-Received: by 2002:a67:fe57:: with SMTP id m23mr7736079vsr.47.1622213788791;
        Fri, 28 May 2021 07:56:28 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id c15sm743661vko.15.2021.05.28.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:56:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/11] nfc: st21nfca: drop ftrace-like debugging messages
Date:   Fri, 28 May 2021 10:55:32 -0400
Message-Id: <20210528145534.125460-6-krzysztof.kozlowski@canonical.com>
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

