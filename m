Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB73942C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhE1Mnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:43:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42489 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbhE1Mnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:46 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboZ-0007xF-B5
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:11 +0000
Received: by mail-vs1-f72.google.com with SMTP id g13-20020a0561020ccdb029023fe9ce9042so951212vst.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5PhAYJAgpgGf/ki2oqzdzivSFW2QLSW3v25wv1mU4g=;
        b=uAJs6xYayY5lqyZ6KEgj4tmEF38CEScOt3cbxZJxdpSKHQxhBRCl7V8X6uY9kPjjHU
         C6b1xCYe8rpEGtPTL3RsNpPl8BeJcbUIA6kAbdlbiLFXYyF1ThvSq5urIvpRLxSkJN9k
         ym4i34NrXorIANLMHBisbc/cB3A8rip+kwgngwf8Ke6gAVhKsrh8J85bwEZ/CXOWIZEs
         R3WgUZ1npi17tDp6oe8Mk1GFchfCUEwpYfLFYZ3PyRgrxagPCF4U66sZtsWxTVnAMc5o
         zZ9NyIvUfxybC3znVDVNJagDYivSEchsvJwz5EmAs36tGVMNfAVOCRKf1e0GtzUCkhf+
         0cjw==
X-Gm-Message-State: AOAM5334AP/oo8348n1OApXcFKI5SyOTC7yoRwlt/QT1PvuUMjv2iSHe
        RXVComwmBIGM4DCNQVWGtsQr+q6itMq7zTc740jJDVxMowmT06F53/j+/TTs1XQRKNdtp7T7Dsz
        Rp2W66yQTMdLLj9pV30XJbNilTQEQO20grGv9rnv7oA==
X-Received: by 2002:ac5:c3ca:: with SMTP id t10mr1383172vkk.11.1622205730297;
        Fri, 28 May 2021 05:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAguSr2J93TSQQJDG3VnDliTUMEJaVy45IiQ+G+QWSSRLr762rLfLwGPi5FoNLdafPbJYLgw==
X-Received: by 2002:ac5:c3ca:: with SMTP id t10mr1383136vkk.11.1622205730053;
        Fri, 28 May 2021 05:42:10 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] nfc: fdp: drop ACPI_PTR from device ID table
Date:   Fri, 28 May 2021 08:41:50 -0400
Message-Id: <20210528124200.79655-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the ACPI ID table so the table should be
always used and the ACPI_PTR does not have any sense.  This fixes fixes
compile warning (!CONFIG_ACPI):

    drivers/nfc/fdp/i2c.c:362:36: warning:
        ‘fdp_nci_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index adaa1a7147f9..997e0806821a 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -368,7 +368,7 @@ MODULE_DEVICE_TABLE(acpi, fdp_nci_i2c_acpi_match);
 static struct i2c_driver fdp_nci_i2c_driver = {
 	.driver = {
 		   .name = FDP_I2C_DRIVER_NAME,
-		   .acpi_match_table = ACPI_PTR(fdp_nci_i2c_acpi_match),
+		   .acpi_match_table = fdp_nci_i2c_acpi_match,
 		  },
 	.probe_new = fdp_nci_i2c_probe,
 	.remove = fdp_nci_i2c_remove,
-- 
2.27.0

