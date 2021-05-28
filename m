Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE23942D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhE1Moc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42540 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbhE1Mn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:58 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboj-00081M-Rl
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:21 +0000
Received: by mail-ua1-f72.google.com with SMTP id 5-20020ab004850000b029022e612041f6so1856512uaw.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xi/NsDS4IjaK0xUaurfvCiwF1a8SfsfV6rw+HJ5RS3o=;
        b=GGzO5U36/V3N/vda7uq6EoMzzX+s8Ksm7x/6K+mag53vd1SfHsiK0soWrO05g+cLXQ
         eEa4EMz8HP0RegETKrT3EtYrCMXaTmS8gvKwL8cXGkkKFnGcaybUmHyFXPao2dQDzvmA
         af3K17L7fVQI1dwJdQL9j6u+DWxYRsEr9a4FA3Ltr4xIZu3DTCyGJa8oUbQr31JFW1y6
         U8o3C7X++lzHel4/D1emhlOVTlG9wZ6pycakm7LIXv+QuBkgA3DCSNGf3xIimQHtlHyq
         JMe+egmy7C2Cmzx0bwQUG8nR4nDLGmMXYdtYO5euYsQaqHu195bOR0lQC0MndqfnE6nC
         1NvA==
X-Gm-Message-State: AOAM5324MIukeXq1zEuuNEs9M/XN2DDvxfuRMi5jaDmYEwg1VGfABh+G
        U5Kcdj4llqRZm56Qtx1Fh3P7f3o/m77Mkg6UN4uXwXDWNMbWJN+9l8hSz/GkGYvnLXj7Z2U+1f4
        GYTvGiPVhZ7HWovZ14AYCw2JZCbHiYa5XkzGYYalfsA==
X-Received: by 2002:a1f:f84a:: with SMTP id w71mr5977876vkh.4.1622205741009;
        Fri, 28 May 2021 05:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnhXTt0JMrjFgz7bxnO/WhpFd/Z/vii9Wwis1Kyx0+9nbuCIwGaLCOgr65EHk25XSkaukBKA==
X-Received: by 2002:a1f:f84a:: with SMTP id w71mr5977858vkh.4.1622205740887;
        Fri, 28 May 2021 05:42:20 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] nfc: pn544: mark ACPI and OF device ID tables as maybe unused
Date:   Fri, 28 May 2021 08:41:57 -0400
Message-Id: <20210528124200.79655-9-krzysztof.kozlowski@canonical.com>
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

    drivers/nfc/pn544/i2c.c:53:36: warning:
        ‘pn544_hci_i2c_acpi_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 4ac8cb262559..aac778c5ddd2 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -50,7 +50,7 @@ static const struct i2c_device_id pn544_hci_i2c_id_table[] = {
 
 MODULE_DEVICE_TABLE(i2c, pn544_hci_i2c_id_table);
 
-static const struct acpi_device_id pn544_hci_i2c_acpi_match[] = {
+static const struct acpi_device_id pn544_hci_i2c_acpi_match[] __maybe_unused = {
 	{"NXP5440", 0},
 	{}
 };
@@ -951,7 +951,7 @@ static int pn544_hci_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-static const struct of_device_id of_pn544_i2c_match[] = {
+static const struct of_device_id of_pn544_i2c_match[] __maybe_unused = {
 	{ .compatible = "nxp,pn544-i2c", },
 	{},
 };
-- 
2.27.0

