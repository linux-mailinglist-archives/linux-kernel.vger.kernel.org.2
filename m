Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C173E3C75AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhGMR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhGMR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386CC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v14so4510316plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNw+zYjGLCxUN5d1sFI6uhg5qD8hAV6e7VF77djR0Qk=;
        b=LDDeVdQyyCZr+nS6kwbTKuHYesQQ1YAhjGz2GZfqKLu6Yi5m/VheF0U5QOYvl0RhbG
         qdhbnlHrHze2/cy5ZOJpdaGJNzRZWk4Ofs4jAhkvXh8QFjK7j+OZUTUMhrqvnsP+mxQg
         L6fHyxMRW51oS5MkGZiJ3TdRpuOqq+2EVnXew/5kU2O1nMXE5VVVb3+5E44Wo06AVhHk
         b5pO91Anr7Cj6zd6YkGIHNIpuPryoyU+PP6ohojshJGNx9HaieM7r5WINCH0hHtETEHK
         EkJoREgttzxNKlAJlMM0xj2csBr1ieDvT3JkuQ5Wausp1Pu531MTpOC9RPPr8dpM33hr
         B7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNw+zYjGLCxUN5d1sFI6uhg5qD8hAV6e7VF77djR0Qk=;
        b=WjTuMl/OdvTZTrt0vXF+39X0ljwK8LTMTT9GSRlpzukNQYQX8ZA9DGZ67LIvKb/irA
         kJBzbEyjvKn+MGcRWe/X2AYknJJDIb5aE644+zp0aWxr7rb4NHJfW/kQNSjNwpYnXYEd
         EJoIhz0rksqBI6tKnfaTgUVFUWl4wv+IqMOBUbLoo4TtjGzwLNz5ew/xfIR8wyakd+29
         E3khKPAhiC/1z8V18ZFemzqnOWoL6P8APv7WhXV3zEBh2cfOwOerDzYWdghWRu+eYIJA
         2UXtTvcePE619ztUwytSgA/PVgRJ2uIPsMNaHlFhT8zX2kuHt6VGl/WWhqCzUNCtJbJ5
         KdUQ==
X-Gm-Message-State: AOAM532ZP2L7bgEVBpWpnQig6R6NuByorOL4t9TuwkQNtE8EsuiwoWsC
        eu9v0Xsx2cY+aGlKoRCJ8sU=
X-Google-Smtp-Source: ABdhPJz5YQFne3dqlopytY9Q2+i2Tn62pz8b0WFr2DgcZe4rnbm+JtKjnl8C4fpxxLg33OKcCZPwvg==
X-Received: by 2002:a17:90a:5892:: with SMTP id j18mr5454749pji.18.1626197088123;
        Tue, 13 Jul 2021 10:24:48 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:47 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] iommu/amd: Enable page-selective flushes
Date:   Tue, 13 Jul 2021 02:41:44 -0700
Message-Id: <20210713094151.652597-1-namit@vmware.com>
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

