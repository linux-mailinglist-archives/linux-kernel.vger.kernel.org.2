Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8694201BB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJCNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:35:36 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F836C0613EC;
        Sun,  3 Oct 2021 06:33:49 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A7F1FC1D32F;
        Sun,  3 Oct 2021 15:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633268027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeNxvtd5M1WG392RQHi/zqPpeo7nSR1qDA2byq9wMl8=;
        b=f4KuiDAhUj+BkzpMCs+26DI3tdNSqLQZ/Lp3AVUIe5g1vFz1LY3nhvmtyHysiURggyumMk
        FbdtFZEXtwco0Sa0wmoJcecDvTdOJ6w4ANIcXx2GDhA0FD29xfcMby4XG+oLkKz4FTnXSz
        5dT+TbdlsAnlAVvfxzl14cXL/fNHB1s=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (nct6775) add Pro WS X570-ACE
Date:   Sun,  3 Oct 2021 15:33:42 +0200
Message-Id: <20211003133344.9036-2-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003133344.9036-1-oleksandr@natalenko.name>
References: <20211003133344.9036-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS Pro WS X570-ACE board has got an nct6775 chip, but by default
there's no use of it because of resource conflict:

```
ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x0000000000000299 (\AMW0.SHWM) (20210604/utaddress-204
)
ACPI: OSL: Resource conflict; ACPI support missing from driver?
ACPI: OSL: Resource conflict: System may be unstable or behave erratically
```

A workaround is to use `acpi_enforce_resources=lax`, but a proper
support needs to be added instead.

This commit adds Pro WS X570-ACE to the list of boards that can be monitored
using ASUS WMI.

Tested by me on this hardware:

```
Base Board Information
    Manufacturer: ASUSTeK COMPUTER INC.
    Product Name: Pro WS X570-ACE

BIOS Information
    Vendor: American Megatrends Inc.
    Version: 3801
    Release Date: 07/30/2021
```

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 drivers/hwmon/nct6775.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index ba18c1cbf572..ff28ba70a8b3 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5000,6 +5000,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"Pro WS X570-ACE",
 	"PRIME B360-PLUS",
 	"PRIME B460-PLUS",
 	"PRIME X570-PRO",
-- 
2.33.0

