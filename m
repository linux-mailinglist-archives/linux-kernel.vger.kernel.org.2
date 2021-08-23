Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120233F4844
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhHWKIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:08:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14656 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232386AbhHWKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:08:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NA7IGk138958;
        Mon, 23 Aug 2021 06:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oYNLIMSMvB4YhOHwoYQFm8gWeGoHsURJM89MC2S96OA=;
 b=hDhaJHljdYpvROCLIBheE03GGto3EQxx0XDNs9sG42GJaolEd3vNrUKD488Iyi/8HEBk
 8OYl/aSqJayCsAUYxyB7UYzleIrmJ6cd1iZ3idLoyYDd3ILN1BWuVLip87Ul43z/w/FY
 69OX80oxHOmYLNPo3NoyPHAwYD1wxSD/EFncji4TNlQuoKVeJgJEpaxkMmoSLEIhIFG/
 EESmCtNQr35oBqY/wmrEr8If0uJexqXX2awXt7tI+d6q86EG/3X/e6S5YhTBjOkAOmR3
 XUHoGexRIiNpE+Vy6Sg3m1YVXKLSUidbttt9/JhZ5Ed3frWl8fvTEcbvbYzqqW1bVXYV Aw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3akf28jsvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 06:08:01 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NA1O1F009081;
        Mon, 23 Aug 2021 10:07:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3ajs48an0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 10:07:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NA4G7q55247192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 10:04:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AFA4A406D;
        Mon, 23 Aug 2021 10:07:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A5CCA4062;
        Mon, 23 Aug 2021 10:07:53 +0000 (GMT)
Received: from localhost (unknown [9.102.2.197])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 10:07:52 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/2] kernel/workqueue: Make schedule_on_each_cpu as EXPORT_SYMBOL
Date:   Mon, 23 Aug 2021 15:37:45 +0530
Message-Id: <f824a9b589be576f5dac9109ca07d65d6b83219a.1629712557.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sBM5twi1U8ZmQn0mHBdanqxhEgB7Tnuu
X-Proofpoint-ORIG-GUID: sBM5twi1U8ZmQn0mHBdanqxhEgB7Tnuu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_02:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=776 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make schedule_on_each_cpu as EXPORT_SYMBOL.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a..6f15e4afbf38 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3309,6 +3309,7 @@ int schedule_on_each_cpu(work_func_t func)
 	free_percpu(works);
 	return 0;
 }
+EXPORT_SYMBOL(schedule_on_each_cpu);
 
 /**
  * execute_in_process_context - reliably execute the routine with user context
-- 
2.31.1

