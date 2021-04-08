Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F5358396
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhDHMrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:47:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16049 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:47:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGLZ31d7zzNttM;
        Thu,  8 Apr 2021 20:44:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 20:47:19 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Chen Huang <chenhuang5@huawei.com>
Subject: [PATCH -next] ALSA: virtio: use module_virtio_driver() to simplify the code
Date:   Thu, 8 Apr 2021 12:54:29 +0000
Message-ID: <20210408125429.1158703-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_virtio_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 sound/virtio/virtio_card.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index ae9128063917..150ab3e37013 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -432,17 +432,7 @@ static struct virtio_driver virtsnd_driver = {
 #endif
 };
 
-static int __init init(void)
-{
-	return register_virtio_driver(&virtsnd_driver);
-}
-module_init(init);
-
-static void __exit fini(void)
-{
-	unregister_virtio_driver(&virtsnd_driver);
-}
-module_exit(fini);
+module_virtio_driver(virtsnd_driver);
 
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio sound card driver");
-- 
2.17.1

