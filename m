Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9980D3942D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhE1MoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42525 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbhE1Mnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:55 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboh-000802-4z
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:19 +0000
Received: by mail-vs1-f69.google.com with SMTP id a11-20020a67d30b0000b02902363051a2cbso947672vsj.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRrONTypgp1EMOyVarHqpM55W7hpCkiyyNUgXqdeSg8=;
        b=QJZmYm0/tRlG+UkqKhKM0RRaXGG7lOK1a6uVgTXRMZnSqpGELoGC3wxRUJoBQ19cq2
         wZ/0G8JUR2sWpLS4JaSh9iWUJwWFmfdvG5JM5RjUo1LvfkthFN+AZGlJzjvKyXVigw3k
         u/B+UTsl/3qbL/6YL9mW5QUyZ+l3P78PG9gz9EG9upCrIYLJDvAZMSb3GyvAW02/0wgS
         wcns2ZNMvVjw1eb/pG69qcrRxR8gjyIvEUdULU/zI24CUMPHEl0GjvVK4ZzStPflUg6q
         ChydCbevJvIf9H+KrBZ1ZK+LGG/HC7LtNOEOwAr1hf0C1ZWue5VqIikutP+GSl5i31nR
         HWVQ==
X-Gm-Message-State: AOAM5332P9Ag0WIujz+3ZVC9EOsNHFJPUQSk0Zig2GWJUX7vxKTBKAI6
        A3Us2xxh8QM2SipnA9K5Zv5unJhYpTmqTWvIPT/SCdDlpdb3x6HZWKSEV5m/cqT/acaTk4wufqk
        zaUMnflNV6l67AvieE0S2v2ZIbGzC9YDztNzQjZ55Eg==
X-Received: by 2002:a9f:3d8e:: with SMTP id c14mr2753858uai.56.1622205738279;
        Fri, 28 May 2021 05:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ85BUBzclvNLh7WIZE3MKmHtee0D8gkvhnzRRLXAKuWP18m1wvUKV55wFGMN9FZrfjQ2RGA==
X-Received: by 2002:a9f:3d8e:: with SMTP id c14mr2753841uai.56.1622205738135;
        Fri, 28 May 2021 05:42:18 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] nfc: pn533: mark OF device ID tables as maybe unused
Date:   Fri, 28 May 2021 08:41:55 -0400
Message-Id: <20210528124200.79655-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match either via OF or I2C ID tables.  If OF is disabled,
the table will be unused:

    drivers/nfc/pn533/i2c.c:252:34: warning:
        ‘of_pn533_i2c_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 795da9b85d56..bfc617acabae 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -249,7 +249,7 @@ static int pn533_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct of_device_id of_pn533_i2c_match[] = {
+static const struct of_device_id of_pn533_i2c_match[] __maybe_unused = {
 	{ .compatible = "nxp,pn532", },
 	/*
 	 * NOTE: The use of the compatibles with the trailing "...-i2c" is
-- 
2.27.0

