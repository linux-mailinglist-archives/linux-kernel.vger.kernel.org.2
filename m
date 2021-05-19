Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7162388E94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353526AbhESNEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:04:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14909 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344580AbhESNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:04:43 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JCo98S081874;
        Wed, 19 May 2021 09:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=gDr4AyJqJnBwECmoaT27J6fluxSXXow3J0eEstgflGw=;
 b=AExgfuwvQKxWhoCqDObZKrmZCeIiwInICrRKH96LNKeGo75aUicxsbah8cxIlkPSb/oO
 vp7fN3ua742RaE3pPvWFYqgKfatw20601WKHmVOsMRYDSpI8VIfjik5D8Lrwb4N9dkaK
 jf3O94ftZ0yS4esPEz8kFpUTCFDK1oVex9ngl137W5dbdMSYZSup+O1Ltcb5yfYU6bh1
 s3SCCPwLLvgaxXq8N/QBFGHjbvZ7QedZK04JRPHCN8Rn7OvPOLV0Sz8XDdxYGdYuesBo
 +9uyYUTT96FlG0umBb9OhghNK8OgrUovc2WcVykyZEbbvhsw95SkAI4OpQy97ce+JLe+ xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n31f0bkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 09:03:13 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JCowvx083872;
        Wed, 19 May 2021 09:03:12 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38n31f0bj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 09:03:12 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JClHNH030212;
        Wed, 19 May 2021 13:03:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgt4g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 13:03:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JD2d4G32964932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 13:02:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 779BA11C054;
        Wed, 19 May 2021 13:03:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2142D11C052;
        Wed, 19 May 2021 13:03:07 +0000 (GMT)
Received: from localhost (unknown [9.171.63.142])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 May 2021 13:03:07 +0000 (GMT)
Date:   Wed, 19 May 2021 15:03:02 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] objtool annotations: Avoid using inline asm operand
 modifiers
Message-ID: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PKtrcvLPQmEz0OryV_ydz_xdDjd2ihVm
X-Proofpoint-ORIG-GUID: fzVAFem_tojLE7BzZDJ-E8sodCMB8LCU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_05:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=589
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make objtool annotations arch assembler independent. Would be nice if this goes
via objtool tree. I have further patches which depend on that.

Vasily Gorbik (2):
  compiler.h: Avoid using inline asm operand modifiers
  instrumentation.h: Avoid using inline asm operand modifiers

 include/linux/compiler.h        | 22 ++++++++++++++--------
 include/linux/instrumentation.h | 20 ++++++++++++--------
 2 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.25.4
