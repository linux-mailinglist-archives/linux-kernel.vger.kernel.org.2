Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52364422B38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhJEOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhJEOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:40:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F4C061755
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 07:38:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j5so82204669lfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aD0ZimcpDdMwxxDkok8INnwAF4L8JkxKG7hlNjJNuc4=;
        b=xr/EbJQXsQv4f8TFJbE2w6XzhEQf/jsX9u4gGwqhd0AvcG1AQDhsxEeR3pfpTpw9c/
         KWVwcxUDdoeM0yqquLJuLWpJAAopOx97wTP2Q+143laE4khIxbb7JeDeJkR0gOb8oIYC
         41ZvV95CrLfPsQoREGzi1/nO++3VwdYgi7hfrL1aUdWK/pibrAd2XGwDYYRuFNx+X2/j
         gcsZYfGj1GvbBlX1TeaPjFFx5ZmBKAMWu6nLTQlVGsYEgOUO5gOnH6phW7sFkuA0VJp7
         0bdXaeVjd+P/1BCvlgovSJPtphlexKfI7yWMs6mFzykdj73vQENifMenCHBjmbdX5E9Y
         gEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aD0ZimcpDdMwxxDkok8INnwAF4L8JkxKG7hlNjJNuc4=;
        b=a1alRMwA3uVvKC6Qn7AsAgoQYKGV42z6h5ND0liVxpWMBkeyK2gkEkpmjgrK/mz1HH
         P77dtSDEVxxfnjwP3iOjQcD05u1OQQlmrcm/spm/dmMPXeqo7FsnIFyt8Dq1m4/db4uV
         UzqHAsVYtr5Iwe81uElFHYJ+HRrAvUpZAhEgDsnE9DCEVbiS9pB8pr4M3601qlAw8bpQ
         nfmY8L+0Y34tZVpKCw8n15KKJiEkN1jBm0SSuLsdzkCQKNH40v30Cd9HmBwsvMaKiFnk
         jRCkzyRuVhj/+PxMf6KoIArz/a0yFJQTIFz6u0r6WcnfVAPg/AW5/XJ74V1AGq3bykXr
         fl4Q==
X-Gm-Message-State: AOAM533qocrctILuE7VlZZfFI2Fth1wML4DFQHSmkGV1FkZS4/AUNyWl
        UUrLHdy2iweFhk5WPrOQDtk+Vg==
X-Google-Smtp-Source: ABdhPJz1Gqoll+/R0fBf7HkcMgpMiilGz9sNSE96xW6sZExUwmOViaK4fIephyq2Ege3h6LgH4KT9Q==
X-Received: by 2002:a05:6512:1053:: with SMTP id c19mr3819153lfb.283.1633444697355;
        Tue, 05 Oct 2021 07:38:17 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id u25sm1973835lfc.176.2021.10.05.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:38:17 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, robh+dt@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, dinguyen@kernel.org, p.yadav@ti.com,
        Tudor.Ambarus@microchip.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        thunder.leizhen@huawei.com, Jonathan.Cameron@huawei.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ka@semihalf.com, tn@semihalf.com, jam@semihalf.com,
        amstan@google.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 3/4] reset: socfpga: add empty driver allowing consumers to probe
Date:   Tue,  5 Oct 2021 16:37:47 +0200
Message-Id: <20211005143748.2471647-4-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005143748.2471647-1-pan@semihalf.com>
References: <20211005143748.2471647-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early reset driver doesn't ever probe, which causes consuming
devices to be unable to probe. Add an empty driver to set this device
as available, allowing consumers to probe.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 drivers/reset/reset-socfpga.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 2a72f861f798..8c6492e5693c 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -92,3 +92,29 @@ void __init socfpga_reset_init(void)
 	for_each_matching_node(np, socfpga_early_reset_dt_ids)
 		a10_reset_init(np);
 }
+
+/*
+ * The early driver is problematic, because it doesn't register
+ * itself as a driver. This causes certain device links to prevent
+ * consumer devices from probing. The hacky solution is to register
+ * an empty driver, whose only job is to attach itself to the reset
+ * manager and call probe.
+ */
+static const struct of_device_id socfpga_reset_dt_ids[] = {
+	{ .compatible = "altr,rst-mgr", },
+	{ /* sentinel */ },
+};
+
+static int reset_simple_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver reset_socfpga_driver = {
+	.probe	= reset_simple_probe,
+	.driver = {
+		.name		= "socfpga-reset",
+		.of_match_table	= socfpga_reset_dt_ids,
+	},
+};
+builtin_platform_driver(reset_socfpga_driver);
-- 
2.25.1

