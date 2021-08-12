Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2430A3EA780
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbhHLP1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:27:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63624 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232854AbhHLP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:27:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CFBcsL028122;
        Thu, 12 Aug 2021 08:26:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=WB6DoJ7BBOGVQsPX8Zjhwmyob2kIUfsRdQP2drnnNWs=;
 b=cL7pIfCH6jk4VvrR1099Izc7iMWMSabc+XimX1G3TV0cAvrmaGvxPxoFGnbgb2uFrvKS
 VLoHR//cmBBfWx2xgbvUn6GozycMba1JIiynFA+W9JYgIA36I0A1Jbh9wOtYJa5kMtbC
 uE8l6GsVHK5qvejxcEoMQbDmw8817ncU7+vJM8fQWMclCaoz4hdLCpgre6iUSrdXdu8e
 R9UAT/Poz50Z6C7SuEnYY5Ulwlo+0HQNULY7MyqTT4k4Scy9NvZFdISibafdMkYwRWTr
 9sFXk7IQIFZPEY5y0RIqNbH/dCBDHysaXEjqPST3xhuhzTtOP7pGRWALCnGtOKcEoKQa sg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3acrnp2m6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 08:26:28 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 12 Aug
 2021 08:26:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 12 Aug 2021 08:26:26 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 65B583F709B;
        Thu, 12 Aug 2021 08:26:26 -0700 (PDT)
From:   Vasyl Gomonovych <vgomonovych@marvell.com>
To:     <james.morse@arm.com>
CC:     Vasyl Gomonovych <vgomonovych@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: arm_sdei: Print sdei event number in hex
Date:   Thu, 12 Aug 2021 08:26:14 -0700
Message-ID: <20210812152615.28930-1-vgomonovych@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ZKTzeFA6iYzLEViGn0Mi61TJL-FkM5UF
X-Proofpoint-ORIG-GUID: ZKTzeFA6iYzLEViGn0Mi61TJL-FkM5UF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDEI specified event numbers in hexadecimal format.
Change event number format to hexadecimal to make
it easier for the reader to recognize the proper event.

Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
---
 drivers/firmware/arm_sdei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a7e762c352f9..66d2869d03f7 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -496,7 +496,7 @@ int sdei_event_unregister(u32 event_num)
 	mutex_lock(&sdei_events_lock);
 	event = sdei_event_find(event_num);
 	if (!event) {
-		pr_warn("Event %u not registered\n", event_num);
+		pr_warn("Event 0x%x not registered\n", event_num);
 		err = -ENOENT;
 		goto unlock;
 	}
@@ -579,7 +579,7 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 
 	mutex_lock(&sdei_events_lock);
 	if (sdei_event_find(event_num)) {
-		pr_warn("Event %u already registered\n", event_num);
+		pr_warn("Event 0x%x already registered\n", event_num);
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -587,7 +587,7 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 	event = sdei_event_create(event_num, cb, arg);
 	if (IS_ERR(event)) {
 		err = PTR_ERR(event);
-		pr_warn("Failed to create event %u: %d\n", event_num, err);
+		pr_warn("Failed to create event 0x%x: %d\n", event_num, err);
 		goto unlock;
 	}
 
@@ -605,7 +605,7 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 
 	if (err) {
 		sdei_event_destroy(event);
-		pr_warn("Failed to register event %u: %d\n", event_num, err);
+		pr_warn("Failed to register event 0x%x: %d\n", event_num, err);
 		goto cpu_unlock;
 	}
 
@@ -635,7 +635,7 @@ static int sdei_reregister_shared(void)
 					sdei_entry_point, event->registered,
 					SDEI_EVENT_REGISTER_RM_ANY, 0);
 			if (err) {
-				pr_err("Failed to re-register event %u\n",
+				pr_err("Failed to re-register event 0x%x\n",
 				       event->event_num);
 				sdei_event_destroy_llocked(event);
 				break;
@@ -645,7 +645,7 @@ static int sdei_reregister_shared(void)
 		if (event->reenable) {
 			err = sdei_api_event_enable(event->event_num);
 			if (err) {
-				pr_err("Failed to re-enable event %u\n",
+				pr_err("Failed to re-enable event 0x%x\n",
 				       event->event_num);
 				break;
 			}
@@ -670,7 +670,7 @@ static int sdei_cpuhp_down(unsigned int cpu)
 
 		err = sdei_do_local_call(_local_event_unregister, event);
 		if (err) {
-			pr_err("Failed to unregister event %u: %d\n",
+			pr_err("Failed to unregister event 0x%x: %d\n",
 			       event->event_num, err);
 		}
 	}
@@ -693,7 +693,7 @@ static int sdei_cpuhp_up(unsigned int cpu)
 		if (event->reregister) {
 			err = sdei_do_local_call(_local_event_register, event);
 			if (err) {
-				pr_err("Failed to re-register event %u: %d\n",
+				pr_err("Failed to re-register event 0x%x: %d\n",
 				       event->event_num, err);
 			}
 		}
@@ -701,7 +701,7 @@ static int sdei_cpuhp_up(unsigned int cpu)
 		if (event->reenable) {
 			err = sdei_do_local_call(_local_event_enable, event);
 			if (err) {
-				pr_err("Failed to re-enable event %u: %d\n",
+				pr_err("Failed to re-enable event 0x%x: %d\n",
 				       event->event_num, err);
 			}
 		}
@@ -1095,7 +1095,7 @@ int sdei_event_handler(struct pt_regs *regs,
 
 	err = arg->callback(event_num, regs, arg->callback_arg);
 	if (err)
-		pr_err_ratelimited("event %u on CPU %u failed with error: %d\n",
+		pr_err_ratelimited("event 0x%x on CPU 0x%x failed with error: %d\n",
 				   event_num, smp_processor_id(), err);
 
 	return err;
-- 
2.17.1

