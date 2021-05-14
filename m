Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E7380AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhENOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhENOBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:01:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3380D6101A;
        Fri, 14 May 2021 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621000842;
        bh=QO8k/jSE1zp7BeVRCZZeywW1fgcMVXNir/KR3YgKKxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=TrZQ1cvCeAYQ3JQMLFvWzrexTwvmlpaISJVbAjKvT8PGfzPmKWJHz9s5MPmWgsiZv
         81iXwP1zAb7crjuwdaCidK8Im2NRws45imYCZr6Y46sT8lag6fvcN1f+Hog2cfWl0L
         R+S2ARTuupNUTsZmI3FaDq7b1mLNRC2MQ1AMYVbfIYYOiNVfyOcMZIoENX3NbmYqgf
         EWuzAkM9db5HDqlVl1jyVUFMQi7e1t2YoW6kJAnYTo/HBaVCEAs8A+ToqjQmS7lFlh
         1C0L6vltKXPgptoIauukkMkPJlJKK5BZxGYw1y+1r9Wo31Qc7SDbrGpNjK6uYDy32I
         tymj2AJR2BvoQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] mm/shuffle: fix section mismatch warning
Date:   Fri, 14 May 2021 15:59:48 +0200
Message-Id: <20210514135952.2928094-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang sometimes decides not to inline shuffle_zone(), but it calls
a __meminit function. Without the extra __meminit annotation we get
this warning:

WARNING: modpost: vmlinux.o(.text+0x2a86d4): Section mismatch in reference from the function shuffle_zone() to the function .meminit.text:__shuffle_zone()
The function shuffle_zone() references
the function __meminit __shuffle_zone().
This is often because shuffle_zone lacks a __meminit
annotation or the annotation of __shuffle_zone is wrong.

shuffle_free_memory() did not show the same problem in my tests, but
it could happen in theory as well, so mark both as __meminit.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/shuffle.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shuffle.h b/mm/shuffle.h
index 71b784f0b7c3..cec62984f7d3 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -10,7 +10,7 @@
 DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
 extern void __shuffle_free_memory(pg_data_t *pgdat);
 extern bool shuffle_pick_tail(void);
-static inline void shuffle_free_memory(pg_data_t *pgdat)
+static inline void __meminit shuffle_free_memory(pg_data_t *pgdat)
 {
 	if (!static_branch_unlikely(&page_alloc_shuffle_key))
 		return;
@@ -18,7 +18,7 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
 }
 
 extern void __shuffle_zone(struct zone *z);
-static inline void shuffle_zone(struct zone *z)
+static inline void __meminit shuffle_zone(struct zone *z)
 {
 	if (!static_branch_unlikely(&page_alloc_shuffle_key))
 		return;
-- 
2.29.2

