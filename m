Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56407311DE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhBFOou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:44:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:38620 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhBFOoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:44:22 -0500
IronPort-SDR: kBfKaW46x5+N9Wy4GkLW2wpKu0uCCKCA61+KHHe3eY/TJv/aSUZrtDJYG71DnS+etHPRP9mS6J
 NLaUFWVmTUOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200566037"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="200566037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:42 -0800
IronPort-SDR: ErNLbfj5dIp7pyz+k+n+6ErkTg5r/cJGmXtdSoSeh1qd7cBWK8UG3nPOs8NbDjuQfhYZ3SCa0u
 rMBGh5m/OgYg==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="394360218"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:40 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/6] mei: add support for client dma capability
Date:   Sat,  6 Feb 2021 16:43:22 +0200
Message-Id: <20210206144325.25682-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206144325.25682-1-tomas.winkler@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Client DMA capability indicates whether the firmware supports setting up
a direct DMA channel between the host and me client.
The DMA capabilities are supported from firmware HBM version 2.2
and newer.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/debugfs.c |  1 +
 drivers/misc/mei/hbm.c     | 13 ++++++++++++-
 drivers/misc/mei/hw.h      |  8 ++++++++
 drivers/misc/mei/mei_dev.h |  2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 3ab1a431d810..1ce61e9e24fc 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -106,6 +106,7 @@ static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
 		seq_printf(m, "\tDR: %01d\n", dev->hbm_f_dr_supported);
 		seq_printf(m, "\tVT: %01d\n", dev->hbm_f_vt_supported);
 		seq_printf(m, "\tCAP: %01d\n", dev->hbm_f_cap_supported);
+		seq_printf(m, "\tCD: %01d\n", dev->hbm_f_cd_supported);
 	}
 
 	seq_printf(m, "pg:  %s, %s\n",
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index df0f62de3dca..6e748da7e55d 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -339,7 +339,9 @@ static int mei_hbm_capabilities_req(struct mei_device *dev)
 	memset(&req, 0, sizeof(req));
 	req.hbm_cmd = MEI_HBM_CAPABILITIES_REQ_CMD;
 	if (dev->hbm_f_vt_supported)
-		req.capability_requested[0] = HBM_CAP_VT;
+		req.capability_requested[0] |= HBM_CAP_VT;
+	if (dev->hbm_f_cd_supported)
+		req.capability_requested[0] |= HBM_CAP_CD;
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
@@ -1085,6 +1087,13 @@ static void mei_hbm_config_features(struct mei_device *dev)
 	    (dev->version.major_version == HBM_MAJOR_VERSION_CAP &&
 	     dev->version.minor_version >= HBM_MINOR_VERSION_CAP))
 		dev->hbm_f_cap_supported = 1;
+
+	/* Client DMA Support */
+	dev->hbm_f_cd_supported = 0;
+	if (dev->version.major_version > HBM_MAJOR_VERSION_CD ||
+	    (dev->version.major_version == HBM_MAJOR_VERSION_CD &&
+	     dev->version.minor_version >= HBM_MINOR_VERSION_CD))
+		dev->hbm_f_cd_supported = 1;
 }
 
 /**
@@ -1233,6 +1242,8 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		capability_res = (struct hbm_capability_response *)mei_msg;
 		if (!(capability_res->capability_granted[0] & HBM_CAP_VT))
 			dev->hbm_f_vt_supported = 0;
+		if (!(capability_res->capability_granted[0] & HBM_CAP_CD))
+			dev->hbm_f_cd_supported = 0;
 
 		if (dev->hbm_f_dr_supported) {
 			if (mei_dmam_ring_alloc(dev))
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index df2fb9520dd8..9577a2cc0733 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -88,6 +88,12 @@
 #define HBM_MINOR_VERSION_CAP              2
 #define HBM_MAJOR_VERSION_CAP              2
 
+/*
+ * MEI version with client DMA support
+ */
+#define HBM_MINOR_VERSION_CD               2
+#define HBM_MAJOR_VERSION_CD               2
+
 /* Host bus message command opcode */
 #define MEI_HBM_CMD_OP_MSK                  0x7f
 /* Host bus message command RESPONSE */
@@ -648,6 +654,8 @@ struct hbm_dma_ring_ctrl {
 
 /* virtual tag supported */
 #define HBM_CAP_VT BIT(0)
+/* client dma supported */
+#define HBM_CAP_CD BIT(2)
 
 /**
  * struct hbm_capability_request - capability request from host to fw
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 585a6f615bf8..8ebd32cb2075 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -451,6 +451,7 @@ struct mei_fw_version {
  * @hbm_f_dr_supported  : hbm feature dma ring supported
  * @hbm_f_vt_supported  : hbm feature vtag supported
  * @hbm_f_cap_supported : hbm feature capabilities message supported
+ * @hbm_f_cd_supported  : hbm feature client dma supported
  *
  * @fw_ver : FW versions
  *
@@ -538,6 +539,7 @@ struct mei_device {
 	unsigned int hbm_f_dr_supported:1;
 	unsigned int hbm_f_vt_supported:1;
 	unsigned int hbm_f_cap_supported:1;
+	unsigned int hbm_f_cd_supported:1;
 
 	struct mei_fw_version fw_ver[MEI_MAX_FW_VER_BLOCKS];
 
-- 
2.26.2

