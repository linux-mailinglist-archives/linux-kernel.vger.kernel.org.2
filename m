Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8141D279
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 06:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhI3Env (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:43:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:28538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348004AbhI3Enu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:43:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205246077"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="205246077"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 21:42:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="437899154"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 21:42:06 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>
Subject: [PATCH 1/1] virtio: Fix virtio transitional ids
Date:   Wed, 29 Sep 2021 21:41:31 -0700
Message-Id: <20210930044131.3742311-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d61914ea6ada ("virtio: update virtio id table, add
transitional ids") adds transitional virtio PCI IDs. But it uses the ID
range (1000-1009). But as per virtio spec [1], transitional PCI ID
range is (0x1000-0x1009).

So modify the IDs to use hex values (0x1000-0x1009).

[1] - https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html

Fixes: d61914ea6ada ("virtio: update virtio id table, add transitional ids")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/uapi/linux/virtio_ids.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 80d76b75bccd..7aa2eb766205 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -73,12 +73,12 @@
  * Virtio Transitional IDs
  */
 
-#define VIRTIO_TRANS_ID_NET		1000 /* transitional virtio net */
-#define VIRTIO_TRANS_ID_BLOCK		1001 /* transitional virtio block */
-#define VIRTIO_TRANS_ID_BALLOON		1002 /* transitional virtio balloon */
-#define VIRTIO_TRANS_ID_CONSOLE		1003 /* transitional virtio console */
-#define VIRTIO_TRANS_ID_SCSI		1004 /* transitional virtio SCSI */
-#define VIRTIO_TRANS_ID_RNG		1005 /* transitional virtio rng */
-#define VIRTIO_TRANS_ID_9P		1009 /* transitional virtio 9p console */
+#define VIRTIO_TRANS_ID_NET		0x1000 /* transitional virtio net */
+#define VIRTIO_TRANS_ID_BLOCK		0x1001 /* transitional virtio block */
+#define VIRTIO_TRANS_ID_BALLOON		0x1002 /* transitional virtio balloon */
+#define VIRTIO_TRANS_ID_CONSOLE		0x1003 /* transitional virtio console */
+#define VIRTIO_TRANS_ID_SCSI		0x1004 /* transitional virtio SCSI */
+#define VIRTIO_TRANS_ID_RNG		0x1005 /* transitional virtio rng */
+#define VIRTIO_TRANS_ID_9P		0x1009 /* transitional virtio 9p console */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.25.1

