Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8B314547
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBIBKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:10:05 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6565 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhBIBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:10:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021e0c10002>; Mon, 08 Feb 2021 17:09:21 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 01:09:21 +0000
Received: from localhost (172.20.145.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021 01:09:20
 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm-ppc@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <jhubbard@nvidia.com>, <rcampbell@nvidia.com>,
        <jglisse@redhat.com>, "Alistair Popple" <apopple@nvidia.com>
Subject: [PATCH 0/9] Add support for SVM atomics in Nouveau
Date:   Tue, 9 Feb 2021 12:07:13 +1100
Message-ID: <20210209010722.13839-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612832961; bh=fHzIrA6EUkcvyYZOzc2r5U/q2OlDx68NlFICQTs7dQ8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=JLn42Im7IWDEnuTDb+HAfmg21WCbnWEbIR0KYAxMkB56Xg+hXwpVMRWJJRpoQRHJa
         huf1OdR0WZ/xbBkkJUUvfEpMrTL1a5eUkJvtZpjNYotNPcpHubOEIwYsPQWQwTlOxO
         jybuOYXvAGRV+8LewjvSBZSReyU0Uwa0ZRMllU/kW0/RgIx1LjmT0zt3MKIYYamXOK
         pB30alYCHMQ0EXloW6/GydUcrRRaxaCIdqaauza/x+VFBXw1WCAhGJL+cD9g6rHI7u
         K2FsmBZ+Lca4vpaXoQR0qV/i4FwObqrVWHlQXKPTDH/AljdLXGbV8p9MZ6wUzY0KkI
         TsL/93w80i8dw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to Nouveau for atomic memory operations on OpenCL
shared virtual memory (SVM). This is achieved using the atomic PTE bits on
the GPU to only permit atomic operations to system memory when a page is
not mapped in userspace on the CPU.

This is implemented by adding a mode to migrate_vma_pages() which unmaps
and isolates existing pages from the CPU and pins them. The original
userspace page table entries are migrated to point to device private pages
allocated by the driver. This allows the driver to enable GPU atomic access
to the page as it will receive a callback when CPU userspace needs to
access it.

In response to this callback the driver revokes the atomic access
permission from the GPU and migrates entries to point back to the original
page. The original page is unpinned as part of the migration operation
which also returns it to the LRU.

Patch 3 contains the bulk of the memory management changes to implement
unmap and pin.

Patches 6-9 extend Nouveau to use the new mode to allow system wide atomics
for OpenCL SVM to be implemented on Nouveau.

This has been tested using the latest upstream Mesa userspace with a simple
OpenCL test program which checks the results of atomic GPU operations on a
buffer whilst also writing to the same buffer from the CPU.

Problems yet to be addressed:

Recent changes to pin_user_pages() prevent the creation of pinned pages in
ZONE_MOVABLE. This series allows pinned pages to be created in ZONE_MOVABLE
as attempts to migrate may fail which would be fatal to userspace.

In this case migration of the pinned page is unnecessary as the page can be
unpinned at anytime by having the driver revoke atomic permission as it
does for the migrate_to_ram() callback. However a method of calling this
when memory needs to be moved has yet to be resolved so any discussion is
welcome.

Alistair Popple (9):
  mm/migrate.c: Always allow device private pages to migrate
  mm/migrate.c: Allow pfn flags to be passed to migrate_vma_setup()
  mm/migrate: Add a unmap and pin migration mode
  Documentation: Add unmap and pin to HMM
  hmm-tests: Add test for unmap and pin
  nouveau/dmem: Only map migrating pages
  nouveau/svm: Refactor nouveau_range_fault
  nouveau/dmem: Add support for multiple page types
  nouveau/svm: Implement atomic SVM access

 Documentation/vm/hmm.rst                      |  22 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c            |   4 +-
 drivers/gpu/drm/nouveau/include/nvif/if000c.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c        | 190 +++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_dmem.h        |   9 +
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 148 +++++++++++---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h |   1 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |   6 +
 include/linux/migrate.h                       |   2 +
 include/linux/migrate_mode.h                  |   1 +
 lib/test_hmm.c                                | 109 ++++++++--
 lib/test_hmm_uapi.h                           |   1 +
 mm/migrate.c                                  |  82 +++++---
 tools/testing/selftests/vm/hmm-tests.c        |  49 +++++
 14 files changed, 524 insertions(+), 101 deletions(-)

--=20
2.20.1

