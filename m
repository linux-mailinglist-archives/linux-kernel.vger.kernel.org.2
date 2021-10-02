Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83B41F91B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 03:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhJBBVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhJBBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 21:21:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1002C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 18:19:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so10555815pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aXTpsgwefS9FjUBmruzpl69mLwyzpoyIy9pYOBOwR6E=;
        b=isQPBvIbRcj7jMCawK8NBi6iXKFkgh7LMYGFehd/UVjbT/KT4vJLmr+KQhi8dm5Nd+
         QUaqn1gsiad9y3m48SiPTEi+ynUTJlJOIUJGkf4O9awIEKgIDr9DCkULV3LEl1hXoo+9
         Yng+of4AtymWeKnwgLS8ycd+FGBIpI7G/pIuC7qKZfKMQIMlH0aqAF7ubKT1tgCJgT8i
         c+8yFignuCOZnHJj+JzVTAZ6mBC/MxDyQHJSXt7VIa5YrxMTRDyKwXjM5V9Q0Bc9MKJF
         /SEoTqKHttkZF93Tuxnlgs/k+n9C9ZzFS5jyIZcWA1xUwBvpQFsUS5NE/Yy8i8jBUcBn
         yUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aXTpsgwefS9FjUBmruzpl69mLwyzpoyIy9pYOBOwR6E=;
        b=wl+NIMwkrK91yXeQ902SmDKx3Skz3xeh66mpdBktPgsvvurF8qfOabzhIBMyuJFwSM
         ikgHKsY2X6Ur/KHdNGaINP9tInD9zLy7ue3YPfTu0wfVMMs0JpVfy/eD+cwbjIFf6buL
         TkBFKtlOIfcJCBs4xEWTC+LLFlhSppGY/UrAR0QT+FYPHYsZZm5DQgmFrOTyqU2MuRW1
         avemqd3qDx+E66zvmaR+rKRSZg5PFCjWjJFq5U5blW8OWQ5xebYCNwUMeqDZmioGSqbL
         CRzrqEbmeYUXLDbAQQRCCmpq/thB9BFjTJGpb+AxtXksB1cWukT8kjqRnRHrp2MX1sZT
         fPug==
X-Gm-Message-State: AOAM531WtL31YyugnrX/zVnbTHqjWMnQMH2O6BB7iDCMgrRZzzYjtdBD
        EwgSEy/7JhmEBMtrJ3bpNynylcIOCoJ5g4F1Eu4VEXc/xSf8mg==
X-Google-Smtp-Source: ABdhPJy8why/nFvpoAdWHRvrYyGtF5XaGSuamMCitKXoR2UFihU44ob4ierB9fkn1vARcWPZkaIyQMNNGhXAFjf/M1k=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr16605771pjb.220.1633137561353;
 Fri, 01 Oct 2021 18:19:21 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Oct 2021 18:19:12 -0700
Message-ID: <CAPcyv4iEHttW7fDzaKYdAr2t4w3YJQ7t7QtadO0bZKDWPuK0Ag@mail.gmail.com>
Subject: [GIT PULL] nvdimm fixes for v5.15-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.15-rc4

...to receive a fix for a regression added this cycle in the pmem
driver, and for a long standing bug for failed NUMA node lookups on
ARM64.

This has appeared in -next for several days with no reported issues.

Please pull, thanks.

---

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.15-rc4

for you to fetch changes up to d55174cccac2e4c2a58ff68b6b573fc0836f73bd:

  nvdimm/pmem: fix creating the dax group (2021-09-27 11:40:43 -0700)

----------------------------------------------------------------
libnvdimm fixes for v5.15-rc4

- Fix a regression that caused the sysfs ABI for pmem block devices to
  not be registered. This fails the nvdimm unit tests and dax xfstests.

- Fix numa node lookups for dax-kmem memory (device-dax memory assigned
  to the page allocator) on ARM64.

----------------------------------------------------------------
Christoph Hellwig (1):
      nvdimm/pmem: fix creating the dax group

Jia He (1):
      ACPI: NFIT: Use fallback node id when numa info in NFIT table is incorrect

 drivers/acpi/nfit/core.c | 12 ++++++++++++
 drivers/nvdimm/pmem.c    |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)
