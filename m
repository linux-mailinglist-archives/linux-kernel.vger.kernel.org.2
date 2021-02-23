Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193C73234B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhBXAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233666AbhBWX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614124627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BRP8WOD3C7GnixOAaJcuGj6DLx+wECwJIj7jVM8RU0=;
        b=GXwPKih+WvdYP06FTajRZjl6v6rV0sfhnnbUlLRqUJ0UzM4c6Hhw67WlH4zsaru7sjCezV
        KrOnjg2Sv+fXh2/kkKJPVhPm19zhlH+JHVIp1BsSr1VCd6q1NKOXbkYe/rzdDB82XHWCBX
        eW/Nlxslv+00JXgddMRmx8qkBSduHv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-LDBGhwqoPLyuZszq9G7YoA-1; Tue, 23 Feb 2021 18:57:06 -0500
X-MC-Unique: LDBGhwqoPLyuZszq9G7YoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD0B91005501;
        Tue, 23 Feb 2021 23:57:03 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11D5B19C46;
        Tue, 23 Feb 2021 23:57:00 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/nouveau/kms/nvd9-nv138: Fix CRC calculation for the cursor channel
Date:   Tue, 23 Feb 2021 18:56:47 -0500
Message-Id: <20210223235653.66120-1-lyude@redhat.com>
In-Reply-To: <20210119014849.2509965-5-lyude@redhat.com>
References: <20210119014849.2509965-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something that didn't get noticed until I started running cursor tests:
we're accidentally disabling an option for CRC calculation that's enabled
by default: WidePipeCrc, which controls whether we use the full width of
the data in the display pipe in order calculate CRCs. Having this disabled
apparently causes frames with the cursor plane enabled to generate
different CRCs than frames without the cursor plane enabled, even if the
frames are pixel-equivalent.

So, let's make sure to enable this and fix a bunch of cursor related tests
in IGT.

v2:
* Nvidia added the specific bit we were using to fix this issues to
  open-gpu-docs, so pull in the actual macro definitions for it

Cc: Martin Peres <martin.peres@free.fr>
Cc: Jeremy Cline <jcline@redhat.com>
Cc: Simon Ser <contact@emersion.fr>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/crc907d.c          | 3 ++-
 drivers/gpu/drm/nouveau/include/nvhw/class/cl907d.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc907d.c b/drivers/gpu/drm/nouveau/dispnv50/crc907d.c
index 0a89ae9523d4..f9ad641555b7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc907d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc907d.c
@@ -32,7 +32,8 @@ crc907d_set_src(struct nv50_head *head, int or, enum nv50_crc_source_type source
 		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, EXPECT_BUFFER_COLLAPSE, FALSE) |
 		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, TIMESTAMP_MODE, FALSE) |
 		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, SECONDARY_OUTPUT, NONE) |
-		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, CRC_DURING_SNOOZE, DISABLE);
+		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, CRC_DURING_SNOOZE, DISABLE) |
+		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, WIDE_PIPE_CRC, ENABLE);
 	int ret;
 
 	switch (source) {
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/cl907d.h b/drivers/gpu/drm/nouveau/include/nvhw/class/cl907d.h
index 79aff6ff3138..f972ef1409f4 100644
--- a/drivers/gpu/drm/nouveau/include/nvhw/class/cl907d.h
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/cl907d.h
@@ -246,6 +246,9 @@
 #define NV907D_HEAD_SET_CRC_CONTROL_CRC_DURING_SNOOZE                           5:5
 #define NV907D_HEAD_SET_CRC_CONTROL_CRC_DURING_SNOOZE_DISABLE                   (0x00000000)
 #define NV907D_HEAD_SET_CRC_CONTROL_CRC_DURING_SNOOZE_ENABLE                    (0x00000001)
+#define NV907D_HEAD_SET_CRC_CONTROL_WIDE_PIPE_CRC                               6:6
+#define NV907D_HEAD_SET_CRC_CONTROL_WIDE_PIPE_CRC_DISABLE                       (0x00000000)
+#define NV907D_HEAD_SET_CRC_CONTROL_WIDE_PIPE_CRC_ENABLE                        (0x00000001)
 #define NV907D_HEAD_SET_CONTEXT_DMA_CRC(a)                                      (0x00000438 + (a)*0x00000300)
 #define NV907D_HEAD_SET_CONTEXT_DMA_CRC_HANDLE                                  31:0
 #define NV907D_HEAD_SET_OUTPUT_LUT_LO(a)                                        (0x00000448 + (a)*0x00000300)
-- 
2.29.2

