Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24FF36E8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbhD2K3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240389AbhD2K3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619692134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ko3kaV/+Mf9FuO3wToe/HRm5XWo4kyxfc88vhtIYVqA=;
        b=GbtSdfJdBD5pMu1XMaQ8nBerS7GJeezJ+z4d5d/CLNEAv1NZu96pzaU6XYpeYBCXvSvVdl
        eJtzlU7rHIYUQeJqWam+tAi9O4FcwIMaHg+FI5fFe0XZ4hqKqiMIHIyYCbSnreUskJysq6
        8cdTyyReQn0+SN69ue6N2FQQlAMtBiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-ZTi-gXfSPN2PraJHSYgwQg-1; Thu, 29 Apr 2021 06:28:50 -0400
X-MC-Unique: ZTi-gXfSPN2PraJHSYgwQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1D3C1008073;
        Thu, 29 Apr 2021 10:28:49 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.196.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11A325DDAD;
        Thu, 29 Apr 2021 10:28:40 +0000 (UTC)
From:   Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, axboe@kernel.dk, idryomov@redhat.com,
        xiubli@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Subject: [PATCH] nbd: provide a way for userspace processes to identify device backends
Date:   Thu, 29 Apr 2021 15:58:28 +0530
Message-Id: <20210429102828.31248-1-prasanna.kalever@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
On reconfigure of device, there is no way to defend if the backend
storage is matching with the initial backend storage.

Say, if an initial connect request for backend "pool1/image1" got
mapped to /dev/nbd0 and the userspace process is terminated. A next
reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
use /dev/nbd0 for a different backend "pool1/image2"

For example, an operation like below could be dangerous:

$ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
/dev/nbd0
$ sudo blkid /dev/nbd0
/dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
$ sudo pkill -9 rbd-nbd
$ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
/dev/nbd0
$ sudo blkid /dev/nbd0
/dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"

Solution:
Provide a way for userspace processes to keep some metadata to identify
between the device and the backend, so that when a reconfigure request is
made, we can compare and avoid such dangerous operations.

With this solution, as part of the initial connect request, backend
path can be stored in the sysfs per device config, so that on a reconfigure
request it's easy to check if the backend path matches with the initial
connect backend path.

Please note, ioctl interface to nbd will not have these changes, as there
won't be any reconfigure.

Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
---
 drivers/block/nbd.c              | 60 +++++++++++++++++++++++++++++++-
 include/uapi/linux/nbd-netlink.h |  1 +
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4ff71b579cfc..b5022187ad9c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -79,6 +79,7 @@ struct link_dead_args {
 #define NBD_RT_HAS_CONFIG_REF		4
 #define NBD_RT_BOUND			5
 #define NBD_RT_DISCONNECT_ON_CLOSE	6
+#define NBD_RT_HAS_BACKEND_FILE		7
 
 #define NBD_DESTROY_ON_DISCONNECT	0
 #define NBD_DISCONNECT_REQUESTED	1
@@ -119,6 +120,8 @@ struct nbd_device {
 
 	struct completion *destroy_complete;
 	unsigned long flags;
+
+	char *backend;
 };
 
 #define NBD_CMD_REQUEUED	1
@@ -216,6 +219,20 @@ static const struct device_attribute pid_attr = {
 	.show = pid_show,
 };
 
+static ssize_t backend_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nbd_device *nbd = (struct nbd_device *)disk->private_data;
+
+	return sprintf(buf, "%s\n", nbd->backend ?: "");
+}
+
+static const struct device_attribute backend_attr = {
+	.attr = { .name = "backend", .mode = 0444},
+	.show = backend_show,
+};
+
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
@@ -1215,6 +1232,12 @@ static void nbd_config_put(struct nbd_device *nbd)
 				       &config->runtime_flags))
 			device_remove_file(disk_to_dev(nbd->disk), &pid_attr);
 		nbd->task_recv = NULL;
+		if (test_and_clear_bit(NBD_RT_HAS_BACKEND_FILE,
+				       &config->runtime_flags)) {
+			device_remove_file(disk_to_dev(nbd->disk), &backend_attr);
+			kfree(nbd->backend);
+			nbd->backend = NULL;
+		}
 		nbd_clear_sock(nbd);
 		if (config->num_connections) {
 			int i;
@@ -1274,7 +1297,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
-		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
+		dev_err(disk_to_dev(nbd->disk), "device_create_file failed for pid!\n");
 		return error;
 	}
 	set_bit(NBD_RT_HAS_PID_FILE, &config->runtime_flags);
@@ -1681,6 +1704,7 @@ static int nbd_dev_add(int index)
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
 	nbd->destroy_complete = NULL;
+	nbd->backend = NULL;
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
 	if (err)
@@ -1754,6 +1778,7 @@ static const struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_SOCKETS]		=	{ .type = NLA_NESTED},
 	[NBD_ATTR_DEAD_CONN_TIMEOUT]	=	{ .type = NLA_U64 },
 	[NBD_ATTR_DEVICE_LIST]		=	{ .type = NLA_NESTED},
+	[NBD_ATTR_BACKEND_IDENTIFIER]	=	{ .type = NLA_STRING},
 };
 
 static const struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
@@ -1956,6 +1981,23 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = nbd_start_device(nbd);
+	if (ret)
+		goto out;
+	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
+		nbd->backend = nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
+					  GFP_KERNEL);
+		if (!nbd->backend) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	ret = device_create_file(disk_to_dev(nbd->disk), &backend_attr);
+	if (ret) {
+		dev_err(disk_to_dev(nbd->disk),
+			"device_create_file failed for backend!\n");
+		goto out;
+	}
+	set_bit(NBD_RT_HAS_BACKEND_FILE, &config->runtime_flags);
 out:
 	mutex_unlock(&nbd->config_lock);
 	if (!ret) {
@@ -2048,6 +2090,22 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 		       index);
 		return -EINVAL;
 	}
+	if (nbd->backend) {
+		if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
+			if (nla_strcmp(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
+				       nbd->backend)) {
+				mutex_unlock(&nbd_index_mutex);
+				dev_err(nbd_to_dev(nbd),
+					"backend image doesn't match with %s\n",
+					nbd->backend);
+				return -EINVAL;
+			}
+		} else {
+			mutex_unlock(&nbd_index_mutex);
+			dev_err(nbd_to_dev(nbd), "must specify backend\n");
+			return -EINVAL;
+		}
+	}
 	if (!refcount_inc_not_zero(&nbd->refs)) {
 		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: device at index %d is going down\n",
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
index c5d0ef7aa7d5..2d0b90964227 100644
--- a/include/uapi/linux/nbd-netlink.h
+++ b/include/uapi/linux/nbd-netlink.h
@@ -35,6 +35,7 @@ enum {
 	NBD_ATTR_SOCKETS,
 	NBD_ATTR_DEAD_CONN_TIMEOUT,
 	NBD_ATTR_DEVICE_LIST,
+	NBD_ATTR_BACKEND_IDENTIFIER,
 	__NBD_ATTR_MAX,
 };
 #define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
-- 
2.30.2

