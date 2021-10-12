Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F742AE54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhJLU7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235562AbhJLU7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 967D8610D1;
        Tue, 12 Oct 2021 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072265;
        bh=J5JGi5ZW1VXphRfAjWGvw8aX4WH1jIvTGdGvkWmPVBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9xpgG3uNG2pYVXqp14qBUxRRHcK1ah8h7ZUnNxScE2btRwRuFjN1Vx4yFIiEPaI7
         8wJ4fliZUxWtrnNFJCi/nydfpwg/eN2qY/eMGDgkEaYdWkTeh26MS/xqyFrG842qem
         l6fAKVzKmZWlm+cSVTfgGTuWSjpCumrG6jZRkyhuQFRlhh4hFWQRBSz4EJ/cPNkZFC
         w31lfGvoEC0Fj168bkxVf8V2xYaYCLRcftaH/rc0d7pxvAANuAhDatT2DFWyR7JhRX
         zJPbnl3qZv9z1l5Jfbr/KHp22IgpQ/F30FefhMW+iawPMiA0AjTFYi/2u/cKeKPE3E
         P+gfs8vj7/hVw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Docs/DAMON: Document physical memory monitoring support
Date:   Tue, 12 Oct 2021 20:57:11 +0000
Message-Id: <20211012205711.29216-8-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates the DAMON documents for the physical memory address
space monitoring support.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 25 +++++++++++++----
 Documentation/vm/damon/design.rst            | 29 ++++++++++++--------
 Documentation/vm/damon/faq.rst               |  5 ++--
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index f7d5cfbb50c2..ed96bbf0daff 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -10,15 +10,16 @@ DAMON provides below three interfaces for different users.
   This is for privileged people such as system administrators who want a
   just-working human-friendly interface.  Using this, users can use the DAMON’s
   major features in a human-friendly way.  It may not be highly tuned for
-  special cases, though.  It supports only virtual address spaces monitoring.
+  special cases, though.  It supports both virtual and physical address spaces
+  monitoring.
 - *debugfs interface.*
   This is for privileged user space programmers who want more optimized use of
   DAMON.  Using this, users can use DAMON’s major features by reading
   from and writing to special debugfs files.  Therefore, you can write and use
   your personalized DAMON debugfs wrapper programs that reads/writes the
   debugfs files instead of you.  The DAMON user space tool is also a reference
-  implementation of such programs.  It supports only virtual address spaces
-  monitoring.
+  implementation of such programs.  It supports both virtual and physical
+  address spaces monitoring.
 - *Kernel Space Programming Interface.*
   This is for kernel space programmers.  Using this, users can utilize every
   feature of DAMON most flexibly and efficiently by writing kernel space
@@ -72,20 +73,34 @@ check it again::
     # cat target_ids
     42 4242
 
+Users can also monitor the physical memory address space of the system by
+writing a special keyword, "``paddr\n``" to the file.  Because physical address
+space monitoring doesn't support multiple targets, reading the file will show a
+fake value, ``42``, as below::
+
+    # cd <debugfs>/damon
+    # echo paddr > target_ids
+    # cat target_ids
+    42
+
 Note that setting the target ids doesn't start the monitoring.
 
 
 Initial Monitoring Target Regions
 ---------------------------------
 
-In case of the debugfs based monitoring, DAMON automatically sets and updates
-the monitoring target regions so that entire memory mappings of target
+In case of the virtual address space monitoring, DAMON automatically sets and
+updates the monitoring target regions so that entire memory mappings of target
 processes can be covered.  However, users can want to limit the monitoring
 region to specific address ranges, such as the heap, the stack, or specific
 file-mapped area.  Or, some users can know the initial access pattern of their
 workloads and therefore want to set optimal initial regions for the 'adaptive
 regions adjustment'.
 
+In contrast, DAMON do not automatically sets and updates the monitoring target
+regions in case of physical memory monitoring.  Therefore, users should set the
+monitoring target regions by themselves.
+
 In such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the ``init_regions`` file.  Each line
 of the input should represent one region in below form.::
diff --git a/Documentation/vm/damon/design.rst b/Documentation/vm/damon/design.rst
index b05159c295f4..210f0f50efd8 100644
--- a/Documentation/vm/damon/design.rst
+++ b/Documentation/vm/damon/design.rst
@@ -35,13 +35,17 @@ two parts:
 1. Identification of the monitoring target address range for the address space.
 2. Access check of specific address range in the target space.
 
-DAMON currently provides the implementation of the primitives for only the
-virtual address spaces. Below two subsections describe how it works.
+DAMON currently provides the implementations of the primitives for the physical
+and virtual address spaces. Below two subsections describe how those work.
 
 
 VMA-based Target Address Range Construction
 -------------------------------------------
 
+This is only for the virtual address space primitives implementation.  That for
+the physical address space simply asks users to manually set the monitoring
+target address ranges.
+
 Only small parts in the super-huge virtual address space of the processes are
 mapped to the physical memory and accessed.  Thus, tracking the unmapped
 address regions is just wasteful.  However, because DAMON can deal with some
@@ -71,15 +75,18 @@ to make a reasonable trade-off.  Below shows this in detail::
 PTE Accessed-bit Based Access Check
 -----------------------------------
 
-The implementation for the virtual address space uses PTE Accessed-bit for
-basic access checks.  It finds the relevant PTE Accessed bit from the address
-by walking the page table for the target task of the address.  In this way, the
-implementation finds and clears the bit for next sampling target address and
-checks whether the bit set again after one sampling period.  This could disturb
-other kernel subsystems using the Accessed bits, namely Idle page tracking and
-the reclaim logic.  To avoid such disturbances, DAMON makes it mutually
-exclusive with Idle page tracking and uses ``PG_idle`` and ``PG_young`` page
-flags to solve the conflict with the reclaim logic, as Idle page tracking does.
+Both of the implementations for physical and virtual address spaces use PTE
+Accessed-bit for basic access checks.  Only one difference is the way of
+finding the relevant PTE Accessed bit(s) from the address.  While the
+implementation for the virtual address walks the page table for the target task
+of the address, the implementation for the physical address walks every page
+table having a mapping to the address.  In this way, the implementations find
+and clear the bit(s) for next sampling target address and checks whether the
+bit(s) set again after one sampling period.  This could disturb other kernel
+subsystems using the Accessed bits, namely Idle page tracking and the reclaim
+logic.  To avoid such disturbances, DAMON makes it mutually exclusive with Idle
+page tracking and uses ``PG_idle`` and ``PG_young`` page flags to solve the
+conflict with the reclaim logic, as Idle page tracking does.
 
 
 Address Space Independent Core Mechanisms
diff --git a/Documentation/vm/damon/faq.rst b/Documentation/vm/damon/faq.rst
index cb3d8b585a8b..11aea40eb328 100644
--- a/Documentation/vm/damon/faq.rst
+++ b/Documentation/vm/damon/faq.rst
@@ -36,10 +36,9 @@ constructions and actual access checks can be implemented and configured on the
 DAMON core by the users.  In this way, DAMON users can monitor any address
 space with any access check technique.
 
-Nonetheless, DAMON provides vma tracking and PTE Accessed bit check based
+Nonetheless, DAMON provides vma/rmap tracking and PTE Accessed bit check based
 implementations of the address space dependent functions for the virtual memory
-by default, for a reference and convenient use.  In near future, we will
-provide those for physical memory address space.
+and the physical memory by default, for a reference and convenient use.
 
 
 Can I simply monitor page granularity?
-- 
2.17.1

