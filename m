Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B723FF79D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348523AbhIBXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbhIBXFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:05:48 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A37C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:04:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a10-20020ad45c4a000000b0037774ba4e8bso4466286qva.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EzWN+e8Z1YBfv4DI3mOenbfA5vwz77klczIXE4gMJG8=;
        b=H/u4rLaENOC4NRXolWAJG1BEVesOUaKcyjVQyvOKujZopwYDjWEazEDGqRQWy+abkv
         Vqn/7Fela1LOT9fjRrxb6LIBn+MXOOgMeeFkR4EUtrqU7ERTdjHi5C0u9de2J8GD7yaQ
         3hTGTgymYoSKuek/e0TdwkivXKvZ/qFZk+fO9ECGOGN6Qns6O2iJCHiRBq9NvPAR8wFz
         s1pIXfPe9BItQwRad2sn5dd5J5PJB8b7DG2e9WGnjKPwQYOzUoEXIuDN9t9HeO1tF0uo
         VCypSX+cbO0J79CfmplZHKL7Q2YGyeUVfG/rMBRJQZvDmGLdOw841k7znnGQoG3SDhlR
         mvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EzWN+e8Z1YBfv4DI3mOenbfA5vwz77klczIXE4gMJG8=;
        b=filtBxgLRFawFQ0rztZm7bRNWoFcdLw5RlKyxAnUdQDlxqZL2Fx8I8yTzd0X1+AZFv
         4Zuw5m9GT80oCawtrWJzSWUoyFYG75agT8L2Y0by7GaR+go+dXnhucPJX/ROLuf/bBGT
         PnRhcYl5P0Y2j1J7loyU0u3917k4teRMALOdOFqlOy3Pw0ssl8ttlBGrAeVdkjT5+PJz
         qv1WPnbk6qpT8dMCicfwaMF0uxijAgk0990ULFudE4pQqb2UwQtZ3DOes93lr5sXlKoq
         pPaobZuKP+cM6MDwOFCqpedphrCFm5OX7oY6pcSyx7zjsLLLmO9jpLjKH0v57MvzLTpT
         tDwA==
X-Gm-Message-State: AOAM531VmBDT/RxqW943nDXpCGCuAo7aHiaWvuhjeonO2Ih5oyctkoe7
        gxhwr4PPgCdW5y2Z2c6JwEDFdxAwQLD1jWs=
X-Google-Smtp-Source: ABdhPJyMqvlBqqp1YK5/YEtU2oGozc6mjbpZipwjtwEhTxnBYpLaUPMIgwdvUtn/2nDF+EclWV6MwTPtxGwOJvw=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7cb7:1ee7:33cb:da76])
 (user=saravanak job=sendgmr) by 2002:a05:6214:130a:: with SMTP id
 a10mr632215qvv.53.1630623888488; Thu, 02 Sep 2021 16:04:48 -0700 (PDT)
Date:   Thu,  2 Sep 2021 16:04:40 -0700
In-Reply-To: <20210902230442.1515531-1-saravanak@google.com>
Message-Id: <20210902230442.1515531-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_devlink could end up creating device links for bus only devices.
However, bus only devices don't get probed and can block probe() or
sync_state() [1] call backs of other devices. To avoid this, set up
these devices to get probed by the simple-pm-bus.

[1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 74afbb7a4f5e..b010e2310131 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -97,6 +97,48 @@ static void of_device_make_bus_id(struct device *dev)
 	}
 }
 
+/**
+ * of_match_only_simple_bus - Check if a device node is only a simple bus
+ * @np: device node to check
+ *
+ * A simple bus in this context is defined as a transparent bus whose child
+ * devices are automatically populated but has no hardware specific
+ * functionality.
+ *
+ * Returns true if the device node is only a simple bus and can never match
+ * with any other specific driver.  Otherwise, returns false.
+ */
+static bool of_match_only_simple_bus(struct device_node *np)
+{
+	/* List of buses that don't have an explicit driver. */
+	static const char * const of_simple_bus_table[] = {
+		"simple-bus",
+		"simple-mfd",
+		"isa",
+		"arm,amba-bus",
+	};
+	const char *cp;
+	struct property *prop;
+	int i;
+
+	prop = of_find_property(np, "compatible", NULL);
+	for (cp = of_prop_next_string(prop, NULL); cp;
+	     cp = of_prop_next_string(prop, cp)) {
+		bool match = false;
+		const char *bus = of_simple_bus_table[i];
+
+		for (i = 0; i < ARRAY_SIZE(of_simple_bus_table); i++)
+			if (!of_compat_cmp(cp, bus, strlen(bus))) {
+				match = true;
+				break;
+			}
+		if (!match)
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * of_device_alloc - Allocate and initialize an of_device
  * @np: device node to assign to device
@@ -143,6 +185,9 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	dev->dev.fwnode = &np->fwnode;
 	dev->dev.parent = parent ? : &platform_bus;
 
+	if (of_match_only_simple_bus(np))
+		dev->driver_override = "simple-pm-bus";
+
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
-- 
2.33.0.153.gba50c8fa24-goog

