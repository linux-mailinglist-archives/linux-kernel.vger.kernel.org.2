Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4034F737
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhCaDHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:07:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14968 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhCaDHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:07:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9B5L63plzyNPC;
        Wed, 31 Mar 2021 11:05:26 +0800 (CST)
Received: from ubuntu1604.huawei.com (10.67.174.77) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 11:07:25 +0800
From:   Cui GaoSheng <cuigaosheng1@huawei.com>
To:     <keescook@chromium.org>, <luto@amacapital.net>, <wad@chromium.org>,
        <yifeifz2@illinois.edu>
CC:     <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH -next] seccomp: Fix a typo in seccomp.c
Date:   Tue, 30 Mar 2021 23:07:24 -0400
Message-ID: <20210331030724.84419-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.77]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a trivial typo fix.
s/cachable/cacheable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Cui GaoSheng <cuigaosheng1@huawei.com>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1d60fc2c9987..1e63db4dbd9a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -817,7 +817,7 @@ static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
 }
 
 /**
- * seccomp_cache_prepare - emulate the filter to find cachable syscalls
+ * seccomp_cache_prepare - emulate the filter to find cacheable syscalls
  * @sfilter: The seccomp filter
  *
  * Returns 0 if successful or -errno if error occurred.
-- 
2.30.0

