Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7250E3071A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhA1IjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhA1IjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:39:01 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8458C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:38:20 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id t5so2989001qti.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5FeqogviNew+o0VUZFdW9/7nJCLDRVT518/ol39sXus=;
        b=feBp+DyLNzzD8X0Ce+CXsFWPnXv2fHlzLphroxefIAqmT+JpM/kjRlXM0jYBO49OB0
         aMbLpNbmmnzAi/9UeA27rngoE2YSbQbINyQmGOFdRSu2UFqfJfcUTP9rtzwGZ0L9HHw1
         SLgaBIz5JXj7JZm7XM2mrrlUWog1w7vMp3s/b7pJWhtCPqMKtE2nJL/jRLrXPTPbn31z
         NRBRmnHuYUqXhpQd+fV4beEmz8wBrUtAqV/TWS+n4934YebWuxgTEbyF/6L/nmSyr4IJ
         9noMeixTlrdTmBRDYfZr6AQTZ/a3enLlsVIh9lINb2G/9c4Eh6AqXwaIRNl65hidPi1T
         Q6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5FeqogviNew+o0VUZFdW9/7nJCLDRVT518/ol39sXus=;
        b=C8Ya4XOc5ZaBj5YVFgR3eMq6d95M7QGZfyqi4HRfIpDJI/s58OMy0Ax1Q17QvqyhwR
         FhW8g1C2FYrgQJcjZVF3kB6wSgZ5OOq/7EUC+7jmFtivZv9pFORU+vZckcwACjxW2AdA
         ef9oQ8zFNDrAWvBwbubANgJOtzix/bVYWfu52W+uiucJF5OD1/hREVa9z8B4/73+RPwL
         trx6eUL+DJN2GuyEgzgPx3GBWFRgECLdLDc8BaIePS6sWGYLHXIfZxsiUYe3kY0lqTtk
         AcosT1ZS4kM2n5s9taIiG5s7fx9vuAm4KbysvYlyGHh7XDA206snw3mXwJf+EoMfjaVd
         LxoQ==
X-Gm-Message-State: AOAM530WrTT5D5Tch4W3LlGjMCyj9aa4xu6uRFEvpuXZvbat6i8gXQVm
        AvwO7HL31/Yi+wmiqMwrWnXFT8nzOyk=
X-Google-Smtp-Source: ABdhPJxf8gcn/0Ccf1D2y+uKA7hjFIYYcMpDgFIBoM7I4ge4xPQw0/SKpxYwLJkEQuwnNCB8GYEYaWvd2vQ=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f693:9fff:fef4:2055])
 (user=surenb job=sendgmr) by 2002:ad4:4d4c:: with SMTP id m12mr14286593qvm.6.1611823099629;
 Thu, 28 Jan 2021 00:38:19 -0800 (PST)
Date:   Thu, 28 Jan 2021 00:38:17 -0800
Message-Id: <20210128083817.314315-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 1/1] dma-buf: heaps: Map system heap pages as managed by linux vm
From:   Suren Baghdasaryan <surenb@google.com>
To:     sumit.semwal@linaro.org
Cc:     benjamin.gaignard@linaro.org, lmark@codeaurora.org,
        labbott@redhat.com, Brian.Starkey@arm.com, john.stultz@linaro.org,
        christian.koenig@amd.com, cgoldswo@codeaurora.org,
        orjan.eide@arm.com, robin.murphy@arm.com, jajones@nvidia.com,
        minchan@kernel.org, hridya@google.com, sspatil@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently system heap maps its buffers with VM_PFNMAP flag using
remap_pfn_range. This results in such buffers not being accounted
for in PSS calculations because vm treats this memory as having no
page structs. Without page structs there are no counters representing
how many processes are mapping a page and therefore PSS calculation
is impossible.
Historically, ION driver used to map its buffers as VM_PFNMAP areas
due to memory carveouts that did not have page structs [1]. That
is not the case anymore and it seems there was desire to move away
from remap_pfn_range [2].
Dmabuf system heap design inherits this ION behavior and maps its
pages using remap_pfn_range even though allocated pages are backed
by page structs.
Clear VM_IO and VM_PFNMAP flags when mapping memory allocated by the
system heap and replace remap_pfn_range with vm_insert_page, following
Laura's suggestion in [1]. This would allow correct PSS calculation
for dmabufs.

[1] https://driverdev-devel.linuxdriverproject.narkive.com/v0fJGpaD/using-ion-memory-for-direct-io
[2] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-October/127519.html
(sorry, could not find lore links for these discussions)

Suggested-by: Laura Abbott <labbott@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/dma-buf/heaps/system_heap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 17e0e9a68baf..0e92e42b2251 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -200,11 +200,13 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	struct sg_page_iter piter;
 	int ret;
 
+	/* All pages are backed by a "struct page" */
+	vma->vm_flags &= ~VM_PFNMAP;
+
 	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
 		struct page *page = sg_page_iter_page(&piter);
 
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
-				      vma->vm_page_prot);
+		ret = vm_insert_page(vma, addr, page);
 		if (ret)
 			return ret;
 		addr += PAGE_SIZE;
-- 
2.30.0.280.ga3ce27912f-goog

