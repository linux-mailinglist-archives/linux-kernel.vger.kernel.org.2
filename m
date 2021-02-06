Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A53311DE5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBFOo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:44:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:38614 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBFOof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:44:35 -0500
IronPort-SDR: a2qNEI5UXs4KfVIVKO5WH4im873sfSpEINnr1jp4CQJBAi5D8dWUEwQ3CVGdvPmPc1wlODPiEU
 0BsU+y+Kv/Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200566038"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="200566038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:43 -0800
IronPort-SDR: HGqnJti6aRK6R4Nn8qJg7qmkjRQmtiWxGRDKjfLy4uCQ1fk2/EpLmfHvLhYnCXzit/JDG5i+MU
 54uCHU348rqg==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="394360222"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:42 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/6] mei: hbm: add client dma hbm messages
Date:   Sat,  6 Feb 2021 16:43:23 +0200
Message-Id: <20210206144325.25682-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206144325.25682-1-tomas.winkler@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Define structures for client DMA HBM protocol.
The protocol requires passing dma buffer address
and the buffer id.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 9577a2cc0733..b10606550613 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -142,6 +142,12 @@
 #define MEI_HBM_CAPABILITIES_REQ_CMD        0x13
 #define MEI_HBM_CAPABILITIES_RES_CMD        0x93
 
+#define MEI_HBM_CLIENT_DMA_MAP_REQ_CMD      0x14
+#define MEI_HBM_CLIENT_DMA_MAP_RES_CMD      0x94
+
+#define MEI_HBM_CLIENT_DMA_UNMAP_REQ_CMD    0x15
+#define MEI_HBM_CLIENT_DMA_UNMAP_RES_CMD    0x95
+
 /*
  * MEI Stop Reason
  * used by hbm_host_stop_request.reason
@@ -679,4 +685,51 @@ struct hbm_capability_response {
 	u8 capability_granted[3];
 } __packed;
 
+/**
+ * struct hbm_client_dma_map_request - client dma map request from host to fw
+ *
+ * @hbm_cmd: bus message command header
+ * @client_buffer_id: client buffer id
+ * @reserved: reserved
+ * @address_lsb: DMA address LSB
+ * @address_msb: DMA address MSB
+ * @size: DMA size
+ */
+struct hbm_client_dma_map_request {
+	u8 hbm_cmd;
+	u8 client_buffer_id;
+	u8 reserved[2];
+	u32 address_lsb;
+	u32 address_msb;
+	u32 size;
+} __packed;
+
+/**
+ * struct hbm_client_dma_unmap_request
+ *    client dma unmap request from the host to the firmware
+ *
+ * @hbm_cmd: bus message command header
+ * @status: unmap status
+ * @client_buffer_id: client buffer id
+ * @reserved: reserved
+ */
+struct hbm_client_dma_unmap_request {
+	u8 hbm_cmd;
+	u8 status;
+	u8 client_buffer_id;
+	u8 reserved;
+} __packed;
+
+/**
+ * struct hbm_client_dma_response
+ *   client dma unmap response from the firmware to the host
+ *
+ * @hbm_cmd: bus message command header
+ * @status: command status
+ */
+struct hbm_client_dma_response {
+	u8 hbm_cmd;
+	u8 status;
+} __packed;
+
 #endif
-- 
2.26.2

