Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4277A3E9266
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhHKNS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:18:59 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:64084 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhHKNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:18:58 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id A7411C40091;
        Wed, 11 Aug 2021 21:18:31 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] f2fs: fix potential memory leaks in create_discard_cmd_control
Date:   Wed, 11 Aug 2021 21:18:25 +0800
Message-Id: <20210811131826.223141-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkeHk5WQk9CGk5MHUsfSU
        JDVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6AQw*Qj9KHyIyPCw6IT8f
        VjAaFChVSlVKTUlDTUNMQkpJSU5JVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUpOQk83Bg++
X-HM-Tid: 0a7b355d4b98d996kuwsa7411c40091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release f2fs_issue_discard every time it is destroyed,
otherwise it will cause memory leaks when remounting.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index afe20c5c3c08..363779a4402d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1741,6 +1741,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 
 		dcc->f2fs_issue_discard = NULL;
 		kthread_stop(discard_thread);
+		put_task_struct(discard_thread);
 	}
 }
 
@@ -2168,6 +2169,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 		SM_I(sbi)->dcc_info = NULL;
 		return err;
 	}
+	get_task_struct(dcc->f2fs_issue_discard);
 
 	return err;
 }
-- 
2.32.0

