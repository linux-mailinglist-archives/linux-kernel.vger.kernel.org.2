Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA831C753
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhBPIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBPIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:22:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F40C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:21:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v9so6694903edw.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnoo0wmivAjtZsEgEktgO+RKl2tieZPPQBjazmOBOqU=;
        b=Z9Vu0aY51nyWdAxaO8mXDSjbTc43mQTKoZLKO9C80Q9Eizer9riaRFW7Lqs4O782Gh
         wi0i8XWFSUf4jxHteMhIEOc8Lvkx/Phq7OkuBzzw5XE+YS4k0QrLX8GTtnA0UkSDDLUs
         J3crWlj0yKdWAa2Mtk/TeAE/O0HLvyapWLlf8XPalfsFmOsmlhIG3gm0ku4CkotSJ+Uv
         28UkfzIQ32dvxKfkufY0GIGE3R/sfegOpWLT/U0+5ItkJYjm279f7eR8iq4I1wXKqeVE
         Jo5XYUqPGcasDe86VCbcPee8DPAV9qlRHKmeCAP/pXeRTyBwjsHSWizXtdHHpcsyhvlN
         nqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnoo0wmivAjtZsEgEktgO+RKl2tieZPPQBjazmOBOqU=;
        b=EQj1q4sX5moUc5FYyIoHtWjRAm7TephkQBItkj8X97tZv2I3271H3cpV2Mh4xQQOlY
         SuJVRfCKAo31xX5/Gwu3uJwklaehfrYAjoZ5HTmQL4TOBdPagHcQOPIGFwmd/sIvwK0F
         QimSRNz0kXGWVvxGvwYjAOlwEg4EuE1X9ZctRlEbWOYVqQwGT10KPtz2USA4wtSrkNxd
         mjURdvJqZv+Sky3H/Ak9CU6nfkpBmF0gf9o3zEWBQxkTzueLZEZaN0I3IdMvj2EcYJbL
         9/SPFvIwcF/gcqRqYUDN7mYwtVcb6oDpGABxqhQyNmwUzfHFJ3OKE+TDHsQqH4qY8dvb
         WqMQ==
X-Gm-Message-State: AOAM530NO2FkkJ/XPd1oxPP51+4hTbcopmnXouEjAshHe08ivCnzGwrg
        WFHbMbaSW4UrfTm7zIoe2y0=
X-Google-Smtp-Source: ABdhPJwN0aJw4oDqNgChQKLd0HpHNrQQPz5Yf69fZ8UG0f27hAb0Oqz/qJilxqiV1MOkSJ6vWsMsBA==
X-Received: by 2002:aa7:c887:: with SMTP id p7mr6605831eds.28.1613463707651;
        Tue, 16 Feb 2021 00:21:47 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:d4a8:bc96:3480:def7])
        by smtp.gmail.com with ESMTPSA id yh4sm6051192ejb.29.2021.02.16.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 00:21:47 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org
Subject: [PATCH] mutex: nuke mutex_trylock_recursive
Date:   Tue, 16 Feb 2021 09:21:46 +0100
Message-Id: <20210216082146.69286-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user went away in the 5.11 cycle.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/mutex.h  | 25 -------------------------
 kernel/locking/mutex.c | 10 ----------
 scripts/checkpatch.pl  |  6 ------
 3 files changed, 41 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd185cbfe79..0cd631a19727 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -199,29 +199,4 @@ extern void mutex_unlock(struct mutex *lock);
 
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
-/*
- * These values are chosen such that FAIL and SUCCESS match the
- * values of the regular mutex_trylock().
- */
-enum mutex_trylock_recursive_enum {
-	MUTEX_TRYLOCK_FAILED    = 0,
-	MUTEX_TRYLOCK_SUCCESS   = 1,
-	MUTEX_TRYLOCK_RECURSIVE,
-};
-
-/**
- * mutex_trylock_recursive - trylock variant that allows recursive locking
- * @lock: mutex to be locked
- *
- * This function should not be used, _ever_. It is purely for hysterical GEM
- * raisins, and once those are gone this will be removed.
- *
- * Returns:
- *  - MUTEX_TRYLOCK_FAILED    - trylock failed,
- *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
- *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
- */
-extern /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock);
-
 #endif /* __LINUX_MUTEX_H */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce50a97e..adb935090768 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -86,16 +86,6 @@ bool mutex_is_locked(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_is_locked);
 
-__must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock)
-{
-	if (unlikely(__mutex_owner(lock) == current))
-		return MUTEX_TRYLOCK_RECURSIVE;
-
-	return mutex_trylock(lock);
-}
-EXPORT_SYMBOL(mutex_trylock_recursive);
-
 static inline unsigned long __owner_flags(unsigned long owner)
 {
 	return owner & MUTEX_FLAGS;
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92e888ed939f..15f7f4fa6b99 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7069,12 +7069,6 @@ sub process {
 			}
 		}
 
-# check for mutex_trylock_recursive usage
-		if ($line =~ /mutex_trylock_recursive/) {
-			ERROR("LOCKING",
-			      "recursive locking is bad, do not use this ever.\n" . $herecurr);
-		}
-
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
-- 
2.25.1

