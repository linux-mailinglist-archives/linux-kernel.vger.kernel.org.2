Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98587437218
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJVGuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhJVGuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CDD860F50;
        Fri, 22 Oct 2021 06:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634885273;
        bh=j+A3hXIyh6wwO3xTe/afg7vjWoz+VUdDqxC1TFMrp3k=;
        h=From:To:Cc:Subject:Date:From;
        b=IIA5uKpiECH9A7MHonzFCOH9FqxhmEobyME1JhdYrlQ7V5+fu0sC598FX8UCaJdFE
         i7Co8rMZX2gjTHk4IN024x+CEYQPa9vKxEFufKaXwYjZX3PY+gRRFZNyts8/psfQKM
         4FD6j3FieJTVG8EJIeorTCGVaphtK0KOOXnCgG8asJydXPkancG6G3LKtqiIJzh24h
         L5mGkbyHa2qLuo0ftL7wpiDZd2ogw2u2Ob+0HDMdJIiLy00QQUJ98FKY98XaqCqTrL
         Qs9SKSEnWxYF1DIQ2/yxHJi4zjKbjuIuMWwpfy3bgVqWmIWVXdFehCQZUEi07EuwUZ
         U4KoxZYhDD5xA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oscar Salvador <osalvador@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shmem: fix uninitialized variable use in me_pagecache_clean()
Date:   Fri, 22 Oct 2021 08:47:36 +0200
Message-Id: <20211022064748.4173718-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It appears that the has_extra_refcount() is now in the wrong place:

mm/memory-failure.c:892:6: error: variable 'extra_pins' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (!mapping) {
            ^~~~~~~~
mm/memory-failure.c:915:32: note: uninitialized use occurs here
        if (has_extra_refcount(ps, p, extra_pins))
                                      ^~~~~~~~~~
mm/memory-failure.c:892:2: note: remove the 'if' if its condition is always false
        if (!mapping) {
        ^~~~~~~~~~~~~~~
mm/memory-failure.c:879:6: error: variable 'extra_pins' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (PageAnon(p)) {
            ^~~~~~~~~~~
mm/memory-failure.c:915:32: note: uninitialized use occurs here
        if (has_extra_refcount(ps, p, extra_pins))
                                      ^~~~~~~~~~
mm/memory-failure.c:879:2: note: remove the 'if' if its condition is always false
        if (PageAnon(p)) {
        ^~~~~~~~~~~~~~~~~~
mm/memory-failure.c:871:17: note: initialize the variable 'extra_pins' to silence this warning
        bool extra_pins;
                       ^
                        = 0

In both of those cases, we already set an error code and don't
need to override that one.

Fixes: d882a43a0011 ("mm: shmem: don't truncate page if memory failure happens")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is caused by a commit im -mm, so the commit ID is not stable.
If the fix is correct, I'd suggest folding it into the original
change
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3b04f0361a58..e8c38e27b753 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -909,12 +909,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
 	ret = truncate_error_page(p, page_to_pfn(p), mapping);
-out:
-	unlock_page(p);
-
 	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 
+out:
+	unlock_page(p);
+
 	return ret;
 }
 
-- 
2.29.2

