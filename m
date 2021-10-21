Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF999436A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhJUSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhJUSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D20F1619EE;
        Thu, 21 Oct 2021 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839473;
        bh=lGh0XeqSZNuW0fqplNWzUDedNwAXO4pvwLSl9pHgoZY=;
        h=From:To:Cc:Subject:Date:From;
        b=EEj3xxBawH/cZAnovGxNz2vMTaV3p3XTSa1IEaFTRbJMsCDVlO1XuCMHbnIlbmzuV
         veDGmUuPOiqTCCiAld06Qt/6f4IEUK8GjEZdjGjrW7prpQv3bJ4pNi8ZeQFvPzl1/V
         U66JnX8qMzz+MnefSv3dQVp/it/IMRivlzi1wx2mWNRKliC6FpgMz6iYVRQATKep48
         nb8w3cc+R41alXXuncus9UpMV8kKBncmT9LLfMAZf+CbDpqv5sf8irj/7oUXlW8dzv
         XUGNoJFj4R3BHfz8qOuzjvFIZXtrLDJHJAnSORRPVDE11HBbkyDWUF7RtY4G/Qfkq1
         MSZ7Jq5oMC8bw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] mm/memory_failure: Initialize extra_pins in me_pagecache_clean()
Date:   Thu, 21 Oct 2021 11:03:37 -0700
Message-Id: <20211021180336.2328086-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

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
2 errors generated.

Initialize extra_pins to false so that it is not used uninitialized.

Fixes: d882a43a0011 ("mm: shmem: don't truncate page if memory failure happens")
Link: https://github.com/ClangBuiltLinux/linux/issues/1487
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

I am aware the fixes tag is not stable. It is there to convey this
should be squashed into mm-shmem-dont-truncate-page-if-memory-failure-happens.patch.

 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3b04f0361a58..dba5f0098165 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -868,7 +868,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 {
 	int ret;
 	struct address_space *mapping;
-	bool extra_pins;
+	bool extra_pins = false;
 
 	delete_from_lru_cache(p);
 
-- 
2.33.1.637.gf443b226ca

