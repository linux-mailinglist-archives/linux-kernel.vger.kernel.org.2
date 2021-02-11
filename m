Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22D318399
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBKCeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhBKCeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:34:09 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A12C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:33:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z9so2465238pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hFI5yMs4utCGVkTIq+kw76z9rISLs3vt2KceBV+AVLQ=;
        b=PablRw/+VzBu2+dc0GcDX97Indy6T8rtWdl2Ct2/QMMOOc2wvRh6zI//vqs3V7EuVL
         0kdUDZGnFIbo8jpIiGhCH1xEU+TdWcW5/nI9iScBu1Wg53Cp3CRPLde1z981RMp06q8F
         fjX3Rz3tYDYgIgsUPtQj+EzJ8+ggz93zgIMTiQpBo0ymn7QmzasM8wEgR94UEG6Xgj6b
         nVwT79lSu1gFY/eAt9a9DU04hhpWO4c7Isc7ZCC4KNWTw7WqE454jHP31YfcjchoY7w7
         HT1l45Mmm9yb/5wWKFTlfpm/+b8EzUFIu6zZY9uY4SrXvC5IIsIqCIMhcinJ7IDIPBaN
         GEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hFI5yMs4utCGVkTIq+kw76z9rISLs3vt2KceBV+AVLQ=;
        b=PAtE/uESQrKTUYMd9b+xQpgTQdFjv4QmK/MacFa77Uh3hp2o1e/MbkBnZQeiS+VTvS
         pPiAF30F2g3djTlHutjc8Roq/9Rg1uYSx4fDQ3kEthkvcKLapwlNTiaLdQ2gdGkMy3/D
         jTY+MafdwhIlkS5jjkvHNKBS86Hpt4a2of38dvadtY24db8XQGX+SERtsjoM1Qk6FSY4
         ZEtcQ15pKFji2OJRDGjhYWypp4wisPTNBSfg5FABzPDpGhPklsrYMT+LjG5QRZvD989d
         J4WNnjcsp2GT0ukV3VDk7P0Yfw9K5/gwy4KGU4IOdF1Y+NOM0/nIGb7G1FVLDJ90ZPmW
         iYIA==
X-Gm-Message-State: AOAM531xKr9Wz2J/pr/aARt5gyD3NMIe31FQLF9q8iTXpcBiZxutCPSq
        gtwgW3PZssBDBZCcg4Am27c=
X-Google-Smtp-Source: ABdhPJzicJVWym89B8juaBqIm5UT7IXON0L7p0YLb0YbsqibNiiVZ2x4ADApQCTsAKKQI+Qgw7QikA==
X-Received: by 2002:a17:90a:12c9:: with SMTP id b9mr1871725pjg.177.1613010808752;
        Wed, 10 Feb 2021 18:33:28 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id p17sm3612583pgn.38.2021.02.10.18.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:33:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     sumit.semwal@linaro.org, john.stultz@linaro.org
Cc:     LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        hridya@google.com, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] dma-buf: system_heap: do not warn for costly allocation
Date:   Wed, 10 Feb 2021 18:33:24 -0800
Message-Id: <20210211023324.2331377-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmabuf system_heap allocation logic starts with the highest necessary
allocation order before falling back to lower orders. The requested
order can be higher than PAGE_ALLOC_COSTLY_ODER and failures to
allocate will flood dmesg with warnings. Such high-order allocations
are not unexpected and are handled by the system_heap's allocation
fallback mechanism.
Prevent these warnings when allocating higher than
PAGE_ALLOC_COSTLY_ODER pages using __GFP_NOWARN flag.

Below is ION warning example I got but dmabuf system heap is nothing different:

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
* from v1 - https://lore.kernel.org/lkml/20210210162632.3903128-1-minchan@kernel.org/
 * better description - surenb
 * use mid_order_gfp - john.stultz

 drivers/dma-buf/heaps/system_heap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 29e49ac17251..e5f545ada587 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -40,11 +40,16 @@ struct dma_heap_attachment {
 	bool mapped;
 };
 
+#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
+/* 
+ * Avoid warning on order-4 allocation failures as we'll fall back to
+ * order-0 in that case.
+ */
+#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
 #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
 				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
 				| __GFP_COMP)
-#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
-static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
+static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
 /*
  * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
  * to match with the sizes often found in IOMMUs. Using order 4 pages instead
-- 
2.30.0.478.g8a0d178c01-goog

