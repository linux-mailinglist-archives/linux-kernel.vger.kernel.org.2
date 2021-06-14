Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3DA3A6DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhFNSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:02:34 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:36563 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhFNSC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:02:26 -0400
Received: by mail-pl1-f171.google.com with SMTP id x10so6996996plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikgWymc1ypzBC+qNXVUU0vzqUyTd66gZ/nAfzMGF6Gs=;
        b=WY/R0WLaBaiYdlkocqkG/FJRbohR+AMqvPTJBgCgQ6WUpM6WGjKHryGL50t5NkWvsm
         vMcH1hbSdap6cslA79RfB+rP6Fc2nsooTv9Fbah/pcwb7KaiyIr0RTqlzXX2SPnreISO
         M6r2ObUm6QdboLUe/Xsmg1vyziPOxsnZSQ8FUxZS3TQkMFiYm2vJ7tlkj5xJb1iVoQ6q
         k/FYyV8gYGC1iOQSj0xq6w2U0mlqDjyCCZBI0riuo17i4vKea++vngs2XSPoKPjaXVMa
         UnmI5/8WQ0BpC+Mq9BVZPrmd5tYBXBXV9esqEQSVd+pvT895+vg5+SyfmCSnWUpHUr7W
         2Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikgWymc1ypzBC+qNXVUU0vzqUyTd66gZ/nAfzMGF6Gs=;
        b=HT+0jxnJJC6b1PMJB8PA5/NqY/2P/prpa3YCaKLBeLpt0bYCKkhNd3nvrtB+5Vgyms
         n6Advn9xQVuRNW43vh4MeDyRUnXeLncyz2C8kGLOveWfQrsNP5RrvhrHIX1eJCdXw4Z4
         9EYXsVt+Y2E7voKw/pacMRybzuo7drOIPg6A3LivmNUBNH13KyiqnkWzMpuV2gasFA0m
         bqEj7ORcJ9Xj5xfJpar8Kl2/gVQ0i3evuIFf+JNE3bX9YS/ET9HY4MC+d2/Gb9A6UC1J
         nEmHVlmqM1tfgohHNu8YVuAV6kTQzyDe+qijwA6S0EhObedhGo0HgpbdGPUPlAKZYeld
         LWHg==
X-Gm-Message-State: AOAM531XwpKrZLk21zXj0H0KjICISKcmYjTx/GFKVpyvOKiR35ofpm0r
        92oFBUwRdLKVYMJqjp+KBqyYTg==
X-Google-Smtp-Source: ABdhPJzgBl1fU+pCey+nzBpjvGIYgZkPno3JTYM2mPOn574FE4xRd5Go9RIDWay2rJHRcRbQPliVpA==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr20698468pjb.13.1623693551409;
        Mon, 14 Jun 2021 10:59:11 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:10 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] coresight: tmc-etf: Fix global-out-of-bounds in tmc_update_etf_buffer()
Date:   Mon, 14 Jun 2021 11:59:00 -0600
Message-Id: <20210614175901.532683-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

commit 6f755e85c332 ("coresight: Add helper for inserting synchronization
packets") removed trailing '\0' from barrier_pkt array and updated the
call sites like etb_update_buffer() to have proper checks for barrier_pkt
size before read but missed updating tmc_update_etf_buffer() which still
reads barrier_pkt past the array size resulting in KASAN out-of-bounds
bug. Fix this by adding a check for barrier_pkt size before accessing
like it is done in etb_update_buffer().

 BUG: KASAN: global-out-of-bounds in tmc_update_etf_buffer+0x4b8/0x698
 Read of size 4 at addr ffffffd05b7d1030 by task perf/2629

 Call trace:
  dump_backtrace+0x0/0x27c
  show_stack+0x20/0x2c
  dump_stack+0x11c/0x188
  print_address_description+0x3c/0x4a4
  __kasan_report+0x140/0x164
  kasan_report+0x10/0x18
  __asan_report_load4_noabort+0x1c/0x24
  tmc_update_etf_buffer+0x4b8/0x698
  etm_event_stop+0x248/0x2d8
  etm_event_del+0x20/0x2c
  event_sched_out+0x214/0x6f0
  group_sched_out+0xd0/0x270
  ctx_sched_out+0x2ec/0x518
  __perf_event_task_sched_out+0x4fc/0xe6c
  __schedule+0x1094/0x16a0
  preempt_schedule_irq+0x88/0x170
  arm64_preempt_schedule_irq+0xf0/0x18c
  el1_irq+0xe8/0x180
  perf_event_exec+0x4d8/0x56c
  setup_new_exec+0x204/0x400
  load_elf_binary+0x72c/0x18c0
  search_binary_handler+0x13c/0x420
  load_script+0x500/0x6c4
  search_binary_handler+0x13c/0x420
  exec_binprm+0x118/0x654
  __do_execve_file+0x77c/0xba4
  __arm64_compat_sys_execve+0x98/0xac
  el0_svc_common+0x1f8/0x5e0
  el0_svc_compat_handler+0x84/0xb0
  el0_svc_compat+0x10/0x50

 The buggy address belongs to the variable:
  barrier_pkt+0x10/0x40

 Memory state around the buggy address:
  ffffffd05b7d0f00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
  ffffffd05b7d0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffffd05b7d1000: 00 00 00 00 00 00 fa fa fa fa fa fa 00 00 00 03
                                      ^
  ffffffd05b7d1080: fa fa fa fa 00 02 fa fa fa fa fa fa 03 fa fa fa
  ffffffd05b7d1100: fa fa fa fa 00 00 00 00 05 fa fa fa fa fa fa fa
 ==================================================================

Link: https://lore.kernel.org/r/20210505093430.18445-1-saiprakash.ranjan@codeaurora.org
Fixes: 0c3fc4d5fa26 ("coresight: Add barrier packet for synchronisation")
Cc: stable@vger.kernel.org
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 45b85edfc690..cd0fb7bfba68 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -530,7 +530,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		buf_ptr = buf->data_pages[cur] + offset;
 		*buf_ptr = readl_relaxed(drvdata->base + TMC_RRD);
 
-		if (lost && *barrier) {
+		if (lost && i < CORESIGHT_BARRIER_PKT_SIZE) {
 			*buf_ptr = *barrier;
 			barrier++;
 		}
-- 
2.25.1

