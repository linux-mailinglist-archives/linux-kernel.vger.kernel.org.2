Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667773560F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbhDGBv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:51:58 -0400
Received: from server.lespinasse.org ([63.205.204.226]:34719 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbhDGBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:49 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759902; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=sRgr3eTHMkYG0a033c5wSjP6+Yvrcvk4eJe6GnX/cXk=;
 b=5EhncmT4Gv438y6/5NG8ncKXAEzImmCZNTdJ3BxGL42bGoEFICVQKsc5B2hxAx8fr7H4e
 xJ/4tdl7nubFCxJCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759902; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=sRgr3eTHMkYG0a033c5wSjP6+Yvrcvk4eJe6GnX/cXk=;
 b=l9qp+/x/nFDxeFdkHEoF5i+V2o64nYkMphTKPV+I1CsWjxM3TxYvrT3odZdhMkHUWNk7P
 mJP519TzYNxVsZRJ5bWfMQ4XA/VwL5/m+55+duBR7nt6WMjCdzRqzAIT9uNSt+hForKTjF1
 vYafd0yyNFnhcNrFcuASUOHtJ4PL9q9UdQ2S9QSDDo6ObI65oDsQE7NLqJvFpg/nCTfZkXQ
 6RjIKhSCrcNJS43RcFFrQIOYKiT4ISh2jSANhns1iZaXnAGFiXYs4iv3jNfy2jsXh1x6Vaf
 LBpGuioVpY/32Plv1fYa63ymJhJ9ve3uUAyf8tv7eYHnQoypIIbXGU9nNNGQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 757ED160224;
        Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 6242919F31F; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 02/37] mmap locking API: name the return values
Date:   Tue,  6 Apr 2021 18:44:27 -0700
Message-Id: <20210407014502.24091-3-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
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

