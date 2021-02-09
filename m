Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77127314F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBIMnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:43:07 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:47566 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhBIMlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:41:17 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id E2D82A15FB;
        Tue,  9 Feb 2021 13:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=JMWVu00sJKNa
        UzNO4ZqMeD8FYjdkJxYXTlplUlw+228=; b=mPwXUFMeBCUQKFHXb+RJBbh6VEJt
        gcrdgn9BziPBCzbdN5q6V/KdFCo14KP8tcypFc9XIfQuFWMs+n7i7pe17dNkccj4
        0wAICl4s8Yr6jl6OItvdFJ2yEEOBKPsIN3v+F8Rag5QKOC/ircJ7RGEfPE45rwLd
        Cnv8ZiwsTKJ19lns4T0FIUy4nNTqLbsmpPdWGaSVfONw9xNomhZ7T3Sa3MM3ANX6
        iWe8aZv3at4riOeALU00M13W270YPyO9fu3t+wIVyW4yq3jLmGCUQsxd8ALhjVxc
        PbFZP1vm+xy5QDwHauHTlUA1xDJEn9ncM5gXjkqoSTbrHzwTXVaAIeqvhA==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/9] uapi: virtio_ids: add a sound device type ID from OASIS spec
Date:   Tue, 9 Feb 2021 13:40:02 +0100
Message-ID: <20210209124011.1224628-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209124011.1224628-1-anton.yakovlev@opensynergy.com>
References: <20210209124011.1224628-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
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


