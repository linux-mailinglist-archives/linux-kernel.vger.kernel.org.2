Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA94114BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhITMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhITMnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:43:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD827C061764
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so65009639lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aD0ZimcpDdMwxxDkok8INnwAF4L8JkxKG7hlNjJNuc4=;
        b=ROkKUP5Wti0ZceJVkqlAW1hw9pw2rtGO+UYdzPbSZg0ZsAEcFmWUy5DNCnc2MIrx4b
         BYp0RUGvkHwf934xqPgpQ6UUwcdgw6xDoe22pz4EAJzNIkulRo31v++TUs9ymGhu5K5u
         tFmeYg86tBZ7B0TP8fKKkgwBNWF29JNbAnbvAilubZMvvjqh33+omk3tgv1z+6L1bSvw
         FCli+M02Sz/IhIHZXabClzluGQtQlRj9xfOIJWpPK6WGTy5EPC3C9NjyvqDaeSeKSJCU
         Vakycw1Ed8PiorDWqI1+IUXUUnKX7kJZHW55ViIYHRIy6ZFT8OOia60WSN3/sQxWirf6
         jpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aD0ZimcpDdMwxxDkok8INnwAF4L8JkxKG7hlNjJNuc4=;
        b=hU65grR3g0NhMJ//mTOqtARwiFDs6YMkHVGMm5GtRQcGXNIcj0h8xVvmdlvVQ/Y99j
         J6E0U7JxwqtFKrQsVRWyTgwDwV0LG/BYSY0JhmW+SXSj/dt3oqHOR3YOVptOC76SZwW4
         5IQN51BgYJzXjgqTymIPwMaSsl6wJJ/OgMzkwB9CcZX8ACbBW290mho8oGS/VbjaMSgl
         fchlQ+a5kFXTRt2siOkyKUk0MM5IEb3tezpHgIHkKE+I4mPZr7Sn9T2gxqmBU1ehc+Ux
         Kqc0pyFhalEX9eqG/HzcCy2Ib+7b8ThHpQl10O7sClUsGzF2HojhnR0gapn/bwLvfL+M
         21aQ==
X-Gm-Message-State: AOAM530R7bm86RKwJ7XOIWNI8E6negdtorJ00mZjnSXwW2rQ7NqQixpc
        raPZVHuAnKHqbtDOfmDD9WZElA==
X-Google-Smtp-Source: ABdhPJzdjJvEESBsRijWxynJclTM1jLd3jz584eIX1nzT8MgbP4/OcLKY9ulXqJbDoTj+2jHr5+kVA==
X-Received: by 2002:a2e:9a07:: with SMTP id o7mr6991825lji.125.1632141730817;
        Mon, 20 Sep 2021 05:42:10 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id v1sm630944lfo.308.2021.09.20.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:42:10 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        dinguyen@kernel.org, p.zabel@pengutronix.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tn@semihalf.com, ka@semihalf.com, jam@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 3/3] reset: socfpga: add empty driver allowing consumers to probe
Date:   Mon, 20 Sep 2021 14:41:41 +0200
Message-Id: <20210920124141.1166544-4-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920124141.1166544-1-pan@semihalf.com>
References: <20210920124141.1166544-1-pan@semihalf.com>
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

