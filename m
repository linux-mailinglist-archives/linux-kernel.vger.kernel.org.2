Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09833C7BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhGNCcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:32:00 -0400
Received: from usmx01.baidu.com ([12.0.243.41]:36206 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237422AbhGNCcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:32:00 -0400
Received: from BC-Mail-Ex16.internal.baidu.com (unknown [172.31.51.56])
        by Forcepoint Email with ESMTPS id D85945FA3FD35FEAB57B;
        Tue, 13 Jul 2021 19:29:04 -0700 (PDT)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex16.internal.baidu.com (172.31.51.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 14 Jul 2021 10:29:02 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 14 Jul 2021 10:29:02 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <sgarzare@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 0/2] virtio_ring: fix errors to make virtio tools
Date:   Wed, 14 Jul 2021 10:28:52 +0800
Message-ID: <20210714022854.1077-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the errors occurs when run "make virtio" in linux/tools

Cai Huoqing (2):
  virtio_ring: fix error - unknown type name 'spinlock_t'
  virtio_ring: fix error - 'prev' and 'head_flags' may be used
    uninitialized in this function

 drivers/virtio/virtio_ring.c | 6 +++---
 include/linux/vringh.h       | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

--
2.25.1

