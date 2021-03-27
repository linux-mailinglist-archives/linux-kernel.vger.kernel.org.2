Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8F34B579
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC0Id4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 04:33:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15352 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhC0Idp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:33:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6sWd6fJHz8y9f;
        Sat, 27 Mar 2021 16:31:41 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 16:33:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>
CC:     <teigland@redhat.com>, <ccaulfie@redhat.com>
Subject: [PATCH -next] fs: dlm: fix missing unlock on error in accept_from_sock()
Date:   Sat, 27 Mar 2021 16:37:04 +0800
Message-ID: <20210327083704.1092954-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from accept_from_sock()
in the error handling case.

Fixes: 6cde210a9758 ("fs: dlm: add helper for init connection")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/dlm/lowcomms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 73cc1809050a..166e36fcf3e4 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -931,6 +931,7 @@ static int accept_from_sock(struct listen_connection *con)
 			result = dlm_con_init(othercon, nodeid);
 			if (result < 0) {
 				kfree(othercon);
+				mutex_unlock(&newcon->sock_mutex);
 				goto accept_err;
 			}
 
-- 
2.25.1

