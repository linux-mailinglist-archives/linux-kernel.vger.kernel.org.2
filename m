Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752D3E92CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhHKNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:38:02 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:20674 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhHKNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:38:00 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 86099C401AF;
        Wed, 11 Aug 2021 21:37:34 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3] f2fs: warn on when fsck flag is set
Date:   Wed, 11 Aug 2021 21:37:33 +0800
Message-Id: <20210811133733.227456-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMaTUxWThpPTxgZTEJDSE
        oYVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDY6UQw*ND9DLSJMSy4RGg00
        Hk4wChJVSlVKTUlDTUNCS05OS0NIVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUpMQ0M3Bg++
X-HM-Tid: 0a7b356ebbebd996kuws86099c401af
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered,
this flag is set in too many places. For some scenes that are not very
reproducible, adding stack information will help locate the problem.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-Remove extra parentheses
v2:
-Convert to WARN_ON
-One more blank
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67faa43cc141..0d08e31214a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -33,7 +33,7 @@
 #else
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
-		if (WARN_ON(condition))					\
+		if (condition)						\
 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
 	} while (0)
 #endif
@@ -1999,6 +1999,8 @@ static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
 
 static inline void set_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 {
+	WARN_ON(type ==  SBI_NEED_FSCK);
+
 	set_bit(type, &sbi->s_flag);
 }
 
-- 
2.32.0

