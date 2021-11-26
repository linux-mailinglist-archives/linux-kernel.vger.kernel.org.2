Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA645F275
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhKZQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239547AbhKZQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637945285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PsJG6PvKljGFJ8TWs32flKxNSDrPXqWSYzJh9yh3yU=;
        b=VyGWYhWQSf2P4ejyFC8Si0pMnmDEwdsJabDaqewBdsznh9kNM2Tg1rs1qNB9w5X56zHes4
        d46u0e6mHkY4Oy2zo/O3Re5LBq8XngSYev4mDoVJlKQI8WWPG/J9F00x9RsIdZAfGQwqDi
        SFiEbL8SXjgH1uCSN5vY8JEtH2kdM5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-3C0hKvQnM928kaGkzUdfvQ-1; Fri, 26 Nov 2021 11:48:04 -0500
X-MC-Unique: 3C0hKvQnM928kaGkzUdfvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468DA1853022;
        Fri, 26 Nov 2021 16:48:03 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.193.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB4A667840;
        Fri, 26 Nov 2021 16:48:01 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 1/2] docs: document sysfs ABI for vDPA bus
Date:   Fri, 26 Nov 2021 17:47:52 +0100
Message-Id: <20211126164753.181829-2-sgarzare@redhat.com>
In-Reply-To: <20211126164753.181829-1-sgarzare@redhat.com>
References: <20211126164753.181829-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation of sysfs ABI for vDPA bus in
the new Documentation/ABI/testing/sysfs-bus-vdpa file.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-vdpa | 37 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vdpa

diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
new file mode 100644
index 000000000000..4e55761a39df
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-vdpa
@@ -0,0 +1,37 @@
+What:		/sys/bus/vdpa/driver_autoprobe
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		This file determines whether new devices are immediately bound
+		to a driver after the creation. It initially contains 1, which
+		means the kernel automatically binds devices to a compatible
+		driver immediately after they are created.
+
+		Writing "0" to this file disable this feature, any other string
+		enable it.
+
+What:		/sys/bus/vdpa/driver_probe
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		Writing a device name to this file will cause the kernel binds
+		devices to a compatible driver.
+
+		This can be useful when /sys/bus/vdpa/driver_autoprobe is
+		disabled.
+
+What:		/sys/bus/vdpa/drivers/.../bind
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		Writing a device name to this file will cause the driver to
+		attempt to bind to the device. This is useful for overriding
+		default bindings.
+
+What:		/sys/bus/vdpa/drivers/.../unbind
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		Writing a device name to this file will cause the driver to
+		attempt to unbind from the device. This may be useful when
+		overriding default bindings.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5250298d2817..36ea80b4ba63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20104,6 +20104,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/devicetree/bindings/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-- 
2.31.1

