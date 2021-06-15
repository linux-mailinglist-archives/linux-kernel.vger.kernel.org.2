Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538233A8AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFOVSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:18:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:41951 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhFOVSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:18:51 -0400
IronPort-SDR: FGJva7Uqvv8eO6nVAJWlOdLiseNrFIrszJJzSyVB9hy+wARlOxrJCNUrFwyfpMKjcW/9hGGpXr
 sXuJ+KRB90Mw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185762565"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="185762565"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 14:16:47 -0700
IronPort-SDR: /Hv7l2MMtBuoEjc0OeaXnwTZcAdwKzDz+IUqTnkFwPdnFfH0FFb8ig/VwFu3nXxWt1tyF5Kl0p
 8TWLm9Q5gOyg==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="637240768"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 14:16:45 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: revamp mei extension header structure layout.
Date:   Wed, 16 Jun 2021 00:15:57 +0300
Message-Id: <20210615211557.248292-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615211557.248292-1-tomas.winkler@intel.com>
References: <20210615211557.248292-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mei extension header was build as array of flexible structures
which will not work if actually more headers are added
Use basic type u8 for the variable sized extension.
Define explicitly mei_ext_hdr_vtag structure.
Fix also mei_ext_next() function to point correctly to the
end of the header.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c    | 16 +++++++++-------
 drivers/misc/mei/hw.h        | 28 ++++++++++++++++++++--------
 drivers/misc/mei/interrupt.c | 23 ++++++++++-------------
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 18e49479d8b0..96f4e59c32a5 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1726,12 +1726,15 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 	return rets;
 }
 
-static inline u8 mei_ext_hdr_set_vtag(struct mei_ext_hdr *ext, u8 vtag)
+static inline u8 mei_ext_hdr_set_vtag(void *ext, u8 vtag)
 {
-	ext->type = MEI_EXT_HDR_VTAG;
-	ext->ext_payload[0] = vtag;
-	ext->length = mei_data2slots(sizeof(*ext));
-	return ext->length;
+	struct mei_ext_hdr_vtag *vtag_hdr = ext;
+
+	vtag_hdr->hdr.type = MEI_EXT_HDR_VTAG;
+	vtag_hdr->hdr.length = mei_data2slots(sizeof(*vtag_hdr));
+	vtag_hdr->vtag = vtag;
+	vtag_hdr->reserved = 0;
+	return vtag_hdr->hdr.length;
 }
 
 /**
@@ -1745,7 +1748,6 @@ static struct mei_msg_hdr *mei_msg_hdr_init(const struct mei_cl_cb *cb)
 {
 	size_t hdr_len;
 	struct mei_ext_meta_hdr *meta;
-	struct mei_ext_hdr *ext;
 	struct mei_msg_hdr *mei_hdr;
 	bool is_ext, is_vtag;
 
@@ -1764,7 +1766,7 @@ static struct mei_msg_hdr *mei_msg_hdr_init(const struct mei_cl_cb *cb)
 
 	hdr_len += sizeof(*meta);
 	if (is_vtag)
-		hdr_len += sizeof(*ext);
+		hdr_len += sizeof(struct mei_ext_hdr_vtag);
 
 setup_hdr:
 	mei_hdr = kzalloc(hdr_len, GFP_KERNEL);
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b10606550613..dfd60c916da0 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -235,9 +235,8 @@ enum mei_ext_hdr_type {
 struct mei_ext_hdr {
 	u8 type;
 	u8 length;
-	u8 ext_payload[2];
-	u8 hdr[];
-};
+	u8 data[];
+} __packed;
 
 /**
  * struct mei_ext_meta_hdr - extend header meta data
@@ -250,8 +249,21 @@ struct mei_ext_meta_hdr {
 	u8 count;
 	u8 size;
 	u8 reserved[2];
-	struct mei_ext_hdr hdrs[];
-};
+	u8 hdrs[];
+} __packed;
+
+/**
+ * struct mei_ext_hdr_vtag - extend header for vtag
+ *
+ * @hdr: standard extend header
+ * @vtag: virtual tag
+ * @reserved: reserved
+ */
+struct mei_ext_hdr_vtag {
+	struct mei_ext_hdr hdr;
+	u8 vtag;
+	u8 reserved;
+} __packed;
 
 /*
  * Extended header iterator functions
@@ -266,7 +278,7 @@ struct mei_ext_meta_hdr {
  */
 static inline struct mei_ext_hdr *mei_ext_begin(struct mei_ext_meta_hdr *meta)
 {
-	return meta->hdrs;
+	return (struct mei_ext_hdr *)meta->hdrs;
 }
 
 /**
@@ -284,7 +296,7 @@ static inline bool mei_ext_last(struct mei_ext_meta_hdr *meta,
 }
 
 /**
- *mei_ext_next - following extended header on the TLV list
+ * mei_ext_next - following extended header on the TLV list
  *
  * @ext: current extend header
  *
@@ -295,7 +307,7 @@ static inline bool mei_ext_last(struct mei_ext_meta_hdr *meta,
  */
 static inline struct mei_ext_hdr *mei_ext_next(struct mei_ext_hdr *ext)
 {
-	return (struct mei_ext_hdr *)(ext->hdr + (ext->length * 4));
+	return (struct mei_ext_hdr *)((u8 *)ext + (ext->length * 4));
 }
 
 /**
diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index aab3ebfa9fc4..a67f4f2d33a9 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -123,13 +123,13 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 
 	if (mei_hdr->extended) {
 		struct mei_ext_hdr *ext;
-		struct mei_ext_hdr *vtag = NULL;
+		struct mei_ext_hdr_vtag *vtag_hdr = NULL;
 
 		ext = mei_ext_begin(meta);
 		do {
 			switch (ext->type) {
 			case MEI_EXT_HDR_VTAG:
-				vtag = ext;
+				vtag_hdr = (struct mei_ext_hdr_vtag *)ext;
 				break;
 			case MEI_EXT_HDR_NONE:
 				fallthrough;
@@ -141,20 +141,20 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 			ext = mei_ext_next(ext);
 		} while (!mei_ext_last(meta, ext));
 
-		if (!vtag) {
+		if (!vtag_hdr) {
 			cl_dbg(dev, cl, "vtag not found in extended header.\n");
 			cb->status = -EPROTO;
 			goto discard;
 		}
 
-		cl_dbg(dev, cl, "vtag: %d\n", vtag->ext_payload[0]);
-		if (cb->vtag && cb->vtag != vtag->ext_payload[0]) {
+		cl_dbg(dev, cl, "vtag: %d\n", vtag_hdr->vtag);
+		if (cb->vtag && cb->vtag != vtag_hdr->vtag) {
 			cl_err(dev, cl, "mismatched tag: %d != %d\n",
-			       cb->vtag, vtag->ext_payload[0]);
+			       cb->vtag, vtag_hdr->vtag);
 			cb->status = -EPROTO;
 			goto discard;
 		}
-		cb->vtag = vtag->ext_payload[0];
+		cb->vtag = vtag_hdr->vtag;
 	}
 
 	if (!mei_cl_is_connected(cl)) {
@@ -331,7 +331,6 @@ int mei_irq_read_handler(struct mei_device *dev,
 	struct mei_ext_meta_hdr *meta_hdr = NULL;
 	struct mei_cl *cl;
 	int ret;
-	u32 ext_meta_hdr_u32;
 	u32 hdr_size_left;
 	u32 hdr_size_ext;
 	int i;
@@ -367,14 +366,12 @@ int mei_irq_read_handler(struct mei_device *dev,
 
 	if (mei_hdr->extended) {
 		if (!dev->rd_msg_hdr[1]) {
-			ext_meta_hdr_u32 = mei_read_hdr(dev);
-			dev->rd_msg_hdr[1] = ext_meta_hdr_u32;
+			dev->rd_msg_hdr[1] = mei_read_hdr(dev);
 			dev->rd_msg_hdr_count++;
 			(*slots)--;
-			dev_dbg(dev->dev, "extended header is %08x\n",
-				ext_meta_hdr_u32);
+			dev_dbg(dev->dev, "extended header is %08x\n", dev->rd_msg_hdr[1]);
 		}
-		meta_hdr = ((struct mei_ext_meta_hdr *)dev->rd_msg_hdr + 1);
+		meta_hdr = ((struct mei_ext_meta_hdr *)&dev->rd_msg_hdr[1]);
 		if (check_add_overflow((u32)sizeof(*meta_hdr),
 				       mei_slots2data(meta_hdr->size),
 				       &hdr_size_ext)) {
-- 
2.31.1

