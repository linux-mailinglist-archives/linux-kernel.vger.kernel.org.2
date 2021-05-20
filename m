Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD238B035
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhETNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhETNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:42:30 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1110C061574;
        Thu, 20 May 2021 06:41:08 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 574722E15E6;
        Thu, 20 May 2021 16:39:38 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id AfBgisBlzm-db1ewMOF;
        Thu, 20 May 2021 16:39:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1621517978; bh=MgIFZUM23snZbrtJKwnzK4vDNOyka8LaHXdQ4sh/ipw=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=e5rywHlnHxuj6xMcssjmvUOHDilA/Z+0BhL0UO/hTXt21/raFmE4Gwvsd0I9LaHn3
         H4q6jgKpBzVPkYTmQN/QAM1VgxD7mdjp4wupio+6FzBgE11Ibz6YHbwYOlqbmJrYuw
         ecXj9IjGzJg8MOFmr18/HMZVofyyOwL2u40DTMko=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 172.31.109.104-vpn.dhcp.yndx.net (172.31.109.104-vpn.dhcp.yndx.net [172.31.109.104])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kx0LBZ7Ldj-dboCjjet;
        Thu, 20 May 2021 16:39:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Yury Kamenev <damtev@yandex-team.ru>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Kamenev <damtev@yandex-team.ru>
Subject: [PATCH 1/1] virtio: disable partitions scanning for no partitions block
Date:   Thu, 20 May 2021 16:39:08 +0300
Message-Id: <20210520133908.98891-2-damtev@yandex-team.ru>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210520133908.98891-1-damtev@yandex-team.ru>
References: <20210520133908.98891-1-damtev@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yury Kamenev <damtev@yandex-team.ru>
---
 drivers/block/virtio_blk.c      | 6 ++++++
 include/uapi/linux/virtio_blk.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..17edcfee2208 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -799,6 +799,10 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->disk->flags |= GENHD_FL_EXT_DEVT;
 	vblk->index = index;
 
+	/*Disable partitions scanning for no-partitions block*/
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PS))
+		vblk->disk->flags |= GENHD_FL_NO_PART_SCAN;
+
 	/* configure queue flush support */
 	virtblk_update_cache_mode(vdev);
 
@@ -977,6 +981,7 @@ static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_NO_PS,
 }
 ;
 static unsigned int features[] = {
@@ -984,6 +989,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_NO_PS,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..f197d07afb05 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_NO_PS      16      /* No partitions */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
-- 
2.24.3 (Apple Git-128)

