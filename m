Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC553413F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhCSECR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhCSECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:02:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD547C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:02:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x26so4950991pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7mFIfrzw76jaQ9BbBSTUMUy/Bx5PZFnj8PSi3nxWPw=;
        b=vT5gF/rP53wrLkt5FgWCnTvzL2Lm4+0MTd2LwNkfliI0IofCaUUuhYXBqnGH8mgQse
         XVRj9uu6bkRZ6TnndZ88Via39/wpmpS0U7pogW2EtRIk5hI896hyTVe9S2E1Zj5MZoMB
         WLIWtZYnsytiJ7l3VGQgZbDeQLPIe6yQAfIU0oPK4kGMQtCZoVxDTY8/guk+M9ZCS8YE
         NCeFxN6Y30db9cdXAPgn7UyKg5RtQZWd43qWuFWe51rF/gOApFxwsMGpf03s6OC2YFJZ
         LRsPB+10LblXK4BlELJjHLCIYPMwEoMwzJMT82XSrN8jTlQ94VM7wa6diGZpUXjoiy5r
         6DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7mFIfrzw76jaQ9BbBSTUMUy/Bx5PZFnj8PSi3nxWPw=;
        b=qJBXI5tOZTltpQHKt4da0U3f+ReJ2QAhgqinpoenswtg3+P0DfRtMOq35QC/MhZ+sG
         0Qod9HdPTLyat4S0uDcX33STow4qzutGMQgGYtjoUT8lHJaNaqR4LGRadYyvE7VV02gS
         F3i41ETqYfNkCmlR4XW0QT7SDOvbPwy9Rmoag5HhkjPrtXoAvI0wyg85WhW9UHP1dFjF
         QEMjR0zHL8L6PIaPSC3PxLG275V8wl76IAuyrEint5mW2bhffvqihi/AL5UB2ebQ2ZFX
         0lQcIPIpl0gvDga6IApERk1hD308iuT70saG/KuMkSXRcHaVvdLtKagdqGgQb5CpkPE3
         bMYw==
X-Gm-Message-State: AOAM533GPtkMyvb7tL8JQYRpr9QoXFObs5uF9M3aSYrv2HAJkTaqOupf
        qLWuwYrnlBLkwfE9mxMZXBWTarpvTjo=
X-Google-Smtp-Source: ABdhPJwOT5v2SjIr5oPyeuziHKydK5prtvXzLz9YHJ/Nhd6vYqvzGx7avXYViGHQxS9NCyperggkcg==
X-Received: by 2002:a62:cfc4:0:b029:200:49d8:6f29 with SMTP id b187-20020a62cfc40000b029020049d86f29mr7012389pfg.45.1616126526798;
        Thu, 18 Mar 2021 21:02:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22sm3347487pgv.94.2021.03.18.21.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:02:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:SWIOTLB SUBSYSTEM)
Subject: [PATCH] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Date:   Thu, 18 Mar 2021 21:00:54 -0700
Message-Id: <20210319040055.183433-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318191816.4185226-1-f.fainelli@gmail.com>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SWIOTLB_NO_FORCE is used, there should really be no allocations of
io_tlb_nslabs to occur since we are not going to use those slabs. If a
platform was somehow setting swiotlb_no_force and a later call to
swiotlb_init() was to be made we would still be proceeding with
allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
was set on the kernel command line we would have only allocated 2KB.

This would be inconsistent and the point of initializing io_tlb_nslabs
to 1, was to avoid hitting the test for io_tlb_nslabs being 0/not
initialized.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/dma/swiotlb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c10e855a03bc..526c8321b76f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -121,12 +121,10 @@ setup_io_tlb_npages(char *str)
 	}
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force")) {
+	if (!strcmp(str, "force"))
 		swiotlb_force = SWIOTLB_FORCE;
-	} else if (!strcmp(str, "noforce")) {
+	else if (!strcmp(str, "noforce"))
 		swiotlb_force = SWIOTLB_NO_FORCE;
-		io_tlb_nslabs = 1;
-	}
 
 	return 0;
 }
@@ -284,6 +282,9 @@ swiotlb_init(int verbose)
 	unsigned char *vstart;
 	unsigned long bytes;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		goto out;
+
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
@@ -302,6 +303,7 @@ swiotlb_init(int verbose)
 		io_tlb_start = 0;
 	}
 	pr_warn("Cannot allocate buffer");
+out:
 	no_iotlb_memory = true;
 }
 
-- 
2.25.1

