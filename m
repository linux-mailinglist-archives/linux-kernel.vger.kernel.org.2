Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CF13D3E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhGWQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGWQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137BC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:01:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m1so3124994pjv.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRqyEQwSK8a5VcDxoLq6e7E7eMl32a4nXuP9u56Czfo=;
        b=KpDExJjZyn7jvGFCVe55uegQnxofh0kPe/1E6j4MZBAM1crjYg/2eOTUd3ukJGMFXA
         gAc8qpTOvA8r6CQCaOoy5OQ0g6PYsMnTZx5NUfjamX3K6iZBqCsYeGG4PgH1Inrr8ULu
         a+cD9vo0Ly8k1NyosxtewTmGJ0B/U1yxFGKY2zOEpQHGNmP6CYAAcakvUwIqSPfnzUoy
         AEoMRVqtL9NHGV6Bx4/wjV54Qn9kUuCrcTI+ET7Xp4gg/3UAk18QO9PRv/DiLNhla1uZ
         9zJxQBR6ZZSh7HLt2lnEnuTbgpIFa8pY/02eGUwdVP6vOZGBqaK7i/45RhKiQWWFBBEX
         JAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRqyEQwSK8a5VcDxoLq6e7E7eMl32a4nXuP9u56Czfo=;
        b=iC4E1S0OgPUYC8BVnxv4VzPCia+5VLBkpF5kFfbCZf94kX2x23OoJ5bLTX9jq7CN/p
         hVNMmy0lV2M4if9Lk8Fn4L4RfqRplF9f81p3HTNqAek3/9c4l97LTaZw8uIhroW65akN
         PUOVbah5q1Elr1uZgzJCmvkgIY3XblhY4FRJMHkMu+tSZw0yyL0wLYDi3Kb616gssCJ0
         ft2BOkRqlQtU0K3H8KVsWFKK63N306IQyEFUATgeFkLHXj/fjTzYiDz5wmRfnRrSiZVe
         1HsHXBN6rNjFu4rGrx2Xe29bklHYSgzL57DtW3kz4VTJJoTbA82Hdjaf+vMGmiSPkylE
         RVgA==
X-Gm-Message-State: AOAM533t8cfYDuV9jRLoEYo8DlbUqz7vSkAeCQwVT35DYxidgOxK7fk/
        S8UomramcB2a6+61rwR7tE0OI5D2EnBDAQ==
X-Google-Smtp-Source: ABdhPJwu0sEFw0GJ5VQokSq9OuxyiT8DW6fSoZg7H7iZyjLKoGiZtzQ6uwlxp+ySB3GFkSCMem08Zw==
X-Received: by 2002:a63:a558:: with SMTP id r24mr5741972pgu.438.1627059718026;
        Fri, 23 Jul 2021 10:01:58 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:01:57 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] iommu/amd: Enable page-selective flushes
Date:   Fri, 23 Jul 2021 02:32:02 -0700
Message-Id: <20210723093209.714328-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The previous patch, commit 268aa4548277 ("iommu/amd: Page-specific
invalidations for more than one page") was supposed to enable
page-selective IOTLB flushes on AMD.

Besides the bug that was already fixed by commit a017c567915f
("iommu/amd: Fix wrong parentheses on page-specific invalidations")
there are several remaining matters to enable and benefit from
page-selective IOTLB flushes on AMD:

1. Enable selective flushes on unmap (patch 1)
2. Avoid using flush-queue on vIOMMUs (patch 2)
3. Relaxed flushes when gathering, excluding vIOMMUs (patches 3-5)
4. Syncing once on scatter-gather map operations (patch 6)
5. Breaking flushes to naturally aligned ranges on vIOMMU (patch 7)

The main difference in this version is that the logic that flushes
vIOMMU was improved based on Robin's feedback. Batching decisions are
not based on alignment anymore, but instead the flushing range is broken
into naturally aligned regions on sync. Doing so allows us to flush only
the entries that we modified with the minimal number of flushes.

Robin, others: your feedback would be highly appreciated to get these
patches merge.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

---

v5->v6:
* Remove redundant check on amd_iommu_iotlb_gather_add_page() [Robin]
* Add Robin's reviewed-by tags

v4->v5:
* Rebase on v5.14-rc1
* Change pr_warn() to pr_info() [John Garry]

v3->v4:
* Breaking flushes to naturally aligned ranges on vIOMMU [Robin]
* Removing unnecessary stubs; fixing comment [Robin]
* Removing unused variable [Yong]
* Changing pr_warn_once() to pr_warn() [Robin]
* Improving commit log [Will]

v2->v3:
* Rebase on v5.13-rc5
* Refactoring (patches 4-5) [Robin]
* Rework flush logic (patch 5): more relaxed on native
* Syncing once on scatter-gather operations (patch 6)

v1->v2:
* Rebase on v5.13-rc3

Nadav Amit (6):
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not use flush-queue when NpCache is on
  iommu: Factor iommu_iotlb_gather_is_disjoint() out
  iommu/amd: Tailored gather logic for AMD
  iommu/amd: Sync once for scatter-gather operations
  iommu/amd: Use only natural aligned flushes in a VM

Robin Murphy (1):
  iommu: Improve iommu_iotlb_gather helpers

 drivers/iommu/amd/init.c  |  7 ++-
 drivers/iommu/amd/iommu.c | 96 +++++++++++++++++++++++++++++++++++----
 drivers/iommu/mtk_iommu.c |  6 +--
 include/linux/iommu.h     | 72 +++++++++++++++++++++++------
 4 files changed, 153 insertions(+), 28 deletions(-)

-- 
2.25.1

