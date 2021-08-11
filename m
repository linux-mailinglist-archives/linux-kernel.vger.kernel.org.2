Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1F3E9268
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhHKNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:19:03 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:64104 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhHKNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:19:00 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 64A3EC400ED;
        Wed, 11 Aug 2021 21:18:35 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Fengnan Chang <changfengnan@vivo.com>,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] fs: Don't create discard thread when device not support realtime discard
Date:   Wed, 11 Aug 2021 21:18:26 +0800
Message-Id: <20210811131826.223141-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811131826.223141-1-frank.li@vivo.com>
References: <20210811131826.223141-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpNQhlWQhhNTBpISUNCQk
        1PVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6Lww4CD9ODyI6FiMXITdM
        SFEKFAtVSlVKTUlDTUNMQkpOQkNCVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUpCTkk3Bg++
X-HM-Tid: 0a7b355d5a4ad996kuws64a3ec400ed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fengnan Chang <changfengnan@vivo.com>

Don't create discard thread when device not support realtime discard.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 363779a4402d..bc4ac46f3041 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2161,6 +2161,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
 init_thread:
+	if (!f2fs_realtime_discard_enable(sbi))
+		return err;
 	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
 				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(dcc->f2fs_issue_discard)) {
-- 
2.32.0

