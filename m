Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B343C7BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhGNCcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:32:07 -0400
Received: from usmx01.baidu.com ([12.0.243.41]:36268 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237593AbhGNCcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:32:04 -0400
Received: from BC-Mail-HQEx02.internal.baidu.com (unknown [172.31.51.58])
        by Forcepoint Email with ESMTPS id 482C4258739D676063E3;
        Tue, 13 Jul 2021 19:29:07 -0700 (PDT)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEx02.internal.baidu.com (172.31.51.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.10; Wed, 14 Jul 2021 10:29:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 14 Jul 2021 10:29:04 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <sgarzare@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 1/2] virtio_ring: fix error - unknown type name 'spinlock_t'
Date:   Wed, 14 Jul 2021 10:28:53 +0800
Message-ID: <20210714022854.1077-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714022854.1077-1-caihuoqing@baidu.com>
References: <20210714022854.1077-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when run "make virtio" in linux/tools,
the error: unknown type name 'spinlock_t' occurs

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 include/linux/vringh.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 84db7b8f912f..ff21c2643792 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -43,11 +43,13 @@ struct vringh {
        /* The vring (note: it may contain user pointers!) */
        struct vring vring;

+#if IS_REACHABLE(CONFIG_VHOST_IOTLB)
        /* IOTLB for this vring */
        struct vhost_iotlb *iotlb;

        /* spinlock to synchronize IOTLB accesses */
        spinlock_t *iotlb_lock;
+#endif

        /* The function to call to notify the guest about added buffers */
        void (*notify)(struct vringh *);
--
2.25.1

