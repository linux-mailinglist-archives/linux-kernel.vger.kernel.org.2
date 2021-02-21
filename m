Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E74320AC0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBUN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:58:37 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:11090 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhBUN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:58:36 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id BD445A1116;
        Sun, 21 Feb 2021 14:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=JMWVu00sJKNa
        UzNO4ZqMeD8FYjdkJxYXTlplUlw+228=; b=uG9+E9I/d1bg/MLj7SPOUDoYPycj
        c/k9k8uOCRZt3M6oYlEzSXXED6u40Lb+c7OcsxEVY5NGLX6kYfJyKc1IRPN0RZKr
        wmV61OG2joo6ND3USkRSZY6bKPdF3vKKRaeNs9N93ExrxbbZ63tpHxmBVBzIAWSq
        xCf9/wV+gbxQXcf9t+OnOCL4jk7d/xAgrfu8HTlaPTKE36gr5TnODHfnnTTObuJO
        uCH1As/anVSuGxtapgRvh2NkxvJnuzLHAy0TWyf9LEcBp3jS8TKvlKtDquhK9/FD
        nLqVS9a+y5XAH8hU9+PMNGJZZgSO41d/TeKkS0xOB9poC/A/Vm6thatwYA==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/9] uapi: virtio_ids: add a sound device type ID from OASIS spec
Date:   Sun, 21 Feb 2021 14:57:23 +0100
Message-ID: <20210221135731.51348-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221135731.51348-1-anton.yakovlev@opensynergy.com>
References: <20210221135731.51348-1-anton.yakovlev@opensynergy.com>
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


