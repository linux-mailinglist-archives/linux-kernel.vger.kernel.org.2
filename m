Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3975537A764
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhEKNSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:18:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhEKNSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:18:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620739058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TbzIPuv8QFfOH+W8/b0Q54elXeb5H3WNjU08vHiM77M=;
        b=X5EAAlQVYOrjhnDtGLgHKLkBIzzswi4C7lRNms+ahL/nW8p1u+9TePidS4UzuguRJsCuVO
        SpYMEyWthTIjkrXRYLhA2uz2tUVSpxH9YB/IFE8q5IyMTyUrzM+xC86qm9bffByzQHYqRq
        +qBD3lGJrXalUOMNy87/d7aTN0gEDIU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78D93B239;
        Tue, 11 May 2021 13:17:38 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] MAINTAINERS: Add lib/percpu* as part of percpu entry
Date:   Tue, 11 May 2021 16:17:37 +0300
Message-Id: <20210511131737.185726-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch get_maintainers.pl on a patch which modified
lib/percpu_refcount.c produces:

Jens Axboe <axboe@kernel.dk> (commit_signer:2/5=40%)
Ming Lei <ming.lei@redhat.com> (commit_signer:2/5=40%,authored:2/5=40%,added_lines:99/114=87%,removed_lines:34/43=79%)
"Paul E. McKenney" <paulmck@kernel.org> (commit_signer:1/5=20%,authored:1/5=20%,added_lines:9/114=8%,removed_lines:3/43=7%)
Tejun Heo <tj@kernel.org> (commit_signer:1/5=20%)
Andrew Morton <akpm@linux-foundation.org> (commit_signer:1/5=20%)
Nikolay Borisov <nborisov@suse.com> (authored:1/5=20%,removed_lines:3/43=7%)
Joe Perches <joe@perches.com> (authored:1/5=20%,removed_lines:3/43=7%)
linux-kernel@vger.kernel.org (open list)

Whereas with the patch applied it now (properly) prints:

Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
linux-kernel@vger.kernel.org (open list)

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..b18fed606ddd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14004,6 +14004,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
 F:	arch/*/include/asm/percpu.h
 F:	include/linux/percpu*.h
+F:	lib/percpu*.c
 F:	mm/percpu*.c
 
 PER-TASK DELAY ACCOUNTING
-- 
2.25.1

