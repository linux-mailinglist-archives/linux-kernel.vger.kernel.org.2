Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A735D577
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbhDMCvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:51:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:17659 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238431AbhDMCvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:51:45 -0400
IronPort-SDR: qVznAS8GNEqlvTsRbxzuoqdS4gk3jXDW4YH5zl3ZyqyS4ccdRTQfeSkT3udMtH17Z7X1krANfz
 1ed2e4e59SlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="181843747"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="181843747"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 19:51:24 -0700
IronPort-SDR: C/pz0Bo8wG7zPRBY1g+nsnnxYmdXfRyhaLPs+FB1hzhb2zWN3YARepyj0eXnF4bOB2Py7XyxZ0
 ymUhgYsb+87Q==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="532108026"
Received: from yhuang6-desk1.sh.intel.com ([10.239.13.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 19:51:22 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [RFC PATCH] percpu_ref: Make percpu_ref_tryget*() ACQUIRE operations
Date:   Tue, 13 Apr 2021 10:47:03 +0800
Message-Id: <20210413024703.2745636-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One typical use case of percpu_ref_tryget() family functions is as
follows,

  if (percpu_ref_tryget(&p->ref)) {
	  /* Operate on the other fields of *p */
  }

The refcount needs to be checked before operating on the other fields
of the data structure (*p), otherwise, the values gotten from the
other fields may be invalid or inconsistent.  To guarantee the correct
memory ordering, percpu_ref_tryget*() needs to be the ACQUIRE
operations.

This function implements that via using smp_load_acquire() in
__ref_is_percpu() to read the percpu pointer.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/percpu-refcount.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 16c35a728b4c..9838f7ea4bf1 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -165,13 +165,13 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
 	 * !__PERCPU_REF_ATOMIC, which may be set asynchronously, and then
 	 * used as a pointer.  If the compiler generates a separate fetch
 	 * when using it as a pointer, __PERCPU_REF_ATOMIC may be set in
-	 * between contaminating the pointer value, meaning that
-	 * READ_ONCE() is required when fetching it.
+	 * between contaminating the pointer value, smp_load_acquire()
+	 * will prevent this.
 	 *
-	 * The dependency ordering from the READ_ONCE() pairs
+	 * The dependency ordering from the smp_load_acquire() pairs
 	 * with smp_store_release() in __percpu_ref_switch_to_percpu().
 	 */
-	percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
+	percpu_ptr = smp_load_acquire(&ref->percpu_count_ptr);
 
 	/*
 	 * Theoretically, the following could test just ATOMIC; however,
@@ -231,6 +231,9 @@ static inline void percpu_ref_get(struct percpu_ref *ref)
  * Returns %true on success; %false on failure.
  *
  * This function is safe to call as long as @ref is between init and exit.
+ *
+ * This function is an ACQUIRE operation, that is, all memory operations
+ * after will appear to happen after checking the refcount.
  */
 static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
 					  unsigned long nr)
@@ -260,6 +263,9 @@ static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
  * Returns %true on success; %false on failure.
  *
  * This function is safe to call as long as @ref is between init and exit.
+ *
+ * This function is an ACQUIRE operation, that is, all memory operations
+ * after will appear to happen after checking the refcount.
  */
 static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 {
@@ -280,6 +286,9 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
  * percpu_ref_tryget_live().
  *
  * This function is safe to call as long as @ref is between init and exit.
+ *
+ * This function is an ACQUIRE operation, that is, all memory operations
+ * after will appear to happen after checking the refcount.
  */
 static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 {
-- 
2.30.2

