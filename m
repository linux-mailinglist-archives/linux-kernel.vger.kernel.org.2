Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EFB3D99DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhG2AET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:04:19 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:35667 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhG2AES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:04:18 -0400
X-QQ-mid: bizesmtp47t1627517045tc5sn4m5
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 29 Jul 2021 08:04:04 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: N/s2IhZC2kB/UP9K3qmqMqXKNEviE95eaKovK49Vfuc1Vvwz/R0XX6qcQiTtb
        XMq2lLxXmr/HK1mJCpxCixoxMZ8/n/HhhitsKHC7j89l0HD3rDe3Uc/Olq4MN3xlLbULkYe
        O97HKLq5Wp7JlBd+Ab+DKqv3oXorG8Mpggzc0Pmt7E6o1Y+0S5aqHN1tS1umUljQ4wXnYjt
        lbCp2y9XlgjuefN5DzyQAMFqy3SCra04r03YyrbXGBsh6wzVvDXm+serta7aMnBXhKlq4jl
        HKxBvMSiIO55xGgLfbFXInCAVdHsCcgoSmADXF9D4dS7B6az1gePwKeTZlAatnofi8tQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] tools/virtio: use 'unsigned int' instead of bare 'unsigned'
Date:   Thu, 29 Jul 2021 08:04:02 +0800
Message-Id: <20210729000402.45690-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the lazy way 'unsigned' with 'unsigned int' which is more
accurate.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 tools/virtio/vringh_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index fa87b58bd5fa..3e85f4ec210d 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -447,7 +447,7 @@ int main(int argc, char *argv[])
 	char buf[28];
 	u16 head;
 	int err;
-	unsigned i;
+	unsigned int i;
 	void *ret;
 	bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_range *r);
 	bool fast_vringh = false, parallel = false;
@@ -654,7 +654,7 @@ int main(int argc, char *argv[])
 
 	/* Free those buffers. */
 	for (i = 0; i < RINGSIZE; i++) {
-		unsigned len;
+		unsigned int len;
 		assert(virtqueue_get_buf(vq, &len) != NULL);
 	}
 
-- 
2.32.0

