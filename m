Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685E4395650
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEaHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:40:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60611 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEaHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:40:51 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncVz-00036o-6E
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:39:11 +0000
Received: by mail-wm1-f70.google.com with SMTP id 19-20020a05600c2313b0290193637766d9so4439370wmo.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOll6TKQbDWTse8M6wamAPtyvMVGYz69R1ORjx1lV/0=;
        b=QVxr/6FPIoeeM/dGnNeE5f9npHmM00m/cKV7KQzJb4sFEdQXpizD4d1VQRuszeyNBs
         1Mxslu6A63bGh8AkZ7WartKEVoL+cV6J4uYtm13RdkbSQhO89she6+YfFW5gE3Q/NxXA
         JL/szg6KJTXRc6KIhdrP2WP1IX6rVRCeEVitZkEgCceRXbKimIUecJhhXcnNAbarvLe/
         5+x/p6eC0bN+xOiEUucnby0a5GO1xo3o2S4JuX0i0f3nUQVPfh8wAONlX6BlaFTzggAf
         nfRWbBm61A9Gna5vjQNfJX7dGQljPGZATLWVSilatt5/Px3Kv957+7QDHdGhSv/10dUK
         tz1A==
X-Gm-Message-State: AOAM530oNLBjpt2rFpbqJA9iV0/68H6SYmwM2IBXGt7b8//zTPjaBs0q
        DiG9h/ymwp77sxOKfu89wnmIVYX5koILX4rAJPKowa2v03mYMWz8Zon9EGGIBo682gvCqfncYp0
        NBOxgz3XwVbUUgZBm53x8WcgwTmkdlIzd+XxAjn2JAQ==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr4703725wmg.56.1622446750583;
        Mon, 31 May 2021 00:39:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsIR56tR1+XGrfQapnZONUGR+r+w7KQN84keiQfNaaA1hDubeRB9qINkqZRXhWIEB3B3hmNA==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr4703716wmg.56.1622446750484;
        Mon, 31 May 2021 00:39:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id a1sm9168911wrg.92.2021.05.31.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:39:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 05/11] nfc: mrvl: simplify with module_driver
Date:   Mon, 31 May 2021 09:38:56 +0200
Message-Id: <20210531073902.7111-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
References: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove standard module init/exit boilerplate with module_driver() which
also annotates the functions with __init.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/uart.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index ed85645eb885..50d86c90b9dd 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -189,23 +189,7 @@ static struct nci_uart nfcmrvl_nci_uart = {
 		.tx_done	= nfcmrvl_nci_uart_tx_done,
 	}
 };
-
-/*
-** Module init
-*/
-
-static int nfcmrvl_uart_init_module(void)
-{
-	return nci_uart_register(&nfcmrvl_nci_uart);
-}
-
-static void nfcmrvl_uart_exit_module(void)
-{
-	nci_uart_unregister(&nfcmrvl_nci_uart);
-}
-
-module_init(nfcmrvl_uart_init_module);
-module_exit(nfcmrvl_uart_exit_module);
+module_driver(nfcmrvl_nci_uart, nci_uart_register, nci_uart_unregister);
 
 MODULE_AUTHOR("Marvell International Ltd.");
 MODULE_DESCRIPTION("Marvell NFC-over-UART");
-- 
2.27.0

