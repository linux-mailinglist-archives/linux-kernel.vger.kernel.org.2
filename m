Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8D3942DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhE1Mom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhE1MoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:44:00 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmbol-00081u-UA
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:23 +0000
Received: by mail-ua1-f70.google.com with SMTP id j23-20020ab01d170000b029023ea6f67624so1657338uak.14
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgOmPhTBJh9RRkgxZVTiKdOGNIiMBeUiuN1whRzpH+c=;
        b=XUwXehpE686S3TVRuY9q82AY/5egyd2Xm7rhFFmuwRDjYSxOFSzdyIlWoHuldl3PZZ
         oX5sdhm8CB9N3kSD2xI4BH7dpTg0iPyDWEfeqb+tJ+h9VQ7DgAz7Hbe7hiwVX2dqnvvj
         2NhDbwsOLxlOIQiOHxJenGGI4MGDkuKgUufE3JTvW444/lXzE5uNMAcKHpiGt9sI9SvC
         LTGp6KKYRY8eGZiiZWKzxyLisNDRV/BoY5qkWIq19rN8AwZlGa9VXuOsR9kzkkKX1fMY
         DreqYfWys7CXDTHou7GaJcQJnaFBlK09yW7poX91yXbRLSZyFPNgOeBNC0PXjbc4uibI
         Y2dg==
X-Gm-Message-State: AOAM532A/b40HS/+r5W4lRoDIrSndcx/In/YhPrPloV7ye9TryWmRqUv
        CchtkWFgFYzF8I5IQkLzfx2g6LCQq2B6vR+vis/q/lsOM+YICSPSUxMwUpaP5a1fwhuya3A9siI
        T4JEe+5BHrmbWvQk/RSP7rrTBBXxMP965SGEQkzqR1g==
X-Received: by 2002:a67:f3d5:: with SMTP id j21mr6279318vsn.56.1622205743020;
        Fri, 28 May 2021 05:42:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy294cc3ptUaStQ6oMzMn163IRlakgN+VqEvCDV/ilun/KRmRzCMHN0evL0hFuVQTM6mArb6w==
X-Received: by 2002:a67:f3d5:: with SMTP id j21mr6279301vsn.56.1622205742872;
        Fri, 28 May 2021 05:42:22 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] nfc: st-nci: mark ACPI and OF device ID tables as maybe unused
Date:   Fri, 28 May 2021 08:41:58 -0400
Message-Id: <20210528124200.79655-10-krzysztof.kozlowski@canonical.com>
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

    drivers/nfc/st-nci/spi.c:296:34: warning:
        ‘of_st_nci_spi_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st-nci/i2c.c | 4 ++--
 drivers/nfc/st-nci/spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index 55d600cd3861..663d1cc19b81 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -274,14 +274,14 @@ static const struct i2c_device_id st_nci_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_nci_i2c_id_table);
 
-static const struct acpi_device_id st_nci_i2c_acpi_match[] = {
+static const struct acpi_device_id st_nci_i2c_acpi_match[] __maybe_unused = {
 	{"SMO2101"},
 	{"SMO2102"},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, st_nci_i2c_acpi_match);
 
-static const struct of_device_id of_st_nci_i2c_match[] = {
+static const struct of_device_id of_st_nci_i2c_match[] __maybe_unused = {
 	{ .compatible = "st,st21nfcb-i2c", },
 	{ .compatible = "st,st21nfcb_i2c", },
 	{ .compatible = "st,st21nfcc-i2c", },
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 09df6ea65840..5f1a2173b2e7 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -287,13 +287,13 @@ static struct spi_device_id st_nci_spi_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_nci_spi_id_table);
 
-static const struct acpi_device_id st_nci_spi_acpi_match[] = {
+static const struct acpi_device_id st_nci_spi_acpi_match[] __maybe_unused = {
 	{"SMO2101", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, st_nci_spi_acpi_match);
 
-static const struct of_device_id of_st_nci_spi_match[] = {
+static const struct of_device_id of_st_nci_spi_match[] __maybe_unused = {
 	{ .compatible = "st,st21nfcb-spi", },
 	{}
 };
-- 
2.27.0

