Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7432F43D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCETtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:49:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16062 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhCETtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:49:04 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125JjWRt021101;
        Fri, 5 Mar 2021 11:48:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Sk4yZI7Bp+UP9Nlhv+6pVDu8yJ9U2GexzJCEuuBRHBY=;
 b=k3gUSwY0gYCocNaxeXIF2drfJENWPBSb5zfxfM7CBp04LcB+Eo88/kdu4SHVKBpy0yH2
 bJNAAdAsXgpXni3W3bs32aHyLvt3ZtUu9/u4sSxuOnWMi8fanVlXkzgoR/xeA2rKtBvt
 DZ0RnZ7H0q9NIR+b4AWaOwmBuTm67zAIC4E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 373ha4ub8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:48:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 11:48:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcBeLFxVosFMZ/wOs6DL96rcgv0RsBEyxyi2pc+nsQTG/MBM6v1nxTDxJV26mWmuH+hexujpnNkFmBX4b/gHuTNRcwsknrep/jGFgcsXIu9pEXlMZFetxnhEpXGL3aiV4NDnkJw/gTIzzQ7fqI7Bd4m3qCA8mfpp6e1zg7kaXrw6vaD06OzeOIIVQYBo4BRCrnoyfgYu+gSf3PRsl6biMjfw/9LO6hQBJcXS8hopOZUyXN1ZuI2oGGWofomwSWGVdcuoiq/yQcnJgcdWvnjINJ4BEN5rWL12ilKsXh+FzEs0YbYS+EW400o4NzoXfEd8jvx8O4S9JQPYMbNVjO4lUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4yZI7Bp+UP9Nlhv+6pVDu8yJ9U2GexzJCEuuBRHBY=;
 b=n2o5VZe0zjhoMYldB1f8wrRZzsu8suOMPg6eHb3WCDyhq9lqAlKRUgMhNryNBfurDNBGivxpbHf5QQBbkgvOtgi3NzFspbzaSr8+4QJnujGHyIaCOr3ztDh2rhFaDBB4uD2l6lPho18IKGEJcddCmTY7X4tZYDRsoPVw49oet1Qj5TwRaCezE2QojGPv0aqeBuqlfoE98W8uFhK7IqNVTqkKSp1X06pCk0SFRBKglwOpuMiAhOeXwfFoazPdYtbjE/52D/V7y1EjVevuCD9tlzWegrKRK/b7gKiWE7g4kiIil0Vp5tVFgee6wEKatdCdBKIgDDl15JWyESfYMS6aZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3351.namprd15.prod.outlook.com (2603:10b6:a03:10c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 19:48:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 19:48:53 +0000
Date:   Fri, 5 Mar 2021 11:48:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vdavydov.dev@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v2 4/5] mm: memcontrol: introduce remote objcg charging
 API
Message-ID: <YEKLIUcPfpKYtFLA@carbon.dhcp.thefacebook.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303055917.66054-5-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:6f6c]
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6f6c) by MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 19:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee1dbf4-fbaf-4f5a-b39b-08d8e00fb4c2
X-MS-TrafficTypeDiagnostic: BYAPR15MB3351:
X-Microsoft-Antispam-PRVS: <BYAPR15MB33511F20B638268EBCB77DC6BE969@BYAPR15MB3351.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z32abLsTomkdVT94GUPyRxIhkJ4Tvm2MNaJzpBIKYu2psuFrkdNEhcM9y3q5ZRKZNHMmqk+FM+mKpe4Kr8uoPrdlmnd2ubvUpc97c5qx8z2oz19mzKN7hJl+T8FKHoO84NOcj+yCCI+5qQgp0UAIafRaREwrRWBsqfaeEVE1F2qUQJ84D4MtmsS1acCI2fzXpOdJhao2UHqG261g/OoJuckE3QIdH5BRi1KoFQBoBXAEapShg0kMFAXBSeXQ70/vmcwooLWbXlJY8BBXIlTyBTBH7DQmd7BTFu3Qujm95Xr+F/8BJaJbF+wFKZNelCbpN6NUt+kmDnVR9JFXtBmqYoGVv2Cro4Potex6Iipstqx6spAPToef7/9JzbqsIN2+S0pqJh5OXZuSB9Iyx2evWgDM7AVHm9UAbk0eDyEcsJxVCr71ECBcG6Tr9T0o1r/684ekoSFgRusKg1sI8Cn2O/+Sy3xTrGp2uyIZnBhLrcRh4X8HIbpeyJuqKDE0mIWuo2V2k5wHw3GV+bf3DxT/MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(396003)(136003)(346002)(4326008)(316002)(2906002)(9686003)(66946007)(55016002)(66476007)(6916009)(478600001)(83380400001)(52116002)(16526019)(86362001)(6666004)(5660300002)(7696005)(186003)(8676002)(8936002)(66556008)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PXkuPCesMXuvhZqnQmmYVgXscpll9I/u+4dx2HAoJLKA7r9mYOj9bV5I/LXR?=
 =?us-ascii?Q?/8emT/LJrf3UxVMOaO1CQ4srodHpdOfcjSF37si7ckzXKQcaIWobYLF6ci2v?=
 =?us-ascii?Q?Yxh0M5xg6MECOG6g3UokViMuE55T4eLyl+RyekZzCKeGY+0/79F8pBxVyErt?=
 =?us-ascii?Q?ufLIYTne5lqtcqW6O8fK6aXVQeaqAdQ5eTccfhCxJlVNELTgnCv38aQfjNV5?=
 =?us-ascii?Q?q6tDDS6wUZUU8P0ELNx/1TWl9EmtG9PSnIXtGJuz4uwI3fu//62Y+Uk6hXCq?=
 =?us-ascii?Q?DtUhdcKCku3xqk97FFAsN51R9Es0QVM3DtF3LahTl2l1OxApvotyv8AVlzsm?=
 =?us-ascii?Q?ELJD2pXL7FVe0uvxwVA06IIGe7PmQdpm7UbFj01eHyXg1MknxaZw4b9IOb8d?=
 =?us-ascii?Q?nKMS8ZJxrfIyHxCf7Nrn69rg5dEnLhZM5S45VaR4uoDZ9uoc+cRGJMKW0YIx?=
 =?us-ascii?Q?mv1CBd3+0rImGjoxK34U8TdpzPrsgM1jUgW0kT3W7qUWEC86U9vlzsABY9zx?=
 =?us-ascii?Q?Vafoth6uqtbYqobUthz3cGdWdUDlCVD/3u+M2dGZvRiTJga6kwCneg/DmlQQ?=
 =?us-ascii?Q?CdVpsUC+KxDLs/JjqpsOUxtS4zWrhuzSfPOASQvqaUnsiEa+pjGFyJvGPx4x?=
 =?us-ascii?Q?5lMU5A81ElV5V9XC26p1hPyPTr+maSunDQNzTg31hG+I8ejzoWrPKgl0wxPG?=
 =?us-ascii?Q?FnH+BGbA3PQBtbKPhpr31O3/w2pbzjM4p8YC3eOoDmLkZs3T4CT//YcLZBPG?=
 =?us-ascii?Q?TenhJOVaXfHZlLr+3boKti8Y5U6YicKXakrbJ5xzsdjNMAqhHyDNtik3dxbH?=
 =?us-ascii?Q?tXbsO1jGUWKK83MSMrqp9qjLh+Uw0KmHlqjELpnJC7BsRpl7JC0Ol3VuP9KJ?=
 =?us-ascii?Q?BjRFOvIH+LOJNOC/p8FQj5JZv/FCh8Hvj7H0UZeQBHDxjH5YzBrpdYs6l9EP?=
 =?us-ascii?Q?v3Khs8XPQhCsqGvD4Ei3febizEr2oJDRrRFqcWcQcvhTSkBxRmawKvJ3YqAR?=
 =?us-ascii?Q?qRAIU5VRl0OjBQjeCL5Xn4UOO3CQrKEk/SipbfIIXOMl76vQy1Nkhg025QGa?=
 =?us-ascii?Q?+zZgEaOsr7C5pEW6oR3nhxM+z0Lm0Cz2SLQA3p4MMHpAMDfPUuFzeEDXgtyv?=
 =?us-ascii?Q?iFI9FVnwXy2SWnwJQ4tzeJBF6Birajy4lQ/B2HoBBX7x4bGZOkDmekIZNHFt?=
 =?us-ascii?Q?vl1KLhPgB5XI16phrYTPb0uJ+bcOV6/FiuQ1foJYEBw+hHOt9PWTdrq+B8pW?=
 =?us-ascii?Q?vDXLnUQkOucfHaPyfC33H/hUiKAIseOxTPJeW2eLOwoAfCKno5KSGHDZRsqA?=
 =?us-ascii?Q?X+81kAWQKnfZC8NRFCixQ2cMTM/qGTMnHXVJG07f4OtQjg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aee1dbf4-fbaf-4f5a-b39b-08d8e00fb4c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 19:48:53.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8r/AZolFG+DTsF4ED4WnvlQRQ2wxw10mjbNm4bI5oKzM9fB8k4PQR0IoJ2F9bWZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:59:16PM +0800, Muchun Song wrote:
> The remote memcg charing APIs is a mechanism to charge pages to a given
> memcg. Since all kernel memory are charged by using obj_cgroup APIs.
> Actually, we want to charge kernel memory to the remote object cgroup
> instead of memory cgroup. So introduce remote objcg charging APIs to
> charge the kmem pages by using objcg_cgroup APIs. And if remote memcg
> and objcg are both set, objcg takes precedence over memcg to charge
> the kmem pages.
> 
> In the later patch, we will use those API to charge kernel memory to
> the remote objcg.

I'd abandon/postpone the rest of the patchset (patches 4 and 5) as now.
They add a lot of new code to solve a theoretical problem (please, fix
me if I'm wrong), which is not a panic or data corruption, but
a sub-optimal garbage collection behavior. I think we need a better
motivation or/and an implementation which makes the code simpler
and smaller.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/sched.h    |  4 ++++
>  include/linux/sched/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/fork.c            |  3 +++
>  mm/memcontrol.c          | 44 ++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ee46f5cab95b..8edcc71a0a1d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1318,6 +1318,10 @@ struct task_struct {
>  	/* Used by memcontrol for targeted memcg charge: */
>  	struct mem_cgroup		*active_memcg;
>  #endif
> +#ifdef CONFIG_MEMCG_KMEM
> +	/* Used by memcontrol for targeted objcg charge: */
> +	struct obj_cgroup		*active_objcg;
> +#endif
>  
>  #ifdef CONFIG_BLK_CGROUP
>  	struct request_queue		*throttle_queue;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 1ae08b8462a4..be1189598b09 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -330,6 +330,44 @@ set_active_memcg(struct mem_cgroup *memcg)
>  }
>  #endif
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +DECLARE_PER_CPU(struct obj_cgroup *, int_active_objcg);
> +
> +/**
> + * set_active_objcg - Starts the remote objcg kmem pages charging scope.
> + * @objcg: objcg to charge.
> + *
> + * This function marks the beginning of the remote objcg charging scope. All the
> + * __GFP_ACCOUNT kmem page allocations till the end of the scope will be charged
> + * to the given objcg.
> + *
> + * NOTE: This function can nest. Users must save the return value and
> + * reset the previous value after their own charging scope is over.
> + *
> + * If remote memcg and objcg are both set, objcg takes precedence over memcg
> + * to charge the kmem pages.
> + */
> +static inline struct obj_cgroup *set_active_objcg(struct obj_cgroup *objcg)
> +{
> +	struct obj_cgroup *old;
> +
> +	if (in_interrupt()) {
> +		old = this_cpu_read(int_active_objcg);
> +		this_cpu_write(int_active_objcg, objcg);
> +	} else {
> +		old = current->active_objcg;
> +		current->active_objcg = objcg;
> +	}
> +
> +	return old;
> +}
> +#else
> +static inline struct obj_cgroup *set_active_objcg(struct obj_cgroup *objcg)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #ifdef CONFIG_MEMBARRIER
>  enum {
>  	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY		= (1U << 0),
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66cd1014211..b4b9dd5d122f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -945,6 +945,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  #ifdef CONFIG_MEMCG
>  	tsk->active_memcg = NULL;
>  #endif
> +#ifdef CONFIG_MEMCG_KMEM
> +	tsk->active_objcg = NULL;
> +#endif
>  	return tsk;
>  
>  free_stack:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0cf342d22547..e48d4ab0af76 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -79,6 +79,11 @@ struct mem_cgroup *root_mem_cgroup __read_mostly;
>  /* Active memory cgroup to use from an interrupt context */
>  DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +/* Active object cgroup to use from an interrupt context */
> +DEFINE_PER_CPU(struct obj_cgroup *, int_active_objcg);
> +#endif
> +
>  /* Socket memory accounting disabled? */
>  static bool cgroup_memory_nosocket;
>  
> @@ -1076,7 +1081,7 @@ static __always_inline struct mem_cgroup *get_active_memcg(void)
>  	return memcg;
>  }
>  
> -static __always_inline bool memcg_kmem_bypass(void)
> +static __always_inline bool memcg_charge_bypass(void)
>  {
>  	/* Allow remote memcg charging from any context. */
>  	if (unlikely(active_memcg()))
> @@ -1094,7 +1099,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>   */
>  static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
>  {
> -	if (memcg_kmem_bypass())
> +	if (memcg_charge_bypass())
>  		return NULL;
>  
>  	if (unlikely(active_memcg()))
> @@ -1103,6 +1108,29 @@ static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
>  	return get_mem_cgroup_from_mm(current->mm);
>  }
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +static __always_inline struct obj_cgroup *active_objcg(void)
> +{
> +	if (in_interrupt())
> +		return this_cpu_read(int_active_objcg);
> +	else
> +		return current->active_objcg;
> +}
> +
> +static __always_inline bool kmem_charge_bypass(void)
> +{
> +	/* Allow remote charging from any context. */
> +	if (unlikely(active_objcg() || active_memcg()))
> +		return false;
> +
> +	/* Memcg to charge can't be determined. */
> +	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +		return true;
> +
> +	return false;
> +}
> +#endif
> +
>  /**
>   * mem_cgroup_iter - iterate over memory cgroup hierarchy
>   * @root: hierarchy root
> @@ -2997,13 +3025,20 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  {
> -	struct obj_cgroup *objcg = NULL;
> +	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  
> -	if (memcg_kmem_bypass())
> +	if (kmem_charge_bypass())
>  		return NULL;
>  
>  	rcu_read_lock();
> +	objcg = active_objcg();
> +	if (unlikely(objcg)) {
> +		/* remote object cgroup must hold a reference. */
> +		obj_cgroup_get(objcg);
> +		goto out;
> +	}
> +
>  	if (unlikely(active_memcg()))
>  		memcg = active_memcg();
>  	else
> @@ -3015,6 +3050,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  			break;
>  		objcg = NULL;
>  	}
> +out:
>  	rcu_read_unlock();
>  
>  	return objcg;
> -- 
> 2.11.0
> 
