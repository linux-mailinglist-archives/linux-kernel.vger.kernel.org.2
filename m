Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305743F5257
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhHWUnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36896 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhHWUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:43:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NKY73v035222;
        Mon, 23 Aug 2021 16:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9rXrXUL2EH5bsC/ieEUl845iVI4rREWihUpykiR5eDo=;
 b=e3pnvMf6fg0Eoct12XvJ1iww9L9bWrJBRnMQUAwTJAyGlsYjP4gK7CzSP05ilB820Dpa
 R6hiveCXHDPMSj+ClxmWjgB64u+WI17WLmEZZ6WfPTWqm2I6LaRwzJ24PHn+CyKSR8Ym
 Ow0Go0sHAYxY5awpqagkCqLVqPqgPPbbDzVVQJW8htz2On7JnN30soFfwABLOmgNkcvX
 xU8WX4AYx8hUewtlR+HjiiK2LuEsCjQLyVChjj+QTeMsA/682Et3UFxPkEbM1m60uWpN
 LwuRYbElWPzJ2d66NnuPcG+dxnQ1k8zM/NXEwul0amxo7SKyAv0RXPrV/l8tPt3b42V5 iA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amb23qns6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 16:42:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NKXS0F001938;
        Mon, 23 Aug 2021 20:42:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48bucf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 20:42:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NKcrlk57671958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 20:38:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22F794C052;
        Mon, 23 Aug 2021 20:42:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A2F4C046;
        Mon, 23 Aug 2021 20:42:32 +0000 (GMT)
Received: from localhost (unknown [9.102.2.197])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Aug 2021 20:42:32 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/2] kernel/workqueue: Make schedule_on_each_cpu as EXPORT_SYMBOL_GPL
Date:   Tue, 24 Aug 2021 02:12:29 +0530
Message-Id: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IGHOdOMC2wUIWC8IsNTsQ9uDG8Hh0IC5
X-Proofpoint-ORIG-GUID: IGHOdOMC2wUIWC8IsNTsQ9uDG8Hh0IC5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=711 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make schedule_on_each_cpu as EXPORT_SYMBOL_GPL

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
[v1 -> v2]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL

 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a..993f8983186d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3309,6 +3309,7 @@ int schedule_on_each_cpu(work_func_t func)
 	free_percpu(works);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(schedule_on_each_cpu);

 /**
  * execute_in_process_context - reliably execute the routine with user context
--
2.31.1

