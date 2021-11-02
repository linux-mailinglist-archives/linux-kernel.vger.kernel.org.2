Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C1442541
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKBBmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:42:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25335 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhKBBm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:42:29 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HjssS0jHYzbhVn;
        Tue,  2 Nov 2021 09:35:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 2
 Nov 2021 09:39:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v4 0/4] Fix hungtask when nbd_config_put and sanity check for first_minor
Date:   Tue, 2 Nov 2021 09:52:33 +0800
Message-ID: <20211102015237.2309763-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset include two patchsets as follows:
1. Fix hungtask when nbd_config_put
https://patchwork.kernel.org/project/linux-block/list/?series=573381
2. nbd: fix sanity check for first_minor
https://lore.kernel.org/linux-block/20211021122936.758221-1-yukuai3@huawei.com/

I have consulted with Yu Kuai, and his modification has also been confirmed by him.

Ye Bin (2):
  nbd: Fix incorrect error handle when first_minor is illegal in
    nbd_dev_add
  nbd: Fix hungtask when nbd_config_put

Yu Kuai (2):
  nbd: fix max value for 'first_minor'
  nbd: fix possible overflow for 'first_minor' in nbd_dev_add()

 drivers/block/nbd.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.31.1

