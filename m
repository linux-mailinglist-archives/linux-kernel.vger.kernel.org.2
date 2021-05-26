Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2B391563
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhEZKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:52:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46144 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234226AbhEZKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:52:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QAXn54081451;
        Wed, 26 May 2021 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=MgNkRyycYgE65dwI2cYr82Q4ztIirZScjByaZO3nsWk=;
 b=p5J7vAdpsHDdRBWdkPprcvO60S1i/MluuO9BjrAbiAcCtfYvCLgAbeTnypADacdtpdB0
 MD0c0b1solK/4iWnnIoO8LGbKk6FFH5zs1RClrVZrEFbGsUxSBFR/qBqkZfoJO6kK0B3
 ln5w+i5Ayp3Srio9jvTK2+fyBamJdTqrpXY7C5pEGqIbJjuIEEzkznvU2WZ0PIDTgWZq
 s4zL8uCDfrOTD5Ljz0y3/HLragBYUG8v+qP/SWX2MKngzFvN5XnWykJTsm0yg391lKXn
 KUdfpRtxZqyn/Bmx/TQq2SxV1tWdpDBkfB7V3guWSk86ECrQqZXwuaLUBt1alEpXgrth Zw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sewma58q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 06:50:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14QAm2su014237;
        Wed, 26 May 2021 10:50:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 38sba2r84j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 10:50:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14QAoS1F28901822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 10:50:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEAF7AE051;
        Wed, 26 May 2021 10:50:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74280AE053;
        Wed, 26 May 2021 10:50:27 +0000 (GMT)
Received: from localhost (unknown [9.85.75.241])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 10:50:27 +0000 (GMT)
Date:   Wed, 26 May 2021 16:20:25 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kprobes: Remove kprobe::fault_handler
To:     mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     ananth@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        rostedt@goodmis.org, x86@kernel.org
References: <20210525072518.791889911@infradead.org>
        <20210525073213.561116662@infradead.org>
In-Reply-To: <20210525073213.561116662@infradead.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1622025445.6q8nl3t4ap.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LN2HX_Wg0WKAcYIOdfS208OoAILAQtgT
X-Proofpoint-ORIG-GUID: LN2HX_Wg0WKAcYIOdfS208OoAILAQtgT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_06:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105260070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> The reason for kprobe::fault_handler(), as given by their comment:
>=20
>  * We come here because instructions in the pre/post
>  * handler caused the page_fault, this could happen
>  * if handler tries to access user space by
>  * copy_from_user(), get_user() etc. Let the
>  * user-specified handler try to fix it first.
>=20
> Is just plain bad. Those other handlers are ran from non-preemptible
> context and had better use _nofault() functions. Also, there is no
> upstream usage of this.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/trace/kprobes.rst    |   24 +++++-------------------
>  arch/arc/kernel/kprobes.c          |   10 ----------
>  arch/arm/probes/kprobes/core.c     |    9 ---------
>  arch/arm64/kernel/probes/kprobes.c |   10 ----------
>  arch/csky/kernel/probes/kprobes.c  |   10 ----------
>  arch/ia64/kernel/kprobes.c         |    9 ---------
>  arch/mips/kernel/kprobes.c         |    3 ---
>  arch/powerpc/kernel/kprobes.c      |   10 ----------
>  arch/riscv/kernel/probes/kprobes.c |   10 ----------
>  arch/s390/kernel/kprobes.c         |   10 ----------
>  arch/sh/kernel/kprobes.c           |   10 ----------
>  arch/sparc/kernel/kprobes.c        |   10 ----------
>  arch/x86/kernel/kprobes/core.c     |   10 ----------
>  include/linux/kprobes.h            |    8 --------
>  kernel/kprobes.c                   |   19 -------------------
>  samples/kprobes/kprobe_example.c   |   15 ---------------
>  16 files changed, 5 insertions(+), 172 deletions(-)
>=20

<snip>

> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -947,16 +947,6 @@ int kprobe_fault_handler(struct pt_regs
>  		 * these specific fault cases.
>  		 */
>  		kprobes_inc_nmissed_count(cur);

Not necessarily related, but I'm wondering why we're incrementing the=20
probe miss count here. Unlike what the comment above indicates, this is=20
not a 'fault' counter, but just a count of the number of times the probe=20
handler wasn't called.

> -
> -		/*
> -		 * We come here because instructions in the pre/post
> -		 * handler caused the page_fault, this could happen
> -		 * if handler tries to access user space by
> -		 * copy_from_user(), get_user() etc. Let the
> -		 * user-specified handler try to fix it first.
> -		 */
> -		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
> -			return 1;
>  	}


- Naveen

