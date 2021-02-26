Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1454E3263B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:04:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:53688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhBZOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:04:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70AB3B06A;
        Fri, 26 Feb 2021 14:03:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 04/13] driver core: plafrom: Introduce platform_mmio_configure()
Date:   Fri, 26 Feb 2021 15:02:56 +0100
Message-Id: <20210226140305.26356-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function will traverse the platform device's bus hierarchy and set
the relevant MMIO access flags.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/base/platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6e1f8e0b661c..31772fd4ca1d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1504,6 +1504,14 @@ int platform_dma_configure(struct device *dev)
 	return ret;
 }
 
+static int platform_mmio_configure(struct device *dev)
+{
+	if (dev->parent && dev->parent->of_node)
+		return of_mmio_configure(dev, dev->parent->of_node);
+
+	return 0;
+}
+
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	.runtime_suspend = pm_generic_runtime_suspend,
 	.runtime_resume = pm_generic_runtime_resume,
@@ -1519,6 +1527,7 @@ struct bus_type platform_bus_type = {
 	.remove		= platform_remove,
 	.shutdown	= platform_shutdown,
 	.dma_configure	= platform_dma_configure,
+	.mmio_configure = platform_mmio_configure,
 	.pm		= &platform_dev_pm_ops,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
-- 
2.30.1

