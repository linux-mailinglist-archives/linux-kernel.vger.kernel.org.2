Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8616B3F6FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbhHYGvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:51:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46354 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238276AbhHYGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:51:13 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17P6Y8Zm186841;
        Wed, 25 Aug 2021 02:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=la4vEtQ0bjUYtyFdwToE8Kr64UtTJADQ4kxTUtKVsCs=;
 b=Qdvr29Zs0TEeWRdP0wssLbJehRXpOFP2yQyWISzKrf8BYXJAEKugN/zkUpsxTXRoq2ds
 jTOxBCUA6O6mz+T2i4Tj68W3C0NYHzDah/DK9FLmMnEKdsslVQBKt25FjJc08FUDloDn
 +oSPv31tBjf0kEPNg3AlfolexEdkqzQrX2yewlbmr4ZLE3jhyMdgR4VeDFm4l2WoMZsU
 4IxnnTWeUbPCaiTMVMEHVvMMAdfT+JSUfP4KnGUy8KXoUf+ciixCFcVKxbkMxK87RKrz
 kaQYUURhW/zJE6FieMpvVNDvNRwlg5F/LbvMq4j6hCqqrsEn9WQg+ziyZFa1ob9zP0Px JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3anfse9mca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 02:50:09 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17P6Y9Rq187036;
        Wed, 25 Aug 2021 02:50:08 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3anfse9mb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 02:50:08 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17P6iTKP028948;
        Wed, 25 Aug 2021 06:50:07 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3ajs4e3e92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 06:50:07 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17P6o62e36504008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 06:50:06 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B86B42805A;
        Wed, 25 Aug 2021 06:50:06 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E00228058;
        Wed, 25 Aug 2021 06:50:03 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.43.79.237])
        by b01ledav001.gho.pok.ibm.com (Postfix) with SMTP;
        Wed, 25 Aug 2021 06:50:03 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 20ECE2E318C; Wed, 25 Aug 2021 12:20:00 +0530 (IST)
Date:   Wed, 25 Aug 2021 12:20:00 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Subject: Re: [PATCH] kernel/cpu: fix spelling mistake of cpuhp_thread_run()
Message-ID: <20210825065000.GA11343@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20210824070707.5731-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824070707.5731-1-kernelfans@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hIDqC8bP71wHmzMQYv1qxwGcany3hw85
X-Proofpoint-GUID: UE4zXinWaKNB0OAdARSCvudNcWtFI3jh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_02:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pingfan,

On Tue, Aug 24, 2021 at 03:07:07PM +0800, Pingfan Liu wrote:
> According to the name of cpuhp_should_run(), cpuhp_thread_fun() should
> be a spelling mistake.

I think cpuhp_thread_fun() is short for "CPU Hotplug thread
function". It seems correct since the function pointer "thread_fn"
(short for "Thread function") in the struct "smp_hotplug_thread
cpuhp_threads" is assigned the value cpuhp_thread_fun().


> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Donnefort <vincent.donnefort@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 804b847912dc..581d08c0efb6 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -521,7 +521,7 @@ static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st)
>  	st->result = 0;
>  	/*
>  	 * Make sure the above stores are visible before should_run becomes
> -	 * true. Paired with the mb() above in cpuhp_thread_fun()
> +	 * true. Paired with the mb() above in cpuhp_thread_run()
>  	 */
>  	smp_mb();
>  	st->should_run = true;
> @@ -723,7 +723,7 @@ static int cpuhp_should_run(unsigned int cpu)
>   *
>   * When complete or on error, should_run is cleared and the completion is fired.
>   */
> -static void cpuhp_thread_fun(unsigned int cpu)
> +static void cpuhp_thread_run(unsigned int cpu)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  	bool bringup = st->bringup;
> @@ -863,7 +863,7 @@ static struct smp_hotplug_thread cpuhp_threads = {
>  	.store			= &cpuhp_state.thread,
>  	.create			= &cpuhp_create,
>  	.thread_should_run	= cpuhp_should_run,
> -	.thread_fn		= cpuhp_thread_fun,
> +	.thread_fn		= cpuhp_thread_run,
>  	.thread_comm		= "cpuhp/%u",
>  	.selfparking		= true,
>  };
> -- 
> 2.29.2
> 
