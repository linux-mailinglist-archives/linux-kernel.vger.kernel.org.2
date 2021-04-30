Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C812B370181
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhD3Txj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:53:39 -0400
Received: from server.lespinasse.org ([63.205.204.226]:54429 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhD3TxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:22 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=sRgr3eTHMkYG0a033c5wSjP6+Yvrcvk4eJe6GnX/cXk=;
 b=pu4gEEk8gaS/ZROdf2FE6TRCwKA3WG48lPgW+lbTvRhfaZiXKDPKC9Ab/r9nTYZxiRuSc
 oCeVJTcBB8K0IfVAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=sRgr3eTHMkYG0a033c5wSjP6+Yvrcvk4eJe6GnX/cXk=;
 b=OJ/qR0VZF0/gCuHmcQvd9wL3u8ggpTpELa5K5Ixo9ImrXlgyebYkv+gh7VbA4Oqt247Jh
 8Dbgd9DQXJjIO6xeGUV6CvAdM8lohz6e/MyQl9EnmjOSIGedHtdE5y21J/h2RzDYBxt/9O4
 2BgjQihL+CXBHVw4WBP8WKugN0Zmgd7TthmDaEWPZJPdtSNW5Y4lVplSE8/LT2d7KprQmBb
 EvaxTSSuJXKuLgr8BEvcU8nFcvs51kLDtBc0yi7/v6HVis2w5RGQH3MrvycJhtJ/lyzvTFt
 wbL+fbDoTZeH4ZTYaqxXhiw7/u9ZMFL++Qe2UuCz6X7igqi/n60uPIaF4qrQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 244BA16030D;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0D7FE19F524; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
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
Subject: [PATCH 03/29] mmap locking API: name the return values
Date:   Fri, 30 Apr 2021 12:52:04 -0700
Message-Id: <20210430195232.30491-4-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the mmap locking API, the *_killable() functions return an error
(or 0 on success), and the *_trylock() functions return a boolean
(true on success).

Rename the return values "int error" and "bool ok", respectively,
rather than using "ret" for both cases which I find less readable.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mmap_lock.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 4e27f755766b..8ff276a7560e 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -81,22 +81,22 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
-	int ret;
+	int error;
 
 	__mmap_lock_trace_start_locking(mm, true);
-	ret = down_write_killable(&mm->mmap_lock);
-	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
-	return ret;
+	error = down_write_killable(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, true, !error);
+	return error;
 }
 
 static inline bool mmap_write_trylock(struct mm_struct *mm)
 {
-	bool ret;
+	bool ok;
 
 	__mmap_lock_trace_start_locking(mm, true);
-	ret = down_write_trylock(&mm->mmap_lock) != 0;
-	__mmap_lock_trace_acquire_returned(mm, true, ret);
-	return ret;
+	ok = down_write_trylock(&mm->mmap_lock) != 0;
+	__mmap_lock_trace_acquire_returned(mm, true, ok);
+	return ok;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
@@ -120,22 +120,22 @@ static inline void mmap_read_lock(struct mm_struct *mm)
 
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
-	int ret;
+	int error;
 
 	__mmap_lock_trace_start_locking(mm, false);
-	ret = down_read_killable(&mm->mmap_lock);
-	__mmap_lock_trace_acquire_returned(mm, false, ret == 0);
-	return ret;
+	error = down_read_killable(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, !error);
+	return error;
 }
 
 static inline bool mmap_read_trylock(struct mm_struct *mm)
 {
-	bool ret;
+	bool ok;
 
 	__mmap_lock_trace_start_locking(mm, false);
-	ret = down_read_trylock(&mm->mmap_lock) != 0;
-	__mmap_lock_trace_acquire_returned(mm, false, ret);
-	return ret;
+	ok = down_read_trylock(&mm->mmap_lock) != 0;
+	__mmap_lock_trace_acquire_returned(mm, false, ok);
+	return ok;
 }
 
 static inline void mmap_read_unlock(struct mm_struct *mm)
-- 
2.20.1

