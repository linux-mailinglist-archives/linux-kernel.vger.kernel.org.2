Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D95379347
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEJQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:01:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230503AbhEJQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:01:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AFrxTN014353;
        Mon, 10 May 2021 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=T9PBKtwXoVvXEpuchVhHiNNBgDVGlvnuMRc3vleHmW4=;
 b=DjEfrKo1S6IRZoMVVi5OKLjqEjzvvcbIHn3jHUACCI1MvOYZWONDlzrY280rDTv8FiwN
 5eByoGTAzjXYw3PApH4eGa3gepnXn7N1TKc3ApXtzpBolW66G2ZqoqmccUC3K2C2uUE6
 oVdpJjvydD3NoxG3pgqqfu9Zy+gkQ8OWNVV3AdF0ApB2ajFcjhcrMBSNteWwOm2pxYnH
 pnD/Q9U9lp00p5M+MH6W0Df55DOP1nTrdiP3DBTYRTdHia7ojMNcNH2tjf3nMftNi6R8
 KqGfizzO3oZsdQr37X0lgwoAXB43sd0y6Cbo/8Xj6/8VdxtFJ8y1TED0gLHsl/+4XNvr aA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f7vn03mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 12:00:08 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14AFq5cY027925;
        Mon, 10 May 2021 16:00:07 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 38dj98ydk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 16:00:07 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AG06Fu12255512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:00:06 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2D79BE056;
        Mon, 10 May 2021 16:00:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43453BE058;
        Mon, 10 May 2021 16:00:06 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.85.54])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 May 2021 16:00:06 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id C2B9B2E2D67; Mon, 10 May 2021 21:30:02 +0530 (IST)
Date:   Mon, 10 May 2021 21:30:02 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix unsetting of "has_idle_cores" flag
Message-ID: <20210510160002.GA3369@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619456652-19143-1-git-send-email-ego@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cep7LY-Qs4NKZ194gBxchr9kDahwpZ4u
X-Proofpoint-GUID: cep7LY-Qs4NKZ194gBxchr9kDahwpZ4u
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_09:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Ingo,

Pinging to check on this tiny fix :-)


On Mon, Apr 26, 2021 at 10:34:12PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()"), in
> select_idle_cpu(), we check if an idle core is present in the LLC of the
> target CPU via the flag "has_idle_cores". We look for the idle core in
> select_idle_cores(). If select_idle_cores() isn't able to find an idle
> core/CPU, we need to unset the has_idle_cores flag in the LLC of the
> target to prevent other CPUs from going down this route.
> 
> However, the current code is unsetting it in the LLC of the current CPU
> instead of the target CPU. This patch fixes this issue.
> 
> Fixes: Commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb..5fb5020 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6171,7 +6171,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	}
> 
>  	if (smt)
> -		set_idle_cores(this, false);
> +		set_idle_cores(target, false);
> 
>  	if (sched_feat(SIS_PROP) && !smt) {
>  		time = cpu_clock(this) - time;
> -- 
> 1.9.4
> 
