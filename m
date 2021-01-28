Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C4307404
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhA1Kqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:46:55 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:4192
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229596AbhA1Kqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:46:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdyRKfw3LXKMgJXk6lRfwBUyr6u7R/3/PQwGCy8zzcOqnrGlrByIREng9xAesKj9/m4aUlVh46/o4RGKpVDDC5FlS7W8LglrTNQEG2GWxJQMrbBvD104k0LFiRjWkFyr0eNbsHCzYY34PgUxhbpLxPOx/pWq+ZHgTD1tq02MB++CgKO5TnSGCav0VsJLuELPmtQesy54o9bsjQ2j/TNl7Sg+ZzyJobfmu65KRzY1VABNQSuXhLGNKCE8j4jKI9olMlTa3pWjr+84wZ0DPzRCpHpf7ImAkmsX1Kb9pnlDcm3q6gPTkjrg6Q24nhAsLmq4xe0X/2zN9If0FSqnT9faAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSNN3hmbNQmty0osrwoOUYgga0ox7m9gZiYlPWFjpvU=;
 b=iBt6xArfN8/e3ZsegTE9llio9Zdixm7tX+z+DxhLlUpXlpi772YCHcgIpyCfETWZHjSWgouOpJ3qAJsbWG+HsJyuZWV7kVoE3aCpsEugEaQ5ND+RAlW/NhBhqjNE+PIGpHG6ylNNkrHQoFdH4pzTUZmDvS0Bl6/HzzzufcHC/DgoUS5IKRczZUyvo6rydFUshFj/Cc7HFq0SC1UTun8nhqGgypXUXrhUyhGgudZe7OkgSirN3VXPTE96B18H15NI5w7ZJjKRONksVdRzGg5yjy5NxMdqmi8RZ8lf1VPIbOR3V0bHXFKVlqtmdTrdergj8xR8s7EQdY406fawoKNkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSNN3hmbNQmty0osrwoOUYgga0ox7m9gZiYlPWFjpvU=;
 b=SV/9xIWucItn3JOzyUNWdzcTdcoU/A2zYdB0EEBw/at3PhrNhJCZe+sZL1sT1Nx7U/36MuxWn7u4WCsDokj42ic7kSGj7En9Cx7BpfakyDZJehKX8HvlAX/6+d3du54JlD+PtNsKzIuUPg6g21rR8TAxPzRVmbgcJJmbbVb5jR4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Thu, 28 Jan
 2021 10:45:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 10:45:52 +0000
Subject: Re: [PATCH] drm/ttm: Use __GFP_NOWARN for huge pages in
 ttm_pool_alloc_page
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Huang Rui <ray.huang@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210128095346.2421-1-michel@daenzer.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6863d36f-a80d-046b-fb04-0e5783901747@amd.com>
Date:   Thu, 28 Jan 2021 11:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210128095346.2421-1-michel@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::39) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0170.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 10:45:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ae2da87-29ee-4c7d-9f9e-08d8c379e1b9
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2481E605F888150D9DD5465683BA9@BL0PR12MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4MuDZjSnOCmai5cfNH/dDebuonyw3M0ZeDmG1CHcm6g8Qewgxsxy+wy358SMMUgEhxVoHrhc5YVHXg4rq9Lclof8RaQRYE3ohst8nm7zEN0gwPHWayIg4+hrFPsvGDP3u6lzOxeEMmnbg8E13HijtkgA5KetK34dQYNuaJ8AcIZ8/38lx7gVbQ9zDNx5gX+05+HMZ07gmzhpwb9GAt6BM1XmEigsboT0iDGUL81LMsYoKLWrEtEpyAIFBj+zItBN5FOd8NgRNOULEbjqn6bSNZqFwFL79eeG4R/IgLG1BPg47oK10yi9Sn8xTPqPxUwlYT8QZd+ERysrIbhebNohHBWXDEk0Ytmr3e0aeeqwDBd66h8MIZM/az04WURWp/O6EHlX/wr4Bd0VoJL8koutTKF7h+B0SjQpQJMS2rEL7NZdyO/fJCdBPc+HPbksrcTr0OX6GZ2GVFDzA2wrG8UBJo8RqEwRjGrqO0VhyacyhHibxAKfxo6iBCVzcuC6nPeFUZdSfXzv1LMTWGTcaV6Ul5DawTEUp6GiARIcN3OYl4OO+jzoRloR2Jisyc26QxzXOojv8709cBcYab653k9cBsew9rn9m1PJAz6K7uUSeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(6636002)(316002)(478600001)(66556008)(8676002)(2906002)(4326008)(52116002)(5660300002)(66476007)(36756003)(6666004)(8936002)(66946007)(6486002)(16526019)(186003)(31696002)(110136005)(31686004)(66574015)(86362001)(2616005)(83380400001)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VXFQNXdaTEtSUjliOXNLN25Peldqa0t1aFBFNGQrQVdDS1lxV0VqTm1mS0w3?=
 =?utf-8?B?WWhXb3dTV1hEbmhId2NZREtDanZnamdIUzh4dzQvRkc3UG41N0tQMVZzMXY2?=
 =?utf-8?B?bWxhN2pOM2c2NzFaby9rOURsOFZid3ZDSFlua2k5Vk9zOXdJK3FNb1Q0WW5Y?=
 =?utf-8?B?K0U5c0hqVkJCTncyaTNGWkRMVEZmbC9FMDVBMDRQMlJoWTd1USt2b1MrSWlo?=
 =?utf-8?B?d3RJSll4UE1WdzZZR1p0Zm9TYXFXeGhUMVRFS2RRSGtmenZQaFgrNGNSNzlt?=
 =?utf-8?B?cllpTjU0RG1NdFNMQVFQbEVkMGVoTTJrMWpGamVqRUZ6Z0orL1dkNFJDWit4?=
 =?utf-8?B?bGVzQUoyYTZMSzcyYnhDcXlLeVV0NytSSjl0U01EdFJkYkk2WE14VC9CVmRN?=
 =?utf-8?B?YytkL1BTN3drSUIxekxQTmIrNytpcTZaMjdFbDh2Ulk4QUxXYlBkcHZoZXpm?=
 =?utf-8?B?VFlUalFxUm45RStsRzhpNDNJRHhteHJDT2RLWllIamlBQjhwK2xQSUdwTHJ6?=
 =?utf-8?B?Q3liQzJhZlg2aFh6K1JtdWNZZHQ1REUrMnRSLytVNk5YNkdCUFc1YTVGL0xy?=
 =?utf-8?B?UUJPcmFoTTRjSVN6bm9YM2IwcVZOenRNTEdvTG43ZUxCdHo2bThDUGpvcjFQ?=
 =?utf-8?B?ZFdxQllSbGJ0K1djazNHZzRCaHcvdVlUNDBmakZSUXhYSVBPMlB5cURKUEM4?=
 =?utf-8?B?QWlkUTJmZHRVc2JWdnhucnJIdXFjR3FDaU9xM2V5TGxHaklTN2hWSDFaL1c5?=
 =?utf-8?B?Q3JhK0ZUZmx0UFU4Q28rUWR4L09maHpLNFNyS2MraWlwMUt2cUtkTlpzYWRI?=
 =?utf-8?B?NEUrb2JLTEUwemVlZ212YlU5TnIwNjNka2ZGUzlWVzB3dXgxd2t5KzNHM1hW?=
 =?utf-8?B?RXowZGF4S0U0UktUUFYrWkdJVHBLQWJiYWhHQmZiY1FucE1Vb3BqK1NBQTVl?=
 =?utf-8?B?MWl6Mk9KYXhyNlB1QVV2VmZZRVJTdHJKUVdUZlBuWSsxZ2JlRk5oOCtrZjE5?=
 =?utf-8?B?aWxVVmRzS1NORi9zQ3ZPUzZEdHlGMGJlWHVUQ0dDdlpZcmtERXBNYU1WS1ow?=
 =?utf-8?B?My9UZVo1a0krbVZocFNVVTdOOWNNQktZUGg1SmpKZWt5RjNnQlprM3U5WXVq?=
 =?utf-8?B?WWlTVU4rUkJFRHEwc3FxODN3VElkTmRLTzVkMEFGRkt1WWpoUTlGZDRMK0Vt?=
 =?utf-8?B?YTlxSkNQdVd4S3hxRXIrWVpoSSs5L2txb0Q3YUlKeGM1VG1BVlpWMldNTlhm?=
 =?utf-8?B?b3BPczVtNk1lK21ZMGs3TDFnY1VCQUdtaEgvOFM0b3c4UkVrdUZJcG9KR0dS?=
 =?utf-8?B?NVFaRFYwUkZWRWFDRy9FS0JRMTNzZit2SHp4TmJYdUJVNnJRc21BMENRZnls?=
 =?utf-8?B?UFFVL0x1dXBueVY4aXBwMTIwL24vd2YyS2dUV3UrazRzOHNMeWthUW5vd3RS?=
 =?utf-8?B?S1R4Y3NDdnRGU2xuTHUxL3NpQUpYTTUyRS9WcXd6ZEFtbVIxM3BkdzF1TUhK?=
 =?utf-8?B?QmNlNTRjc2MxalB2bzlqZjVRZWdTNzVBVEg3cEFMK2ExcmdET05YRHRqNmto?=
 =?utf-8?B?SkRCUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae2da87-29ee-4c7d-9f9e-08d8c379e1b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 10:45:52.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmzGeOKAZNxAgzJbM99M13AIcExsf2g48taiJUPXabNse+6hdCyOWkL6/c8U4yar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.01.21 um 10:53 schrieb Michel Dänzer:
> From: Michel Dänzer <mdaenzer@redhat.com>
>
> Without __GFP_NOWARN, attempts at allocating huge pages can trigger
> dmesg splats like below (which are essentially noise, since TTM falls
> back to normal pages if it can't get a huge one).
>
> [ 9556.710241] clinfo: page allocation failure: order:9, mode:0x194dc2(GFP_HIGHUSER|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_ZERO|__GFP_NOMEMALLOC), nodemask=(null),cpuset=user.slice,mems_allowed=0
> [ 9556.710259] CPU: 1 PID: 470821 Comm: clinfo Tainted: G            E     5.10.10+ #4
> [ 9556.710264] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.OR 11/29/2019
> [ 9556.710268] Call Trace:
> [ 9556.710281]  dump_stack+0x6b/0x83
> [ 9556.710288]  warn_alloc.cold+0x7b/0xdf
> [ 9556.710297]  ? __alloc_pages_direct_compact+0x137/0x150
> [ 9556.710303]  __alloc_pages_slowpath.constprop.0+0xc1b/0xc50
> [ 9556.710312]  __alloc_pages_nodemask+0x2ec/0x320
> [ 9556.710325]  ttm_pool_alloc+0x2e4/0x5e0 [ttm]
> [ 9556.710332]  ? kvmalloc_node+0x46/0x80
> [ 9556.710341]  ttm_tt_populate+0x37/0xe0 [ttm]
> [ 9556.710350]  ttm_bo_handle_move_mem+0x142/0x180 [ttm]
> [ 9556.710359]  ttm_bo_validate+0x11d/0x190 [ttm]
> [ 9556.710391]  ? drm_vma_offset_add+0x2f/0x60 [drm]
> [ 9556.710399]  ttm_bo_init_reserved+0x2a7/0x320 [ttm]
> [ 9556.710529]  amdgpu_bo_do_create+0x1b8/0x500 [amdgpu]
> [ 9556.710657]  ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
> [ 9556.710663]  ? get_page_from_freelist+0x11f9/0x1450
> [ 9556.710789]  amdgpu_bo_create+0x40/0x270 [amdgpu]
> [ 9556.710797]  ? _raw_spin_unlock+0x16/0x30
> [ 9556.710927]  amdgpu_gem_create_ioctl+0x123/0x310 [amdgpu]
> [ 9556.711062]  ? amdgpu_gem_force_release+0x150/0x150 [amdgpu]
> [ 9556.711098]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> [ 9556.711133]  drm_ioctl+0x20f/0x3a0 [drm]
> [ 9556.711267]  ? amdgpu_gem_force_release+0x150/0x150 [amdgpu]
> [ 9556.711276]  ? preempt_count_sub+0x9b/0xd0
> [ 9556.711404]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [ 9556.711411]  __x64_sys_ioctl+0x83/0xb0
> [ 9556.711417]  do_syscall_64+0x33/0x80
> [ 9556.711421]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: bf9eee249ac2 ("drm/ttm: stop using GFP_TRANSHUGE_LIGHT")
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

You have been faster than me typing that down :)

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks for the help,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 8c762a03ad8a..a264760cb2cd 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -84,7 +84,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>   	 * put_page() on a TTM allocated page is illegal.
>   	 */
>   	if (order)
> -		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY |
> +		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
>   			__GFP_KSWAPD_RECLAIM;
>   
>   	if (!pool->use_dma_alloc) {

