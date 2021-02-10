Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2F316B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBJQ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBJQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:27:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE183C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:26:37 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b145so1588924pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XEVXKVqEiCt5vuaec4vVpy06+wZ2dKpFomwefF9KMs=;
        b=eYUe8RRn2A68Oj2Im2yzv+RtrdWOSSJergCiUDRS7+6jdMoLhYOVloYXmoPVAQO15S
         c3CFltDh2/bTqJAZDGoGcCTSmaEol3aSBJ8TT2korgdzLBhF+IKm6GPoIUEGVA4A960u
         MXxMaMdP3m2CaXp6IURKghkAbLSddakZRqzGyaUSl8mrKnrcXyDbesexRylqqm5S1Kqy
         EK4gXGDcRHoTXQEiAOsWCva22WTZA3bkiZPXNVbDpXn0eGO6jdMZGiRzd8LkaUqCWksc
         caiSZP/zSR6L19/LTsX6y3huFS3g/lif4oE1xQXsvqHvIM8To3tp/om7YhpEgKBAF3P0
         mRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3XEVXKVqEiCt5vuaec4vVpy06+wZ2dKpFomwefF9KMs=;
        b=g7tYhPMSykXHKpdjc/4yBEwGmipa1iy1N0ZhaNT1eyfkHkdSrXj2iGyL+JRFQp2lxx
         NWl5yvtLY/pxTa8pNECgi5cyQunL8bzyCUm4Aq56TU7Y7kPtEDAcc00UEDwfmvKy2JuP
         ikGoFEBUlXQKN/ZA0QnlkfPuYyXWVRmsK0uoAkqXFyHsdleo/7ZZxIIjtxdyH+WuOsX2
         9sGt8NyrnNSsiuLKtr+kHWXxGLhbIkhIwC0F4ZnBwh86jMlg+sjFXMD3vVYEumRQxgl+
         RFpHGKtynArHPmTQRb1v65bfg0Fx127upZjnXdJK7qq37l9JLyQhb8ZImAMqkS8f4fmm
         HyZA==
X-Gm-Message-State: AOAM533XpsYc6LGMdXIMSh8crt8zdnzCkVgZBAp/CJQm7kqWENHC2QDE
        +JOxle2HQP6ryKmXQLuZ31E=
X-Google-Smtp-Source: ABdhPJx/HMb8jcj3j7HsbYcnK1tfCvYY09LLiTC2+woVLJE79zJrllGk4oF9DjqtwJqlD/r4oY2R3w==
X-Received: by 2002:a62:7e8c:0:b029:1e1:6431:7ce with SMTP id z134-20020a627e8c0000b02901e1643107cemr4062314pfc.6.1612974397405;
        Wed, 10 Feb 2021 08:26:37 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id d133sm2690245pfd.6.2021.02.10.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:26:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     sumit.semwal@linaro.org, john.stultz@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        hridya@google.com, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] dma-buf: system_heap: do not warn for costly allocation
Date:   Wed, 10 Feb 2021 08:26:32 -0800
Message-Id: <20210210162632.3903128-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux VM is not hard to support PAGE_ALLOC_COSTLY_ODER allocation
so normally expects driver passes __GFP_NOWARN in that case
if they has fallback options.

system_heap in dmabuf is the case so do not flood into demsg
with the warning for recording more precious information logs.
(below is ION warning example I got but dmabuf system heap is
nothing different).

[ 1233.911533][  T460] warn_alloc: 11 callbacks suppressed
[ 1233.911539][  T460] allocator@2.0-s: page allocation failure: order:4, mode:0x140dc2(GFP_HIGHUSER|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
[ 1233.926235][  T460] Call trace:
[ 1233.929370][  T460]  dump_backtrace+0x0/0x1d8
[ 1233.933704][  T460]  show_stack+0x18/0x24
[ 1233.937701][  T460]  dump_stack+0xc0/0x140
[ 1233.941783][  T460]  warn_alloc+0xf4/0x148
[ 1233.945862][  T460]  __alloc_pages_slowpath+0x9fc/0xa10
[ 1233.951101][  T460]  __alloc_pages_nodemask+0x278/0x2c0
[ 1233.956285][  T460]  ion_page_pool_alloc+0xd8/0x100
[ 1233.961144][  T460]  ion_system_heap_allocate+0xbc/0x2f0
[ 1233.966440][  T460]  ion_buffer_create+0x68/0x274
[ 1233.971130][  T460]  ion_buffer_alloc+0x8c/0x110
[ 1233.975733][  T460]  ion_dmabuf_alloc+0x44/0xe8
[ 1233.980248][  T460]  ion_ioctl+0x100/0x320
[ 1233.984332][  T460]  __arm64_sys_ioctl+0x90/0xc8
[ 1233.988934][  T460]  el0_svc_common+0x9c/0x168
[ 1233.993360][  T460]  do_el0_svc+0x1c/0x28
[ 1233.997358][  T460]  el0_sync_handler+0xd8/0x250
[ 1234.001989][  T460]  el0_sync+0x148/0x180

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/dma-buf/heaps/system_heap.c | 9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 29e49ac17251..33c25a5e06f9 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -40,7 +40,7 @@ struct dma_heap_attachment {
 	bool mapped;
 };
 
-#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
+#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
@@ -315,6 +315,7 @@ static struct page *alloc_largest_available(unsigned long size,
 					    unsigned int max_order)
 {
 	struct page *page;
+	unsigned long gfp_flags;
 	int i;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
@@ -323,7 +324,11 @@ static struct page *alloc_largest_available(unsigned long size,
 		if (max_order < orders[i])
 			continue;
 
-		page = alloc_pages(order_flags[i], orders[i]);
+		gfp_flags = order_flags[i];
+		if (orders[i] > PAGE_ALLOC_COSTLY_ORDER)
+			gfp_flags |= __GFP_NOWARN;
+
+		page = alloc_pages(gfp_flags, orders[i]);
 		if (!page)
 			continue;
 		return page;
-- 
2.30.0.478.g8a0d178c01-goog

