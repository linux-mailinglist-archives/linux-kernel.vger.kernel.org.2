Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411AE3A6DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhFNSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:06:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42495 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232776AbhFNSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:06:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EHlY0m191055;
        Mon, 14 Jun 2021 14:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Q6Q4H24APbAc+PJPlsJ3iPAFbiUVQkvxhE/ezUDR55U=;
 b=dkGTqCMKO2llonZiog7V9fwLiPjliTXblLaqqSy3RGX8FMDl74uFGjt0Q22GROBzb/dY
 6/ryt6AzeO95xPxbuCKFWnFc1cF1CNZFaZTGqs0FFw0ptBnGWO3m5ZgqNEIngZAchlqM
 BZPwlAiVrMpHqfeYFGVWKJYHgfOaUYgs6Xr8TSCy/lf40aOu+nnafItxAHweSZJ0Ol8v
 LkEVasiUdUKgnL3v4ymTZmvCxJyW007OfYp+r7xD2L+Wqs5kZKSflWMIRAJrs7dr+aD6
 Wx+Mf3vvPZe+i4EWkRasOfF8x0TIxqQmwNCprjwvaNjc4/T8kKepkPQwNYQn9G5WFRJv CA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 396btv8bn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 14:03:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EI27CK030146;
        Mon, 14 Jun 2021 18:03:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8s39q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 18:03:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EI3fmu17760594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 18:03:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 840ED11C050;
        Mon, 14 Jun 2021 18:03:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6626511C04A;
        Mon, 14 Jun 2021 18:03:39 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.73.215])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 18:03:38 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 0/2] trace/kprobe: Two fixes for kretprobes
Date:   Mon, 14 Jun 2021 23:33:27 +0530
Message-Id: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: scTf_HXmsg4URaAtoBsb6pEWDiwo2ZWe
X-Proofpoint-GUID: scTf_HXmsg4URaAtoBsb6pEWDiwo2ZWe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_10:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 mlxlogscore=956 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes accounting of missed kretprobes in kprobe_profile.  
The second patch removes limit on the maximum active kretprobe 
instances, when registering a kretprobe through tracefs.

- Naveen


Naveen N. Rao (2):
  trace/kprobe: Fix count of missed kretprobes in kprobe_profile
  trace/kprobe: Remove limit on kretprobe maxactive

 kernel/trace/trace_kprobe.c                           | 11 ++---------
 kernel/trace/trace_probe.h                            |  1 -
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc      |  1 -
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc       |  3 ---
 4 files changed, 2 insertions(+), 14 deletions(-)


base-commit: 0b42677e2e5d87c730ddc41544b289b88596738c
-- 
2.31.1

