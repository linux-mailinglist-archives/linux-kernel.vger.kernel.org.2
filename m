Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9D376F55
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 06:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhEHECW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 00:02:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18794 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhEHECV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 00:02:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FcYTF6Y6tzBtfD;
        Sat,  8 May 2021 11:58:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 12:01:12 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] samples/seccomp: fix error return code in handle_req()
Date:   Sat, 8 May 2021 12:01:01 +0800
Message-ID: <20210508040101.2474-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike branch "if (lseek(mem, req->data.args[0], SEEK_SET) < 0)" above,
'ret' is overwritten by the previous 'ret = read(...)' statement.
Therefore, 'ret' needs to be explicitly assigned to -1 here. Otherwise,
0 is incorrectly returned.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 samples/seccomp/user-trap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 20291ec6489f..c1d4ca0284ba 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -164,6 +164,7 @@ static int handle_req(struct seccomp_notif *req,
 	}
 
 	if (lseek(mem, req->data.args[1], SEEK_SET) < 0) {
+		ret = -1;
 		perror("seek");
 		goto out;
 	}
-- 
2.25.1


