Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3D327EE6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhCANGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhCANF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:05:59 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5FC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 05:05:18 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a2so11831728qtw.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au8Zz+SoDXzMusEo7KWrVD2KWYlN8RtcYdlrrqZQY1Q=;
        b=Fwg5sXghGbeVoMUeFboVqc1HxX4XekAmXOt6YiX5/jk00xUDDPdAmyyMzpWtK+hxeF
         Zixn+xD+Uf/GasSDjsB37aw1vOWIuF8CB07QR3ZfU51ef++wNIEhPwRn0gpLDldamqln
         LoXlhzWSNH6k5UkkNhxcPzHwXoDyeqTrijY9oIAtdLPmTDr1Nl7+IM51TP8jEjyvfLbR
         RvVgkuUaLkUAPPN6nejzA5KpIr5DxZK/o5lrSHuDmJz7PcE6I7WPdu5O4rUCYRQpXaXQ
         oL10WNS4vTah6zNEYx2EIOZasZVbPl3TSHhn6tEAUFMC+99iUHJu9NUa3Ui2KAA0IyYL
         L0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au8Zz+SoDXzMusEo7KWrVD2KWYlN8RtcYdlrrqZQY1Q=;
        b=Rh4iBOxzCZv+HUgIT9l50GEl3AfnxBUpaEn1j5Y41Lw4VgUnAJLbCgnl4fOF626Y+f
         2FgPIvBX7BzFSNP+SEe9jblAwDCnZl+fYxYBhAMIPEADNTSEqb9rIr2K8LSGH6GiPX1h
         f2RmT8wFD8FNwfW6ihdltxltRKCRint7PYeYUp9M4726gVU2gSirMBsUMcoEd6UB0N+K
         a2wenvWzchHRwo4XEI/FBSZyWgHaghZQo8sHWQxXmeM8B3DgiTaFOAwm9Lu9+KgG/5Jq
         pE5uiY9OZJjulhEa01Hckjq8V+tETnmuaRbRRxazBweiplHLNux61G02zjrpEwuPQS9t
         oZ9A==
X-Gm-Message-State: AOAM532nfbqNA92TfRNK4QWPMjgAvQC10NV7FUwlbHi9jFhnlZK+CYM4
        KsU2MMm+jUduAje7kase9h8CmNVgnZ0qpw==
X-Google-Smtp-Source: ABdhPJy5+inN+dAqecyZ5YIZMBG70oRsFUvfuHAlv0dndv6fiIV/T0bBjrssgDXQTgpBo1O0RxnQVQ==
X-Received: by 2002:ac8:35d1:: with SMTP id l17mr13103233qtb.127.1614603917212;
        Mon, 01 Mar 2021 05:05:17 -0800 (PST)
Received: from localhost.localdomain ([138.199.13.198])
        by smtp.gmail.com with ESMTPSA id f12sm12740371qkl.2.2021.03.01.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 05:05:16 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: linux:  Typos fixed in throughout the file lru_cache.h
Date:   Mon,  1 Mar 2021 18:32:58 +0530
Message-Id: <20210301130258.32077-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Few typos fixed throughout the file.


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/lru_cache.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index 429d67d815ce..f65c6734be3c 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -32,7 +32,7 @@ This header file (and its .c file; kernel-doc of functions see there)
   Because of this later property, it is called "lru_cache".
   As it actually Tracks Objects in an Active SeT, we could also call it
   toast (incidentally that is what may happen to the data on the
-  backend storage uppon next resync, if we don't get it right).
+  backend storage upon next resync, if we don't get it right).

 What for?

@@ -152,7 +152,7 @@ struct lc_element {
 	 * for paranoia, and for "lc_element_to_index" */
 	unsigned lc_index;
 	/* if we want to track a larger set of objects,
-	 * it needs to become arch independend u64 */
+	 * it needs to become arch independent u64 */
 	unsigned lc_number;
 	/* special label when on free list */
 #define LC_FREE (~0U)
@@ -263,7 +263,7 @@ extern void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char
  *
  * Allows (expects) the set to be "dirty".  Note that the reference counts and
  * order on the active and lru lists may still change.  Used to serialize
- * changing transactions.  Returns true if we aquired the lock.
+ * changing transactions.  Returns true if we acquired the lock.
  */
 static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
 {
@@ -275,7 +275,7 @@ static inline int lc_try_lock_for_transaction(struct lru_cache *lc)
  * @lc: the lru cache to operate on
  *
  * Note that the reference counts and order on the active and lru lists may
- * still change.  Only works on a "clean" set.  Returns true if we aquired the
+ * still change.  Only works on a "clean" set.  Returns true if we acquired the
  * lock, which means there are no pending changes, and any further attempt to
  * change the set will not succeed until the next lc_unlock().
  */
--
2.26.2

