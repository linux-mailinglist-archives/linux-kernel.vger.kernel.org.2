Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20D3ED03D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhHPI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:28:35 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37210
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234857AbhHPI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:28:29 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 590CB412C8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629102477;
        bh=LGXeYNyXdNZabi2rsTrBrSKGeoJEXLIlN8urP2NyQJU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aronc15gjDySeaHh4+/UmGPBCnkSlEnrtNdN3jwuhg0ncD8YpobluI3KEA/DXZmzw
         0g5DiksdGJn+WMwXPDf6YPnHpfyX2m+KriBnhytLkdwZNsguKIxEgfAB8c14lqd+0w
         ZPqiQAhHPLYU3Cavl00TOnicIsr2EFFDwgfAQfCL4Ui8Y8fuT2HdYhul7HsNkjOD9c
         ScpnMvYtShsblzuWxs3t1/BRAKJjZyU1CpJFJ6bngp45D49sT+o4v0ZlD2VYoaDQLj
         hf/zSCYwMxyfAP/lRfQFUsQYznwuWsgB+82QW5zuahILx2VzVbMSdsffHBn1uMfr6+
         5sAKShP6MybrQ==
Received: by mail-ed1-f70.google.com with SMTP id di3-20020a056402318300b003bebf0828a2so4420430edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGXeYNyXdNZabi2rsTrBrSKGeoJEXLIlN8urP2NyQJU=;
        b=CNFav0vreYqqg0HhotEYfi9IKHTANlE0b2RXLU4KX7tE3lQ0WzXXnpCGSf6/gNQdYf
         2lPG7qo7d7dqFU4Y4BubmkLFn9w4FGSAcy1nAl+PUDcym2TwcnVv3bfTJhG5BNMVByo9
         RWRLYMP++NmZe7dIFi58tVCFL9R9oYvpECTrNhyeiyvUixZyemarIRmUdg8zUbcqv9kp
         aNGA76nTYQI/1qJKmnqTh0sDm5cLP6gJHuHrmfoSrajHL0vCQEpmIh67bALP0ET8E5X5
         i45YUeyUSB/tZkzENqfD6E3v64fu3JdKs/heXUY3/F6rWj3W8eKS7b9IvpDv/jvN8J96
         r1FQ==
X-Gm-Message-State: AOAM530Gx0HZ3YKKFv6x0gijPy4oJztZkXJlH1RwM/oGvhhRoofEGG7a
        QMfCKy5ggz+XZYF5+J/91eMmqrzL+RpIoRScz6DXeBUlqsHolZnoIvLMO80ntGuszzzOpgua5oN
        nXQxTw6Qjnyf4j8cUI1wvD1Vz5FXQAVOdSTpNga8Jlw==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr5909688ejk.290.1629102477146;
        Mon, 16 Aug 2021 01:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgJtC2xYYQ1rabRz50rSzNmMkzjNcca15jnOWvhr6wFrPLEn2SCpbF7hYawopjlDIBOZlkew==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr5909673ejk.290.1629102477040;
        Mon, 16 Aug 2021 01:27:57 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ay20sm4469605edb.91.2021.08.16.01.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:27:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] power: supply: max17042: remove duplicated STATUS bit defines
Date:   Mon, 16 Aug 2021 10:27:15 +0200
Message-Id: <20210816082716.21193-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
References: <20210816082716.21193-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All bits of STATUS register are already defined (see STATUS_SMN_BIT and
further) so there is no need to define status SoC threshold min/max
values one more time.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17042_battery.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 858ae97600d4..936e43fb710b 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -36,8 +36,6 @@
 
 /* Interrupt mask bits */
 #define CONFIG_ALRT_BIT_ENBL	(1 << 2)
-#define STATUS_INTR_SOCMIN_BIT	(1 << 10)
-#define STATUS_INTR_SOCMAX_BIT	(1 << 14)
 
 #define VFSOC0_LOCK		0x0000
 #define VFSOC0_UNLOCK		0x0080
@@ -875,8 +873,7 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 	if (ret)
 		return IRQ_HANDLED;
 
-	if ((val & STATUS_INTR_SOCMIN_BIT) ||
-		(val & STATUS_INTR_SOCMAX_BIT)) {
+	if ((val & STATUS_SMN_BIT) || (val & STATUS_SMX_BIT)) {
 		dev_info(&chip->client->dev, "SOC threshold INTR\n");
 		max17042_set_soc_threshold(chip, 1);
 	}
-- 
2.30.2

