Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1383AA275
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFPRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so4438623pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ndv/CKBKWeZLGFITwYmA/LrS0ISEm1en6ZoDc/lnmnM=;
        b=lZBfDvvWzFAzf4Ab0IQdP3N1xb84xSuyTdRiGY3kzvaFhQKHITW1O8ia/0R+O7CVDT
         fnoFfGPPM4DVROl2yCRQR/5BYgQFpNOobG+b54vQjV5cEsRKqLqU6uZBu3jIGdV+yjkX
         dlOYuAW+cuSdaCaTDxMcXtHpfoohc2qLCrwgHQ/Z5Viy2a4c/86RWJlStPwfeQdgacAq
         TE9I786FgA3aI2OdYcpFPXsgUS9+0k+LBs6wSF421VApYV40Rwoy++7vuq4fXez+yaH7
         dsNhSLWHopSF6HhaUgM3uenPg1rGuFoFY3LrAciWMsFxidEznML6TbtHiXAmfT+FOdHZ
         TSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ndv/CKBKWeZLGFITwYmA/LrS0ISEm1en6ZoDc/lnmnM=;
        b=okVIph2mA06DQJ/hTGzXiytsOIxvUOUnzyJN5vOUkNGc0gUoPx5XvgHsrTLgWOXncu
         +vpWj1Upf9gjaALSBffIv5PNRLiiWgflR8tAXIou0eLmirhKrIANN9uZ5f+asAGPHzgR
         ENZKfDxigpjflj/a39K2kTVoHH3SAQodynik7G4Dxl5lq3fwFL6w1sWoLTTbkIgzAAmc
         xURtU/ASNAlyqLtpMo2Sx3RNAg/hz0edbFQRelkWEvQqmyjfgVgRnLIkh6auQZ4d/VV7
         ZKMqYtMWPKwbPUGttzVQ2XthVArVK22+p4HJl+3e8JzAPNazydlxZnlVtKVUuYyKqJJ2
         f0nQ==
X-Gm-Message-State: AOAM533XVXRnrtR6D1PzmpfYRANclfwCoOOaKYRhvElSGm6XaZIniPdI
        fxnrWpexl8DNFkxJmGyl6Rw=
X-Google-Smtp-Source: ABdhPJwchOz3b9uNdjbyFvbmTtwXO6fZ9OX/aRp1x8R3ip9DPpfONPoVr7bQ30ZWpFubf5YWF6omeQ==
X-Received: by 2002:a17:902:6b04:b029:10d:8c9e:5f56 with SMTP id o4-20020a1709026b04b029010d8c9e5f56mr692857plk.8.1623864863480;
        Wed, 16 Jun 2021 10:34:23 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:22 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] iommu/amd: Enable page-selective flushes
Date:   Wed, 16 Jun 2021 03:04:53 -0700
Message-Id: <20210616100500.174507-1-namit@vmware.com>
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

---

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

