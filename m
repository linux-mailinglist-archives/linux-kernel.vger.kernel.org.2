Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A67C30D6C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhBCJyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:54:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55578 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232665AbhBCJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:54:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1139fgpG189503;
        Wed, 3 Feb 2021 04:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=9lkY0ztB3KdjXTLP87ZJV7LdY29nbosHh0pHdthBNhc=;
 b=bsc+1dWeCLgYxNmigNjMrEbgFwVNc/w9b8mS67KL9/riBfhc8f8HgE/4FjbG9+OSiihK
 Tm0ktTn4Pyfs+NgXJqhZOmJcgQnVmSkW72DOTvHcC2lMZx6Sa0g8+blOM5glbPU9KFd/
 7zWP6NGMyLq89nJVelxCHttiFaqA8x1/eDJ6ZyxTkCdbl6UqcPjvGYNaTiCl0vgtdlsJ
 Yyh0Gl6PObuGreErHLd+UjushL9pudNEICmgFxbczc1IQj/RLTJ9dN+DRFsoprGZrmNi
 ltouiFko7xUiWVQhclQdACyrx4R4y/4Pl3S974EL6KoiTcGC4AzjORSYGbvknS+urbEh 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36fr6qadhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 04:53:04 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1139hwEA195511;
        Wed, 3 Feb 2021 04:53:03 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36fr6qadh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 04:53:03 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1139qOrl002174;
        Wed, 3 Feb 2021 09:53:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 36er8y9j04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 09:53:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1139qxqT12321202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Feb 2021 09:52:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 941495204E;
        Wed,  3 Feb 2021 09:52:59 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 24D3052050;
        Wed,  3 Feb 2021 09:52:57 +0000 (GMT)
Date:   Wed, 3 Feb 2021 15:22:56 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH] sched/topology: Switch to sched_debug() for conditional
 sched domain printk
Message-ID: <20210203095256.vzduw2gpcpum6a7g@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210203042010.799-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210203042010.799-1-zbestahu@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_04:2021-02-02,2021-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yue Hu <zbestahu@gmail.com> [2021-02-03 12:20:10]:

> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, the macro sched_debug_enabled has same function as
> sched_debug() with return false for !SCHED_DEBUG. And sched_debug()
> is a wapper of variable sched_debug_enabled for SCHED_DEBUG. We
> can use the sched_debug() for all cases. So, let's remove the
> unnecessary marco, also use sched_debug() in sched_domain_debug()
> for code consistency.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 5d3675c..402138c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -131,7 +131,7 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>  {
>  	int level = 0;
>  
> -	if (!sched_debug_enabled)
> +	if (!sched_debug())
>  		return;
>  

sched_debug() would only be present in CONFIG_SCHED_DEBUG. Right?
In which case there would be a build failure with your change in
!CONFIG_SCHED_DEBUG config.

or Am I missing something?

>  	if (!sd) {
> @@ -152,7 +152,6 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
>  }
>  #else /* !CONFIG_SCHED_DEBUG */
>  
> -# define sched_debug_enabled 0
>  # define sched_domain_debug(sd, cpu) do { } while (0)
>  static inline bool sched_debug(void)
>  {
> @@ -2113,7 +2112,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  	if (has_asym)
>  		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>  
> -	if (rq && sched_debug_enabled) {
> +	if (rq && sched_debug()) {

Same as above.

>  		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
>  			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
>  	}
> -- 
> 1.9.1
> 

-- 
Thanks and Regards
Srikar Dronamraju
