Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113CE40663F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhIJECu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:02:50 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:4917 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhIJECt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:02:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UnrmHeq_1631246479;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UnrmHeq_1631246479)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 12:01:26 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] firmware: arm_sdei: pass sdei_api_event_register right parameters
Date:   Fri, 10 Sep 2021 12:01:17 +0800
Message-Id: <20210910040117.98736-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _local_event_enable is used for private sdei event
registeration called by sdei_event_register. We should pass
sdei_api_event_register right flag and mpidr parameters, otherwise atf
may trigger assert errors.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/firmware/arm_sdei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a7e762c352f9..0736752dadde 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -558,14 +558,16 @@ static int sdei_api_event_register(u32 event_num, unsigned long entry_point,
 static void _local_event_register(void *data)
 {
 	int err;
+	u64 mpidr;
 	struct sdei_registered_event *reg;
 	struct sdei_crosscall_args *arg = data;
 
 	WARN_ON(preemptible());
 
+	mpidr = read_cpuid_mpidr();
 	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
 	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
-				      reg, 0, 0);
+				      reg, SDEI_EVENT_REGISTER_RM_PE, mpidr);
 
 	sdei_cross_call_return(arg, err);
 }
-- 
2.19.1.6.gb485710b

