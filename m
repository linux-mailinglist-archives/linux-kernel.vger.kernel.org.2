Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6F45028D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhKOKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:32:19 -0500
Received: from foss.arm.com ([217.140.110.172]:53530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhKOKcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:32:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975B41FB;
        Mon, 15 Nov 2021 02:29:20 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E192D3F70D;
        Mon, 15 Nov 2021 02:29:18 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Make virtio Version_1 compliance optional
Date:   Mon, 15 Nov 2021 10:29:10 +0000
Message-Id: <20211115102910.7639-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a compilation option to disable strict enforcement of compliance
against VirtIO Version_1 backends, so as to allow to support also Legacy
VirtIO devices implementations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig  | 14 ++++++++++++++
 drivers/firmware/arm_scmi/virtio.c |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 3d7081e84853..1e6c4659b640 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -77,6 +77,20 @@ config ARM_SCMI_TRANSPORT_VIRTIO
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on VirtIO, answer Y.
 
+config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
+	bool "SCMI VirtIO transport Version 1 compliance"
+	depends on ARM_SCMI_TRANSPORT_VIRTIO
+	default y
+	help
+	  This enforces strict compliance with VirtIO Version 1 specification.
+
+	  If you want the ARM SCMI VirtIO transport layer to refuse to work
+	  with Legacy VirtIO backends and instead support only VirtIO Version 1
+	  devices (or above), answer Y.
+	  If you want instead to support also old Legacy VirtIO backends (like
+	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
+	  take care of the needed conversions, say N.
+
 endif #ARM_SCMI_PROTOCOL
 
 config ARM_SCMI_POWER_DOMAIN
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index c8cab5652daf..bcfc4474535b 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -459,12 +459,13 @@ static void scmi_vio_remove(struct virtio_device *vdev)
 
 static int scmi_vio_validate(struct virtio_device *vdev)
 {
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
 		dev_err(&vdev->dev,
 			"device does not comply with spec version 1.x\n");
 		return -EINVAL;
 	}
-
+#endif
 	return 0;
 }
 
-- 
2.17.1

