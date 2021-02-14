Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26F231AECC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 04:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBNDPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 22:15:32 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60800 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBNDP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 22:15:29 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11E3EDYb025484;
        Sun, 14 Feb 2021 12:14:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Sun, 14 Feb 2021 12:14:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11E3E3TI025171
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Feb 2021 12:14:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com>
Subject: [PATCH] pstore: fix warning in pstore_kill_sb()
Date:   Sun, 14 Feb 2021 12:13:07 +0900
Message-Id: <20210214031307.57903-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <00000000000084130f05bb3aa802@google.com>
References: <00000000000084130f05bb3aa802@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting WARN_ON(pstore_sb != sb) at pstore_kill_sb() [1], for the
assumption that pstore_sb != NULL is wrong because pstore_fill_super() will
not assign pstore_sb = sb when new_inode() for d_make_root() returned NULL
(due to memory allocation fault injection).

Since mount_single() calls pstore_kill_sb() when pstore_fill_super()
failed, pstore_kill_sb() needs to be aware of such failure path.

[1] https://syzkaller.appspot.com/bug?id=6abacb8da5137cb47a416f2bef95719ed60508a0

Reported-by: syzbot <syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/pstore/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 93a217e4f563..14658b009f1b 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -467,7 +467,7 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 static void pstore_kill_sb(struct super_block *sb)
 {
 	mutex_lock(&pstore_sb_lock);
-	WARN_ON(pstore_sb != sb);
+	WARN_ON(pstore_sb && pstore_sb != sb);
 
 	kill_litter_super(sb);
 	pstore_sb = NULL;
-- 
2.18.4

