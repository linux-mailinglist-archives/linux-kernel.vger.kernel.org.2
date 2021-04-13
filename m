Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5049F35DBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbhDMJ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:57:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16907 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbhDMJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:57:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FKLZH0QPdzlXjF;
        Tue, 13 Apr 2021 17:55:19 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 17:57:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: document: add description about compressed space handling
Date:   Tue, 13 Apr 2021 17:56:53 +0800
Message-ID: <20210413095653.28231-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User or developer may still be confused about why f2fs doesn't expose
compressed space to userspace, add description about compressed space
handling policy into f2fs documentation.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 63c0c49b726d..992bf91eeec8 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -819,6 +819,14 @@ Compression implementation
   * chattr +c file
   * chattr +c dir; touch dir/file
   * mount w/ -o compress_extension=ext; touch file.ext
+  * mount w/ -o compress_extension=*; touch any_file
+
+- At this point, compression feature doesn't expose compressed space to user
+  directly in order to guarantee potential data updates later to the space.
+  Instead, the main goal is to reduce data writes to flash disk as much as
+  possible, resulting in extending disk life time as well as relaxing IO
+  congestion. Alternatively, we've added ioctl interface to reclaim compressed
+  space and show it to user after putting the immutable bit.
 
 Compress metadata layout::
 
-- 
2.29.2

