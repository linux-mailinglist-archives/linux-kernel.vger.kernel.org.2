Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308B7452C63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhKPIIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:08:38 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47463 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhKPIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:08:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UwqPPRz_1637049934;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UwqPPRz_1637049934)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 16:05:35 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] pipe: Eliminate compilation warnings
Date:   Tue, 16 Nov 2021 16:05:34 +0800
Message-Id: <20211116080534.30834-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_WATCH_QUEUE is not set, clang will have five similar
compilation warnings as follows:

  fs/pipe.c:755:15: warning: no previous prototype for function 'account_pipe_buffers' [-Wmissing-prototypes]
  unsigned long account_pipe_buffers(struct user_struct *user,
                ^
  fs/pipe.c:755:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  unsigned long account_pipe_buffers(struct user_struct *user,
  ^
  static

Eliminate compilation warnings by removing macro compilation in
header files.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 include/linux/pipe_fs_i.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index fc5642431b92..b4fa7879ad83 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -256,18 +256,14 @@ void generic_pipe_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 
 extern const struct pipe_buf_operations nosteal_pipe_buf_ops;
 
-#ifdef CONFIG_WATCH_QUEUE
 unsigned long account_pipe_buffers(struct user_struct *user,
 				   unsigned long old, unsigned long new);
 bool too_many_pipe_buffers_soft(unsigned long user_bufs);
 bool too_many_pipe_buffers_hard(unsigned long user_bufs);
 bool pipe_is_unprivileged_user(void);
-#endif
 
 /* for F_SETPIPE_SZ and F_GETPIPE_SZ */
-#ifdef CONFIG_WATCH_QUEUE
 int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots);
-#endif
 long pipe_fcntl(struct file *, unsigned int, unsigned long arg);
 struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 
-- 
2.32.0

