Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4893225D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhBWGXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231664AbhBWGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614061162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0W8Iouaiv+280rcLPUAIdqALHz0RUbDwkNLOs2EfjZw=;
        b=HNGRbw5dgVGWaZTkcpHEfVvsmkF07wQD/xgeUfNrxUiK3ZVuaSHIzLDJu6d625PWSBjKo+
        ODruSBo1iXO56XvdyUwj/CTZaeALj3wCkI/JbnBNk4pXqdf6IjGGH6mhmJtPP3JjOLuiSB
        ibHKejINOB0RI59S9/ELyNims149oAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-LnAMAtx-OFGtUaYucVyweA-1; Tue, 23 Feb 2021 01:19:20 -0500
X-MC-Unique: LnAMAtx-OFGtUaYucVyweA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 085298030B7;
        Tue, 23 Feb 2021 06:19:19 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-6.pek2.redhat.com [10.72.13.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4D75D9D0;
        Tue, 23 Feb 2021 06:19:14 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        sgarzare@redhat.com, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Date:   Tue, 23 Feb 2021 14:19:03 +0800
Message-Id: <20210223061905.422659-2-jasowang@redhat.com>
In-Reply-To: <20210223061905.422659-1-jasowang@redhat.com>
References: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
lot of confusion. E.g it may break various default configs which want
virtio devices.

So this patch fixes this by hiding the prompot and documenting the
dependency. While at it, rename the module to VIRTIO_PCI_LIB.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/Kconfig  | 11 ++++++-----
 drivers/virtio/Makefile |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6b9b81f4b8c2..ce1b3f6ec325 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -12,13 +12,13 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	  This option is selected if the architecture may need to enforce
 	  VIRTIO_F_ACCESS_PLATFORM
 
-config VIRTIO_PCI_MODERN
-	tristate "Modern Virtio PCI Device"
-	depends on PCI
+config VIRTIO_PCI_LIB
+	tristate
 	help
 	  Modern PCI device implementation. This module implements the
 	  basic probe and control for devices which are based on modern
-	  PCI device with possible vendor specific extensions.
+	  PCI device with possible vendor specific extensions. Any
+	  module that selects this module must depend on PCI.
 
 menuconfig VIRTIO_MENU
 	bool "Virtio drivers"
@@ -28,7 +28,8 @@ if VIRTIO_MENU
 
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices"
-	depends on VIRTIO_PCI_MODERN
+	depends on PCI
+	select VIRTIO_PCI_LIB
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual device
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index f097578aaa8f..699bbea0465f 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
-obj-$(CONFIG_VIRTIO_PCI_MODERN) += virtio_pci_modern_dev.o
+obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
-- 
2.25.1

