Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93738FA82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhEYGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhEYGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:12:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B598C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f22so14396945pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IdcS0bFy+y6ulhI9jyzfyMDlCSagPAt22qi8j9Vz510=;
        b=mc4IUwZLJpdkM8bbnvHKPA26QdF+Ie2VdMYPxDl7eC3vIr98RQhLTsZbiRzQV4lZV6
         b6rdy5h6snfAVuj2BsDPxPJv4mQfj7sGtfCltHDRuSke2KeyQQpxS6+QvDBjeZBTuCCh
         0PvUc6xRGYUW/6U7gz2fBhTDRSPZyLCrr3fdK0u3bF8TtBdZRi26JGxaA4ZXZmDt1FNn
         fYDS6sWJrW6HnXloZWf3lBGURTFw1NRUoXBdTG6IqIin0yXnGe/9m9SKHe+mqYg+nFSr
         w6Dsrg6whm32mkaNx1jwiUEAiDlWcUcPiDebNsaxn4fdeMho6yqb7wC1Tkv4+sIVf8nf
         tyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IdcS0bFy+y6ulhI9jyzfyMDlCSagPAt22qi8j9Vz510=;
        b=qQRcJr3ElHxbBmoRyY8Yziwm6ZkFwVK7c/SBXc9LT1BBTralTUyPf+BOAQULZwtQUc
         n2v9gKbRwatK+U/ElMRD3Bis2ZEqtAJbtjtI+x37XXG11x9QbmtBpCkczXsVvHPcssia
         jV5N6kJn0XxjsTuaKg9Z6K6FGwELFmMaFgwl4UKSJ2IFhvy14Sp7Z7yyZaDkM6m4s+U3
         zw73Qj3pwT/AQO694DjsEFy0FT7xkYN91RJQKjB/IVGQ1O5ATK3MmR8WboWTbFfSJvjl
         BH4xIOgc5/wkaheA+i6w8U1aqMvWct3RDZDcruGavmp8A4NGLZ6OV3+RnCdLuh7hfptq
         xvrQ==
X-Gm-Message-State: AOAM533oC/XRZTAy+iBoLY9Ae0+ETnWRQ9EnVWhOp9whXyv/122zq6u/
        UekP7oTyb6ApXG3EhFKzN/E=
X-Google-Smtp-Source: ABdhPJxHFskWnQ3Twf0BOzSFH/LrWOUSxi3nuj1D6nt0WdQu2zeZNePHmRy1XEpqnnuunDpeUbBlcw==
X-Received: by 2002:a63:3444:: with SMTP id b65mr17373426pga.185.1621923073765;
        Mon, 24 May 2021 23:11:13 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:11:13 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
Date:   Mon, 24 May 2021 15:41:55 -0700
Message-Id: <20210524224159.32807-1-namit@vmware.com>
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

The patch had an embaressing bug, and I apologize for it.

Analysis as for why this bug did not result in failures raised
additional issues that caused at least most of the IOTLB flushes not to
be page-selective ones.

The first patch corrects the bug from the previous patch. The next
patches enable page-selective invalidations, which were not enabled
despite the previous patch.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

---

v1->v2:
* Rebase on v5.13-rc3

Nadav Amit (4):
  iommu/amd: Fix wrong parentheses on page-specific invalidations
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not sync on page size changes
  iommu/amd: Do not use flush-queue when NpCache is on

 drivers/iommu/amd/init.c  |  7 ++++++-
 drivers/iommu/amd/iommu.c | 18 +++++++++++++++---
 include/linux/iommu.h     |  3 ++-
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1

