Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5423E5BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbhHJNgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:36:22 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:37330 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbhHJNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:35:45 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 94FD3C40070;
        Tue, 10 Aug 2021 21:27:08 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: correct comment in segment.h
Date:   Tue, 10 Aug 2021 21:27:06 +0800
Message-Id: <20210810132707.349147-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJPGR5WQhlNGh5MHU5MGh
        9CVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Lio5Ej9NTCwpOhVWHgoT
        E0gwCQJVSlVKTUlDTUtJS0lCTUlKVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUpDS003Bg++
X-HM-Tid: 0a7b303ed2d5d996kuws94fd3c40070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/two/three

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 050230c70a53..89fff258727d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -142,7 +142,7 @@ enum {
 };
 
 /*
- * In the victim_sel_policy->alloc_mode, there are two block allocation modes.
+ * In the victim_sel_policy->alloc_mode, there are three block allocation modes.
  * LFS writes data sequentially with cleaning operations.
  * SSR (Slack Space Recycle) reuses obsolete space without cleaning operations.
  * AT_SSR (Age Threshold based Slack Space Recycle) merges fragments into
@@ -155,7 +155,7 @@ enum {
 };
 
 /*
- * In the victim_sel_policy->gc_mode, there are two gc, aka cleaning, modes.
+ * In the victim_sel_policy->gc_mode, there are three gc, aka cleaning, modes.
  * GC_CB is based on cost-benefit algorithm.
  * GC_GREEDY is based on greedy algorithm.
  * GC_AT is based on age-threshold algorithm.
-- 
2.32.0

