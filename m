Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D63942DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhE1Mov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbhE1MoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:44:03 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboq-000838-5k
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:28 +0000
Received: by mail-ua1-f71.google.com with SMTP id o7-20020ab01e870000b029020d37e3e144so1870837uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVM99Rq9YYpmqFYN93ErdoKv+Sqk4U9Fa7zLEpo/FoQ=;
        b=CrQOzEAyfnWMv4x3nUCM2zoDrmtdwDZEKG3i3fHMEtLk/qObpCgj9U49ucr0MaoQO+
         VlnjpJsuoUvtsVMQETYHGJLnpA7KNcZoWatV13uJDppVe9MDQlw1UewimiB6M+LsBLYV
         GCYKsog5rFk9ZdGh9aNRjbTtg0e3IwWwsME9L1r+EXUeLxInbKx9EjKPbkePqLWxHQAT
         p0EKLN8NJWOd77sX/WtmYCG9gPmWONw5d7XOwxkzIJMfgjF4/PWbbUdsfw8nPg/+xRpv
         /kSE1rF/LE5XdJ8N8sIfTBTcNKmi5Bvx+aOSKSIRz79AkTKHyaTAygFyfeLbwnO4l4Pe
         rodg==
X-Gm-Message-State: AOAM533nP0KcblOSrGGqCV4jDc6xYn8mo/j/2UmJjWr1OQ6tIVmK7473
        Wih/4TOQBGfhp86rQdCSKTLpoCWy4ftWebxsWz25owjEaIVbDrQ0TI95lfKLqf3Wcz3ekJQos+j
        vBWw9IShyWfH3qy6YfUob0pGxt/xZO3C+3ImP/wZRgQ==
X-Received: by 2002:a1f:eac6:: with SMTP id i189mr6094876vkh.3.1622205745858;
        Fri, 28 May 2021 05:42:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI4pXCt8bne0kZBifLt5Y1FotnUnE0PxhwFaZQXgWqXhUGHZi56pmTBuAwfHxymwdgrabXfQ==
X-Received: by 2002:a1f:eac6:: with SMTP id i189mr6094860vkh.3.1622205745730;
        Fri, 28 May 2021 05:42:25 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] nfc: st95hf: mark ACPI and OF device ID tables as maybe unused
Date:   Fri, 28 May 2021 08:42:00 -0400
Message-Id: <20210528124200.79655-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match either via OF or ACPI ID tables.  If one
configuration is disabled, the table will be unused:

    drivers/nfc/st95hf/core.c:1059:34: warning:
        ‘st95hf_spi_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st95hf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index 88924be8decb..0d99181b6ce3 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -1056,7 +1056,7 @@ static const struct spi_device_id st95hf_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, st95hf_id);
 
-static const struct of_device_id st95hf_spi_of_match[] = {
+static const struct of_device_id st95hf_spi_of_match[] __maybe_unused = {
         { .compatible = "st,st95hf" },
         { },
 };
-- 
2.27.0

