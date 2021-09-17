Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B303040F815
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbhIQMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhIQMl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:41:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4D2610C9;
        Fri, 17 Sep 2021 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631882437;
        bh=JMN+cOzc4FEJ/rTXCOyd6vVaS2oETNboMyto2RaZsks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ms1CaQw5Z5W22DHJxuKh+gkV+w5c4kppF6VL28aF7AWFF3RMXsGMDxOJEyJ3lr8fZ
         UkxGC0Y6D5+6GUdFL/QjTQNMQDyg8OA8KOA9FiZweZ2Oj9JXnuSnkupsXIBO/U4X17
         QSrzz2M9+Jzgu044wXtCLnL5lPna0wjtsfhlKSgeynVPQqWRdRZ74A9/NRmaXyMyoj
         kmd1Bmaz+ZCULPa3+1S41hhq6fzom+kFlp3vNJcEE/TaarI52FctF3VOPeUT+qZzp+
         8BwOWoQWdPRqIAd6uXcnQe5YuDfxHB3uLO+3pQ8GHQMkRUPOnLUDfcfyYTI1RVn8no
         IxqEJAYZzmUcg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, sj@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/5] Documentation/vm: Move user guides to admin-guide/mm/
Date:   Fri, 17 Sep 2021 12:39:54 +0000
Message-Id: <20210917123958.3819-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917123958.3819-1-sj@kernel.org>
References: <20210917123958.3819-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Most memory management user guide documents are in 'admin-guide/mm/',
but two of those are in 'vm/'.  This commit moves the two docs into
'admin-guide/mm' for easier documents finding.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/index.rst        |  2 ++
 .../{vm => admin-guide/mm}/swap_numa.rst      |  0
 .../{vm => admin-guide/mm}/zswap.rst          |  0
 Documentation/vm/index.rst                    | 26 ++++---------------
 4 files changed, 7 insertions(+), 21 deletions(-)
 rename Documentation/{vm => admin-guide/mm}/swap_numa.rst (100%)
 rename Documentation/{vm => admin-guide/mm}/zswap.rst (100%)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index cbd19d5e625f..c21b5823f126 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -37,5 +37,7 @@ the Linux memory management.
    numaperf
    pagemap
    soft-dirty
+   swap_numa
    transhuge
    userfaultfd
+   zswap
diff --git a/Documentation/vm/swap_numa.rst b/Documentation/admin-guide/mm/swap_numa.rst
similarity index 100%
rename from Documentation/vm/swap_numa.rst
rename to Documentation/admin-guide/mm/swap_numa.rst
diff --git a/Documentation/vm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
similarity index 100%
rename from Documentation/vm/zswap.rst
rename to Documentation/admin-guide/mm/zswap.rst
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index b51f0d8992f8..6f5ffef4b716 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -3,27 +3,11 @@ Linux Memory Management Documentation
 =====================================
 
 This is a collection of documents about the Linux memory management (mm)
-subsystem.  If you are looking for advice on simply allocating memory,
-see the :ref:`memory_allocation`.
-
-User guides for MM features
-===========================
-
-The following documents provide guides for controlling and tuning
-various features of the Linux memory management
-
-.. toctree::
-   :maxdepth: 1
-
-   swap_numa
-   zswap
-
-Kernel developers MM documentation
-==================================
-
-The below documents describe MM internals with different level of
-details ranging from notes and mailing list responses to elaborate
-descriptions of data structures and algorithms.
+subsystem internals with different level of details ranging from notes and
+mailing list responses for elaborating descriptions of data structures and
+algorithms.  If you are looking for advice on simply allocating memory, see the
+:ref:`memory_allocation`.  For controlling and tuning guides, see the
+:doc:`admin guide <../admin-guide/mm/index>`.
 
 .. toctree::
    :maxdepth: 1
-- 
2.17.1

