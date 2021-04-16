Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20F3628DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbhDPTrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbhDPTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:47:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:47:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z19-20020a63e1130000b02901fcdcf0c5a3so3436412pgh.19
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n0xqOD+HIIPHd9L+1JhJaqzL6wTQupXv0yWby8BFCbU=;
        b=SG7MYoDgHPv3+eVbtsaDOEy621mUf9HRWHs8Os8SeRAsq2Qid3gqvZUBqsGlB5RZ0A
         imH0O+vUCTpJWmVYX4JaqjbfYhEIKSO+NHflN+ph90KGMGSDQJAncCUITXAlEX0NSy2i
         3ZCL/OkZdfVKsxg/wf7O3dK55m0sxkp2pOHGpf+DptLpCMO9aQcXBIup0hlM7EOjxAj0
         wDPJpn0cqLIaG8aiy863p9aOrmOgONBRj1oJsjlPd16iNlfOxb3ubNIX8I7wTiO9TNyN
         2/zpU1UxpeLim2/WmNuAcYanmVq5vQY3/SmAifFcA2TPanTgcK8opaa8DSSQPdg+ixB8
         I/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n0xqOD+HIIPHd9L+1JhJaqzL6wTQupXv0yWby8BFCbU=;
        b=hZYKvgGtY1BxFc0KJcsMsLolv6iSz19frGPOCjNloF2FAqxkTFFZTDpFxvKzkXFCJF
         t0VofyjQcd3t4/naEbcBbZiU78DpYRor1Tca9wdyxAWIObX4VXx5OXDokS3C2/fD4iEi
         CUjPtABXhPXa1zWUvltVyzCMbwlT9E5p59//SINybpsSLFxONAwilH83lE21eT5ZTEzp
         uhiiLIBRAbA9jobQfmYL8MEFNZJCyWX73CCDrPTDRLiUJrO3kQV49opsdYxVcxnBpAQu
         3BvIr2SPdPsvYLfpq0gdP6JBiTrd5w5gD6ia26U3k7qI4bAAPQlaqe0yO6CyISxX3rzd
         C20A==
X-Gm-Message-State: AOAM533vFahIZVW70iLC7udL3/kkEgY4TeWo5zriKbKMt90NvQbNjVs+
        s0DBTfeQ3niJRSPDuGw8H4/+akeNsZsgcw==
X-Google-Smtp-Source: ABdhPJy/e1nlYyzeC3Wn/3T0KUvwDS0wZR0x8qD4cVs39WV5FqVwizloQoLixHs2q+GScjjASmKOMlLM7L1jtQ==
X-Received: from egcloud.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:35b5])
 (user=egranata job=sendgmr) by 2002:a17:902:d104:b029:eb:6d3:1436 with SMTP
 id w4-20020a170902d104b02900eb06d31436mr11466076plw.1.1618602433880; Fri, 16
 Apr 2021 12:47:13 -0700 (PDT)
Date:   Fri, 16 Apr 2021 19:47:09 +0000
Message-Id: <20210416194709.155497-1-egranata@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2] virtio_blk: Add support for lifetime feature
From:   Enrico Granata <egranata@google.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     egranata@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VirtIO TC has adopted a new feature in virtio-blk enabling
discovery of lifetime information.

This commit adds support for the VIRTIO_BLK_T_LIFETIME command
to the virtio_blk driver, and adds two new attributes to the
sysfs entry for virtio_blk:
* pre_eol_info
* life_time

which are defined in the same manner as the files of the same name
for the eMMC driver, in line with the VirtIO specification.

Signed-off-by: Enrico Granata <egranata@google.com>
---
Changes in v2:
  - Removed redudnant buffer size checks
  - Renamed variables for consistency
  - Cleaned up endianness

 drivers/block/virtio_blk.c      | 75 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_blk.h | 11 +++++
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..31969f680a9f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -246,14 +246,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
 		break;
 	case REQ_OP_DRV_IN:
-		type = VIRTIO_BLK_T_GET_ID;
-		break;
+		break; /* type already set for custom requests */
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
 	}
 
-	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, type);
+	if (req_op(req) != REQ_OP_DRV_IN)
+		vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, type);
+
 	vbr->out_hdr.sector = type ?
 		0 : cpu_to_virtio64(vblk->vdev, blk_rq_pos(req));
 	vbr->out_hdr.ioprio = cpu_to_virtio32(vblk->vdev, req_get_ioprio(req));
@@ -310,11 +311,14 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	struct virtio_blk *vblk = disk->private_data;
 	struct request_queue *q = vblk->disk->queue;
 	struct request *req;
+	struct virtblk_req *vbr;
 	int err;
 
 	req = blk_get_request(q, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
 
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
@@ -327,6 +331,34 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	return err;
 }
 
+static int virtblk_get_lifetime(struct gendisk *disk, struct virtio_blk_lifetime *lifetime)
+{
+	struct virtio_blk *vblk = disk->private_data;
+	struct request_queue *q = vblk->disk->queue;
+	struct request *req;
+	struct virtblk_req *vbr;
+	int err;
+
+	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
+		return -EOPNOTSUPP;
+
+	req = blk_get_request(q, REQ_OP_DRV_IN, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	vbr = blk_mq_rq_to_pdu(req);
+	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
+
+	err = blk_rq_map_kern(q, req, lifetime, sizeof(*lifetime), GFP_KERNEL);
+	if (err)
+		goto out;
+
+	blk_execute_rq(vblk->disk, req, false);
+	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
+out:
+	blk_put_request(req);
+	return err;
+}
+
 static void virtblk_get(struct virtio_blk *vblk)
 {
 	refcount_inc(&vblk->refs);
@@ -435,6 +467,40 @@ static ssize_t serial_show(struct device *dev,
 
 static DEVICE_ATTR_RO(serial);
 
+static ssize_t pre_eol_info_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x\n", le16_to_cpu(lft.pre_eol_info));
+}
+
+static DEVICE_ATTR_RO(pre_eol_info);
+
+static ssize_t life_time_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct virtio_blk_lifetime lft;
+	int err;
+
+	err = virtblk_get_lifetime(disk, &lft);
+	if (err)
+		return 0;
+
+	return sprintf(buf, "0x%02x 0x%02x\n",
+			le16_to_cpu(lft.device_life_time_est_typ_a),
+			le16_to_cpu(lft.device_life_time_est_typ_b));
+}
+
+static DEVICE_ATTR_RO(life_time);
+
 /* The queue's logical block size must be set before calling this */
 static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 {
@@ -638,6 +704,8 @@ static DEVICE_ATTR_RW(cache_type);
 
 static struct attribute *virtblk_attrs[] = {
 	&dev_attr_serial.attr,
+	&dev_attr_pre_eol_info.attr,
+	&dev_attr_life_time.attr,
 	&dev_attr_cache_type.attr,
 	NULL,
 };
@@ -984,6 +1052,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_LIFETIME,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..bbd3978b9d08 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_LIFETIME	15 /* LIFETIME is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -149,6 +150,9 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Get device lifetime command */
+#define VIRTIO_BLK_T_GET_LIFETIME 10
+
 /* Discard command */
 #define VIRTIO_BLK_T_DISCARD	11
 
@@ -196,6 +200,13 @@ struct virtio_scsi_inhdr {
 };
 #endif /* !VIRTIO_BLK_NO_LEGACY */
 
+/* Lifetime information for virtio_blk device */
+struct virtio_blk_lifetime {
+	__le16 pre_eol_info;
+	__le16 device_life_time_est_typ_a;
+	__le16 device_life_time_est_typ_b;
+};
+
 /* And this is the final byte of the write scatter-gather list. */
 #define VIRTIO_BLK_S_OK		0
 #define VIRTIO_BLK_S_IOERR	1
-- 
2.31.1.368.gbe11c130af-goog

