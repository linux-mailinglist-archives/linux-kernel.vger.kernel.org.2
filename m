Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3403942CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhE1MoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhE1Mnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:52 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboe-0007yp-QD
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:16 +0000
Received: by mail-ua1-f71.google.com with SMTP id z43-20020a9f372e0000b029020dcb32d820so1869199uad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAqSfj4V8Ljuoku0z/gnZf+7DpK+uMQ7YFx87xd1taE=;
        b=TYeCP4aAkweeDHpqEM0XAZvO26yy0BIelIMAFOF+hDNOizKE9l97rE4JKKiH7c7hjj
         bQJTj0aOkgpSvW8SswK6i8I34fkljB2z/cJq2Jfyc3Uqy3nTqcrRwZamOqtRcTUp7U/u
         RsE4TWOI0rvE+gaDDcqtLz9AEdp6RQb1JpqFA0QO31hVFinTKTJBRkzMErEioFZO34zm
         pwHGpzM6PRZgPuvJ5zCFon+KIi1W1iQstG5X264BYSdJxsMeRPHEPrNohWDkGwIvNW6P
         mRBG2ScGZr91+zW8CLnfbjqBCDlBI2I6pLSQuG368rkZDV+d9SLcEP7GjU7lDR8JHvfB
         iJjg==
X-Gm-Message-State: AOAM531aro34KmVf9k9eVSXMZV3V+QTL7laMCnbJVa6x9ecPrxj4OXNb
        Jm7nTumriwBh1f6oNrTwJIGO3rotIZyfWbvfHPX55LpPo2/IfBKVvs+8h/59KIn43ShEbzjANbP
        z0R2GPpQDtRO0mJ7iV24uQJIpQcjRnbM+hNsE0A43hQ==
X-Received: by 2002:a1f:2850:: with SMTP id o77mr5533753vko.23.1622205734690;
        Fri, 28 May 2021 05:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP8YHtx6Nm7Vih9OSRSik8WCc8W76wXEqvpaj46Qq9kY3UA3420v5Vf1Pwn5+9Osz0Gz33sA==
X-Received: by 2002:a1f:2850:: with SMTP id o77mr5533616vko.23.1622205733050;
        Fri, 28 May 2021 05:42:13 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] nfc: pn533: drop of_match_ptr from device ID table
Date:   Fri, 28 May 2021 08:41:52 -0400
Message-Id: <20210528124200.79655-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might be not relevant here).  This
fixes compile warning (!CONFIG_OF):

    drivers/nfc/pn533/i2c.c:252:34: warning:
      ‘of_pn533_i2c_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn533/uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index a0665d8ea85b..7bdaf8263070 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -319,7 +319,7 @@ static struct serdev_device_driver pn532_uart_driver = {
 	.remove = pn532_uart_remove,
 	.driver = {
 		.name = "pn532_uart",
-		.of_match_table = of_match_ptr(pn532_uart_of_match),
+		.of_match_table = pn532_uart_of_match,
 	},
 };
 
-- 
2.27.0

