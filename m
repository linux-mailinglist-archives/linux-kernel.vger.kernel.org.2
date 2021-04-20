Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699EE3657C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhDTLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:40:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39111 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhDTLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:40:08 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYojA-0005UH-5s
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 11:39:36 +0000
Received: by mail-ed1-f72.google.com with SMTP id w14-20020aa7da4e0000b02903834aeed684so11195452eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QRQo+xpUYHPCxTbJPvKb59/XsQMOAX0KEXbrpjY1cc=;
        b=W/hKLtZjOjxJlslEBJ8C+t6MgdG79YsSRvXt+yFup87uF53JPqyTfQfv3QOjQ5SND7
         ytqAAu0jad6HSdC3Xtyig8Y4OxwD3lN233NAAKMIqDE9VkTuKHXO0RMG/DbH+t9Dv1NT
         /FLAflmOczsEb3L0kwwaKuHEH9dcDAqXXE1Qx+KeaykUESSjpaA/Zk87fbBXGwpTP5zr
         219rwXTQaeTnJFfeWipzp8Fgz1xjhkVtVrDrlS19mM6aZvWErlfdkAC03whvBaCI6nuq
         1yccX3OyVhH88kUc6W4bIIN3phVqdD7J+e0kyFP1kJEzonaOXh/AaZx20+oGumVIGhis
         GbYA==
X-Gm-Message-State: AOAM530oDGH4zm20yP4LrW3c6ScfmF32vopuQ1bubHR6BA7M0gHz9pVK
        H7SuEKV1ExzR4r9Z0KyWixw039JNaDyqNKde6WIoukuiQJfTCCsEG7B8SDMGFA4aIvJUefofatz
        pniqMsMH8jfaF9Vl8OTw/MyXdriNV6dUR1WK3L6miRA==
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr6030783edt.331.1618918775748;
        Tue, 20 Apr 2021 04:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxenHfop9KAauFCZtv5V4COrg2sAveJWXuaem0SSGfvEBrhcrropUIwjQVfyJ44In3y9caFVA==
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr6030762edt.331.1618918775613;
        Tue, 20 Apr 2021 04:39:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id bw26sm10109007ejb.119.2021.04.20.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:39:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 3/7] mfd: da9052: Simplify getting of_device_id match data
Date:   Tue, 20 Apr 2021 13:39:25 +0200
Message-Id: <20210420113929.278082-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
References: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

---

Changes since v1:
1. Add Ack
---
 drivers/mfd/da9052-i2c.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 47556d2d9abe..5d8ce8dca3fc 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -154,13 +154,8 @@ static int da9052_i2c_probe(struct i2c_client *client,
 		return ret;
 
 #ifdef CONFIG_OF
-	if (!id) {
-		struct device_node *np = client->dev.of_node;
-		const struct of_device_id *deviceid;
-
-		deviceid = of_match_node(dialog_dt_ids, np);
-		id = deviceid->data;
-	}
+	if (!id)
+		id = of_device_get_match_data(&client->dev);
 #endif
 
 	if (!id) {
-- 
2.25.1

