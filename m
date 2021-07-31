Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACCB3DC7F7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhGaT0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 15:26:49 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6CC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 12:26:42 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bm25-20020a05620a1999b02903a9c3f8b89fso7950564qkb.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aq5goyzLdVULZzcaDLSUVOZLTRPe+Z2LTBDzbfKug1g=;
        b=ri/RK0P5wZxA5hLgj+K6MsqbXj20FVsWlQ/y55ppJkr6Em7jCq7jYT6NIdC98Fyw0l
         xiKiACGCcploqmrBaq02A3L3lwQus+ZKlKYCABP7T7keZO5K3HE9J6n1JREbmXCYtK4o
         rNeRlqoJqMu1vrTt/vW2TKMe9mE9Ggtq4FI7TeqO2C4ZhP9U5/DTyWCSPYgqM3qOVaUf
         YJVOar9AGDbyyr97D5KpR+ePnqppw+3dWdmrF6ZajhWnDoKHk+6YcbU/Rmb5nO52QRUy
         Aq90fF40gzMZ5zMREWFPh4auS0Z3uB1cIB1ldvlJ1YUOp1YT5EVdO/ehdrHSPu++HBe3
         tK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aq5goyzLdVULZzcaDLSUVOZLTRPe+Z2LTBDzbfKug1g=;
        b=oZUUAKE0ISI8ndmQoBN2YgE5b6KWeeWV5bBCpYhEz1XSDqBDWXNo3+Y07Kd5T307yD
         P3In9TgIQh0/MUz85317bJS1q73iXKR+YyGArqGnlt8Y3NeK9qa15Pkv09AAeeiTnO3f
         XRVTPGmmQMKiSlBmQ5LItDTPw6cvpabUB6fO4AhWe5QSd8vO3EQmFN+5p4PnSU0In8ys
         j1pwaDxhEJcY3eB6aFgkwjzSl7kFXbtY5qNvxsdx5pITPiVc9tiRXwoXHhtvOh7bpm4J
         iECqvtnl5VKHPF/ZKlNaQJrTrCnLavQHfEni1HWn5S4hqpH3+QEEuq+b0Ztr/ZwwLcGh
         KE/A==
X-Gm-Message-State: AOAM531DdOCVOnvipDgTkQo2IB9plaj4yAhhryxLWGlcSlKDX7sr8Bcl
        idG1gcPYiTFKXiwlAtoteeKi5V0iE9c=
X-Google-Smtp-Source: ABdhPJzmMkfAwt4s0ixVeRPJXjhMpC9htyV2iCNfRj+tHT5clfdwdD4U7s3jdREU16AlRWW19UTxJ0AGKto=
X-Received: from lrizzo2.svl.corp.google.com ([2620:15c:2c4:201:af39:9f08:202e:eb75])
 (user=lrizzo job=sendgmr) by 2002:a05:6214:501d:: with SMTP id
 jo29mr9093263qvb.43.1627759601987; Sat, 31 Jul 2021 12:26:41 -0700 (PDT)
Date:   Sat, 31 Jul 2021 12:26:37 -0700
Message-Id: <20210731192637.3653796-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH] amd/iommu: fix logic bug in amd_iommu_report_page_fault()
From:   Luigi Rizzo <lrizzo@google.com>
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Rientjes <rientjes@google.com>, rizzo.unipi@gmail.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_iommu_report_page_fault() has two print paths, depending on whether or
not it can find a pci device. But the code erroneously enters the second
path if the rate limiter in the first path triggers:
  if (dev_data && ratelimit(A)) { A; } else if (ratelimit(B)) { B; }
The correct code should be
  if (dev_data) { if (ratelimit(A)) { A;} } else if (ratelimit(B)) { B; }

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/amd/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..38b4aff70800 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -480,9 +480,11 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
-	if (dev_data && __ratelimit(&dev_data->rs)) {
-		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-			domain_id, address, flags);
+	if (dev_data) {
+		if (__ratelimit(&dev_data->rs)) {
+			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
+				domain_id, address, flags);
+		}
 	} else if (printk_ratelimit()) {
 		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-- 
2.32.0.554.ge1b32706d8-goog

