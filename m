Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A295363D43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhDSISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:18:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhDSISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:18:04 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYP65-0007tq-My
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 08:17:33 +0000
Received: by mail-ej1-f69.google.com with SMTP id r14-20020a1709062cceb0290373a80b4002so3350596ejr.20
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBlSlGEgsRYkWadTEY1QTDX93GegaXkwf2V4Jg/WsDg=;
        b=PM78mK6XQhaeZxvqZ1kAV2DULplYiFxJeKlmdHkvsfzq/AyATxDDy+flmm/VATM+gU
         cO9q1n8G/uPzaqi3BIK0dEuHfTdKEv2/Za5l2C0WcZpJzI9xncOJUeG0eL6O0VWf0r04
         pZ++QamfYzr6lhQbi99IIoIrZVdwWMKkmoNc4idBDoNFeoeOcrtHqkkd5JiIvJ1iXAkz
         l//GGj4tyYRUSkZ7q2yLhY1YPP2SC9o7meD4QZMKJncS927TcsU9AB1s3X21xdDNPlYK
         QgTAkzOM0QLaOuZqqPSjQkWC/FR6lhmemOlBHbn+bqwWcWp/D0CEaBSnh1WFDDa6j842
         ytTw==
X-Gm-Message-State: AOAM530bzGzsqYuD5rMcJMFNoWs3mdNigESRi9T0JPOVzT0MguY9aXUl
        bOh7RV74Cx1BvYg/3rrFUkUbvauIOlY/+TvpZeQkkkw3bv/3iXSlD+GAOBR4pP38+pHjxgbmOhQ
        iYObIo+kJZ3Zs54Oo/rDhYRjTIhv3JKWq3DZB814VZA==
X-Received: by 2002:a17:906:5e15:: with SMTP id n21mr20554427eju.57.1618820253486;
        Mon, 19 Apr 2021 01:17:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg+swdgj8EuewfKecTej+k1qH/AS1lZ95oqPWPHenRPBZ4PUCtQ7xGMn+3SRt0O+PhuF3UZw==
X-Received: by 2002:a17:906:5e15:: with SMTP id n21mr20554419eju.57.1618820253361;
        Mon, 19 Apr 2021 01:17:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id da13sm12384781edb.6.2021.04.19.01.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:17:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 3/7] mfd: da9052: Simplify getting of_device_id match data
Date:   Mon, 19 Apr 2021 10:17:22 +0200
Message-Id: <20210419081726.67867-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
References: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

