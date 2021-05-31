Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06935395AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEaMof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:44:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2916 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:44:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ftvy36PLvz67W2;
        Mon, 31 May 2021 20:39:55 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 20:42:52 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 20:42:51 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <yangds.fnst@cn.fujitsu.com>,
        <s.hauer@pengutronix.de>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>, <yukuai3@huawei.com>,
        <chengzhihao1@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ubifs: Fixes for xattr concurrent operations
Date:   Mon, 31 May 2021 20:52:08 +0800
Message-ID: <20210531125210.1173922-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBIFS may occur some problems with concurrent xattr_{set|get} and
listxattr operations, such as assertion failure, memory corruption,
stale xattr value[1].

Patch 1: Import a new rw-lock in @ubifs_inode to serilize write
	 operations on xattr
Patch 2: Remove unnecessary ui_mutex in ubifs_xattr_get and change_xattr

BTW changing @host->ui_mutex to a rw lock to adapting xattr operations
is a risky method, since @host->ui_mutex acts as too many roles:
* serializes inode write-back with the rest of VFS operations(such as
  rename, mkdir, rmdir, create, eg.)
* serializes "clean <-> dirty" state changes, serializes bulk-read
* protects @dirty, @bulk_read, @ui_size, and @xattr_size

Besides, if xattr operations and io/vfs operations share same rw-lock,
xattr operations may effect UBIFS performance more or less.

[1] https://lore.kernel.org/linux-mtd/20200630130438.141649-1-houtao1@huawei.com

Zhihao Cheng (2):
  ubifs: Fix races between xattr_{set|get} and listxattr operations
  ubifs: Remove ui_mutex in ubifs_xattr_get and change_xattr

 fs/ubifs/super.c |  1 +
 fs/ubifs/ubifs.h |  2 ++
 fs/ubifs/xattr.c | 48 +++++++++++++++++++++++++++++++++---------------
 3 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.25.4

