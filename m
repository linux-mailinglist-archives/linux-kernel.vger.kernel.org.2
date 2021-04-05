Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DB3546B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhDESQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:16:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33085 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhDESP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:15:58 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTTlO-0004rL-UU
        for linux-kernel@vger.kernel.org; Mon, 05 Apr 2021 18:15:50 +0000
Received: by mail-wr1-f72.google.com with SMTP id t2so618614wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z6sJlr0sCPS8MR/sKy7gMvD05Sd0WFk7r5Dv1ypQclI=;
        b=m/Q7wi19IoK4hpmwDvtAdli2EO7KeqYE5IpFvSEW7/GYsxfFIX3UjNMbYfNrchVxX7
         42yy7UXu6C5ThQp47vQ931iuLuXK8n+VlYkZaOsXSr8CZ62ntXNEQel2/LKzWtiOFlSY
         ffGRBxeAxR88SikCG2JVp8n21B476ZOV1MvF6Ncb50jNGjT73V4gjft4cEUcrDFedv4Z
         FcMHd42Nr5d2iUfyL44YXF9+J6UkpwOc00/fh2aGAmUuH/OptJLEmvzHicpBWsiKT1vv
         b4lWZDgS4uq9JLcdwkcjggNQ0JRkPGE0m/plUH1y+8I1m5av8Wlv5U7Krfi6ZGZYFHkB
         ThaA==
X-Gm-Message-State: AOAM533pW20ZUlUDOc53qtssM8R0MpyiWiXrcdcHPOAwOIsOFRr86Xdh
        3AWIr8cOKjvm0/RKc8TcYjGn6mfZO2lD1SfUTt/MPJSaYu2eoSUcHMzL1A4wtAnltv29KUqdY6C
        sYxlbSlty1AqkHh6HsB/pdnYTXFbP68tikzKLjELSMQ==
X-Received: by 2002:a05:600c:3650:: with SMTP id y16mr337782wmq.182.1617646550716;
        Mon, 05 Apr 2021 11:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQNdtJzoVtUMXkbcFivyybLHuHwyECjDgnf8EE/AYCZedkLowO9BthVxx0DZWdYzaREY7GHg==
X-Received: by 2002:a05:600c:3650:: with SMTP id y16mr337775wmq.182.1617646550615;
        Mon, 05 Apr 2021 11:15:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id 4sm8151817wrf.5.2021.04.05.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 11:15:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steve Glendinning <steve.glendinning@shawell.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] net: smsc911x: skip acpi_device_id table when !CONFIG_ACPI
Date:   Mon,  5 Apr 2021 20:15:48 +0200
Message-Id: <20210405181548.52501-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match via multiple methods.  Its acpi_device_id table is
referenced via ACPI_PTR() so it will be unused for !CONFIG_ACPI builds:

  drivers/net/ethernet/smsc/smsc911x.c:2652:36: warning:
    ‘smsc911x_acpi_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 606c79de93a6..556a9790cdcf 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2649,11 +2649,13 @@ static const struct of_device_id smsc911x_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, smsc911x_dt_ids);
 #endif
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id smsc911x_acpi_match[] = {
 	{ "ARMH9118", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smsc911x_acpi_match);
+#endif
 
 static struct platform_driver smsc911x_driver = {
 	.probe = smsc911x_drv_probe,
-- 
2.25.1

