Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030FA37B281
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEKXZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D5961626;
        Tue, 11 May 2021 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775446;
        bh=cCZiIKSYRe8Se7dZiI5MPDJLnFp4PsJZgVTgCrJuyaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cekeiQ73wdLMfw1R5jOXmxbW9/R5auj6VHq29R0LI8+UI2tuJwhP1BFf6zD1RHJpN
         cnqSoWLw3OqOWK5cyWn7bcsh7cbl4e4pSEuOWyy+6AaDZ++X3W8i3DfFzNRTHAO6Fs
         mGl5VK2+bAaxzNtOYKZ8XvjSS+xMrKYH94AnSUIq+xUfvZPbRsaPirBbdNe440FQag
         HPT6omryhujJ4JCq61lAceGQUyiFVqJ79Bzy7L3LnbttUxl47mpRTQC93nNJ5ah5Aa
         qkrCpJGm+XK9XNdZ4SpBlL7kIqNiXrsZsmt7rWDwzUBpGfylqdEiRpLeloMYbCNnZL
         IsoAtrkEfRjAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 99CD95C0138; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH tip/core/rcu 01/10] kcsan: Add pointer to access-marking.txt to data_race() bullet
Date:   Tue, 11 May 2021 16:23:52 -0700
Message-Id: <20210511232401.2896217-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit references tools/memory-model/Documentation/access-marking.txt
in the bullet introducing data_race().  The access-marking.txt file
gives advice on when data_race() should and should not be used.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index d85ce238ace7..80894664a44c 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -106,7 +106,9 @@ the below options are available:
 
 * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
   any data races due to accesses in ``expr`` should be ignored and resulting
-  behaviour when encountering a data race is deemed safe.
+  behaviour when encountering a data race is deemed safe.  Please see
+  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
+  tree for more information.
 
 * Disabling data race detection for entire functions can be accomplished by
   using the function attribute ``__no_kcsan``::
-- 
2.31.1.189.g2e36527f23

