Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE05F43D780
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhJ0XbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0XbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:31:15 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0B1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:28:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w4-20020a1709029a8400b00138e222b06aso1783600plp.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uDDw3N5CBHxN32c5VspvkYKtdupefenssD38+djE0Js=;
        b=P4EX9mgT725zotWLAJ/xneDIPXR7OXLeYE3WwQOc1ez7NAdyFSe2zdkFoV2RUn1ekO
         x/AM6panIleqYWTm/gdai2XwFoI86mCR4WlEusAdMmva5OqUUR6XcErRMtXXevGQsFIs
         4Y4hog8D/58ddpF3SO0kNMp5ZqudZJQ2QKckK+BKEJlC0enHbIT5I7aVR5lsbogINcP/
         PAoc5OCUeDqPs+ebz23t+sSvSm80ClDVgMhV4+6ADCl8bkDyp8hz5LF6PfY06jLlVZ3b
         8j8NvTOHNkf7PLDMMsoNTNcVPrLwR5NmoPVleTYR1SSvmslc/G7lwrarOkzsCeyJW1RN
         Rcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uDDw3N5CBHxN32c5VspvkYKtdupefenssD38+djE0Js=;
        b=oKsC0sxHTPu6nDhatk1V8tEBo/1P08kKeLxvXAi9Y5MnR7I975qeKIJM3zKt6myWtV
         SgPQKzZRvN5PaOaKO4RW57UoLGAqRxJfTx56SUVrb7KjMtn6rUTsZhZ+v9cGgEwOvMKY
         nJXfdVjA+XFWIeSUXYK8S1BbVuVjjzp9vOj9MWkGytZjH9DWdiPLP2NhD0eXb0Qa3p3N
         KujFM/L/OQ3WGZhzIfzadiW1HvQHtYYHn9U7DG45FUoBMSNL6sNiMtcbvGkMHk2sW442
         M0CZTgJeDgKP9458ajvc08QK9YsisZXsOzNccMExpxiEMvz8BDb3gviGnGPEsdiIg7HU
         tLXA==
X-Gm-Message-State: AOAM532uo+pcDowTxuI/ij3tPurIjyOGHk3H3lC0ld/V2XJQUZCFmMcM
        0lQ+AK7U021iPsgM1chHZW5m67jwZijr1tVxYfxMMTywPOTb6ShEZb0CqjU/9H9tgwckm9sLgBb
        u4Ixz7xjzfDAw8sMSwORYEDDVq9+4P0j/i2Cknvp871irRzPFS0RMkA6x6B+OIuSDaeaXIzfxc4
        qCD7UT
X-Google-Smtp-Source: ABdhPJzJ5RBmiXPjmxwdl42/6rP2XbtDgS1nAYiRfySTAv6J2WD6YhiumB1hStV06KTkCIqs1A7c0p+w1I01z3fy
X-Received: from nehir.kir.corp.google.com ([2620:15c:29:204:9e0:c169:7f1:2eaa])
 (user=erdemaktas job=sendgmr) by 2002:a05:6a00:1897:b0:47c:3554:52eb with
 SMTP id x23-20020a056a00189700b0047c355452ebmr712483pfh.22.1635377329353;
 Wed, 27 Oct 2021 16:28:49 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:28:28 -0700
Message-Id: <20211027232828.2043569-1-erdemaktas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [RFC] Add DMA_API support for Virtio devices earlier than VirtIO 1.0
From:   Erdem Aktas <erdemaktas@google.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Erdem Aktas <erdemaktas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DMA_API for any VirtIO device earlier than Virtio 1.0 which
is the only way for those devices to be configured correctly when
memory access is retricted.

Virtio devices can use DMA_API to translate guest phsical addresses to
device physical addresses if VIRTIO_F_ACCESS_PLATFORM feature is set
while the device is being initialized. VIRTIO_F_ACCESS_PLATFORM
feature is only supported in VirtIO 1.0 and later devices. This prevents
any device using an earlier VirtIO version than Virtio 1.0 to be
attached when memory access is restricted ie memory encryption features
(AMD SEV [ES/SNP], Intel TDX, etc..) are enabled.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
---
I have tested the this patch using linux-stable.git head, 5.15.0-rc6
kernel and scsi disk with virtio 0.95 version with legacy VM and
Confidential VM (AMD SEV). I want to get feedback if
there is any risk or downside of enabling DMA_API on older virtio
drivers when memory encrytion is enabled.

 drivers/virtio/virtio.c       |  7 ++-----
 include/linux/virtio_config.h | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 236081afe9a2..71115ba85d07 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -179,11 +179,8 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret) {
 		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
 			dev_warn(&dev->dev,
-				 "device must provide VIRTIO_F_VERSION_1\n");
-			return -ENODEV;
-		}
-
-		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
+				 "device does not provide VIRTIO_F_VERSION_1 while restricted memory access is enabled!.\n");
+		} else if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
 			dev_warn(&dev->dev,
 				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
 			return -ENODEV;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8519b3ae5d52..6eacb4d43318 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -170,6 +170,15 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return __virtio_test_bit(vdev, fbit);
 }
 
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+int arch_has_restricted_virtio_memory_access(void);
+#else
+static inline int arch_has_restricted_virtio_memory_access(void)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
+
 /**
  * virtio_has_dma_quirk - determine whether this device has the DMA quirk
  * @vdev: the device
@@ -180,6 +189,11 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	 * Note the reverse polarity of the quirk feature (compared to most
 	 * other features), this is for compatibility with legacy systems.
 	 */
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
+	   arch_has_restricted_virtio_memory_access())
+		return false;
+
+
 	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
@@ -558,13 +572,5 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
-#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
-int arch_has_restricted_virtio_memory_access(void);
-#else
-static inline int arch_has_restricted_virtio_memory_access(void)
-{
-	return 0;
-}
-#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
 
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
2.30.2

