Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E654341EDEC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJAM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhJAM55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:57:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A040D61A83;
        Fri,  1 Oct 2021 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092973;
        bh=i3wWGOOEmKmXHqCyVU2+U7UgkYZRj4bRP5WgsDEYdis=;
        h=From:To:Cc:Subject:Date:From;
        b=OUQzdC6vmsowD9c3WEY5zdZwe9kZK+FxiofXaYgyKPCzq2ZG5Yw5eHr6zrr251ef9
         7+8mCT8vLjYvWzp+HccrsmPgj5oTT2QCWQxEnCEa9AVkkuiHl4Ks6PAPX2ek0BsWfW
         jyg8v6So+aYl7NDn8aF3SZCgQ1QDyEsYQoAajxYQC5c0+e6MLqjgdv2J6Gci9PlhV2
         ur9AAGyzVf8ItEQuJs1B+zOrODbhygwJucJJw25/1oLQ2zq82WnC6rHNeMCBmC6L0Y
         x/WY+bzPqtx5m0xsow6trv9jSAZAPMEyCb5GOxpc6G2fsqMhi3TQUk20iuj2ejxQig
         Q+lrbtsvRvBFg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Fri,  1 Oct 2021 12:55:57 +0000
Message-Id: <20211001125604.29660-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from Previous Version (RFC[1])
======================================

- Rebase on latest -mm tree

[1] https://lore.kernel.org/linux-mm/20201216084404.23183-1-sjpark@amazon.com/

Introduction
============

DAMON[1] can be used as a primitive for data access aware memory management
optimizations.  For that, users who want such optimizations should run DAMON,
read the monitoring results, analyze it, plan a new memory management scheme,
and apply the new scheme by themselves.  Such efforts will be inevitable for
some complicated optimizations.

However, in many other cases, the users would simply want the system to apply a
memory management action to a memory region of a specific size having a
specific access frequency for a specific time.  For example, "page out a memory
region larger than 100 MiB keeping only rare accesses more than 2 minutes", or
"Do not use THP for a memory region larger than 2 MiB rarely accessed for more
than 1 seconds".

To make the works easier and non-redundant, this patchset implements a new
feature of DAMON, which is called Data Access Monitoring-based Operation
Schemes (DAMOS).  Using the feature, users can describe the normal schemes in a
simple way and ask DAMON to execute those on its own.

[1] https://damonitor.github.io

Evaluations
===========

DAMOS is accurate and useful for memory management optimizations.  An
experimental DAMON-based operation scheme for THP, 'ethp', removes 76.15% of
THP memory overheads while preserving 51.25% of THP speedup.  Another
experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
reduces 93.38% of residential sets and 23.63% of system memory footprint while
incurring only 1.22% runtime overhead in the best case (parsec3/freqmine).

NOTE that the experimental THP optimization and proactive reclamation are not
for production but only for proof of concepts.

Please refer to the showcase web site's evaluation document[1] for detailed
evaluation setup and results.

[1] https://damonitor.github.io/doc/html/v34/vm/damon/eval.html

Baseline and Complete Git Tree
==============================

The patches are based on the latest -mm tree
(v5.15-rc3-mmots-2021-09-30-19-38)[1].  You can also clone the complete git
tree:

    $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git -b damos/patches/v1

The web is also available:
https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tag/?h=damos/patches/v1

[1] https://github.com/hnaz/linux-mm/tree/v5.15-rc3-mmots-2021-09-30-19-38

Development Trees
-----------------

There are a couple of trees for entire DAMON patchset series.

- For latest release: https://git.kernel.org/sj/h/damon/master
- For next release: https://git.kernel.org/sj/h/damon/next

Long-term Support Trees
-----------------------

For people who want to test DAMON but using LTS kernels, there are another
couple of trees based on two latest LTS kernels respectively and containing the
'damon/master' backports.

- For v5.4.y: https://git.kernel.org/sj/h/damon/for-v5.4.y
- For v5.10.y: https://git.kernel.org/sj/h/damon/for-v5.10.y

Sequence Of Patches
===================

The 1st patch accounts age of each region.  The 2nd patch implements the core
of the DAMON-based operation schemes feature.  The 3rd patch makes the default
monitoring primitives for virtual address spaces to support the schemes.  From
this point, the kernel space users can use DAMOS.  The 4th patch exports the
feature to the user space via the debugfs interface.  The 5th patch implements
schemes statistics feature for easier tuning of the schemes and runtime access
pattern analysis, and the 6th patch adds selftests for these changes.  Finally,
the 7th patch documents this new feature.

Patch History
=============

Changes from RFC v15.1
(https://lore.kernel.org/linux-mm/20201216084404.23183-1-sjpark@amazon.com/)
- Rebase on latest -mm tree

Please refer to RFC v15.1 for previous history.

SeongJae Park (7):
  mm/damon/core: Account age of target regions
  mm/damon/core: Implement DAMON-based Operation Schemes (DAMOS)
  mm/damon/vaddr: Support DAMON-based Operation Schemes
  mm/damon/dbgfs: Support DAMON-based Operation Schemes
  mm/damon/schemes: Implement statistics feature
  selftests/damon: Add 'schemes' debugfs tests
  Docs/admin-guide/mm/damon: Document DAMON-based Operation Schemes

 Documentation/admin-guide/mm/damon/start.rst  |  11 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  51 +++++-
 include/linux/damon.h                         |  86 +++++++++
 mm/damon/core.c                               | 127 ++++++++++++++
 mm/damon/dbgfs.c                              | 166 +++++++++++++++++-
 mm/damon/vaddr.c                              |  58 ++++++
 .../testing/selftests/damon/debugfs_attrs.sh  |  13 ++
 7 files changed, 507 insertions(+), 5 deletions(-)

-- 
2.17.1

