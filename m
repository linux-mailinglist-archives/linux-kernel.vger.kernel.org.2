Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130DC39EBBF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFHB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:58:14 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43551 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhFHB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:58:12 -0400
Received: by mail-pg1-f181.google.com with SMTP id e22so15257636pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EEGe9Ooze4GaX83CqyBjOJjYKqAJ6kwJsMnPkif2OY=;
        b=QbD3d+SJyUQo4eXzNBP1b/6gLP4lu/LxZQ86ATRlGCjgMCqzm3Zf9UKwZv7eaoiFkw
         qtHrIVEMhZVcLWLxogpZnYl8pG5VjBl5NZB+HCvWbM6JgP4gdhBa3jvJsQyU3YrOk1bS
         l7XZFeBefB6KmuwkIBOMgBFcmx2hLNxtuIPyBRksZSTimd8Gv5b2ZyXg0QZ8NVqyxW2z
         mnHttAJRh69h79IeMRNQAnvv4OkKs5CCMI5zIHN6EM6TVtiZA0SshOVfsdTEjPpmmUT3
         CH5VG8Hji0LiMUwKEsaT056iDzXHKSlCXD8LebsOYX6yY2G5nGmj02XP2SanbtT6idfy
         p1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EEGe9Ooze4GaX83CqyBjOJjYKqAJ6kwJsMnPkif2OY=;
        b=ml4zZJ5tcKCy8zOaCVM5HOCGy+vHOhvlll2G2lenSjxzQXJ4EHBfV8kBKOL2cHwK9l
         K6hTZ4hfQuLRnpqIxkRsD2h4GOoNJz4ydlyo3JtkeJkubUEPRth6X3CFRLTWN3g77fgn
         OAjfLvoNnlb+O9xmtm/yUkj6u4egJchCFw0Gy5MIKMc7fue47rHuc3EoQrXlUN+KPWvx
         RsfBlnWyNX3xW4NiFfPLyx2FytoGIC02wpiVaYCmrkrTPrXn9/YWaDX5sGCVNAwEOCi0
         hR23oxtJ6Jj/ai9ydPs7W2U6A4eHlRijpl9XuNT+KEiaDBdQwMnTHUG6mVXyv8mkit6t
         hQVg==
X-Gm-Message-State: AOAM53279qibUehCW4Yhy7aacYSIrESA/9xOT1DAQpGqJLSLqcqZyONX
        m2lNiD/2yxY3my7cYPmqTm4SaX+E1CGOnQ==
X-Google-Smtp-Source: ABdhPJw3HEe1Vqciw+ZEa16TSM4Oui/l4o31zfLOYckW9DnqQPDsfThgkLzlxaSnf8dfTMVfpyUGAw==
X-Received: by 2002:a63:fa03:: with SMTP id y3mr20520339pgh.389.1623117320402;
        Mon, 07 Jun 2021 18:55:20 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:19 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] iommu/amd: Enable page-selective flushes
Date:   Mon,  7 Jun 2021 11:25:35 -0700
Message-Id: <20210607182541.119756-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

--- 

v2->v3:
* Rebase on v5.13-rc5
* Refactoring (patches 4-5) [Robin]
* Rework flush logic (patch 5): more relaxed on native
* Syncing once on scatter-gather operations (patch 6)

v1->v2:
* Rebase on v5.13-rc3

Nadav Amit (5):
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not use flush-queue when NpCache is on
  iommu: Factor iommu_iotlb_gather_is_disjoint() out
  iommu/amd: Tailored gather logic for AMD
  iommu/amd: Sync once for scatter-gather operations

Robin Murphy (1):
  iommu: Improve iommu_iotlb_gather helpers

 drivers/iommu/amd/init.c  |  7 +++-
 drivers/iommu/amd/iommu.c | 72 ++++++++++++++++++++++++++++++---
 drivers/iommu/mtk_iommu.c |  5 +--
 include/linux/iommu.h     | 84 +++++++++++++++++++++++++++++++++------
 4 files changed, 145 insertions(+), 23 deletions(-)

-- 
2.25.1

