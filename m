Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB43F5574
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 03:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhHXBUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 21:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhHXBUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 21:20:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7794861056;
        Tue, 24 Aug 2021 01:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629767992;
        bh=HVZTqOmU6yGjrnUz9nZy965JrWb9oPWaPbk7egBfE2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=X9GgP3p07uB8vlItd0PUdqd+/ogUgdCMVK4ZKLbx0zCX3UNQyqJkLwdzu7IntfhnW
         MPG8g+b37v0gi/vD+VaAJAb5gOZjzZv4zzuhOFh6Gj+nXwM7z+dJO+YPGMSbFjkltL
         nDnNgbQi/jKiPTe94gRMgbKaoM7FP8JTOJkFV7rDiKxYqlHUzVjJRNem6X9dEc7wkI
         8LcY3zZB5WWAG8ry7uRx/C6Du1kOVuQQUTr3QdmQOSyk2fDhDv8QU6JrHtd/zY1XpU
         N6zOllcfjo0+tsBrvLKf/yJJ1HfW/2njdP+tV+s+7ZpJJxlkmDeX5wU2Qb5HTnOD9M
         i4b5fVkkFxwKQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix wrong option name printed by parse_options()
Date:   Tue, 24 Aug 2021 09:19:48 +0800
Message-Id: <20210824011948.15408-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It prints below kernel message during mounting w/ checkpoint=disable
option:

"F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"

Fix typo "checkpoint=merge" w/ "checkpoint_merge"

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 49e153fd8183..88c66e46bd5c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1289,6 +1289,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
+	if (test_opt(sbi, DISABLE_CHECKPOINT) &&
+			test_opt(sbi, MERGE_CHECKPOINT)) {
+		f2fs_err(sbi, "checkpoint_merge cannot be used with checkpoint=disable\n");
+		return -EINVAL;
+	}
+
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_PERSIST_TYPE.
 	 */
-- 
2.32.0

