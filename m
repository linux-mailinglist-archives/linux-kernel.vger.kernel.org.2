Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3303431F605
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBSIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhBSIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613724322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/buFKeI9CtoxyX4nukMARJ+1vltPsaW0sfkWh7oknSY=;
        b=aYigwRGxxusrJJMSXG3kysyQBkcoWwsIK2zUO+yqGNefNWfq+Orcxa6Va9jr2rw+dtz4Ok
        yHG1mtIR3YikfMswshjJ5kyQTgLRkfRS4bEiBrAhaAPpYSEs/CbNympI09NuZ9/uJT5uJh
        b8sQJnHNW1v7OObC3RaTFpErbfZbBNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Zp71jxVWOmWJmIfbjgXXMA-1; Fri, 19 Feb 2021 03:45:20 -0500
X-MC-Unique: Zp71jxVWOmWJmIfbjgXXMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE1D0192CC40;
        Fri, 19 Feb 2021 08:45:18 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6AB6F95B;
        Fri, 19 Feb 2021 08:45:13 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Date:   Fri, 19 Feb 2021 03:45:09 -0500
Message-Id: <20210219084509.48269-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
lot of confusion. E.g it may break various default configs which want
virtio devices.

So this patch fixes this by hide the prompot and document the
dependency.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6b9b81f4b8c2..be7df369bc2b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -13,12 +13,12 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	  VIRTIO_F_ACCESS_PLATFORM
 
 config VIRTIO_PCI_MODERN
-	tristate "Modern Virtio PCI Device"
-	depends on PCI
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
+	select VIRTIO_PCI_MODERN
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual device
-- 
2.18.1

