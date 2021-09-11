Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7940757D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhIKHqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 03:46:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16251 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhIKHqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 03:46:20 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H64Wj2cwMz8t2t;
        Sat, 11 Sep 2021 15:44:33 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 15:45:06 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 15:45:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <bskeggs@redhat.com>
Subject: [PATCH 2/2] drm/nouveau/debugfs: fix file release memory leak
Date:   Sat, 11 Sep 2021 15:50:23 +0800
Message-ID: <20210911075023.3969054-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911075023.3969054-1-yangyingliang@huawei.com>
References: <20210911075023.3969054-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using single_open() for opening, single_release() should be
called, otherwise the 'op' allocated in single_open() will be leaked.

Fixes: 6e9fc177399f ("drm/nouveau/debugfs: add copy of sysfs pstate interface ported to debugfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index c2bc05eb2e54..1cbe01048b93 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -207,6 +207,7 @@ static const struct file_operations nouveau_pstate_fops = {
 	.open = nouveau_debugfs_pstate_open,
 	.read = seq_read,
 	.write = nouveau_debugfs_pstate_set,
+	.release = single_release,
 };
 
 static struct drm_info_list nouveau_debugfs_list[] = {
-- 
2.25.1

