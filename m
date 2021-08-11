Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D03E8819
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhHKCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhHKCoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E256C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so7317842pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qegFIKnQxZw4wxrrKT+itOQUvH07gg9i31emr5EQUb4=;
        b=RpTikaOmvpWwhBu76RwlPbsObyEP8VBGJW4O3kl7/3R7kPEt0F1chIpOfr1IjPjQBa
         vpanoB+b2m/11+QKLDdu4+wX35ur2FG5V/fzPTeWDmrryi4W1iBRn+DMCB6FL3kdI+Tn
         0pjynKjbONb2PPmb3boUZFiwjIRHZ0pyXeizQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qegFIKnQxZw4wxrrKT+itOQUvH07gg9i31emr5EQUb4=;
        b=DIthkwEXRslaJuxhzdnvvJX4qm4gnFfrehXBXikeZi69m6eenTBLL3UhsB1pj0jLpf
         CyNjE/2NmYGrYf/BKu490HQTxqs0UPpkBzVoHd07bF0ffPZ/85dDrt0GK/tFq9cl2z4R
         7iyxI+6LANl6fXI5x6mSrK2qVTmbZYv9f+sC0vC7/OOYdNLljD5fSsWczBo1WpTNAUHY
         FTwjRPGJCUKeIcIJxuTRvRgfW5FgPFkwoXdQQ1zVd7ueQPirWeQmx7SvXGRFyxeEFqOR
         Mbl032FtzvOjHPVW1KrRoYLEaJ3NQ5oh4mY5ZH/NQJe+TDaRb+xqOM1lCNX3U/vByi5R
         1vHg==
X-Gm-Message-State: AOAM533j5xgO6+BzLIT7GuxnWzseqNHta2XLMXq4SHtx//FsvouVObWS
        41DxHgxBA7Acijg5R0XSbyQ9zA==
X-Google-Smtp-Source: ABdhPJxpAtpMRVCkIy0CeKRG1iq4BSx19vJTWB5BGIzxIogqH5LE+bVlWj3wiiCx6ViPagQt5ibgjw==
X-Received: by 2002:a17:90a:c8c:: with SMTP id v12mr8177299pja.37.1628649847154;
        Tue, 10 Aug 2021 19:44:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
        by smtp.gmail.com with UTF8SMTPSA id t9sm32800688pgc.81.2021.08.10.19.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 19:44:06 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 0/5] Fixes for dma-iommu swiotlb bounce buffers
Date:   Wed, 11 Aug 2021 11:42:42 +0900
Message-Id: <20210811024247.1144246-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch set includes various fixes for dma-iommu's swiotlb bounce
buffers for untrusted devices. There are three fixes for correctness
issues, one performance issue, and one general cleanup.

The min_align_mask issue was found when running fio on an untrusted nvme
device with bs=512. The other issues were found via code inspection, so
I don't have any specific use cases where things were not working, nor
any concrete performance numbers.

v2 -> v3:
 - Add new patch to address min_align_mask bug
 - Set SKIP_CPU_SYNC flag after syncing in map/unmap
 - Properly call arch_sync_dma_for_cpu in iommu_dma_sync_sg_for_cpu

v1 -> v2:
 - Split fixes into dedicated patches
 - Less invasive changes to fix arch_sync when mapping
 - Leave dev_is_untrusted check for strict iommu

David Stevens (5):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map
  dma-iommu: add SKIP_CPU_SYNC after syncing
  dma-iommu: Check CONFIG_SWIOTLB more broadly
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 97 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

-- 
2.32.0.605.g8dce9f2422-goog

