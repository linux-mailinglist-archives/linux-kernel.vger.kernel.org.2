Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613EA3BB4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 03:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhGEBjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 21:39:14 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9346 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhGEBjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 21:39:13 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GJ7TX0Qz9z75tf;
        Mon,  5 Jul 2021 09:32:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 09:36:34 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 09:36:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>
CC:     <alexander.deucher@amd.com>
Subject: [PATCH -next] drm/amdgpu: Fix missing unlock on error in amdgpu_ras_debugfs_table_read()
Date:   Mon, 5 Jul 2021 09:39:48 +0800
Message-ID: <20210705013948.3112994-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Add the missing unlock before return from function
amdgpu_ras_debugfs_table_read() in the error handling
case.

Fixes: 9b790694a031 ("drm/amdgpu: RAS EEPROM table is now in debugfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index fc70620369e4..dbeeb4986ca6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -912,8 +912,10 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 				 record.retired_page);
 
 			data_len = min_t(size_t, rec_hdr_fmt_size - r, size);
-			if (copy_to_user(buf, &data[r], data_len))
-				return -EINVAL;
+			if (copy_to_user(buf, &data[r], data_len)) {
+				res = -EINVAL;
+				goto Out;
+			}
 			buf += data_len;
 			size -= data_len;
 			*pos += data_len;
-- 
2.25.1

