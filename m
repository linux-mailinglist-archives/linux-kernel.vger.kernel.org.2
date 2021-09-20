Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C32411281
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhITKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234235AbhITKEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:04:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D5EE60F21;
        Mon, 20 Sep 2021 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632132185;
        bh=9+DI7f38UVFXr+/Nh52c4dX/l/6rhwYCtppf9KioJ3k=;
        h=From:To:Cc:Subject:Date:From;
        b=M7e4wSfb0aQ3wRh5TZOnxxadO7wYdZcl9B/Vt0S8I1ZK+f9nbIYLMry6anWxnCYwq
         stA/LsrjKAIGIorakuN6xvTlFZW61OSYkkaRzuGN55gZDpixU17dhnAdADoG2GNsgv
         SLUvb0WeSfCiwbcXfTC/1TpkPOlN8D6u+vX9be4s7JFB3J7SFAqDdnnmW7cRYqAN8y
         xbJhFIpN49JgaAskc7b3GAREHFy9ooR8lpBmJ/7+vF05J1d5UAxP4xcFznLbPXg/sZ
         Qpbv6GwCKNA3rh4hiUjHnQI4kYz4LXiXQeaXbzVDg6LIGya3ABCEwsjoxH6x8PudDh
         N9eZ05jE8LlUA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: arm_scmi: fix VIRTIO dependency
Date:   Mon, 20 Sep 2021 12:02:51 +0200
Message-Id: <20210920100301.1466486-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with CONFIG_VIRTIO=m but CONFIG_ARM_SCMI_PROTOCOL=y leads to
a link error for the scmi virtio transport:

arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `virtio_send_message':
virtio.c:(.text+0x200): undefined reference to `virtqueue_add_sgs'
arm-linux-gnueabi-ld: virtio.c:(.text+0x280): undefined reference to `virtqueue_kick'
arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `scmi_vio_feed_vq_rx':
virtio.c:(.text+0x390): undefined reference to `virtqueue_add_inbuf'
arm-linux-gnueabi-ld: virtio.c:(.text+0x3dc): undefined reference to `virtqueue_kick'
arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `virtio_scmi_exit':
virtio.c:(.text+0x538): undefined reference to `unregister_virtio_driver'
arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/virtio.o: in function `virtio_chan_available':

Prevent this configuration by making the Kconfig dependency a bit
stricter.

Fixes: 46abe13b5e3d ("firmware: arm_scmi: Add virtio transport")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_scmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 7f4d2435503b..3d7081e84853 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -68,7 +68,7 @@ config ARM_SCMI_TRANSPORT_SMC
 
 config ARM_SCMI_TRANSPORT_VIRTIO
 	bool "SCMI transport based on VirtIO"
-	depends on VIRTIO
+	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
 	select ARM_SCMI_HAVE_TRANSPORT
 	select ARM_SCMI_HAVE_MSG
 	help
-- 
2.29.2

