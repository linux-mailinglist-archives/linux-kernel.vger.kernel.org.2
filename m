Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4078C370180
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhD3Txh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:37 -0400
Received: from server.lespinasse.org ([63.205.204.226]:48971 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhD3TxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:22 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=NVL7JPD4xKaWrJCrCCQAhxOaIfpgRthzGvlvMAcHMhY=;
 b=seFAG+swPapZKqpejXszQzpaIdmpkFiiKJBqE4tgh7BHr7TiZ7gnyCpxzN8EIlmwm8g58
 W9e7ERKDPuPRXxvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=NVL7JPD4xKaWrJCrCCQAhxOaIfpgRthzGvlvMAcHMhY=;
 b=Hr12W9SJ/k10T+AhevxFw7Xi/5TWRi39IsNggQfIKgJvy8FTTJ/1TIWDD4/EM8/GYwZpv
 wOk+SqRuC5x5GH5yfrje+m/9tY/aG8W7ipIjF2hwVdNO3FcbbB82d+GTS7m9JoiNr0ywZrn
 mElAhRQk77OBX5vcMLgCS9rQAva0NBgBVAFWJzGc81wJJOeImQFD3aKpNbJ+r+0VMABNEyL
 50XdZ6f4s2Y8lv/vqQRJllplvm4dz8f0IcOlja45ytEz53pLQ755IUI7QSltT6/N+Zwz8TK
 /sCXe+fw3IZD5K1NRhozh6yhxnVV821EBybHtmFvC/e3DjInR9QutLwILhGQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 1698016030A;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0638519F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 02/29] mmap locking API: mmap_lock_is_contended returns a bool
Date:   Fri, 30 Apr 2021 12:52:03 -0700
Message-Id: <20210430195232.30491-3-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mmap_lock_is_contended to return a bool value, rather than an
int which the callers are then supposed to interpret as a bool. This
is to ensure consistency with other mmap lock API functions (such as
the trylock functions).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mmap_lock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 0540f0156f58..4e27f755766b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -171,9 +171,9 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
-static inline int mmap_lock_is_contended(struct mm_struct *mm)
+static inline bool mmap_lock_is_contended(struct mm_struct *mm)
 {
-	return rwsem_is_contended(&mm->mmap_lock);
+	return rwsem_is_contended(&mm->mmap_lock) != 0;
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
-- 
2.20.1

