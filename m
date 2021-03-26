Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF773349FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCZCrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:47:19 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:37921
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230216AbhCZCqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:46:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+oMFDiRHKwAmyMhNyfzGn+MTSx4bLc9XaqF/VETmQ9wHXDSYvpp/BjiHK0gaQs5x5Jf8LVlcw8HDrS0FCjCHEeTFY5TW92NFrGiIp+UfUjbfSxgPwDutr4t1fOZJV29F6rdJ4ax26fk8/Kqgyjaz5D3RRmn7gRssagBXKHYkMfW339I70FPwyumbCTHJU/+fp9JGbyM9hw+ZCy1XNvut48aVYqJ41gL8UeZobAZp75HBTFlJzo4GLnZoi7jkRQtnQE0CSULxAjrKLhRXhxoBbzh4fT01QjRUdZ1yPXz+m8gNzmWlUK9QtDDHEnJ1n86wSTIggKzN53H+mBCARc29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKTGorqW+40JWgBvXwRXkzl9zrlivHETLX+oJqX69uc=;
 b=oYBWrsSR43cWXIAljOwl3BhhAa+rrjULHjO3ckGaKRM3N7IVUAIyL3wjJ6nIRdtDyFANI8aV4c+AyiFmMArVtIEJ6pq39f1oWfU5robqxkQEEoyxEwcHeN8/VtwAhcdZNACFiMsAonYh5rH5Z5fwLJ9swNVxfBHNxlqqpujY5FHa69NtfdwL0AfsYTg6/8hFMEOXKg/zK5HbYDdsKEBQiIVYVsW+jcFz/zDanw+InAKhp2Sn79naxmfPcls77DAId/59XIR2ExoWKFmhpWKQJXHSvKDFLLWFDUWDBpHUA/fI1QeQkPdtPb310x9Z0Nu3q2eC9TNLrqhylEftJs+Mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKTGorqW+40JWgBvXwRXkzl9zrlivHETLX+oJqX69uc=;
 b=dq10R4R0r28tP9duptitbHvckTNjdGF/PSitfAAp+w9GS4TD/TZDN57UIzNnLFiikrkLPecL9aM2HmT4Xo4ugR4zhTN//o4g2qyrqDLSMg720HBm4wAkfUFXtkcUg/oBqWVu74OPIM4Bv3MsT5uPVSDtsxYTUw0a70ODZJT6z60=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22)
 by CH2PR12MB3736.namprd12.prod.outlook.com (2603:10b6:610:2b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 02:46:42 +0000
Received: from CH2PR12MB4955.namprd12.prod.outlook.com
 ([fe80::ecf3:66d6:98be:5d46]) by CH2PR12MB4955.namprd12.prod.outlook.com
 ([fe80::ecf3:66d6:98be:5d46%9]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 02:46:41 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix cat debugfs hang_hws file causes system
 crash bug
To:     Alex Deucher <alexdeucher@gmail.com>, Qu Huang <jinsdb@126.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1616315298-109091-1-git-send-email-jinsdb@126.com>
 <CADnq5_OLBjUbwxUptPk17XMHarThXj7GDYkgYZOPcd_GOJH1XQ@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <103dee67-79d8-991d-b9b3-e5ee0f098567@amd.com>
Date:   Thu, 25 Mar 2021 22:46:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CADnq5_OLBjUbwxUptPk17XMHarThXj7GDYkgYZOPcd_GOJH1XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Fri, 26 Mar 2021 02:46:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71b6a28d-dc00-4de2-cb28-08d8f00162d5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3736DE7C5CA298DD89CDE54C92619@CH2PR12MB3736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+L2H8IoewGSPLtcTFrf2sUdTGmDzWcnqJO7/KMmK45JTT7uwRuA61aQ7sS4fGUZfTq0zOItrHCX6s9QcTL89g/WFIYe5pN/q+quo8m7swLK9MbY11FMPL1ClSHTHevy+0hTyJI2SzlWmphyF7Sqx4+xI0ietoFZ6XkajrO+oEz0LrHGbJfhZFehPZFHuBBw6Zm4pslY4hrX6hlSUoA2nZ9Ge40Ag34nwSBquXmsJu3QDCi6fSPpArWeVtTQndv8z2bv4DmNhqTKMAsh5iIVslMRDYHBmn2QOYomVspOh8VPujse8x5iojfmH9xwVlRYj5DIB72NjfwuijtpJ2P6DR4ZHvk4uJx5ufSxi3FUT/9RTpaFKydMsK7jn+TYinijXYGxJivuYJMFS+xX7m8DcsTYcNwAqQ4baAOBueA3BG/hmAjKNkJNosYyNe8nTOoWtf7lxnNg4gzxKGe4kGVFT9DIa2Ag9BLggH7Coxe/Ynmgc/jZ3EWdLA7+lr9tFLKWiBQjw3k0c4t/Ch2k25u2AjZyWXybYTpqgK2T41pUrq5IUkVJZhBIiOilJ7prIiAEQ4KcQcAihk6zhPSn9QVJU+sX+RoBIFOOcfAdRBM2jLI7z92xIWREzYDpUFuOcs4hoFK0GP2+BgztGN/wNy3wcIqyH8obagrQsT7L6n+Cfg6mxz3Nuo8ziv0tNcIuOwIktp66bHN8bzWg+W6qhn/kfgHbAbxupFoAJLaRedooGhcOZllUNGGX7A9xRIcMyzxCteKT+mLGfsXRVqzw0SGGeEXkXThPvOV0NfCc2QfOqR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4955.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(38100700001)(86362001)(16576012)(110136005)(956004)(966005)(53546011)(5660300002)(6486002)(2616005)(31686004)(316002)(2906002)(478600001)(44832011)(8676002)(31696002)(83380400001)(8936002)(26005)(16526019)(66556008)(54906003)(66476007)(36756003)(4326008)(186003)(66946007)(525324003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?LzZpL1pvK21ZWWlmZlY1eEVaZGlKdlk0cWFUREREMnFCNE5lWGNnaFljNXRY?=
 =?utf-8?B?dmpvdGpCQzVJV01VUG0vaGsxZzUyNmpVMjNGTnExSlZZVkhoYnh6ZTJIMDZq?=
 =?utf-8?B?Rys0QSsyaUROWGViT1pkWmZxZ0tROTZOYWRMM0wxZ1FMek1ZUVlqM25BVXhB?=
 =?utf-8?B?bjJpQ25BNzM2TEJHMS9zSU5MYkVuTWhZSlZDaEJkYWE4V0dTRFJRZzRFTkN5?=
 =?utf-8?B?eG0rZXlQL0FSUUhZZUUxVFJUUHVXUDFNczlyYnFIUkF3UXFqTWV2Myttcnhu?=
 =?utf-8?B?VmRiMDNFcEE2bE1PbFFSVlFtcUhkOWx5MzVlVE04LyszNkFtckdTclNzblZt?=
 =?utf-8?B?RlZDMmE5QjVaT2wxb3pNWldZV1JDL01mSnNpTkhxUmVEQVRiOEtUbzZIRFcx?=
 =?utf-8?B?L0M5RVdUbkt0U3p0d0tQNGxIV1Q2aWEvdmZqMDZHNFJQbVA1ZktaUHNaeHk2?=
 =?utf-8?B?aHlUVnBEdEFLaUVSa01USDJxRzJpR3VEMUo5dWcrUm5SU3hFRDhNU3VPdSs1?=
 =?utf-8?B?NDA3akkvNlgzaWNYMDQzQllWdTl2NGtvUW8wT2NxZkpTNVllMjMybjdpVkk1?=
 =?utf-8?B?V2J5eStJRHllQmFQSnFLYW1waHdzY216bmRCTkJVOFh0V01qeUwvOTd3Q1JS?=
 =?utf-8?B?MXlORnBnWFBMSVYzbUphbDJDMEhXa3UzNkFBOUNzNGVzdk5WbnVBT21oSnZK?=
 =?utf-8?B?M2F6aEtCT05lU1BEeWFVRHcvdURaOGMvQU11eURXKytwbXpteFpWUHFpUmMv?=
 =?utf-8?B?NUhlNERwNmk5a09LQ28vSUZXcVFQU0l2b29BalhpOW9kZ0ZXQzBTM2YvRWxo?=
 =?utf-8?B?TXlhZitjSFdMdlh3dzlXbDh0T1llZ0xEZlZPV3FFV2MxdHAzUU0xZEk0NHJV?=
 =?utf-8?B?NDR6U1JISUN5bW1QdkF2ZXVydFZhNWMyYXdmVHV4cUxqcjhncnkzamgrMEhv?=
 =?utf-8?B?TUgyTmVqRWhEdHpMcU9PZURYNENHMGlrSmd5YjJOanZNWWNDbDFJOTB3bFhk?=
 =?utf-8?B?VVhjTFU0Wm0xYW1zKzFpRTNZa1l0Z0hsTmNWNVFzVVhWRTBpNmF3bk81d2Vj?=
 =?utf-8?B?Qk9KdUpobitRWmxQMjdkMEJocXNyQjZGSUd2akVIQ2NCeGZUbGMvY1U5RXBs?=
 =?utf-8?B?ZkovVDBlR1NRWldITlM3YXY1eWZiMWRGN3pOZXVwR3VGcXVnbFhyYWl3bnJU?=
 =?utf-8?B?bmdWUEcvWkxPcytTOFdBNW9UWnRYazY5eHRVL0hCQjJreWhRNWlwVWhjOFNC?=
 =?utf-8?B?MWVDL2dmWlh4VHFucnBiU1d2bnhoZHd6MkJyMTBBdkdwTXdSZURFSks1Ykg3?=
 =?utf-8?B?cksycXA3UFoxektVQXREOXdWeEJjVW9NRmRCVkJIdnNKOVh5WWZmYkpmTkJC?=
 =?utf-8?B?YUJPYWtHaFhLZTVaNDVNRGxoQlpJbXp0UCszYUU2QnFFYklna3JFK0R3N05Z?=
 =?utf-8?B?dGQ5dWJTMFNrVHhVSGdBRmFDdktjZXk1eU52NXZidnVyT29rYVV1Y2dRemVJ?=
 =?utf-8?B?VjJuWFJLWTBPcjdzUDM3SzRUQUVuNzc3OHpZanlwOS9QTmZZcHRJVFMyeENE?=
 =?utf-8?B?eUdkM0pVNVBGUkpvZVJiTnVSWjV1TnhxcFZ0M0psYk9iaGRzRnZVNXNtRVpw?=
 =?utf-8?B?emJUTGw4cXYwNDRhS21aZGFiTzNmeXcyUGtBeFhOd0lmWVFrcW5JSW1Wbldx?=
 =?utf-8?B?QnZUNDQ1NUVtckdTZTY0NCs1Q1pLMjRNRmc0RmRvU09uRkNKdm5XRmNYZzhm?=
 =?utf-8?Q?KF7R5DXJEBD5uOCOrzoe0RCjoaS1yId46wKqMQc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6a28d-dc00-4de2-cb28-08d8f00162d5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4955.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 02:46:41.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvWPxp6uJomVH1F5Hvc2bqz7/cKHH9Et+YUYoFX7MNx4trFXHsw3945lVClzGdwhrDpvX55fDHTrmzkNrGUfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3736
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 2021-03-23 um 10:56 a.m. schrieb Alex Deucher:
> Applied.  Thanks!

Thanks. I thought we fixed this before by making the file write-only.
But I guess that's not sufficient to stop root from reading it:

commit 2bdac179e217a0c0b548a8c60524977586621b19
Author: Felix Kuehling <Felix.Kuehling@amd.com>
Date:   Thu Dec 19 22:36:55 2019 -0500

    drm/amdkfd: Fix permissions of hang_hws
    
    Reading from /sys/kernel/debug/kfd/hang_hws would cause a kernel
    oops because we didn't implement a read callback. Set the permission
    to write-only to prevent that.
    
    Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Reviewed-by: shaoyunl  <shaoyun.liu@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


Now that we have a sensible message in the file, I guess we should
officially make it readable again.

Regards,
  Felix

>
> Alex
>
> On Sun, Mar 21, 2021 at 5:33 AM Qu Huang <jinsdb@126.com> wrote:
>> Here is the system crash log:
>> [ 1272.884438] BUG: unable to handle kernel NULL pointer dereference at
>> (null)
>> [ 1272.884444] IP: [<          (null)>]           (null)
>> [ 1272.884447] PGD 825b09067 PUD 8267c8067 PMD 0
>> [ 1272.884452] Oops: 0010 [#1] SMP
>> [ 1272.884509] CPU: 13 PID: 3485 Comm: cat Kdump: loaded Tainted: G
>> [ 1272.884515] task: ffff9a38dbd4d140 ti: ffff9a37cd3b8000 task.ti:
>> ffff9a37cd3b8000
>> [ 1272.884517] RIP: 0010:[<0000000000000000>]  [<          (null)>]
>> (null)
>> [ 1272.884520] RSP: 0018:ffff9a37cd3bbe68  EFLAGS: 00010203
>> [ 1272.884522] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000014d5f
>> [ 1272.884524] RDX: fffffffffffffff4 RSI: 0000000000000001 RDI:
>> ffff9a38aca4d200
>> [ 1272.884526] RBP: ffff9a37cd3bbed0 R08: ffff9a38dcd5f1a0 R09:
>> ffff9a31ffc07300
>> [ 1272.884527] R10: ffff9a31ffc07300 R11: ffffffffaddd5e9d R12:
>> ffff9a38b4e0fb00
>> [ 1272.884529] R13: 0000000000000001 R14: ffff9a37cd3bbf18 R15:
>> ffff9a38aca4d200
>> [ 1272.884532] FS:  00007feccaa67740(0000) GS:ffff9a38dcd40000(0000)
>> knlGS:0000000000000000
>> [ 1272.884534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1272.884536] CR2: 0000000000000000 CR3: 00000008267c0000 CR4:
>> 00000000003407e0
>> [ 1272.884537] Call Trace:
>> [ 1272.884544]  [<ffffffffade68940>] ? seq_read+0x130/0x440
>> [ 1272.884548]  [<ffffffffade40f8f>] vfs_read+0x9f/0x170
>> [ 1272.884552]  [<ffffffffade41e4f>] SyS_read+0x7f/0xf0
>> [ 1272.884557]  [<ffffffffae374ddb>] system_call_fastpath+0x22/0x27
>> [ 1272.884558] Code:  Bad RIP value.
>> [ 1272.884562] RIP  [<          (null)>]           (null)
>> [ 1272.884564]  RSP <ffff9a37cd3bbe68>
>> [ 1272.884566] CR2: 0000000000000000
>>
>> Signed-off-by: Qu Huang <jinsdb@126.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>> index 511712c..673d5e3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>> @@ -33,6 +33,11 @@ static int kfd_debugfs_open(struct inode *inode, struct file *file)
>>
>>         return single_open(file, show, NULL);
>>  }
>> +static int kfd_debugfs_hang_hws_read(struct seq_file *m, void *data)
>> +{
>> +       seq_printf(m, "echo gpu_id > hang_hws\n");
>> +       return 0;
>> +}
>>
>>  static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
>>         const char __user *user_buf, size_t size, loff_t *ppos)
>> @@ -94,7 +99,7 @@ void kfd_debugfs_init(void)
>>         debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
>>                             kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
>>         debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
>> -                           NULL, &kfd_debugfs_hang_hws_fops);
>> +                           kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
>>  }
>>
>>  void kfd_debugfs_fini(void)
>> --
>> 1.8.3.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
