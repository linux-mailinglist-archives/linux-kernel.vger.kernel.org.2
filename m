Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58C3263BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBZOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:05:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:54868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhBZOEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:04:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7C26AE07;
        Fri, 26 Feb 2021 14:03:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 06/13] device core: Introduce dev_64bit_mmio_supported()
Date:   Fri, 26 Feb 2021 15:02:58 +0100
Message-Id: <20210226140305.26356-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper function will be help drivers ascertain whether they can use
64-bit memory accesses.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/device.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index bd94aa0cbd72..e9b4b2f99a44 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -826,6 +826,23 @@ static inline int dev_num_vf(struct device *dev)
 	return 0;
 }
 
+#if defined(CONFIG_ARCH_HAS_64BIT_MMIO_BROKEN)
+static inline bool dev_64bit_mmio_supported(struct device *dev)
+{
+	return !dev->mmio_64bit_broken;
+}
+#elif defined(CONFIG_64BIT)
+static inline bool dev_64bit_mmio_supported(struct device *dev)
+{
+	return true;
+}
+#else
+static inline bool dev_64bit_mmio_supported(struct device *dev)
+{
+	return false;
+}
+#endif
+
 /*
  * Root device objects for grouping under /sys/devices
  */
-- 
2.30.1

