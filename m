Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBE321B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBVPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:36:49 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:11060 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhBVPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:36:41 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 841D2A1290;
        Mon, 22 Feb 2021 16:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=JMWVu00sJKNa
        UzNO4ZqMeD8FYjdkJxYXTlplUlw+228=; b=xGRNfUFwOIuPzbXtA9OOG0RlZe1E
        YoOAhV6TFX3U5IvgmVgux/rpH6dPbOrZlornCJP+qHV4MHgSbrrBbXAVB/Uj2ReV
        +Amjlhjnk1+5LaRvbB+C7Q4E72pQGVlrD2POyncCK99e3NkIgV91D56fj5cH4anZ
        /8sO8xfRrrKDh0g0/sYfbmaI5qRpVfLDFToGA7tfP5ZwBvjAkFQZgj6L/UbNCz5o
        ovCwOem26fnT0svW7wKDxZXfvD4gAMXn6Q0AdJ+mUXvzPCLD1f8fquf5gSwOgxxM
        FAIGgOOsiEV+tTzTwYaPsLta4d7y++1yb4wE31BbF0x2A3iHqOoN2UQKpg==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/9] uapi: virtio_ids: add a sound device type ID from OASIS spec
Date:   Mon, 22 Feb 2021 16:34:36 +0100
Message-ID: <20210222153444.348390-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OASIS virtio spec defines a sound device type ID that is not
present in the header yet.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index bc1c0621f5ed..029a2e07a7f9 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -51,6 +51,7 @@
 #define VIRTIO_ID_PSTORE		22 /* virtio pstore device */
 #define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
 #define VIRTIO_ID_MEM			24 /* virtio mem */
+#define VIRTIO_ID_SOUND			25 /* virtio sound */
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
-- 
2.30.0


