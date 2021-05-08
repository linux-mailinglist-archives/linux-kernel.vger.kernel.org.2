Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF104376E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhEHBoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:44:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhEHBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:44:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FcVPH2H5XzQk51;
        Sat,  8 May 2021 09:40:03 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 09:43:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] fs/adfs: dir: fix error return code in adfs_fplus_read()
Date:   Sat, 8 May 2021 09:42:51 +0800
Message-ID: <20210508014251.1577-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/adfs/dir_fplus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..a6fd847ce0eb 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -142,6 +142,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 	}
 
 	if (adfs_fplus_checkbyte(dir) != t->bigdircheckbyte) {
+		ret = -EIO;
 		adfs_error(sb, "dir %06x checkbyte mismatch\n", indaddr);
 		goto out;
 	}
-- 
2.25.1


