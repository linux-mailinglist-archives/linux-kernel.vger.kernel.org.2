Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352E33ED038
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhHPI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:28:29 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37184
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234821AbhHPI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:28:27 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id F33C03F07D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629102475;
        bh=lxDKaysG/aHQwlTNKh0Nbuao0YTQ8x2bzMWqPvbdZ6o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=EZjUqm0q/lNuXLV7BSg/qOKpptxCPveV1iIznTJu23I7fvXSrAM4b3Ms9jD05gV2f
         eEd7Vmy9wT5rqskyeeJVJBaTr1uYxgvm0piSl4n9LaEsk14I1ixsBO9iRdn1XerV6W
         I242vkhor8fhNtg6oMpRKlddJ8uVqMzpdYBzfQFEGwQXxCJeZsHqdXIxEZ0RQgXNJC
         aN2TSUmWkLlUo3dM25AEY1/Rvo/21mknEz/D/Y4qFkEpAVw9p5EHRtoW/2tqqEMDUw
         pjy8TYO80aZ9Fu/oChBRYSzEFqFu19b4ErItFB//kWgRQ+qWgknT8ouyjEU4ciUOul
         39epyCUJVVH+w==
Received: by mail-ed1-f71.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso8469801edp.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxDKaysG/aHQwlTNKh0Nbuao0YTQ8x2bzMWqPvbdZ6o=;
        b=RiQVJEuMH7fayk83wSPUygX4ZKliOjXxKAFXOxtZgKBQFXeoV5Yginf4jPwDyIno16
         OpBrXw+RnOj4TbCJV/830H5crZ6oJbLQr+B3IBa7o40n3GmtedRko6j7LHgt2vPvxSg3
         pUe39ZscfQg/awtw+D2WXueRazu46fJrIp7wh/DNOm358RVycwcN4WUYkBLZf252bMy0
         KwZzUPdrY5cHuewxpsbAgNmbx4ruQgg/XeWjHZzUoCiENBhLoYfGs1T+zVCsy1LyDfWl
         9fxd9HRaTWx+f2yESqb7DXlklciMP2XuteUYlRZ7RhTx5sNfZhr3GeLoYXNRWURU2+is
         y8Xw==
X-Gm-Message-State: AOAM533UWJZqWBaoptmHPPxfbgspsTmJ6zjyKFX6t/sGowvlowS/dDqT
        ztaEB+pUz7PRT9R4+wPgW6iuO0eyTPHf/TMGCVFWjp7DTwFHBI9N6ETJVNExY/aACUtT2m4WRMC
        5Y/2qDCvYeQ+kesFUUzuiz2fXPvS2UyCTGf6KJEVIRQ==
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr15003414ejb.110.1629102475753;
        Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+BOVdere6Fu0M0Ic4QLSp/IuflMOckAgBI2uLtSkJ1OUJq6KxP3xK5gCoc2lA1BHWOYxnbQ==
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr15003404ejb.110.1629102475630;
        Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ay20sm4469605edb.91.2021.08.16.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:27:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] power: supply: max17042: handle fails of reading status register
Date:   Mon, 16 Aug 2021 10:27:14 +0200
Message-Id: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading status register can fail in the interrupt handler.  In such
case, the regmap_read() will not store anything useful under passed
'val' variable and random stack value will be used to determine type of
interrupt.

Handle the regmap_read() failure to avoid handling interrupt type and
triggering changed power supply event based on random stack value.

Fixes: 39e7213edc4f ("max17042_battery: Support regmap to access device's registers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index ce2041b30a06..858ae97600d4 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -869,8 +869,12 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 {
 	struct max17042_chip *chip = dev;
 	u32 val;
+	int ret;
+
+	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	if (ret)
+		return IRQ_HANDLED;
 
-	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if ((val & STATUS_INTR_SOCMIN_BIT) ||
 		(val & STATUS_INTR_SOCMAX_BIT)) {
 		dev_info(&chip->client->dev, "SOC threshold INTR\n");
-- 
2.30.2

