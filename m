Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14834340E05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhCRTSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhCRTSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:18:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B79C06174A;
        Thu, 18 Mar 2021 12:18:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gb6so3455970pjb.0;
        Thu, 18 Mar 2021 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/NaYdFXtlzFcS9g4jr5fVZB7FIesAp70iyBKhysIZI=;
        b=S0Zl/LTLeEBUdhTC+jeUj9e95tgW/RcRt/AX0TMM2jIpbbW2Y7vJrG074gPvuuSLxo
         7VtIgGJt6nwy82W8O8lxgolf2Ck3hN+HHVro9iciIAaM2LjxlD7t+wjiJj0d/oOYtp35
         tMQ4zUOgwoYGKljQ/wHxLrKLiyvvQq3Mz0kr5tR7tOx4g3Al1xl5Hq5Ije5p7zHFCN3m
         sX3nGd/+MryD8ECQddM5GtWXLa2RbTz3b49uLM/i3iktD9F/9ifDzFyNcc7FQa3UKcaH
         qP+cWZKlKel+xHotoEqKhTh2ngTgJOa7CdPE6D6zZdxg6w/UODrxIsvm7RUYK60E49Z7
         9wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/NaYdFXtlzFcS9g4jr5fVZB7FIesAp70iyBKhysIZI=;
        b=IZ1fEZ9AbHRWrBMpW2rksnEHBGRHmeF66WVZqrTwWLscEgpTDyTbAzPC43nMgvvQ6H
         QZ5UnsKyAITMaoN5xzJguL2vbl/8aHmyeh7p2cgGrVVVjx8jhMtgkINCq04M+NWVPfsU
         gLO3lJ4K2uEWUGxsBj1MU49M7pKXhS8dqMZAurt088lPGW/hAY/LBzzqJRhrj20CPHl2
         ut7+g9k2laW3GH/Z3vDapEdLZrYdKIsdRRBKG23yfzA+guSflHqPwJfeBP4voOmzpz/z
         0oQYh5NrLuSrTY4z5xSJutMk3Fethuyz5MlC+gBkGG90kMJuIruYfuCe6ynfrw9JN+eL
         Araw==
X-Gm-Message-State: AOAM53236U+3HsCYWvjbruDDXHYUk94eh00vht4DMRr4WsnnCmXw1aAs
        vKKZl2UDwigmeRPWMCPJuqLPBhY0i+s=
X-Google-Smtp-Source: ABdhPJwm9cn3+ty6m9bscYeLI1ObHPxvuox7k4plqvKWGjZFP9XWBv0av+F/gOX0yt4i11b/fwP6RA==
X-Received: by 2002:a17:902:7609:b029:e6:9f29:625f with SMTP id k9-20020a1709027609b02900e69f29625fmr11336669pll.80.1616095113517;
        Thu, 18 Mar 2021 12:18:33 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h2sm2896177pfq.139.2021.03.18.12.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:18:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        iommu@lists.linux-foundation.org (open list:SWIOTLB SUBSYSTEM)
Subject: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
Date:   Thu, 18 Mar 2021 12:18:14 -0700
Message-Id: <20210318191816.4185226-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be useful to disable the SWIOTLB completely for testing or when a
platform is known not to have any DRAM addressing limitations what so
ever.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 include/linux/swiotlb.h                         | 1 +
 kernel/dma/swiotlb.c                            | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..b0223e48921e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5278,6 +5278,7 @@
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			off -- Completely disable SWIOTLB
 
 	switches=	[HW,M68k]
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5857a937c637..23f86243defe 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,6 +15,7 @@ enum swiotlb_force {
 	SWIOTLB_NORMAL,		/* Default - depending on HW DMA mask etc. */
 	SWIOTLB_FORCE,		/* swiotlb=force */
 	SWIOTLB_NO_FORCE,	/* swiotlb=noforce */
+	SWIOTLB_OFF,		/* swiotlb=off */
 };
 
 /*
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c10e855a03bc..d7a4a789c7d3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -126,6 +126,8 @@ setup_io_tlb_npages(char *str)
 	} else if (!strcmp(str, "noforce")) {
 		swiotlb_force = SWIOTLB_NO_FORCE;
 		io_tlb_nslabs = 1;
+	} else if (!strcmp(str, "off")) {
+		swiotlb_force = SWIOTLB_OFF;
 	}
 
 	return 0;
@@ -229,6 +231,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	unsigned long i, bytes;
 	size_t alloc_size;
 
+	if (swiotlb_force == SWIOTLB_OFF)
+		return 0;
+
 	bytes = nslabs << IO_TLB_SHIFT;
 
 	io_tlb_nslabs = nslabs;
@@ -284,6 +289,9 @@ swiotlb_init(int verbose)
 	unsigned char *vstart;
 	unsigned long bytes;
 
+	if (swiotlb_force == SWIOTLB_OFF)
+		goto out;
+
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
@@ -302,6 +310,7 @@ swiotlb_init(int verbose)
 		io_tlb_start = 0;
 	}
 	pr_warn("Cannot allocate buffer");
+out:
 	no_iotlb_memory = true;
 }
 
-- 
2.25.1

