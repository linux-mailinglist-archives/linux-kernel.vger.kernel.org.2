Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D8388618
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353281AbhESEgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:36:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3412 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbhESEgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:36:39 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKjD6lXYzCsc8;
        Wed, 19 May 2021 12:32:32 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:35:19 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:35:18 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
        <kbusch@kernel.org>, <amit.engel@dell.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 0/2] nvmet: Fix memory leak when create ctrl fails
Date:   Wed, 19 May 2021 13:01:08 +0800
Message-ID: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches to fix the issuse of memory leak 
when creating ctrl fails.

Wu Bo (2):
  nvmet: Fix memory leak in nvmet_alloc_ctrl()
  nvme-loop: Fix memory leak in nvme_loop_create_ctrl()

 drivers/nvme/target/core.c | 2 +-
 drivers/nvme/target/loop.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.3.1

