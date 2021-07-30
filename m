Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAA3DB4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhG3ID6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhG3IDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:03:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:03:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t68so8640021qkf.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MGzbYcDH1nDg768HY0nxSbDVEpHf6CaY6eKAkj1Bcno=;
        b=o9CkvmfR1TcmeOk6LOKvzvte8hfyZYPrZSw2A7Wzr6ScvLcANBE/Yoki51+w9yX2f6
         LVZpGnEbwEkqt7Hnt4+bRy/6x7vHr//wG299GJtb3ki0DosAuUEDfoNE2XtI+uUhKWo8
         JHPPLfpx8KtKArXuCe/nuOYN+WbhwkFd6C/is1BOTenZhPT2ltWUzirXBxTvUZUS+Eth
         QpoRVlzDTTDqPnJEkTWpSHqLZy5XfvU0CnPupILljD14KkG6MGijbWyMZkjws6psWPKu
         It373FYdIqlePn1A4XbdCWvefbcGFvZ9tg5krXyxfwhlI9Zg4rXj4U19/DZ057wpLO/T
         RdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MGzbYcDH1nDg768HY0nxSbDVEpHf6CaY6eKAkj1Bcno=;
        b=VoaCvDEZwCeRqrtBvGJYa4uLL4gTSiiVR8RoLROnBKgEgZYh2g/7kjgNJC6LN0gp4j
         Qt98righCCe2uYpni5P/PlGRCdVi2T6J3ydWJWIOM2uSN+EJIF6eN4h0L4YzwojPrOjT
         di3c7XOFnvhkZdcb0AB2XonNIm2Yp85fIp7gR0MeG7aS5uD75jeJDXM+1AQiY8A4YFbc
         8m9DWTYpXpzdaA7Py2by8+S10275r4B2Cy0GL0xJiEnLphFy4mBvGsWFkUwVE1ZlY/k2
         A7oISD0LTbb+KD80X+9khy2oujCs6gbbI1/vdpSU6zD8FSWKbncQ/J2zNfPLT1ezVpSA
         hglw==
X-Gm-Message-State: AOAM531CvR+aHxtY/Qpk2Vce5rD7HKRTfFc76nIeRbLtqz2JzKWELdaR
        ijFun6AZjkiz2YvmaTKgxs0W3A==
X-Google-Smtp-Source: ABdhPJykYS4oamptTpmIT6dFsy8t5YJDFW4VgtJtNRS/my2z80sEMhOQ8L7GnOEOo0Fymj/Aya18fA==
X-Received: by 2002:a37:4042:: with SMTP id n63mr1074442qka.425.1627632199330;
        Fri, 30 Jul 2021 01:03:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y9sm316166qtw.51.2021.07.30.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:03:18 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:03:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/16] mm: bool user_shm_lock(loff_t size, struct ucounts
 *)
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <dd2669c8-dcbe-c3d3-5ddb-11b84aa5b81@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_shm_lock()'s size_t size was big enough for SysV SHM locking, but
not quite big enough for O_LARGEFILE on 32-bit: change to loff_t size.
And while changing the prototype, let's use bool rather than int here.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm.h |  4 ++--
 mm/mlock.c         | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..f1be2221512b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1713,8 +1713,8 @@ extern bool can_do_mlock(void);
 #else
 static inline bool can_do_mlock(void) { return false; }
 #endif
-extern int user_shm_lock(size_t, struct ucounts *);
-extern void user_shm_unlock(size_t, struct ucounts *);
+extern bool user_shm_lock(loff_t size, struct ucounts *ucounts);
+extern void user_shm_unlock(loff_t size, struct ucounts *ucounts);
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
diff --git a/mm/mlock.c b/mm/mlock.c
index 16d2ee160d43..7df88fce0fc9 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -813,21 +813,21 @@ SYSCALL_DEFINE0(munlockall)
 }
 
 /*
- * Objects with different lifetime than processes (SHM_LOCK and SHM_HUGETLB
- * shm segments) get accounted against the user_struct instead.
+ * Objects with different lifetime than processes (SHM_LOCK and SHM_HUGETLB shm
+ * segments and F_MEM_LOCK tmpfs) get accounted to the user_namespace instead.
  */
 static DEFINE_SPINLOCK(shmlock_user_lock);
 
-int user_shm_lock(size_t size, struct ucounts *ucounts)
+bool user_shm_lock(loff_t size, struct ucounts *ucounts)
 {
 	unsigned long lock_limit, locked;
 	long memlock;
-	int allowed = 0;
+	bool allowed = false;
 
 	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	if (lock_limit == RLIM_INFINITY)
-		allowed = 1;
+		allowed = true;
 	lock_limit >>= PAGE_SHIFT;
 	spin_lock(&shmlock_user_lock);
 	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
@@ -840,13 +840,13 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}
-	allowed = 1;
+	allowed = true;
 out:
 	spin_unlock(&shmlock_user_lock);
 	return allowed;
 }
 
-void user_shm_unlock(size_t size, struct ucounts *ucounts)
+void user_shm_unlock(loff_t size, struct ucounts *ucounts)
 {
 	spin_lock(&shmlock_user_lock);
 	dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
-- 
2.26.2

