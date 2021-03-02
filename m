Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6969932AD60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837452AbhCBVql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:46:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1835279AbhCBSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:51:51 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122IgaOj005470;
        Tue, 2 Mar 2021 10:50:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=X2ud8GF51iDNqBPRYdRv8p0r1IpZQqXQWQVf6NQ4fSA=;
 b=bfBrxud0Gpf6YJDc9w9CgUpPuXvIvyGX6Mlq+UejQMOI++jBsYBFMgrntrXQKVMjKgnw
 NtSVi+sQKUuHSQC7yoSNXror6Zb+iYFX8ffUm/IE95AtCogCZiJWOBFnM7Re1ngCBVGG
 FUtf/bi2a6sXoF0Spq3gx+O7cOSYPf2tTLw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3706nnd9u2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 10:50:50 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Mar 2021 10:50:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzf2neRSc/LM4ruILOb5R3GuhWqX1D9BaMkLC0V1x3YwW9d2gyqhvS+pJQCcXk8+1ESjjmTQW2KlzXeyh67nzt4+LcVnKAotHgdK7vNFAq508TMf4fgP4tUAV2soZZiqR7x54ymIfCVlPuU0MnbXNxs9zUCJaN8GWrWPbx4rRPz+9No5UTjlinJiB5mo4FS/KtLQOR6NAgxK5P/kAJAdO+ULxUYpiyK5COQYAimhxH/2bFsyfHNa/K/wUTylA0vaY+oira9I/HrCByAzaonx57B7QcvGNai0VmimGxea5fJbAE1CAaepvuvfkrnj6m2fAufflBGjUZCkJX+Ia5uRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2ud8GF51iDNqBPRYdRv8p0r1IpZQqXQWQVf6NQ4fSA=;
 b=iepMFW6j/Ifwr4AmQrCOhtYfQ0aRuIuS7p+PSNKl94/W9goRTq+ZpAPM66M9K5podGkk654/UwWBC5/eiQvcOlaCVCAcwHou0LrLP1JkjYLGww8ATKjq1icMe/KqbhmJJx/l+8fAT0y+/WIfl9WZOXcBlXfPi+ZroROdaSjyrTX2N0+b03BexNx7n3zvgwUxZbP2X3vEn+W4822Vho3VG+csPKkLMVIKJz7xRjAK0uzlamShqt0DxrDFewvb+LAijuR9jH158ei3h5qQa+sjWr/OhRq82dw+tinFfb2TsUmUi7YaXCpaFWgHqHP6Y4wEgC7sJ4E2Hz6wAjpK20oLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3555.namprd15.prod.outlook.com (2603:10b6:a03:1f5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 18:50:37 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 18:50:37 +0000
Date:   Tue, 2 Mar 2021 10:50:32 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: memcontrol: fix kernel stack account
Message-ID: <YD6I+DLH0SLnSgo8@carbon.dhcp.thefacebook.com>
References: <20210302073733.8928-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210302073733.8928-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:68d2]
X-ClientProxiedBy: MWHPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:300:117::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:68d2) by MWHPR03CA0017.namprd03.prod.outlook.com (2603:10b6:300:117::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 2 Mar 2021 18:50:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a8fffb-53b4-4887-7e8b-08d8ddac1176
X-MS-TrafficTypeDiagnostic: BY5PR15MB3555:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3555922BD5362B82021D12C3BE999@BY5PR15MB3555.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sirsQYydMtn6Op02xvQxtVyt5MqUfyc+x2ftaw01ufpl5KjZMGfwqlKzmfVrsnpiIFHfC2PcC0OzihwWX84kKz/bq5l+wJJrILcqLajHYQAsTlKwTeAeAt7rDfrfLaioEp7W+8CiywnA4SSCCO3svevqLkKdts7RlCGNzh4Av1cuEpJSizLtqRWbFhpI69hN6yY22MmdKs6HANNUxOoB7dUBJLNiRmXb8u5zjV6O7zWZXr6hq2JAYUuwBblpRCrD/Atkkv6JCChIodZn5D0KZFuiALZcOVFZKjY+isG8B4bst76P+e8RM4IT24WjE08HjsD9876AF+d7BD2QjaXwVEVRyBzc7ivcaT/asye4lZAY1T8gV7Nla2oMO4+o4AHLGr7JK9Bt6TDsU+m/9D6IE99q47GNE47gXFPNmjvvbkjxSghgO3lIRSDnyITnD9oBBMPYRq3VotBeadUJpUaWAtCsVGYrpvOLJ2GvsnaXE4uAJ+/Alr2rQbgT9WHxLCgHoP5iVCMOgQfK78/kXHXedd/wZ+GWHxYy7sMSHK7gzdkWJfa//t4cIDCrsLZJ0Df/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(16526019)(86362001)(186003)(6916009)(316002)(6666004)(2906002)(66946007)(83380400001)(478600001)(66556008)(5660300002)(6506007)(66476007)(9686003)(15650500001)(8936002)(4326008)(8676002)(52116002)(7696005)(55016002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4XG30YzY7tn1TWc/sa5tbykGRVaqnVqWw532F3ZIkmSN75f0lfgI+nQFvKrY?=
 =?us-ascii?Q?/Du1NqsGB0xMQiN217hTIUxmbcZiecJ75O4hFxWUXWmz1NoMqAQas6GIvxR7?=
 =?us-ascii?Q?Mhz/L9vZt8HvmqFdEcRq3sj2PL14YInjjdvKfOCMX61l30Ofelx5e+aM4M+i?=
 =?us-ascii?Q?yOIrNLhe7vNJvXslk99clIxsaJMGOxakLlQVN0ijBsMS/tteUHE/c3mR9gtG?=
 =?us-ascii?Q?ESQr26rPXk+/R4ZTDQoGiTMoNtXhbO8klBlR6G2NxbSkEmHQWYFZqa4+H3Eb?=
 =?us-ascii?Q?0ym0v/lBgL6Lv1IcZADiEWip9RwT6N2TQ54i+dT9/E+boiDIWbLDlrYNrfGi?=
 =?us-ascii?Q?6fUDKHi+N0qrwW23ugu+GERFNobluOXRhqUFpXc39JnFW2KOJgWnqIJZARHG?=
 =?us-ascii?Q?vx4YkyC9LVoEDXa3vlHIYIGVgzGSjCVwZT+KmtOLbcIVvYRk+RRXwqJGRTdX?=
 =?us-ascii?Q?vv3QusiEMo27TQ0YjMCVCr9W21K3p0S5eOphDsIVvh21P1NZrMkYt+UuvEI5?=
 =?us-ascii?Q?DVJgoq1qy8DHjvoRgB5PJl5P/NbDk2BaxcEHhPsaJDvOuFvug8OC9lPlea9g?=
 =?us-ascii?Q?ObN3KF2zvHsB7CY8CCL6ZptSO0LYzVBsYw61XSDjOC3TQtUcBx3Xsk8nh5V+?=
 =?us-ascii?Q?7y4omf1lSpDfSaBngGaN+dkOadpN04+Yj7XZ2f3LnjrNiVhdf5lIndCYrItp?=
 =?us-ascii?Q?8PtBrnP7Pp+bn1R4ZnxsobvpwqzlwtmrieLFc05cI5+sEmCJalbCKZ1rLI+5?=
 =?us-ascii?Q?SZHsYnyX095msFxDKjpUda9AQ6ZhfW8w2VJ/rVm3K5djheLe+Yh8hCHkSAKu?=
 =?us-ascii?Q?1+/eex+o0JNRlXony7dSVvs0POW2IeXm+YTJFQY0bU5nD8EdCStZ+bVFd6Vs?=
 =?us-ascii?Q?DQNKKBTEzV8lBa6c87rDML6cntXUBPlD16mltxsBw0lD9htMkJtPXY+8/gsZ?=
 =?us-ascii?Q?Xl2q2YLHVIl9jGoW+StTrk6gkmH3ygeYqTrxDCB5keAneyvemXo83yN79jJl?=
 =?us-ascii?Q?HCKywpqTop/6pKro7bryCzc2H5gWelDB5NwAcCxJG/VVlz7deTUsOg5Lbw6/?=
 =?us-ascii?Q?3DSmTqaUoLgvfTMJfqYTCSSgONUiG1Iu8vp+/rKKoKwJyu2Lb+wD7XSfi4bL?=
 =?us-ascii?Q?YGevvgNxVHA7MYAaZ1ho5jKfvh4Pm5rAe9A53cgv1j3owk5khoC19jDS9VrJ?=
 =?us-ascii?Q?wWzSqxZiuOWR7ZN+7igMnsP/nU/8Fg1noU3bnR9UVpIpaGddxFS6fWglUfjs?=
 =?us-ascii?Q?xhnW3cbzrC3ggAgQNkYbB2zTEXySPQ+fD93OM13qlfo2SMVtYUdqSohiWJER?=
 =?us-ascii?Q?9xVMSmAeNUV4GmwTBEe+ELaUF5yLN00vWzlk+/5cjWJ+fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a8fffb-53b4-4887-7e8b-08d8ddac1176
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 18:50:37.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPPLHWNSUzN9UTn45CU4A7sa1Gv+jfNDKTK0TDkzJYcQDqmYnAy333kiv5XXxMdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3555
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:37:33PM +0800, Muchun Song wrote:
> The alloc_thread_stack_node() cannot guarantee that allocated stack pages
> are in the same node when CONFIG_VMAP_STACK. Because we do not specify
> __GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
> mod_lruvec_page_state() for each page one by one.

Hm, I actually wonder if it makes any sense to split the stack over multiple
nodes? Maybe we should fix this instead?

> 
> Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/fork.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66cd1014211..6e2201feb524 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -379,14 +379,19 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  	void *stack = task_stack_page(tsk);
>  	struct vm_struct *vm = task_stack_vm_area(tsk);
>  
> +	if (vm) {
> +		int i;
>  
> -	/* All stack pages are in the same node. */
> -	if (vm)
> -		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> -				      account * (THREAD_SIZE / 1024));
> -	else
> +		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
> +					      account * (PAGE_SIZE / 1024));
> +	} else {
> +		/* All stack pages are in the same node. */
>  		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
>  				      account * (THREAD_SIZE / 1024));
> +	}
>  }
>  
>  static int memcg_charge_kernel_stack(struct task_struct *tsk)
> -- 
> 2.11.0
> 
