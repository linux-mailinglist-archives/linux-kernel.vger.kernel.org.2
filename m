Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583BD32A0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576407AbhCBE2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:28:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379610AbhCBB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:29:58 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1221SMa1001658;
        Mon, 1 Mar 2021 17:29:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=BC+jJiFRWHoMSneD71MFXWrIrMwhICXmj7EkfIbR/NY=;
 b=oCPA1ocmGOEddax0fYH+TBnavn4b5csQLb9Y2MpBzP62HKXZ86dolW7wA9ipfipLD/Ih
 09ZipaxydAhW8mWfb1Ud0c2qsUhVuHrqfCQBWXXa7imERwTKBhADrR7uYLB85UQTAESZ
 fc8NTYybCWaASYpJqWk57BquYOabALm7VHc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3707450pkq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Mar 2021 17:29:10 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 17:29:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+kcMeFqwaneZt+B8YqSoL+u3hAbJTfXlEeeaw1FCUga5T+FfkpT0znRoWodPJ8CbaOQHfXfjZw4hF0e4jxfjC0qFyK3g3NRGczkoLxLel64kaPG6a9sM5pcrIaAAl8lzoByZleTjHaF7d75NlkQy7EUV9WE232cb0qSVWxaeNVc7MmIM5yJ9sChnZlvesIRFkUs2xAHqyMuMuRTzNmO1K7yihTulPbBVbmDhW71n9kCngUBW0dLy7AuxUACHb3jAPAhs54+P0z65Lek+RvNxZqlP2LIh37pwwY5wMe0CPxDMv05UvZSgLzneC6ru1rpkt+sQqZWhmjXoKuhbTDg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC+jJiFRWHoMSneD71MFXWrIrMwhICXmj7EkfIbR/NY=;
 b=DKu+mwYfKjtp8HXJaF9E+3N/UB8L4yNM4fh5TGpcozkxuOa2lepDwpjFqMRC6hwEE/+L3twaic3x89yw0GNzWUJq4jLzJ3oiDiqti9vlkuI/6asPeBYSr0hgwmTTWl6j2sAPBYrllQmqaGWX8dkRlM4jBH6Vw6OIfYfhyl/ZsU7XcTP/Pr0NKy7d38o1LugPEVkRtTBGz9R5rn8asEV4cvLF6PBAUON+d2+cUzzr/D3XHymf7qJUk6fkugCxJTtoIuRi06DGkwLRnKJb0/7n+nkifLSfGWd6nbxJATyvk3maXjEx00lVXHM+jjVbnNmZcdm9cFeK7cgjYv9ED8uj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4758.namprd15.prod.outlook.com (2603:10b6:a03:37b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 01:29:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 01:29:06 +0000
Date:   Mon, 1 Mar 2021 17:29:02 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>
Subject: Re: [PATCH 5/5] mm: memcontrol: use object cgroup for remote memory
 cgroup charging
Message-ID: <YD2U3rfjQ9fhx8pD@carbon.dhcp.thefacebook.com>
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210301062227.59292-6-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:642c]
X-ClientProxiedBy: MWHPR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:300:6c::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:642c) by MWHPR04CA0057.namprd04.prod.outlook.com (2603:10b6:300:6c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Tue, 2 Mar 2021 01:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef0f3fc-1a32-4733-cf22-08d8dd1a919d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4758:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB47586FDF51057F240D7D4FBCBE999@SJ0PR15MB4758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbKnHvkxeuUrsS5AiZpgqRlh44p9i+0vFUxaPnByxZMP/FizexxQ84Wsz6kljXUYWlYOk54HTy9ahHdmo98v4ltYeMLrqD5VDasMkgHwhAEa0tN4rNORpHlc0Gg2+sZ6WKPh9T8tP9gG/pshty2bCPXmK9FitoZA6GNbDlSAlVvES7G42uD6LlW9ZKKfPiwLaPqcp2C42wNm9is5mlTOi3JnvRRtoavbBElRGyi1pbvfSl5NylPGPmAaCkOOjxr+woXug+e9AhFpatGPDTsctVa1FYdHniiWwkmYTxwBoFKrOS42GtkfQQhoEdwwwIjiUN25APi+8DQJIHiVbw8BojZd6xGKxRsC4wQX72Zy3Cv5DCbp6+ufYnDdm8CCEfJuJMrVIF0LJXaqKViIH2OG17BTQVnucoQOrZhAXcoA+g1BBpPbekd2AteaGCmHVZuy9v7mcQBU0p5a7mci3Sd7MtLAVWUs50P3L3fMe+IV4O9nvy72bj+L34OO+ZJdTWz2NkNyQ1QhAju4N7P2A0G4dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(396003)(136003)(16526019)(83380400001)(6916009)(66476007)(66946007)(186003)(66556008)(316002)(30864003)(5660300002)(86362001)(6506007)(9686003)(478600001)(55016002)(8676002)(4326008)(52116002)(2906002)(7696005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?26CFPJDlm9XQJHOjN0rr+z2eApkF1Ep58KoOMv3DXwdVGq6LZMiALjAOXz6o?=
 =?us-ascii?Q?dSWlsIoVV6t43GZ1tneai56UpDYGi5g9KS9M2emOGrwBZFGG3CslP2oOrrCF?=
 =?us-ascii?Q?2OhVV306sC49BO+Z5G85e2mycdDamtRMcs/2ZVnznV1pfdHXOGnRcYT/mP5K?=
 =?us-ascii?Q?qXXS95MN8b6dwIDQHImE4vqZ/DFnviYkXi579tJ83YYFkjseVYTMJKfHIr1W?=
 =?us-ascii?Q?kxyddby320CCSyAxW9oh4uL0CAw/lED5OSOwlvcZuZbEV8fF5pTqHyBMbyE3?=
 =?us-ascii?Q?a6Hm4VQDa8asdELDuR0rnbNfuxiIs+MfloyrLpC+eUzPOarhTNiKRg02SwpI?=
 =?us-ascii?Q?GemoLe5iq03aab2uMYcRFIcn5W0a8YV950iYlTVd7Eeu7NrEfaCJ8pBmCjYC?=
 =?us-ascii?Q?fPRLZLftR/GT3EOM6kYY3SAA51ExPAJ2ZZ5zs/IRnt4KeYDEhWl2CsoY3EmG?=
 =?us-ascii?Q?qc18qVPofRmXzQp+hVpGPEVADDqWgv76BWY4IRN/xFauLvoo44boraD9Qsq/?=
 =?us-ascii?Q?foZA2IW8p7UEFWl+TzSiDkuKVVcQyQu4ZhvLo+jtvvkrVQv4bQRQt/0wg095?=
 =?us-ascii?Q?00Dz4WUDSMidwUPe7wrvDNyU4IyTOwhf7f6anRj0UZOPoLwK6OJHLs4eSvku?=
 =?us-ascii?Q?E2Ma0tR6CU2W3WNFjeBY2ZYNMPE7GjlxpX/AzYZPwOFDJu4WM1yUn2xY8C9G?=
 =?us-ascii?Q?774jnbHHs3IbjWpZsOQWeH+2YQb1iTne31RASYOJaY0TdrMat4Pp6qXtGT+g?=
 =?us-ascii?Q?OqXk22/xmXalJm4YS2Y4ssbVbbZMu2veuB0bCrkVBgjWq7ajMu2/GM5KtP22?=
 =?us-ascii?Q?bP6Ok8VKAVI1QGXz35C6ctJQ3+PhW4Cnqym9iVqT7t/qiIcqaSh6Msm8PL2E?=
 =?us-ascii?Q?FcOXWJ9jQI+xaUL1oK19UG0rUdW0LbPF1luYTREhhixixDkRZwgJVXu01veI?=
 =?us-ascii?Q?WAYZiU1wxBhqADdu3mlIZI31EQFnbcowi9sJMns8EMhWuIWU546CydUhH3Tm?=
 =?us-ascii?Q?+bCfBWVKDsBK2g6vxDYc4lLsLT4rKnl8TNBlXVWHj7O0zpBpzBRKauXT40EX?=
 =?us-ascii?Q?TxzzqEoF/2f8nlYyEyRb47Qa25F+vdlAToD8m+tGa/qy2/7/MFwqby7QiBPQ?=
 =?us-ascii?Q?yIRZYSjrfZp42bgvmzyInRd2Lo2/bTPOaZhApbLG1COXNXh9ENo4KSkuwy0Y?=
 =?us-ascii?Q?nKbp59Fh8Q7a6g7rz+gKii9ocwD1X9j/SxAirfoZbt9VxYacMKX97tyDra/G?=
 =?us-ascii?Q?+i+H4NHbJyQggrh14ITMqrNNnWTTgBCzEadmBndCAfIYpnGpnctWV4qfYGb7?=
 =?us-ascii?Q?fVVEGwsmKMiL5EwuUFZAHydqz5ge5nV0p/bAkFdUybKMxQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef0f3fc-1a32-4733-cf22-08d8dd1a919d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 01:29:06.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YwR+9TDrZsWvM1wJi4b/mG5kIYUbrT8rGovXNT9U6h6zFQcWUz1hn6FAogbzhIO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_15:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 02:22:27PM +0800, Muchun Song wrote:
> We spent a lot of energy to make slab accounting do not hold a refcount
> to memory cgroup, so the dying cgroup can be freed as soon as possible
> on cgroup offlined.
> 
> But some users of remote memory cgroup charging (e.g. bpf and fsnotify)
> hold a refcount to memory cgroup for charging to it later. Actually,
> the slab core use obj_cgroup APIs for memory cgroup charing, so we can
> hold a refcount to obj_cgroup instead of memory cgroup. In this case,
> the infrastructure of remote meory charging also do not hold a refcount
> to memory cgroup.

-cc all except mm folks

Same here, let's not switch the remote charging infra to objcg to save
an ability to use it for user pages. If we have a real problem with bpf/...,
let's solve it case by case.

Thanks!

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/buffer.c                          | 10 ++++--
>  fs/notify/fanotify/fanotify.c        |  6 ++--
>  fs/notify/fanotify/fanotify_user.c   |  2 +-
>  fs/notify/group.c                    |  3 +-
>  fs/notify/inotify/inotify_fsnotify.c |  8 ++---
>  fs/notify/inotify/inotify_user.c     |  2 +-
>  include/linux/bpf.h                  |  2 +-
>  include/linux/fsnotify_backend.h     |  2 +-
>  include/linux/memcontrol.h           | 15 ++++++++
>  include/linux/sched.h                |  4 +--
>  include/linux/sched/mm.h             | 28 +++++++--------
>  kernel/bpf/syscall.c                 | 35 +++++++++----------
>  kernel/fork.c                        |  2 +-
>  mm/memcontrol.c                      | 66 ++++++++++++++++++++++++++++--------
>  14 files changed, 121 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 591547779dbd..cc99fcf66368 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -842,14 +842,16 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>  	struct buffer_head *bh, *head;
>  	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
>  	long offset;
> -	struct mem_cgroup *memcg, *old_memcg;
> +	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg, *old_objcg;
>  
>  	if (retry)
>  		gfp |= __GFP_NOFAIL;
>  
>  	/* The page lock pins the memcg */
>  	memcg = page_memcg(page);
> -	old_memcg = set_active_memcg(memcg);
> +	objcg = get_obj_cgroup_from_mem_cgroup(memcg);
> +	old_objcg = set_active_obj_cgroup(objcg);
>  
>  	head = NULL;
>  	offset = PAGE_SIZE;
> @@ -868,7 +870,9 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>  		set_bh_page(bh, page, offset);
>  	}
>  out:
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
> +	if (objcg)
> +		obj_cgroup_put(objcg);
>  	return head;
>  /*
>   * In case anything failed, we just free everything we got.
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 1192c9953620..04d24acfffc7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -530,7 +530,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -	struct mem_cgroup *old_memcg;
> +	struct obj_cgroup *old_objcg;
>  	struct inode *child = NULL;
>  	bool name_event = false;
>  
> @@ -580,7 +580,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  		gfp |= __GFP_RETRY_MAYFAIL;
>  
>  	/* Whoever is interested in the event, pays for the allocation. */
> -	old_memcg = set_active_memcg(group->memcg);
> +	old_objcg = set_active_obj_cgroup(group->objcg);
>  
>  	if (fanotify_is_perm_event(mask)) {
>  		event = fanotify_alloc_perm_event(path, gfp);
> @@ -608,7 +608,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  		event->pid = get_pid(task_tgid(current));
>  
>  out:
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
>  	return event;
>  }
>  
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9e0c1afac8bd..055ca36d4e0e 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -985,7 +985,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	group->fanotify_data.user = user;
>  	group->fanotify_data.flags = flags;
>  	atomic_inc(&user->fanotify_listeners);
> -	group->memcg = get_mem_cgroup_from_mm(current->mm);
> +	group->objcg = get_obj_cgroup_from_current();
>  
>  	group->overflow_event = fanotify_alloc_overflow_event();
>  	if (unlikely(!group->overflow_event)) {
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index ffd723ffe46d..fac46b92c16f 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -24,7 +24,8 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
>  	if (group->ops->free_group_priv)
>  		group->ops->free_group_priv(group);
>  
> -	mem_cgroup_put(group->memcg);
> +	if (group->objcg)
> +		obj_cgroup_put(group->objcg);
>  	mutex_destroy(&group->mark_mutex);
>  
>  	kfree(group);
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index 1901d799909b..20835554819a 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -66,7 +66,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>  	int ret;
>  	int len = 0;
>  	int alloc_len = sizeof(struct inotify_event_info);
> -	struct mem_cgroup *old_memcg;
> +	struct obj_cgroup *old_objcg;
>  
>  	if (name) {
>  		len = name->len;
> @@ -81,12 +81,12 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
>  
>  	/*
>  	 * Whoever is interested in the event, pays for the allocation. Do not
> -	 * trigger OOM killer in the target monitoring memcg as it may have
> +	 * trigger OOM killer in the target monitoring objcg as it may have
>  	 * security repercussion.
>  	 */
> -	old_memcg = set_active_memcg(group->memcg);
> +	old_objcg = set_active_obj_cgroup(group->objcg);
>  	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
>  
>  	if (unlikely(!event)) {
>  		/*
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index c71be4fb7dc5..5b4de477fcac 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -649,7 +649,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
>  	oevent->name_len = 0;
>  
>  	group->max_events = max_events;
> -	group->memcg = get_mem_cgroup_from_mm(current->mm);
> +	group->objcg = get_obj_cgroup_from_current();
>  
>  	spin_lock_init(&group->inotify_data.idr_lock);
>  	idr_init(&group->inotify_data.idr);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cccaef1088ea..b6894e3cd095 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -158,7 +158,7 @@ struct bpf_map {
>  	u32 btf_value_type_id;
>  	struct btf *btf;
>  #ifdef CONFIG_MEMCG_KMEM
> -	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
>  #endif
>  	char name[BPF_OBJ_NAME_LEN];
>  	u32 btf_vmlinux_value_type_id;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index e5409b83e731..d0303f634da6 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -220,7 +220,7 @@ struct fsnotify_group {
>  						 * notification list is too
>  						 * full */
>  
> -	struct mem_cgroup *memcg;	/* memcg to charge allocations */
> +	struct obj_cgroup *objcg;	/* objcg to charge allocations */
>  
>  	/* groups can define private fields here or use the void *private */
>  	union {
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 27043478220f..96e63ec7274a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1642,6 +1642,7 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
>  void __memcg_kmem_uncharge_page(struct page *page, int order);
>  
> +struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg);
>  struct obj_cgroup *get_obj_cgroup_from_current(void);
>  
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
> @@ -1692,6 +1693,20 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>  struct mem_cgroup *mem_cgroup_from_obj(void *p);
>  
>  #else
> +static inline
> +struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg)
> +{
> +	return NULL;
> +}
> +
> +static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> +{
> +}
>  
>  static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
>  					 int order)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c2d488eddf85..75d5b571edcb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1317,8 +1317,8 @@ struct task_struct {
>  #endif
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -	/* Used by memcontrol for targeted memcg charge: */
> -	struct mem_cgroup		*active_memcg;
> +	/* Used by memcontrol for targeted object cgroup charge: */
> +	struct obj_cgroup		*active_objcg;
>  #endif
>  
>  #ifdef CONFIG_BLK_CGROUP
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 64a72975270e..e713f4290914 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -295,36 +295,34 @@ static inline void memalloc_nocma_restore(unsigned int flags)
>  #endif
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> +DECLARE_PER_CPU(struct obj_cgroup *, int_active_objcg);
>  /**
> - * set_active_memcg - Starts the remote memcg charging scope.
> - * @memcg: memcg to charge.
> + * set_active_obj_cgroup - Starts the remote object cgroup charging scope.
> + * @objcg: object cgroup to charge.
>   *
> - * This function marks the beginning of the remote memcg charging scope. All the
> - * __GFP_ACCOUNT allocations till the end of the scope will be charged to the
> - * given memcg.
> + * This function marks the beginning of the remote object cgroup charging scope.
> + * All the __GFP_ACCOUNT allocations till the end of the scope will be charged
> + * to the given object cgroup.
>   *
>   * NOTE: This function can nest. Users must save the return value and
>   * reset the previous value after their own charging scope is over.
>   */
> -static inline struct mem_cgroup *
> -set_active_memcg(struct mem_cgroup *memcg)
> +static inline struct obj_cgroup *set_active_obj_cgroup(struct obj_cgroup *objcg)
>  {
> -	struct mem_cgroup *old;
> +	struct obj_cgroup *old;
>  
>  	if (in_interrupt()) {
> -		old = this_cpu_read(int_active_memcg);
> -		this_cpu_write(int_active_memcg, memcg);
> +		old = this_cpu_read(int_active_objcg);
> +		this_cpu_write(int_active_objcg, objcg);
>  	} else {
> -		old = current->active_memcg;
> -		current->active_memcg = memcg;
> +		old = current->active_objcg;
> +		current->active_objcg = objcg;
>  	}
>  
>  	return old;
>  }
>  #else
> -static inline struct mem_cgroup *
> -set_active_memcg(struct mem_cgroup *memcg)
> +static inline struct obj_cgroup *set_active_obj_cgroup(struct obj_cgroup *objcg)
>  {
>  	return NULL;
>  }
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c859bc46d06c..1b078eddf083 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -390,37 +390,38 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -static void bpf_map_save_memcg(struct bpf_map *map)
> +static void bpf_map_save_objcg(struct bpf_map *map)
>  {
> -	map->memcg = get_mem_cgroup_from_mm(current->mm);
> +	map->objcg = get_obj_cgroup_from_current();
>  }
>  
> -static void bpf_map_release_memcg(struct bpf_map *map)
> +static void bpf_map_release_objcg(struct bpf_map *map)
>  {
> -	mem_cgroup_put(map->memcg);
> +	if (map->objcg)
> +		obj_cgroup_put(map->objcg);
>  }
>  
>  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
>  			   int node)
>  {
> -	struct mem_cgroup *old_memcg;
> +	struct obj_cgroup *old_objcg;
>  	void *ptr;
>  
> -	old_memcg = set_active_memcg(map->memcg);
> +	old_objcg = set_active_obj_cgroup(map->objcg);
>  	ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
>  
>  	return ptr;
>  }
>  
>  void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
>  {
> -	struct mem_cgroup *old_memcg;
> +	struct obj_cgroup *old_objcg;
>  	void *ptr;
>  
> -	old_memcg = set_active_memcg(map->memcg);
> +	old_objcg = set_active_obj_cgroup(map->objcg);
>  	ptr = kzalloc(size, flags | __GFP_ACCOUNT);
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
>  
>  	return ptr;
>  }
> @@ -428,22 +429,22 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
>  void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
>  				    size_t align, gfp_t flags)
>  {
> -	struct mem_cgroup *old_memcg;
> +	struct obj_cgroup *old_objcg;
>  	void __percpu *ptr;
>  
> -	old_memcg = set_active_memcg(map->memcg);
> +	old_objcg = set_active_obj_cgroup(map->objcg);
>  	ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
>  
>  	return ptr;
>  }
>  
>  #else
> -static void bpf_map_save_memcg(struct bpf_map *map)
> +static void bpf_map_save_objcg(struct bpf_map *map)
>  {
>  }
>  
> -static void bpf_map_release_memcg(struct bpf_map *map)
> +static void bpf_map_release_objcg(struct bpf_map *map)
>  {
>  }
>  #endif
> @@ -454,7 +455,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
>  	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  
>  	security_bpf_map_free(map);
> -	bpf_map_release_memcg(map);
> +	bpf_map_release_objcg(map);
>  	/* implementation dependent freeing */
>  	map->ops->map_free(map);
>  }
> @@ -877,7 +878,7 @@ static int map_create(union bpf_attr *attr)
>  	if (err)
>  		goto free_map_sec;
>  
> -	bpf_map_save_memcg(map);
> +	bpf_map_save_objcg(map);
>  
>  	err = bpf_map_new_fd(map, f_flags);
>  	if (err < 0) {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66718bc82d5..5a800916ad8d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -943,7 +943,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  #endif
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -	tsk->active_memcg = NULL;
> +	tsk->active_objcg = NULL;
>  #endif
>  	return tsk;
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 092dc4588b43..024a0f377eb7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -77,8 +77,8 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
>  struct mem_cgroup *root_mem_cgroup __read_mostly;
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -/* Active memory cgroup to use from an interrupt context */
> -DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> +/* Active object cgroup to use from an interrupt context */
> +DEFINE_PER_CPU(struct obj_cgroup *, int_active_objcg);
>  #endif
>  
>  /* Socket memory accounting disabled? */
> @@ -1057,18 +1057,18 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -static __always_inline struct mem_cgroup *active_memcg(void)
> +static __always_inline struct obj_cgroup *active_obj_cgroup(void)
>  {
>  	if (in_interrupt())
> -		return this_cpu_read(int_active_memcg);
> +		return this_cpu_read(int_active_objcg);
>  	else
> -		return current->active_memcg;
> +		return current->active_objcg;
>  }
>  
>  static __always_inline bool memcg_kmem_bypass(void)
>  {
>  	/* Allow remote memcg charging from any context. */
> -	if (unlikely(active_memcg()))
> +	if (unlikely(active_obj_cgroup()))
>  		return false;
>  
>  	/* Memcg to charge can't be determined. */
> @@ -2971,26 +2971,47 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	return page_memcg_check(page);
>  }
>  
> -__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> +__always_inline
> +struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg = NULL;
> +
> +	rcu_read_lock();
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> +		objcg = rcu_dereference(memcg->objcg);
> +		if (objcg && obj_cgroup_tryget(objcg))
> +			break;
> +		objcg = NULL;
> +	}
> +	rcu_read_unlock();
> +
> +	return objcg;
> +}
> +
> +__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> +{
> +	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  
>  	if (memcg_kmem_bypass())
>  		return NULL;
>  
>  	rcu_read_lock();
> -	if (unlikely(active_memcg()))
> -		memcg = active_memcg();
> -	else
> -		memcg = mem_cgroup_from_task(current);
> +	objcg = active_obj_cgroup();
> +	if (unlikely(objcg)) {
> +		/* remote object cgroup must hold a reference. */
> +		obj_cgroup_get(objcg);
> +		goto out;
> +	}
>  
> +	memcg = mem_cgroup_from_task(current);
>  	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
>  		objcg = rcu_dereference(memcg->objcg);
>  		if (objcg && obj_cgroup_tryget(objcg))
>  			break;
>  		objcg = NULL;
>  	}
> +out:
>  	rcu_read_unlock();
>  
>  	return objcg;
> @@ -5296,16 +5317,33 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  	return ERR_PTR(error);
>  }
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +static inline struct obj_cgroup *memcg_obj_cgroup(struct mem_cgroup *memcg)
> +{
> +	return memcg ? memcg->objcg : NULL;
> +}
> +#else
> +static inline struct obj_cgroup *memcg_obj_cgroup(struct mem_cgroup *memcg)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static struct cgroup_subsys_state * __ref
>  mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  {
>  	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
> -	struct mem_cgroup *memcg, *old_memcg;
> +	struct mem_cgroup *memcg;
> +	struct obj_cgroup *old_objcg;
>  	long error = -ENOMEM;
>  
> -	old_memcg = set_active_memcg(parent);
> +	/*
> +	 * The @parent cannot be offlined, so @parent->objcg cannot be freed
> +	 * under us.
> +	 */
> +	old_objcg = set_active_obj_cgroup(memcg_obj_cgroup(parent));
>  	memcg = mem_cgroup_alloc();
> -	set_active_memcg(old_memcg);
> +	set_active_obj_cgroup(old_objcg);
>  	if (IS_ERR(memcg))
>  		return ERR_CAST(memcg);
>  
> -- 
> 2.11.0
> 
