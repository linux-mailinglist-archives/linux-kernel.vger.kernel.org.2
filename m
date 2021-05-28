Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C745B39449D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhE1O6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:58:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47148 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbhE1O56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:57:58 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmduQ-0004Aq-QN
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 14:56:22 +0000
Received: by mail-vs1-f71.google.com with SMTP id h23-20020a67c1970000b029022a88436f30so1089524vsj.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 07:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOll6TKQbDWTse8M6wamAPtyvMVGYz69R1ORjx1lV/0=;
        b=ui5PLsJRjTdeDGFCOvQApERqTaTWGceKCN+EtIYhSIVmIJbx36LPGglleLt1RMjbfY
         zEvQuba+fhEzB1NgYOu0WILPaNwA7Q0j0NS4E+O29FOR1j52mHkElCQ6N2UalpYlXnyG
         VquuM2u0ONuJ6bVeSpI+4oR/2kp71jS8y/hdvkCc41L/UwUEQI9ukpHJ6/Db4v2+X0IL
         gtgjOV+aHTk9HgKROop5nZrpKJva6XP16Mz8NZo4vMatgXMFuIkHOXgSWEJw1cpjoh9g
         Hg4TcQAuf6vHOWjxQe9byGN7i0+Yt8+ySrhX0oAwKnJTEcHd6bquPX/fxIlwC69QQNRP
         mdPA==
X-Gm-Message-State: AOAM532AL2IkO8YLG6rWP67GDXmD/2v8d8wI2oBFm9idJNp0Fhe16/nq
        xOR/AzMNsn/GqSsHaFKrSqx/BpL+0/1yWg78/hfUAK6MzdsE2jFzUg/+lukx85dHtb0G1TIZwtP
        vkFQJt/SvRC9JC35QO9k9F/ZHG1OBmKE9/p5wwsyJ1g==
X-Received: by 2002:a1f:a910:: with SMTP id s16mr6919062vke.10.1622213781948;
        Fri, 28 May 2021 07:56:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4AhxZK2XYM4OiqRRBIBQMjJThDP+GKPg/Kb1XvgWUz6kwSBd+aWgoZQ6H46zZdH9u+CAu3w==
X-Received: by 2002:a1f:a910:: with SMTP id s16mr6919045vke.10.1622213781776;
        Fri, 28 May 2021 07:56:21 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id c15sm743661vko.15.2021.05.28.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:56:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/11] nfc: mrvl: simplify with module_driver
Date:   Fri, 28 May 2021 10:55:28 -0400
Message-Id: <20210528145534.125460-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528145534.125460-1-krzysztof.kozlowski@canonical.com>
References: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
 <20210528145534.125460-1-krzysztof.kozlowski@canonical.com>
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

