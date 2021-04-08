Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B16357F20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhDHJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:29:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15179 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:29:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGG9H1bKwzpWVG;
        Thu,  8 Apr 2021 17:26:27 +0800 (CST)
Received: from huawei.com (10.67.174.117) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 17:29:03 +0800
From:   Ruiqi Gong <gongruiqi1@huawei.com>
To:     <gongruiqi1@huawei.com>, Namjae Jeon <namjae.jeon@samsung.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>
CC:     Wang Weiyang <wangweiyang2@huawei.com>,
        <linux-cifs@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cifsd: remove unused header <linux/version.h>
Date:   Thu, 8 Apr 2021 05:43:09 -0400
Message-ID: <20210408094309.6652-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the header <linux/version.h> that is not needed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 fs/cifsd/mgmt/tree_connect.c | 1 -
 fs/cifsd/mgmt/user_session.c | 1 -
 fs/cifsd/mgmt/user_session.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/fs/cifsd/mgmt/tree_connect.c b/fs/cifsd/mgmt/tree_connect.c
index d3f28b10db4b..b9cd8fc46e5e 100644
--- a/fs/cifsd/mgmt/tree_connect.c
+++ b/fs/cifsd/mgmt/tree_connect.c
@@ -5,7 +5,6 @@
 
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/xarray.h>
 
 #include "../buffer_pool.h"
diff --git a/fs/cifsd/mgmt/user_session.c b/fs/cifsd/mgmt/user_session.c
index bd5789b7e08e..52c5c036ecf9 100644
--- a/fs/cifsd/mgmt/user_session.c
+++ b/fs/cifsd/mgmt/user_session.c
@@ -6,7 +6,6 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/rwsem.h>
-#include <linux/version.h>
 #include <linux/xarray.h>
 
 #include "ksmbd_ida.h"
diff --git a/fs/cifsd/mgmt/user_session.h b/fs/cifsd/mgmt/user_session.h
index 1a97c851f2fc..ad5c0430b62a 100644
--- a/fs/cifsd/mgmt/user_session.h
+++ b/fs/cifsd/mgmt/user_session.h
@@ -7,7 +7,6 @@
 #define __USER_SESSION_MANAGEMENT_H__
 
 #include <linux/hashtable.h>
-#include <linux/version.h>
 #include <linux/xarray.h>
 
 #include "../smb_common.h"

