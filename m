Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CAD42AE45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhJLU70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhJLU7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FD1360720;
        Tue, 12 Oct 2021 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072242;
        bh=jEFMjgQZz4+KQgEEsrewnMdWOVsCrfviXlFb0Khr1V0=;
        h=From:To:Cc:Subject:Date:From;
        b=eLVWLQhf46i7fgHPRfTkTmgQKmBxG6sfZKCygPMk17kjOfKkjjQATw29r2Ru6VFr0
         JH3C+bGeN5BueOQz26IkOy9FWTI/liQCCEEdbrzH22Vb9iraDBI+h/ulpUUNOxEa6f
         qy1HQtZuMXGX5UnmlkYAJ+Pk0YfpaGEvckUCMe6RR2kc/yq19mbkE/ivQpc3s/mEO4
         NleKMPSudLMxL+GLv2A8KDF+MCsn2qBjBxdlAVOPlOz12TecJZQs/HBood6S6lKN80
         PGGzdFVgtM0jO9RgaspDoQZpV3KJxyz5Eez0mOlpID9juADUZ+UnwGg49JdDvgJ2nS
         8Y88eNHnqjn+g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] DAMON: Support Physical Memory Address Space Monitoring
Date:   Tue, 12 Oct 2021 20:57:04 +0000
Message-Id: <20211012205711.29216-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from Previous Version (RFC[1])
======================================

- Rebase on latest -mm tree
- Remove page granularity idleness monitoring part

[1] https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/

Introduction
============

DAMON is currently supporting only virtual address spaces monitoring.  It can
be easily extended for various use cases and address spaces by configuring its
monitoring primitives layer to use appropriate primitives implementations,
though.  This patchset implements monitoring primitives for the physical
address space monitoring using the structure.

Baseline and Complete Git Trees
===============================

The patches are based on the latest -mm tree
(v5.15-rc4-mmots-2021-10-10-18-34)[1].  You can also clone the complete git
tree:

    $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git -b damon-paddr/patches/v1

The web is also available:
https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/tag/?h=damon-paddr/patches/v1

[1] https://github.com/hnaz/linux-mm/tree/v5.15-rc4-mmots-2021-10-10-18-34

Sequence of Patches
===================

The first 3 patches allow the user space users manually set the monitoring
regions.  The 1st patch implements the feature in the 'damon-dbgfs'.  Then,
patches for adding a unit tests (the 2nd patch) and updating the documentation
(the 3rd patch) follow.

Following 4 patches implement the physical address space monitoring primitives.
The 4th patch makes some primitive functions for the virtual address spaces
primitives reusable.  The 5th patch implements the physical address space
monitoring primitives.  The 6th patch links the primitives to the
'damon-dbgfs'.  Finally, 7th patch documents this new features.

Patch History
=============

Changes from RFC v10
(https://lore.kernel.org/linux-mm/20201216094221.11898-1-sjpark@amazon.com/)
- Rebase on latest -mm tree
- Remove page granularity idleness monitoring part

Please refer to RFC v10 for previous history.

SeongJae Park (7):
  mm/damon/dbgfs: Allow users to set initial monitoring target regions
  mm/damon/dbgfs-test: Add a unit test case for 'init_regions'
  Docs/admin-guide/mm/damon: Document 'init_regions' feature
  mm/damon/vaddr: Separate commonly usable functions
  mm/damon: Implement primitives for physical address space monitoring
  mm/damon/dbgfs: Support physical memory monitoring
  Docs/DAMON: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/usage.rst |  62 ++++-
 Documentation/vm/damon/design.rst            |  29 ++-
 Documentation/vm/damon/faq.rst               |   5 +-
 include/linux/damon.h                        |  10 +
 mm/damon/Kconfig                             |  10 +-
 mm/damon/Makefile                            |   3 +-
 mm/damon/dbgfs-test.h                        |  54 +++++
 mm/damon/dbgfs.c                             | 177 ++++++++++++++-
 mm/damon/paddr.c                             | 224 +++++++++++++++++++
 mm/damon/prmtv-common.c                      |  88 ++++++++
 mm/damon/prmtv-common.h                      |  17 ++
 mm/damon/vaddr.c                             |  87 +------
 12 files changed, 655 insertions(+), 111 deletions(-)
 create mode 100644 mm/damon/paddr.c
 create mode 100644 mm/damon/prmtv-common.c
 create mode 100644 mm/damon/prmtv-common.h

-- 
2.17.1

