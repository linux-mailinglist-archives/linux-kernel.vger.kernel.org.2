Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49BF3068C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhA1AlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhA1AjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:39:24 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00EEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l17so2374791pff.17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
        b=ika8x4rgJdL4GFh0YJshUwWatHQjTXQ6jtilrMjzjB5sX9mt0EINzDY8IG5gykxg+V
         gtt0xZreieN+Cl9Zk4vH0z+L75qd0s7an5EkYb64eAua3UBdHun+3RuVtNay74rRmljF
         w5FPFyJlgdiwd0MdSbvafLRju/MC00+cfc/WbLCEtHZUfpqz6G5N0GL3pImWJyq728PK
         YpGO0gtXK2jnCNQoOP//2fEhqOtPi8l/Kif+ts7PTih+MaXF9ASUVT2b7QL1viThPJSu
         nBl/vQz8MYZ+b63p0HxtEj+3y1yHtHp8vbQsXi2xfJj8uwDwMO5ETL38SDXURD71ibF7
         ChIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=jmVH+B5byuoeCWBByF+rlgs1IXxlR3I67Dpk6zRz3g4=;
        b=hcBBdjZtIPH/NpZaOz+DRDGBGD7FOqVpwk3PbiOQaKkF8+U3IYOkPEF+H0/KJB12VM
         5r1zNuryAblj8Nmc00DbqrjUGfz9OwqrdoZoYwmfTV2kdJFi5fJDrxgidfD/paNMvSFt
         dlY4QFNrOE7cT99W8DN3gLO6/N7Fn4s0XW27d9RAxUHkyBHZoMNfMISjwZEb5sveh6KJ
         f2Rd7yXkbN+He1dDGN+vIpNM0UoFob51ug4ruY57QOqCqvxOZeh2fRnogL2ZC6Yf4zq/
         byZRaYmJOT0D7VCH//PNZbQHyDBh9woUgHPK1PEopYzLEojdGBJzK99+Aq8QU4J82Zow
         ZwBw==
X-Gm-Message-State: AOAM5306X9aq583PpNr6c2HZ67aHJ2ZWz++x+k42/uqu6i4SR6WUxe9E
        L8hEVRr/VRZtG5LL71C+CuAcuvdumw==
X-Google-Smtp-Source: ABdhPJxZSrbWZzQDr55mdPo+6c30/Ybjdp+n6lXqVs1jxzQEstypPUxE0mNfzMHFA3Zn+gC3p6cqscaGjw==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a17:902:67:b029:de:c5e0:87ca with SMTP id
 94-20020a1709020067b02900dec5e087camr13986024pla.64.1611794321730; Wed, 27
 Jan 2021 16:38:41 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:38:26 -0800
Message-Id: <20210128003829.1892018-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/3] Adding offset keeping option when mapping data via SWIOTLB.*
From:   Jianxiong Gao <jxgao@google.com>
To:     jxgao@google.com, erdemaktas@google.com, marcorr@google.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
patch adds an option to make sure the mapped data preserves its
offset of the orginal addrss.

Without the patch when creating xfs formatted disk on NVMe backends,
with swiotlb=force in kernel boot option, creates the following error:
meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=0, rmapbt=0, refl
ink=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
mkfs.xfs: pwrite failed: Input/output error

Jianxiong Gao (3):
  Adding page_offset_mask to device_dma_parameters
  Add swiotlb offset preserving mapping when
    dma_dma_parameters->page_offset_mask is non zero.
  Adding device_dma_parameters->offset_preserve_mask to NVMe driver.

 drivers/nvme/host/pci.c     |  4 ++++
 include/linux/device.h      |  1 +
 include/linux/dma-mapping.h | 17 +++++++++++++++++
 kernel/dma/swiotlb.c        | 16 +++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.27.0

