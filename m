Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB332CDF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhCDHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:52:30 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:13440
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231479AbhCDHwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVeW3gY06jySbNiAQ4+0De4qFs+toWE8hQTzKtHpGKx8RYrvpjhrnhjS3UxwIulv9EN5+9Y6WHOiW6IfmO1HDAvQJQ4roWg9hSSqagiX0xf8XizjDLa/EoRRfC2AslaO29muOR3P1PEx4p5fLboL3OxMKzgtmmVWnQE1bXUWzv81m5OrtHVtadYL5YelYLeF3x8ZBYmRM+m+gR9ddNpGQCcXT8vzNRG4lRqZmpi9ys19eYAnww946Z5+pjY7MKLd6aV+A45JjvlDUc1sbqXrBbmTeY1j92+1CaKSnvTFOscr+4MIIPMXdVF3dSvPj5X3jOLx0TBg556h973JGsg1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wouWh3jiS4EJpU31MTRuOscQM9jhxAqzkPLcb72kPZI=;
 b=FHYC7zSYy1SH008Qjiyz6NhrMyIes3UzJ5XpEQraqTwSGby6GgECGTKNdWGYbagJLBKXQZYkjAER/wh1qhOi5sBZ2msPSIutMNOK06RlZHEjLNo4grIWIcico2aaayYDHoxjlYHa6MO2AtLpoFWG9NzW1qmsKW1GFYqTfOBWxL5nKJ8eiKGqabIrgsVDm1ZtZCxDQPg0yQgB1ey7TdJKFQhhst0CXP6rvuB+ztu7ejp/TO9vg/e7dSl/eWPLTOPHAP8KKt452GLxPKWh+2Cf//+qafJdyUVTQz8eWlcKS3N88CuFPDJhLDX8a0do9/1SzvBN8CJ8AJsPYJWeGkqyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wouWh3jiS4EJpU31MTRuOscQM9jhxAqzkPLcb72kPZI=;
 b=hFvYKSqFiOUFtXs/8YhRA9ROKrcOaXibMfy4Xa/Vcuiz7gSBVr/u/qxQWQKGWFVbrqLaNcPRjarJNGMJOYZkmmBcgMNHe+I2//31t51KiDsQhesk7nnmf5VrOMH7AFtn55CgUMOaHWbWYCHl/bl7i5/A8kTyNdclfdrDOP7QDL4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4658.namprd12.prod.outlook.com (2603:10b6:207:32::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 07:51:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 07:51:16 +0000
Subject: Re: drm/ttm: ttm_bo_release called without lock
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <YD+eYcMMcdlXB8PY@alley> <YD+mGFJ5KYWwrJHH@alley>
 <a53377ae-9b33-9030-f9a6-0b620a9cc71f@suse.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <98bbfb1e-c3b2-a8dc-518f-ecb9fa55b4da@amd.com>
Date:   Thu, 4 Mar 2021 08:51:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a53377ae-9b33-9030-f9a6-0b620a9cc71f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:64f0:29b:e922:7ee4]
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:64f0:29b:e922:7ee4] (2a02:908:1252:fb60:64f0:29b:e922:7ee4) by FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14 via Frontend Transport; Thu, 4 Mar 2021 07:51:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a751d902-fdef-4bec-1b62-08d8dee249fd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46589027121D52357F89D3AC83979@BL0PR12MB4658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR2YFSbIHGJkwN4oWOUAj0EbESV1MpjR2ch26yCoHcUakKsf+DnyYvJ/jVTpXUeDKCp9x7w43sbEVx1HKOgQx1AfvsyjeX5sdAk6FzWTCfli3ohs3IQ0qfzWIjfr58679jIw9Yg4DRvgS/P5ck7RrrAB0cLaVn4Sxv7Mi7aKf/EaFdsi1qhVy83ji2FwXopwnhqLul5sMO9iG1Ehn+i2JS8i5Yc2Glr2n0j3kkPs0+1kJRdQYw+XczsgJCHQ2qQQKC4a32YMfkovq27lLfWuofGRr37h1M4KsXNeUqc/9fHssYZ7I8NGC6mHfL9WgxYRNQmmJO4h9z9XO7O6W0H9Y8HX8vJ9ejXGgvzpTbG1OhUoT9oF9XLcDf2JsKIg5tqvQQdNzRsElLXqgpB/eItGKLfqkcla3jyalLpJ3lCjansn1vehAFUS4a9/sD7QMO7uhocE+01YL+6gKSbMzRV0fdId10phd/ANlBOqvaefm1xuw6DtIa4OceBtCgTWNghVD/5WMBJdqBkqKdIOi7G39mXvxU2ozbfor9Ob+cpdsk+xFKmi/9XmsUCZBCQcY3EzHvNmWSrl0Iann2plPmqks36oQeaEypwChpmtmVlG00wkNDWXkSaaiRI44le7QzOdjvXaEinabbFvwYiboFU5lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(31696002)(86362001)(2906002)(31686004)(36756003)(316002)(110136005)(54906003)(83380400001)(478600001)(2616005)(966005)(6666004)(66476007)(66556008)(52116002)(4326008)(66946007)(16526019)(186003)(5660300002)(6486002)(8676002)(45080400002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UU45SWdoZjFhWkdmNDA1S2RiRzhUaWVmTEZ0UzJVNHJ3NFYxcmRNT0pQbFox?=
 =?utf-8?B?TEhHaklmVmhtZlZNKy9LSmsrQmJmTzl1Mk9WZGJuUHBBMmxNNmdvaDRUeC9o?=
 =?utf-8?B?eFFwRTAxbnBPNTdDZG92bitrMXIyeDljUU5YNTZKM3BOcm4xbTVoSTVXK3lv?=
 =?utf-8?B?ckpWeERzRmQyVzFpSk1tZEx1clVjTDQzNG9JK01qa2VXdGFLTC9KRVZzNU5T?=
 =?utf-8?B?eFVtVTMrZXpFWmZZWUdrUWdGR0F3S3ZUOVozTk5oVjZzWnNYaW5vcFVlVnlS?=
 =?utf-8?B?ZEpHamxGTkNkOXhnN2FrNUdxeEVzM0dES1ExNXJnakJtSmoxYjh0M0tRa0Yv?=
 =?utf-8?B?WnY5eE50aEVXNjNiQUg3YU5UZkM4dklDdkE4aWpDTjBUVDhEMUprSWl2Sm03?=
 =?utf-8?B?N1loRmhlZEU4U2c4cUpBL3JtS1FLaGtjdTlEMlJacDBTWWpDdnVydWRnbDVS?=
 =?utf-8?B?WFQwb3hKN0ZyL2prT1NqTmhQcmVzQjZ0elpNREEwTnQ0L3g0QXVhbDUrcDZp?=
 =?utf-8?B?WTlCVWtXQ08vcTFrdXQ4SzhVQklSKytOZm44T29WVC9Gc1A4TmtiQkxnc0Zu?=
 =?utf-8?B?a3RjUWIzekhITGJsWkVVMkJxeHhJVElMWlREZU1nR1pXUktoUEt3bmxtREdy?=
 =?utf-8?B?S3NlTC9TVFJmVHRzRnMyc2FlOHEzajdkTXlLQUR6ak51SndKLzV3dlo0OTlz?=
 =?utf-8?B?QmcxcnhQOTY0Qy9sS0k1Y3Z4aXluT1NoVXFtM2Z2SW9ocHNzSE5kTHdIanZt?=
 =?utf-8?B?bnBrUDdoblV1Rnc2d2RtU1NzdU90VFpTOGdtdDJrQ0k0SlhXQ05RR1FYOFUr?=
 =?utf-8?B?VDMxRmhlZ2xXUHlkRFQwWEJYSDZTemd2OG9KRWRzTTBIMWtWWi9Qb2QwM1Ux?=
 =?utf-8?B?QmxaNXRVVnFZWUgwU2d6dWFYZkEyazA5K0ZVYTg1MG90aDdQNFNlMDBWaXNh?=
 =?utf-8?B?NVZKSmp0ek56dGxiczIwVnJSZDRtM04wUTdXd1FZYkdCS0JOZmI1VnJTK3NC?=
 =?utf-8?B?cUpPcWVsYU56UEdudVNNd05IRXlGZlRMUXpJR3VBSEhFZVVmeEFjeHFYNmFn?=
 =?utf-8?B?WW5ESTBxa0VNT25pajlUN3RhZUszUThNVnZsZDFSRkhMbG1xZVdQMG81Z1VR?=
 =?utf-8?B?eG5SdFNpUnZoZkNIMXFPQ256UEMxVVpEck5wODJyT2lmRitqQ3JjaVVYNjF2?=
 =?utf-8?B?UDZ2RUlVUnFzZC9RZDZRUUFrUzE3bCtlK0NYRFo3UElpTUVGWTlUSlJuZUZX?=
 =?utf-8?B?ckJjQm5FUG9hTXRHU1NzSDJjMkI2Q1NKZ2xvdFhvSTZvWlhIWWQrNmxjUFB0?=
 =?utf-8?B?dzBWVGs3a1RnelNtZnA1bmIwTE5sZU1EMmxZL3VFdXdGNmc1QjJOUk4rZ0xV?=
 =?utf-8?B?LzQ3SytSd3BSU0h5Qko5RUxBZWw3bVF4anZjMUR6YXJJVmZIbnVtbi9NaWRm?=
 =?utf-8?B?ZVZFVEJiNUhjTDkzNWVvZHJPTTYzNmFwc0ZML3pPZXRzZVJOVnFxc3pqSmtq?=
 =?utf-8?B?WnhKS0NTSmx0VjN1TCthclh3ZTAwZUFhUEhLenhROEZ3UGI5QXh2NGlmM3Fh?=
 =?utf-8?B?d2FZM0pLYlNwZkQybVJlTXJtRG9NeWlXS1FCVSt2K1E3Y0kvUjlMSVdHelg2?=
 =?utf-8?B?WGxoU1o5ZGhoOEx3NWNsY0tDZVQ4SGtBUndwMU9RSmRrbi9WN1NlMUc2WGsx?=
 =?utf-8?B?S3Bucjd3SVNzNlpiVGVaMWZiUWR1Rk9nUDdpbVVXU1FOZTNFdkxCMnh6M2RM?=
 =?utf-8?B?dkU4d1d1ZlQ3c1crRmJ1WHc0M0ZOZy8yV1I0dTUxdDFmdTZNek9lYlFOYXRR?=
 =?utf-8?B?YzI4NE0vYzAya2JYRmlmc3hFcTlSY3F3dGMrM3phcVo3alg5Mjc2RHpxNEpa?=
 =?utf-8?Q?2GSVLYmWDsLUK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a751d902-fdef-4bec-1b62-08d8dee249fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:51:15.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmERFGKkzuc8kEn/7JvkN23796H9eE6o/H9b0rbUlGgCjkCyXcfegmvEQ2sU8zY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I also already send a patch to the list to mitigate the warnings into a 
WARN_ON_ONCE().

Christian.

Am 04.03.21 um 08:42 schrieb Thomas Zimmermann:
> (cc'ing Gerd)
>
> This might be related to the recent clean-up patches for the BO 
> handling in qxl.
>
> Am 03.03.21 um 16:07 schrieb Petr Mladek:
>> On Wed 2021-03-03 15:34:09, Petr Mladek wrote:
>>> Hi,
>>>
>>> the following warning is filling my kernel log buffer
>>> with 5.12-rc1+ kernels:
>>>
>>> [  941.070598] WARNING: CPU: 0 PID: 11 at 
>>> drivers/gpu/drm/ttm/ttm_bo.c:139 ttm_bo_move_to_lru_tail+0x1ba/0x210
>>> [  941.070601] Modules linked in:
>>> [  941.070603] CPU: 0 PID: 11 Comm: kworker/0:1 Kdump: loaded 
>>> Tainted: G        W         5.12.0-rc1-default+ #81
>>> [  941.070605] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), 
>>> BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>>> [  941.070606] Workqueue: events qxl_gc_work
>>> [  941.070609] RIP: 0010:ttm_bo_move_to_lru_tail+0x1ba/0x210
>>> [  941.070610] Code: 93 e8 02 00 00 48 89 0a e9 00 ff ff ff 48 8b 87 
>>> 38 01 00 00 be ff ff ff ff 48 8d 78 70 e8 8e 7d 46 00 85 c0 0f 85 6f 
>>> fe ff ff <0f> 0b 8b 93 fc 02 00 00 85 d2 0f 84 6d fe ff ff 48 89 df 
>>> 5b 5d 41
>>> [  941.070612] RSP: 0018:ffffbddf4008fd38 EFLAGS: 00010246
>>> [  941.070614] RAX: 0000000000000000 RBX: ffff95ae485bac00 RCX: 
>>> 0000000000000002
>>> [  941.070615] RDX: 0000000000000000 RSI: ffff95ae485badb0 RDI: 
>>> ffff95ae40305108
>>> [  941.070616] RBP: 0000000000000000 R08: 0000000000000001 R09: 
>>> 0000000000000001
>>> [  941.070617] R10: ffffbddf4008fc10 R11: ffffffffa5401580 R12: 
>>> ffff95ae42a94e90
>>> [  941.070618] R13: ffff95ae485bae70 R14: ffff95ae485bac00 R15: 
>>> ffff95ae455d1800
>>> [  941.070620] FS:  0000000000000000(0000) GS:ffff95aebf600000(0000) 
>>> knlGS:0000000000000000
>>> [  941.070621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  941.070622] CR2: 00007f8ffb2f8000 CR3: 0000000102c5e005 CR4: 
>>> 0000000000370ef0
>>> [  941.070624] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [  941.070626] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>> 0000000000000400
>>> [  941.070627] Call Trace:
>>> [  941.070630]  ttm_bo_release+0x551/0x600
>>> [  941.070635]  qxl_bo_unref+0x3a/0x50
>>> [  941.070638]  qxl_release_free_list+0x62/0xc0
>>> [  941.070643]  qxl_release_free+0x76/0xe0
>>> [  941.070646]  qxl_garbage_collect+0xd9/0x190
>>> [  941.080241]  process_one_work+0x2b0/0x630
>>> [  941.080249]  ? process_one_work+0x630/0x630
>>> [  941.080251]  worker_thread+0x39/0x3f0
>>> [  941.080255]  ? process_one_work+0x630/0x630
>>> [  941.080257]  kthread+0x13a/0x150
>>> [  941.080260]  ? kthread_create_worker_on_cpu+0x70/0x70
>>> [  941.080265]  ret_from_fork+0x1f/0x30
>>> [  941.080277] irq event stamp: 757191
>>> [  941.080278] hardirqs last  enabled at (757197): 
>>> [<ffffffffa217431f>] vprintk_emit+0x27f/0x2c0
>>> [  941.080280] hardirqs last disabled at (757202): 
>>> [<ffffffffa21742dc>] vprintk_emit+0x23c/0x2c0
>>> [  941.080281] softirqs last  enabled at (755768): 
>>> [<ffffffffa300030f>] __do_softirq+0x30f/0x432
>>> [  941.080284] softirqs last disabled at (755763): 
>>> [<ffffffffa20eb0aa>] irq_exit_rcu+0xea/0xf0
>>
>> I have just realized that it actually prints two warnings over and
>> over again. The 2nd one is:
>>
>> [  186.078790] WARNING: CPU: 0 PID: 146 at 
>> drivers/gpu/drm/ttm/ttm_bo.c:512 ttm_bo_release+0x533/0x600
>> [  186.078794] Modules linked in:
>> [  186.078795] CPU: 0 PID: 146 Comm: kworker/0:2 Kdump: loaded 
>> Tainted: G        W         5.12.0-rc1-default+ #81
>> [  186.078797] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), 
>> BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>> [  186.078799] Workqueue: events qxl_gc_work
>> [  186.078801] RIP: 0010:ttm_bo_release+0x533/0x600
>> [  186.078803] Code: e9 c6 fb ff ff 4c 8b 7d d0 b9 4c 1d 00 00 31 d2 
>> be 01 00 00 00 49 8b bf d0 fe ff ff e8 86 f1 04 00 49 8b
>> 47 e0 e9 2b ff ff ff <0f> 0b 48 8b 45 d0 31 d2 4c 89 f7 48 8d 70 08 
>> c7 80 94 00 00 00 00
>> [  186.078805] RSP: 0018:ffffa22a402e3d60 EFLAGS: 00010202
>> [  186.078807] RAX: 0000000000000001 RBX: ffff9334cd8f5668 RCX: 
>> 0000000000001180
>> [  186.078808] RDX: ffff93353f61a7c0 RSI: ffffffffa6401580 RDI: 
>> ffff9334c44f9588
>> [  186.078810] RBP: ffffa22a402e3d90 R08: 0000000000000001 R09: 
>> 0000000000000001
>> [  186.078811] R10: ffffa22a402e3c10 R11: ffffffffa6401580 R12: 
>> ffff9334c48fa300
>> [  186.078812] R13: ffff9334c0f24e90 R14: ffff9334cd8f5400 R15: 
>> ffff9334c4528000
>> [  186.078813] FS:  0000000000000000(0000) GS:ffff93353f600000(0000) 
>> knlGS:0000000000000000
>> [  186.078814] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  186.078816] CR2: 00007f1908079860 CR3: 0000000021824004 CR4: 
>> 0000000000370ef0
>> [  186.078818] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [  186.078819] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>> 0000000000000400
>> [  186.078821] Call Trace:
>> [  186.078826]  qxl_bo_unref+0x3a/0x50
>> [  186.078829]  qxl_release_free_list+0x62/0xc0
>> [  186.078834]  qxl_release_free+0x76/0xe0
>> [  186.078837]  qxl_garbage_collect+0xd9/0x190
>> [  186.078843]  process_one_work+0x2b0/0x630
>> [  186.078850]  ? process_one_work+0x630/0x630
>> [  186.078853]  worker_thread+0x39/0x3f0
>> [  186.078857]  ? process_one_work+0x630/0x630
>> [  186.078859]  kthread+0x13a/0x150
>> [  186.078861]  ? kthread_create_worker_on_cpu+0x70/0x70
>> [  186.078866]  ret_from_fork+0x1f/0x30
>> [  186.078879] irq event stamp: 619687
>> [  186.091417] hardirqs last  enabled at (619761): 
>> [<ffffffffa317293b>] console_unlock+0x45b/0x570
>> [  186.091421] hardirqs last disabled at (619766): 
>> [<ffffffffa31742dc>] vprintk_emit+0x23c/0x2c0
>> [  186.091423] softirqs last  enabled at (617742): 
>> [<ffffffffa400030f>] __do_softirq+0x30f/0x432
>> [  186.091425] softirqs last disabled at (617737): 
>> [<ffffffffa30eb0aa>] irq_exit_rcu+0xea/0xf0
>> [  186.091427] ---[ end trace ac74376b06d2036c ]---
>>
>>
>> Tke kernel is based on Linus' tree and the last commit
>> f69d02e37a85645aa90d1 ("Merge tag 'misc-5.12-2021-03-02' of
>> git://git.kernel.dk/linux-block").
>>
>> Best Regards,
>> Petr
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>

