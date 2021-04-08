Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5120357C97
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDHG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:26:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15175 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDHG0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:26:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGB6d1ZvmzpWRX;
        Thu,  8 Apr 2021 14:23:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 14:26:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <christian.brauner@ubuntu.com>, <masahiroy@kernel.org>,
        <akpm@linux-foundation.org>, <ktkhai@virtuozzo.com>
CC:     <linux-kernel@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        "Zhiqi Song" <songzhiqi1@huawei.com>
Subject: [PATCH] init/version.c: remove unused including <linux/version.h>
Date:   Thu, 8 Apr 2021 14:26:58 +0800
Message-ID: <1617863218-14905-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 init/version.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/version.c b/init/version.c
index 92afc78..b1329f1 100644
--- a/init/version.c
+++ b/init/version.c
@@ -13,7 +13,6 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <generated/utsrelease.h>
-#include <linux/version.h>
 #include <linux/proc_ns.h>
 
 struct uts_namespace init_uts_ns = {
-- 
2.7.4

