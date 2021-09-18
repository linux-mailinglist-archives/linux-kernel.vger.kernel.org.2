Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B348141034F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 06:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhIREGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 00:06:24 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:32737
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231509AbhIREGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRK28P8J29aXsTQvAlLhNEZR2k33n6pNvt/cCISjqIAeS+ktx5/5dyoiMhFsMfy6sOwd6NW3tLzzoLepv/Hz7AiHfarxvnJ8JRm1e4ginFDaliwkNN4BrEMznoaOpgCmslNqTlfL+mq4/jl+6bbIv+Du5LBHbUacr8MG7OhbCc1zGF987Qb5jb48d1gxArvw/kh0RINg7zIp7mY8EWgM3vAyYv7EJAODdyJP/4h+aB4kyCJRh69Ty7Pb9fKbE23eLVg1TwxqhgIH7swi3jjjSnEeBjSTF9aDY5pIkWAzjigsN6vJgcR/rgcuHYzrjJCeBPp2rb1blMdcy33VsncSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C+f5PZhjHCK9mmvDL97HN+hAhTlXsfYH7mqUhGPA9OM=;
 b=PoNsu3ZUrhBOIa6tOlF5NQNdEgVpnkZUuOTF2yP+Fe3GfeKy52GQMO32IyfP/1BypgF4gDglfEj/5ye07iYzV3AcrPY93XAHISfZTR3BNy2FVoZyvH3qA2wBGGRQgz4wpsdt+vagEMRLT8Lvbb+7fzi1EKsLiwTFtKFUN6vztzAYBE91xQXVuCF6fPD0swm5oxVNGUnzmuxOOhVu0jFFneohVpApR77kes2vdA5QgXUIM+p1tr63fzZkJdAE0q9/NrBjw/0UUhZz6iGzAVWFfbxOD/IiKkA0o8lv+FI7dxzUjVEHI6TayDMQDcTUpu53KyroOMPp1xCnwEKo6483cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+f5PZhjHCK9mmvDL97HN+hAhTlXsfYH7mqUhGPA9OM=;
 b=S1oxq3vXFdiiQwfzPW1q0wyUjVGGMR4ruUObwysBFM9KAuN7i0nyoY7vju/VHdangPkxpc+Gs0Jlb36lo6d0JfrI2o5yNiSSzTSnADJrONKS85E2gMZqFJYpFUQLdyyvTrBfc8dT05BQp9vSXSpCKCYqlmL+eRox5j8YSNughos=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB7PR03MB4220.eurprd03.prod.outlook.com (2603:10a6:10:23::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sat, 18 Sep
 2021 04:04:45 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::e955:5a94:c615:40a4]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::e955:5a94:c615:40a4%4]) with mapi id 15.20.4523.017; Sat, 18 Sep 2021
 04:04:45 +0000
Subject: Re: [PATCH] mm/migrate: fix CPUHP state to update node demotion order
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
References: <20210918025849.88901-1-ying.huang@intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <ccf79d4d-4dd6-14c3-bab6-4fac034d8e22@nextfour.com>
Date:   Sat, 18 Sep 2021 07:04:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210918025849.88901-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::38)
 To DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 04:04:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee783fec-1d78-410a-2f50-08d97a5972ef
X-MS-TrafficTypeDiagnostic: DB7PR03MB4220:
X-Microsoft-Antispam-PRVS: <DB7PR03MB422028B06E7442D58B1BA9E983DE9@DB7PR03MB4220.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EviClblJ0/TtJ7q4Mz7VdPuzq1vU67cBGpM/6JgKuIiPzytaXZ6qCZF7Z35viSBdPJoSMHE2mlfgS12cQUNRa3ZItmf6zqaBI0M5fGlCMudTHOpF1spoSn39YmPBHJdmxftf1VmaqK92ZPPhRgimGc4lqWPRAPl3nm+GWeIM1RTmcttPRv0Tdmy4g2AqhaGArNx0P8M1Da0VRdLSuXS5EwqTI+TSxJo7QQFMx6TGkEfd0HgmH4mcZgNRDS2jt5AuFwvnO6ZdacFUvEQeyb7wvwXJ+92z/hrL4iN3erY/drgCE350IPKNAQtRSYLRW1lGhfvE4u6EeD8bNE3qL1c3tjAf16YQxo+nJ9kdKwyKBSkOU6AIqrpNrS9Zj4H2Xf8p6HBLspBD9ffK9EV6Gwc89xkOuSB+g6g0V1dJdvsIXrNLQwqiUV/PHgu53FSd15pZYAY8L/xGleOd5pgS3BaNkXHpjVORMbePh576fd/FyKjgP383gCegyiBp7dwgTAvIsLXjGww0Kl/9IEpAHQ/rCoRYk1+1hDE/tNK7vYFTMG8tHogtLhHAboKMYipNfGXWx0JvmZrd4q5+jHrZa29RDaC8mlBlsJDbcuzLZojiieXzv0kEYgYxMw4udPaiX55o5PFX+ec8MvqNkqoWSOoJ9c5/p9ZN3Bb6CImTxOkl9XiO7fiIcJtucsCFf4rUdtpG0g6V1r+ADPyPQollVd41qglQMineWQsadKIgHFjDPalxZfrQVJoLQ8zbTQ7BqGVMguof96qrvUSNYR35awxixQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39830400003)(2906002)(4326008)(8676002)(86362001)(54906003)(83380400001)(5660300002)(2616005)(8936002)(38350700002)(38100700002)(36756003)(31696002)(316002)(6486002)(956004)(186003)(52116002)(26005)(15650500001)(478600001)(66946007)(7416002)(31686004)(16576012)(66476007)(110136005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhmLzVXRnE3S2s2djN4NGlqTmpPYmo0RSs1SGgxeUp5OUR3ZXBLUW16ODZs?=
 =?utf-8?B?T0JzdXNORnhDTUluNXlpcGRzV2MvVVFOU3NRY1lQMDZVcmZEZXFFWUcxVkxV?=
 =?utf-8?B?SFBiOGNyRnJjaXUxaTZlS3VITnlIdjh5bjZkTnBRZjRkM21lOXlhdmtQbldW?=
 =?utf-8?B?SmlZaVp1UGwvNTVScFlMck9nZ21YUXhsM1hzTWg1RHhlS25FbTh1TmpKeHdW?=
 =?utf-8?B?OVpRcmN4dFdDRFU0VjAxVFEwNHZVWDhkT1BKSG5rS3lFbDcvbHUybXZlSy9I?=
 =?utf-8?B?eWIvTnVWMXlKSUh0cnhMTGlYSVRFUGZBYlcyK0ZjdFlXK1oyRnZzc2pxNDhv?=
 =?utf-8?B?aGdkTEJWWE4ya3dPVWRvbnMrSVJIM3VPa2J4Q2NkemF6eVM4OXIxRHpxZ1du?=
 =?utf-8?B?R05XdW1FVmJQRXB3QnMxY0p5Yk5QZUdFalQ3Y1JXaEJpTWRjU3FkUjZpOWhi?=
 =?utf-8?B?YTMwaHZBa3FHUG9nbWlZVjhGcHZ4ZDhWbUd1TXcwUXJVTGRuVzJiYkNjeVVI?=
 =?utf-8?B?S3pIVi9Db01zMGp6SExZVVpMcjF1elZWY1pZcjlHWGxjakJaaTYwWUM5Vkxn?=
 =?utf-8?B?Qmg4QUZZWXd0N0w0T1dvZU1WMnJRa2dIWTFLcUtNckp2eFJDbmhjTzlzNFlx?=
 =?utf-8?B?cjhLVnZoaFpvWWZzbUlJYmx5RHFkMngyaE9qODA1bjNLeWpCWmVmNXFtekNX?=
 =?utf-8?B?U0ZVMVFlampMYUZua3FsMkJoRE81NWxRRkY5NDRFcE1YK0l4dWYwcHFFaTVJ?=
 =?utf-8?B?SmtnWkVKWUZjRlVoelgvaVRaOVJiZnpnOUpJV21MY0FTbHhRQnVOYmRUc3ZW?=
 =?utf-8?B?cG1BRjVKU3hGNzIwaWMrWDFCRWtUZFJCK1UrNUtTV1B1YzJaY3orNnc2QXRN?=
 =?utf-8?B?MkZjTmlMWTVxWTJDeVJIanRqLytqaEZPdWhhL204QnVZTmF1ODAyRkVLRTBn?=
 =?utf-8?B?ZmhWSnpXOEdrdDkyKzlVYnU5QWU5MzJhT3JkOUVNb1o1cXJibDlGempVdVlG?=
 =?utf-8?B?V2s4ZUZJK1ZKSHBvWmZyb2FlaXZ2NmF4eXoyVHlNVkcwOVVZeXdtRXdZZlIr?=
 =?utf-8?B?Z3Z4MXJPN3AwVGdhVWlxNmhFV290WlRrNDRabEs5VkVKZWVvRHE5NWV5WVdo?=
 =?utf-8?B?N2VldzE0OWRJV0MyeGoyTklBUEZuVjJETkkxeGhiZFZLY0NaSEF5MjFFYTMx?=
 =?utf-8?B?RWt2d3UzNkRxMlFHQ1E1L0JLS3hONC9qZFFndDlZV0VNSzc4WG5iQUpUeTVk?=
 =?utf-8?B?KzBXcWczRDNMdXJ4KzVHRHdVWVRwZWRIWUR0SlZpWlRMeHpPU2ppTzR1Wkk1?=
 =?utf-8?B?TEx0b3NVeGhzMWVnOU9ITloyQndDaTF1QjJBVkZWY1Q3RTY4WGxIWUpRa28y?=
 =?utf-8?B?T0NyRHg0d2htVU1NMk50T1hqT1NCbVhJV05GejVKSzBrUUIzWXpoNXE2Q01Q?=
 =?utf-8?B?TS9DaUQxZVp6TXo5QU5STTB0MDVCUzR0OEV3cDF6SFRXMk9BZUtLVlk4dmlS?=
 =?utf-8?B?enlIN2pITzB0d1UwdmllUjRDVytIVTNJVG0vQ3JZYmJvV01iOWRHSnpiTDQ3?=
 =?utf-8?B?T1lxeHVXbGJHNC8xbkNKcmJTZUlWQWN1TWJrNHdiL1FKODA5VDBzS3JWOVdr?=
 =?utf-8?B?aHRmYlVGRG1VcklOUExvZm1IV1R1T3g2dzJ3emtVVEZXcGw4di9ZRmpzbEVX?=
 =?utf-8?B?UEtiRVZ3elNzTVZTRFFhbnpVWUlKTHFwSy80KzlBUGtrakZSZHQ5WkMwYkRU?=
 =?utf-8?Q?bGanf3FG6cw1nMJRMB/TNR5oeg239VYvaWcpWRt?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee783fec-1d78-410a-2f50-08d97a5972ef
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 04:04:45.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM2/WWuKupalpA2WqOaMmV6n1/P3eOISNuEGI6Liijalv7MWnlHybBcsn5M1eplj+VeRYPvmjj7hWXN4IDeEHS/eY5biIZAMiAFGpdsAiac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 18.9.2021 5.58, Huang Ying wrote:
> The node demotion order needs to be updated during CPU hotplug.
> Because whether a NUMA node has CPU may influence the demotion order.
> The update function should be called during CPU online/offline after
> the node_states[N_CPU] has been updated.  That is done in
> CPUHP_AP_ONLINE_DYN during CPU online and in CPUHP_MM_VMSTAT_DEAD
> during CPU offline.  But in commit 884a6e5d1f93 ("mm/migrate: update
> node demotion order on hotplug events"), the function to update node
> demotion order is called in CPUHP_AP_ONLINE_DYN during CPU
> online/offline.  This doesn't satisfy the order requirement.  So in
> this patch, we added CPUHP_AP_MM_DEMOTION_ONLINE and
> CPUHP_MM_DEMOTION_OFFLINE to be called after CPUHP_AP_ONLINE_DYN and
> CPUHP_MM_VMSTAT_DEAD during CPU online/offline, and register the
> update function on them.
>
> Fixes: 884a6e5d1f93 ("mm/migrate: update node demotion order on hotplug events")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> ---
>   include/linux/cpuhotplug.h | 2 ++
>   mm/migrate.c               | 8 +++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 832d8a74fa59..5a92ea56f21b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -72,6 +72,7 @@ enum cpuhp_state {
>   	CPUHP_SLUB_DEAD,
>   	CPUHP_DEBUG_OBJ_DEAD,
>   	CPUHP_MM_WRITEBACK_DEAD,
> +	CPUHP_MM_DEMOTION_OFFLINE,
>   	CPUHP_MM_VMSTAT_DEAD,
>   	CPUHP_SOFTIRQ_DEAD,
>   	CPUHP_NET_MVNETA_DEAD,
> @@ -240,6 +241,7 @@ enum cpuhp_state {
>   	CPUHP_AP_BASE_CACHEINFO_ONLINE,
>   	CPUHP_AP_ONLINE_DYN,
>   	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
> +	CPUHP_AP_MM_DEMOTION_ONLINE,
>   	CPUHP_AP_X86_HPET_ONLINE,
>   	CPUHP_AP_X86_KVM_CLK_ONLINE,
>   	CPUHP_AP_DTPM_CPU_ONLINE,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a6a7743ee98f..77d107a4577f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3278,9 +3278,8 @@ static int __init migrate_on_reclaim_init(void)
>   {
>   	int ret;
>   
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
> -				migration_online_cpu,
> -				migration_offline_cpu);
> +	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_OFFLINE, "mm/demotion:offline",
> +					NULL, migration_offline_cpu);
>   	/*
>   	 * In the unlikely case that this fails, the automatic
>   	 * migration targets may become suboptimal for nodes
> @@ -3288,6 +3287,9 @@ static int __init migrate_on_reclaim_init(void)
>   	 * rare case, do not bother trying to do anything special.
>   	 */
>   	WARN_ON(ret < 0);
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
> +					migration_online_cpu, NULL);
>

You changed to _nocalls variant, how does this handle initialization for 
cpus present at boot?

Thanks,
Mika

