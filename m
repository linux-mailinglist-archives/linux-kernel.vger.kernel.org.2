Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DFF38263C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhEQIIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:08:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3714 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhEQIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:08:51 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkBW31LGfz16RBk;
        Mon, 17 May 2021 16:04:47 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:07:14 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 16:07:13 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <emma@anholt.net>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/2] cleanup patches for PM reference leak
Date:   Mon, 17 May 2021 16:14:36 +0800
Message-ID: <20210517081438.1562410-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Kuai (2):
  drm/v3d: Fix PM reference leak in v3d_get_param_ioctl()
  drm/v3d: Fix PM reference leak in v3d_v3d_debugfs_ident()

 drivers/gpu/drm/v3d/v3d_debugfs.c | 4 ++--
 drivers/gpu/drm/v3d/v3d_drv.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.4

