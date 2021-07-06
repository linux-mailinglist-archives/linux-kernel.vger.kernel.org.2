Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61B3BC6E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhGFG4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:56:31 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:7425
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230119AbhGFG4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJy23PI7vH+VhuHRt+Q+F1u0HhR3WUXfEa8zcbhofJFiEDnwjAMllk1vvan88jSMLDuCZJJiT8oqga8hDHB24qzpu7ZY1+V/HrgSljEYVLSbKvClk6F0jWDqvsCHiLEMbVq9hEO0RNOlH7JcJYAi3aN6fLkFRSA/5zufvUHebvNxg7JO9+MQPjD5LF1MpES7rr+et1+7DJ8ThTLKTLnO72RyzYAwED3SAngsF6ZlR2jC+3kJ/elUAwWXhc+hYVNMDfEQlEh+bmIJUzGmvfn1xBfK+E+r40HDBt6F9M6xwyXz6LUo288T0xPWx43xZRb9/t2QFpYTbdZjgskGotGH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip+Zquufu+fq2ZeW8luIa065F21BPYB5BLl1mrnUXdk=;
 b=axWwKpA1LnGUNm61GPRQOxSbsu71bE+pMx7B7GJXSxES6u/504h/ZVvRmMSNr39PyRNGb43DnFszEcoHCUPndipcSvMH4jnX1hj6CWidAeGz1AjAd/PDvKilGuYMsCdxe1KxLSYlTexrPmOaqiObZhjWfJJSAdugZcM3BD4OswoFCkVokl4us7ueWtE3QUvlayZUDzrWAbxynyzuwqOpyVoNzhMbEejKLcJYoFmN7TtjqiLH6r/muobgIS/U9YjoNfy7WuQcYnv5goLMJr4jzLrULisDM82As92nC/JG8Oct1syipe4eewBxxUpTVCUZ1/rkqaZ5gKAmXTV6AzXznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip+Zquufu+fq2ZeW8luIa065F21BPYB5BLl1mrnUXdk=;
 b=Zr2ETaFeTIfZVCKAJKJetf4rfDckOyOEIU8matlK9ZFjtf3hKYH6oDy8/19irofcU7WBtyGbPuloJ23CeLxuIMgYLi1yX0pfk9IWaovUJVqj5fP6sy7zNzucsS4t+c1O2i8F5xD0kStxKDZch6sWvRKFUjoZeXbPNW1NRaM8rNE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4739.namprd12.prod.outlook.com (2603:10b6:208:81::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Tue, 6 Jul
 2021 06:53:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 06:53:49 +0000
Subject: Re: kvm-vm boot fail: ttm_bo_cleanup_memtype_use?
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <8c1ea35a-9ec9-bf11-ace4-8c604b04bbc3@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fef73358-748f-f1d0-bca9-43efa6497f44@amd.com>
Date:   Tue, 6 Jul 2021 08:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <8c1ea35a-9ec9-bf11-ace4-8c604b04bbc3@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------F0095003FAE693238293E04E"
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:753c:5dff:bd23:5cf4]
X-ClientProxiedBy: PR3P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::9) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:753c:5dff:bd23:5cf4] (2a02:908:1252:fb60:753c:5dff:bd23:5cf4) by PR3P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Tue, 6 Jul 2021 06:53:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3448ed7e-6183-415c-110a-08d9404ace57
X-MS-TrafficTypeDiagnostic: BL0PR12MB4739:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4739A3EA89056DFEE561C297831B9@BL0PR12MB4739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYGakk3dM2WhGibj/drCJQJENRCzUnfrk9eL9jcIAqZiRbcmle9a9/cdURW8KdUqqIkNIJckJrcNeADVHRq2Pl562h7upm/gIl2+PBc8xjeYO/nQv7fL6mEJmUTZ/miDVabt6jrMQBUboc1rvqHxy/2Ymm/jNubNTB+rx3xYqaQrjfLzq5XEhsDPRZfNMy4ye0mFh4X94msDjv005TWc5FzguqnV/wZX8tatScE006Fo2WUsHFOFhaxWeavoK2LH58HUyZSYhjGwMVGr+BdN1MY4aIIRJFVqMpEjm+kNr90U4mEwO0IooexuPN1cjvOlIgMbN+SNt0ePS3tVUGncOAg5C4HHNEZVkfwXT2wrBzcML4OToxnhTUFdnLbEesuK4fXjrBYtv4IXS7xcnkEI362T6cpBkjc9eYA5F/2qsiRiGVOmQHRbIi8HtGIo84vuZ8ImBQzEeCdNvKgfCHr51h4UNwcwPneSE0I1skgutYWfh59hv0YZ3iB/4CR3266CXGIRTcbYbWKOYi3/O9gZV+y6wQwc3aCXN6vO/WjuyXyVag8YrOyJoTd7BPyjFCxQnjwhf9OlWV/3lA1uzKhNv7HZqkr5HrZcTyTUqMsLkogv+OcCzmf6+GpE2j71eG057k6rjX8kscL7a3aGDjHUiF43xI/Cs782UJ62XHahB2WMTJHcTqmIXeIVfGKZ59Ye
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(186003)(83380400001)(478600001)(316002)(16526019)(2616005)(8936002)(38100700002)(66556008)(86362001)(45080400002)(2906002)(31696002)(33964004)(110136005)(4326008)(30864003)(5660300002)(8676002)(31686004)(66476007)(66946007)(66616009)(235185007)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE4xWjFLM0hWMjhoQTZVbmlJQ1ZXRllyWlIrY0JuQlRUTmx6ejlUQzNybEVz?=
 =?utf-8?B?THBjbjZYZjZUSSs1Z1BURFg4QTFJS0cvUmxNUjRueGx1Wjd5S20vdktOR09v?=
 =?utf-8?B?aC9nMk5OWTBYeUhsZ0xZbzFSejh6V1VSR2RPa292c3JuL2h4d0k3cmtvcnAw?=
 =?utf-8?B?YTQ5SHAxRFIxakFkTDRXTDNlSWRldVR2YkZyLzcveFUwdURxdE5DREJHWXN6?=
 =?utf-8?B?c01wYjJJMVhxb1ZJemRzUFdMSEkzK1RZMU9HL2szOGRrSk0rMDhLTzJyMHU0?=
 =?utf-8?B?YzYrRldISmtMT2JoaWxnRWc4V0RCelQya1k1ekg4OGg4d2c3anhveDlKdEgw?=
 =?utf-8?B?Z1NHRXJ1SzFadnExM1FLOGp2WXpZNWtzdzVkamVpdXBLZEh2eXE0Q1lZUFhW?=
 =?utf-8?B?d3Z4bkx4UUMxUW1oNnRjYmdXSXVYUEJjRkJsQnBTTkthekdrV3Vsd0VneTRa?=
 =?utf-8?B?a2QwSGRlTFRqNkFlTCs4bEg1Zm1FWndLQ0ZpbHk1TGZWL2w1TXh1T3k1Skt3?=
 =?utf-8?B?bEJ4dDR0Yk5XNE1jK3pZRFBpQnAxOXMrMTFDM1Ezc1IzMHBlUEI4N1BkK2lV?=
 =?utf-8?B?MG5pMlBQa1BRWVg4SHIzK0dKNUZDR3JNcXpnalROK3JmbDJIckVRUmVUSnI0?=
 =?utf-8?B?ZGVJU0RmWUttRWV5WERWdVlTVDJsdlc5UlRvcFVDdHlQQXUvdHo3RGJHSXpz?=
 =?utf-8?B?ZHRqSEo3REJrY2FzWWJqN3gyb2JVQUVrclFxSEZVZWNXWE1vSlJoUzFzOTBC?=
 =?utf-8?B?MTlLT0tLZTJ3K0EwTlNWN2wraDIvQS9vanlFZWFieFlySWFsWlRoaUZXd25N?=
 =?utf-8?B?ZzY0ZHdHZEVKUEgrZEdCR1lnVEZRUExCUG8rK09tK3hUcGg3disySlpyeVVZ?=
 =?utf-8?B?NHJoMjVRUE9PVVYwekVMNGhtL0Y5ODViT2NiUFJKdHNxb29FQnJjV1hEWitr?=
 =?utf-8?B?WnFBQ0MwWkh3ZE12YWZGS3hLVjV2R3B1UmRTZER0Tzk5ZHlURDdHZ0pyNXhz?=
 =?utf-8?B?UFAxUlpTZDlJNjNsT002VmtjTzR5a2pyUG1ISEVtd0ozS3hoeW95S20zNDls?=
 =?utf-8?B?UnpLdWsxUzRsb3pINDhwdUoxZnpTUEdrQ1NDQUVnYXVKS3p4L1pZNVJPbnQ3?=
 =?utf-8?B?eVBYS2dUSXp6Yko1RGNJNmIrZm1KcHVQRzlTWHZ0Z0V5bWp3citDY2gwbE43?=
 =?utf-8?B?M1I0anVyd2gxTWdFV2ZxcVpwWm1kRlBQUGExdmI3UWdhWkp3ZUVsVFh1bG1Y?=
 =?utf-8?B?WG1sTmZUckFKczF6MnFTMGVxcGhnTU0ranBwWVQxYk42M29PNktCSzhlbDlH?=
 =?utf-8?B?eTFNTUdDa08yN0V2akE4Ky9ScTlvSitHYnQ4aDN5MVYxbEV4U09CNXpTaWVr?=
 =?utf-8?B?eFFBTWU2QitrK2lPZVQ4K1ZQSk5aN3l3aG1jN1paM2ZBTzJmMUEzRGZLZjND?=
 =?utf-8?B?VUl5Tjk4Tnd5bnk1d2pyZEh1SXJOZ3orS016a2srbXJnZzg2L1pGWk9Vbjlk?=
 =?utf-8?B?U1BBQlhySmFvS2kyQUNxZzVRaEN2b0VaV1kxRkorYnNiMXJ0WndWS1NoUXpT?=
 =?utf-8?B?U1lNQWZyc3V3d0Y3VVorWWppUHNqQmVjRFlvMU5TbXExZVE2ZkFaSDZjZ1dz?=
 =?utf-8?B?MVozdDF0UEFaeGJGWU5pclEwM3FJa3duM3dEcUNmbnJPWHR1K2p0eUVKNFIz?=
 =?utf-8?B?c3R0T0VvMXVXditETktiS2IvVzJvQ0t3TWcvSXRQMXhUUTBoc092NVRVL2dM?=
 =?utf-8?B?TXVLSFVpNnVKbGRSUzRFejRRaFdCazBFWlhDZjRVTHBwK1FyL1hBWWdTaXJi?=
 =?utf-8?B?aWEyNk1mWDhCaGpLL2lkYUlweGo1cWd2SzRQR1k2R3FvbDRCalFsa0pXeHF4?=
 =?utf-8?Q?+E17g7ANwPdwj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3448ed7e-6183-415c-110a-08d9404ace57
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 06:53:48.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8jDlMpNUmANYGiI7kFI8q0CvPIxvHqLUPssbG8Hd+Ni8pA8IM2Xur9wK9MJPMGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4739
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------F0095003FAE693238293E04E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

looks like a simple missing NULL check to me. Please test the attached 
patch.

We recently changed the structure of the resources, so probably 
introduced while doing that.

Christian.

Am 05.07.21 um 13:57 schrieb Daniel Bristot de Oliveira:
> Hey,
>
> I am getting a bug arround:
>
> "Workqueue: events ttm_device_delayed_workqueue [ttm]"
>
> when using Linus' kernel with HEAD:
>
> commit a180bd1d7e16173d965b263c5a536aa40afa2a2a (HEAD -> master, origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Jul 4 16:12:42 2021 -0700
>
> while booting a kvm vm.
>
> The config is attached, and the bug messages are:
>
> [    3.044604] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
> [    3.044607] Workqueue: events ttm_device_delayed_workqueue [ttm]
> [    3.044616] RIP: 0010:kfence_unprotect+0x2c/0x90
> [    3.044620] Code: 44 00 00 55 48 81 e7 00 f0 ff ff 48 89 fd 48 83 ec 08 48 8d 74 24 04 e8 f2 42 d2 ff 48 85 c0 74 07 83 7c 24 04 01 74 13 0f 0b <0f> 0b c6 05 4b 50 cc 01 00 48 83 c4 08 31 c0 5d c3 48 8b 38 48 89
> [    3.044623] RSP: 0018:ffffbcbe80633c50 EFLAGS: 00010046
> [    3.044626] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff98c26000
> [    3.044629] RDX: ffffbcbe80633c54 RSI: 0000000000000000 RDI: ffffffff98c26000
> [    3.044631] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    3.044633] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    3.044635] R13: ffffbcbe80633ce8 R14: 0000000000000000 R15: 0000000000000000
> [    3.044639] FS:  0000000000000000(0000) GS:ffff9e3ff7b00000(0000) knlGS:0000000000000000
> [    3.044641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.044644] CR2: 0000000000000010 CR3: 0000000244c26000 CR4: 0000000000750ee0
> [    3.044648] PKRU: 55555554
> [    3.044650] Call Trace:
> [    3.044653]  page_fault_oops+0x89/0x270
> [    3.044666]  exc_page_fault+0x79/0x260
> [    3.044673]  asm_exc_page_fault+0x1e/0x30
> [    3.044676] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.044683] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.044685] RSP: 0018:ffffbcbe80633d98 EFLAGS: 00010202
> [    3.044688] RAX: 0000000000000000 RBX: ffff9e3e94d30d80 RCX: 0000000000000000
> [    3.044690] RDX: 0000000000000003 RSI: ffff9e3e94d31d18 RDI: ffff9e3e84612400
> [    3.044692] RBP: ffff9e3e84612400 R08: 0000000000000000 R09: 0000000000000001
> [    3.044694] R10: ffffbcbe80633c90 R11: 000000000004cc80 R12: ffff9e3e94d31d00
> [    3.044696] R13: ffff9e3e94d30d80 R14: ffff9e3e84612670 R15: ffff9e3e84612670
> [    3.044715]  ? qxl_bo_delete_mem_notify+0xe/0x40 [qxl]
> [    3.044722]  ttm_bo_cleanup_mistype_use+0x22/0x60 [ttm]
> [    3.044731]  ttm_bo_release+0x28e/0x540 [ttm]
> [    3.044745]  ttm_bo_delayed_delete+0x1be/0x220 [ttm]
> [    3.044761]  ttm_device_delayed_workqueue+0x18/0x40 [ttm]
> [    3.044774]  process_one_work+0x26e/0x550
> [    3.044788]  worker_thread+0x52/0x3b0
> [    3.044792]  ? process_one_work+0x550/0x550
> [    3.044799]  kthread+0x138/0x160
> [    3.044803]  ? set_kthread_struct+0x40/0x40
> [    3.044811]  ret_from_fork+0x22/0x30
> [    3.044832] irq event stamp: 2552
> [    3.044833] hardirqs last  enabled at (2551): [<ffffffff978c990d>] seqcount_lockdep_reader_access+0x7d/0x90
> [    3.044838] hardirqs last disabled at (2552): [<ffffffff97cf3d98>] exc_page_fault+0x38/0x260
> [    3.044841] softirqs last  enabled at (2496): [<ffffffff971c30d4>] css_free_rwork_fn+0x74/0x590
> [    3.044844] softirqs last disabled at (2494): [<ffffffff971c30b9>] css_free_rwork_fn+0x59/0x590
> [    3.044847] ---[ end trace 3fbaaa179830c812 ]---
> [    3.044850] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [    3.044851] #PF: supervisor read access in kernel mode
> [    3.044853] #PF: error_code(0x0000) - not-present page
> [    3.044854] PGD 0 P4D 0
> [    3.044857] Oops: 0000 [#1] SMP NOPTI
> [    3.044859] CPU: 12 PID: 162 Comm: kworker/12:1 Tainted: G        W         5.13.0+ #31
> [    3.044861] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
> [    3.044863] Workqueue: events ttm_device_delayed_workqueue [ttm]
> [    3.044870] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.044875] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.044877] RSP: 0018:ffffbcbe80633d98 EFLAGS: 00010202
> [    3.044879] RAX: 0000000000000000 RBX: ffff9e3e94d30d80 RCX: 0000000000000000
> [    3.044881] RDX: 0000000000000003 RSI: ffff9e3e94d31d18 RDI: ffff9e3e84612400
> [    3.044882] RBP: ffff9e3e84612400 R08: 0000000000000000 R09: 0000000000000001
> [    3.044883] R10: ffffbcbe80633c90 R11: 000000000004cc80 R12: ffff9e3e94d31d00
> [    3.044885] R13: ffff9e3e94d30d80 R14: ffff9e3e84612670 R15: ffff9e3e84612670
> [    3.044889] FS:  0000000000000000(0000) GS:ffff9e3ff7b00000(0000) knlGS:0000000000000000
> [    3.044891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.044893] CR2: 0000000000000010 CR3: 0000000244c26000 CR4: 0000000000750ee0
> [    3.044897] PKRU: 55555554
> [    3.044897] Call Trace:
> [    3.044899]  ttm_bo_cleanup_memtype_use+0x22/0x60 [ttm]
> [    3.044906]  ttm_bo_release+0x28e/0x540 [ttm]
> [    3.044914]  ttm_bo_delayed_delete+0x1be/0x220 [ttm]
> [    3.044923]  ttm_device_delayed_workqueue+0x18/0x40 [ttm]
> [    3.044929]  process_one_work+0x26e/0x550
> [    3.044934]  worker_thread+0x52/0x3b0
> [    3.044936]  ? process_one_work+0x550/0x550
> [    3.044939]  kthread+0x138/0x160
> [    3.044942]  ? set_kthread_struct+0x40/0x40
> [    3.044946]  ret_from_fork+0x22/0x30
> [    3.044952] Modules linked in: xfs qxl drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm virtio_net ghash_clmulni_intel serio_raw virtio_console net_failover failover virtio_blk qemu_fw_cfg fuse
> [    3.044967] CR2: 0000000000000010
> [    3.044969] ---[ end trace 3fbaaa179830c813 ]---
> [    3.044970] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.044975] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.044977] RSP: 0018:ffffbcbe80633d98 EFLAGS: 00010202
> [    3.044979] RAX: 0000000000000000 RBX: ffff9e3e94d30d80 RCX: 0000000000000000
> [    3.044980] RDX: 0000000000000003 RSI: ffff9e3e94d31d18 RDI: ffff9e3e84612400
> [    3.044982] RBP: ffff9e3e84612400 R08: 0000000000000000 R09: 0000000000000001
> [    3.044983] R10: ffffbcbe80633c90 R11: 000000000004cc80 R12: ffff9e3e94d31d00
> [    3.044985] R13: ffff9e3e94d30d80 R14: ffff9e3e84612670 R15: ffff9e3e84612670
> [    3.044989] FS:  0000000000000000(0000) GS:ffff9e3ff7b00000(0000) knlGS:0000000000000000
> [    3.044991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.044992] CR2: 0000000000000010 CR3: 0000000244c26000 CR4: 0000000000750ee0
> [    3.044996] PKRU: 55555554
> [    3.061648] ------------[ cut here ]------------
> [    3.117815] WARNING: CPU: 10 PID: 142 at arch/x86/include/asm/kfence.h:44 kfence_unprotect+0x2a/0x90
> [    3.117821] Modules linked in: xfs qxl drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm virtio_net ghash_clmulni_intel serio_raw virtio_console net_failover failover virtio_blk qemu_fw_cfg fuse
> [    3.119709] CPU: 10 PID: 142 Comm: kworker/10:1 Tainted: G      D W         5.13.0+ #31
> [    3.119711] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
> [    3.119712] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> [    3.123843] RIP: 0010:kfence_unprotect+0x2a/0x90
> [    3.123845] Code: 0f 1f 44 00 00 55 48 81 e7 00 f0 ff ff 48 89 fd 48 83 ec 08 48 8d 74 24 04 e8 f2 42 d2 ff 48 85 c0 74 07 83 7c 24 04 01 74 13 <0f> 0b 0f 0b c6 05 4b 50 cc 01 00 48 83 c4 08 31 c0 5d c3 48 8b 38
> [    3.123846] RSP: 0018:ffffbcbe80593810 EFLAGS: 00010046
> [    3.123847] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff98c26000
> [    3.123848] RDX: ffffbcbe80593814 RSI: 0000000000000000 RDI: ffffffff98c26000
> [    3.123848] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    3.123849] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    3.123849] R13: ffffbcbe805938a8 R14: 0000000000000000 R15: 0000000000000000
> [    3.123851] FS:  0000000000000000(0000) GS:ffff9e3ff7a80000(0000) knlGS:0000000000000000
> [    3.123852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.123852] CR2: 0000000000000010 CR3: 0000000113040000 CR4: 0000000000750ee0
> [    3.123854] PKRU: 55555554
> [    3.134797] Call Trace:
> [    3.134800]  page_fault_oops+0x89/0x270
> [  OK  ] Stopped Create list of sta… nodes[    3.134803]  ? _raw_spin_unlock_irqrestore+0x37/0x40
>   for the current kernel.
> [  OK  ] Stopped Create Syste[    3.136749]  exc_page_fault+0x79/0x260
> m Users.
> [    3.136752]  asm_exc_page_fault+0x1e/0x30
> [    3.136753] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.136756] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.136757] RSP: 0018:ffffbcbe80593958 EFLAGS: 00010202
> [    3.136757] RAX: 0000000000000000 RBX: ffff9e3e957a22a8 RCX: 0000000000000000
> [    3.136758] RDX: ffff9e3e84617a70 RSI: ffffffffc034d705 RDI: ffff9e3e84617800
> [    3.136758] RBP: ffff9e3e84617800 R08: ffff9e3e84617a70 R09: 0000000000000000
> [    3.136759] R10: 0000000000000000 R11: 0000000000000001 R12: ffffbcbe80593ba0
> [    3.136760] R13: ffff9e3e94d30d80 R14: ffff9e3e84617a70 R15: ffff9e3e84617800
> [    3.136761]  ? ttm_bo_release+0x285/0x540 [ttm]
> [    3.146192]  ? qxl_bo_delete_mem_notify+0xe/0x40 [qxl]
> [    3.146194]  ttm_bo_cleanup_memtype_use+0x22/0x60 [ttm]
> [    3.146196]  ttm_bo_release+0x28e/0x540 [ttm]
> [    3.146199]  ttm_mem_evict_first+0x306/0x480 [ttm]
> [    3.146202]  ? ttm_range_man_alloc+0xe1/0xf0 [ttm]
> [    3.146204]  ttm_bo_mem_space+0x24d/0x2b0 [ttm]
> [    3.146207]  ttm_bo_validate+0xa9/0x1c0 [ttm]
> [    3.146209]  ? mutex_trylock+0x116/0x130
> [    3.146210]  ? ttm_bo_init_reserved+0x289/0x2b0 [ttm]
> [    3.146212]  ttm_bo_init_reserved+0x213/0x2b0 [ttm]
> [    3.146214]  qxl_bo_create+0x13b/0x240 [qxl]
> [    3.152840]  ? qxl_ttm_debugfs_init+0xc0/0xc0 [qxl]
> [    3.152843]  qxl_alloc_bo_reserved+0x2e/0x90 [qxl]
> [    3.152845]  qxl_image_alloc_objects+0xab/0x120 [qxl]
> [    3.152847]  qxl_draw_dirty_fb+0x14c/0x420 [qxl]
> [    3.152850]  ? ww_mutex_lock_interruptible+0x30/0x90
> [    3.156624]  ? modeset_lock+0x90/0x1c0 [drm]
> [    3.156637]  qxl_framebuffer_surface_dirty+0xeb/0x1b0 [qxl]
> [    3.156640]  drm_fb_helper_damage_work+0x18e/0x2d0 [drm_kms_helper]
> [    3.156647]  process_one_work+0x26e/0x550
> [    3.156650]  worker_thread+0x52/0x3b0
> [    3.156651]  ? process_one_work+0x550/0x550
> [    3.156652]  kthread+0x138/0x160
> [    3.156653]  ? set_kthread_struct+0x40/0x40
> [    3.156655]  ret_from_fork+0x22/0x30
> [    3.162750] irq event stamp: 1673
> [    3.162751] hardirqs last  enabled at (1673): [<ffffffff97e00d82>] asm_sysvec_apic_timer_interrupt+0x12/0x20
> [    3.162752] hardirqs last disabled at (1671): [<ffffffff980003ee>] __do_softirq+0x3ee/0x485
> [    3.162754] softirqs last  enabled at (1672): [<ffffffff970e4834>] __irq_exit_rcu+0xe4/0x110
> [    3.162756] softirqs last disabled at (1665): [<ffffffff970e4834>] __irq_exit_rcu+0xe4/0x110
> [    3.162757] ---[ end trace 3fbaaa179830c814 ]---
> [    3.162763] ------------[ cut here ]------------
> [    3.162764] WARNING: CPU: 10 PID: 142 at mm/kfence/core.c:135 kfence_unprotect+0x2c/0x90
> [    3.162765] Modules linked in: xfs qxl drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm virtio_net ghash_clmulni_intel serio_raw virtio_console net_failover failover virtio_blk qemu_fw_cfg fuse
> [    3.162769] CPU: 10 PID: 142 Comm: kworker/10:1 Tainted: G      D W         5.13.0+ #31
> [    3.162770] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
> [    3.162771] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> [    3.162776] RIP: 0010:kfence_unprotect+0x2c/0x90
> [    3.162778] Code: 44 00 00 55 48 81 e7 00 f0 ff ff 48 89 fd 48 83 ec 08 48 8d 74 24 04 e8 f2 42 d2 ff 48 85 c0 74 07 83 7c 24 04 01 74 13 0f 0b <0f> 0b c6 05 4b 50 cc 01 00 48 83 c4 08 31 c0 5d c3 48 8b 38 48 89
> [    3.162778] RSP: 0018:ffffbcbe80593810 EFLAGS: 00010046
> [    3.162779] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff98c26000
> [    3.162780] RDX: ffffbcbe80593814 RSI: 0000000000000000 RDI: ffffffff98c26000
> [    3.162780] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    3.162780] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    3.162781] R13: ffffbcbe805938a8 R14: 0000000000000000 R15: 0000000000000000
> [    3.162782] FS:  0000000000000000(0000) GS:ffff9e3ff7a80000(0000) knlGS:0000000000000000
> [    3.162783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.162783] CR2: 0000000000000010 CR3: 0000000113040000 CR4: 0000000000750ee0
> [    3.162785] PKRU: 55555554
> [    3.162785] Call Trace:
> [    3.162786]  page_fault_oops+0x89/0x270
> [    3.162787]  ? _raw_spin_unlock_irqrestore+0x37/0x40
> [    3.162789]  exc_page_fault+0x79/0x260
> [    3.162790]  asm_exc_page_fault+0x1e/0x30
> [    3.162791] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.162793] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.162793] RSP: 0018:ffffbcbe80593958 EFLAGS: 00010202
> [    3.162794] RAX: 0000000000000000 RBX: ffff9e3e957a22a8 RCX: 0000000000000000
> [    3.162794] RDX: ffff9e3e84617a70 RSI: ffffffffc034d705 RDI: ffff9e3e84617800
> [    3.162795] RBP: ffff9e3e84617800 R08: ffff9e3e84617a70 R09: 0000000000000000
> [    3.162795] R10: 0000000000000000 R11: 0000000000000001 R12: ffffbcbe80593ba0
> [    3.162795] R13: ffff9e3e94d30d80 R14: ffff9e3e84617a70 R15: ffff9e3e84617800
> [    3.162797]  ? ttm_bo_release+0x285/0x540 [ttm]
> [    3.162799]  ? qxl_bo_delete_mem_notify+0xe/0x40 [qxl]
> [    3.162801]  ttm_bo_cleanup_memtype_use+0x22/0x60 [ttm]
> [    3.162803]  ttm_bo_release+0x28e/0x540 [ttm]
> [    3.162806]  ttm_mem_evict_first+0x306/0x480 [ttm]
> [    3.162808]  ? ttm_range_man_alloc+0xe1/0xf0 [ttm]
> [    3.162811]  ttm_bo_mem_space+0x24d/0x2b0 [ttm]
> [    3.162813]  ttm_bo_validate+0xa9/0x1c0 [ttm]
> [    3.162815]  ? mutex_trylock+0x116/0x130
> [    3.162816]  ? ttm_bo_init_reserved+0x289/0x2b0 [ttm]
> [    3.162818]  ttm_bo_init_reserved+0x213/0x2b0 [ttm]
> [    3.162820]  qxl_bo_create+0x13b/0x240 [qxl]
> [    3.162822]  ? qxl_ttm_debugfs_init+0xc0/0xc0 [qxl]
> [    3.162824]  qxl_alloc_bo_reserved+0x2e/0x90 [qxl]
> [    3.162826]  qxl_image_alloc_objects+0xab/0x120 [qxl]
> [    3.162828]  qxl_draw_dirty_fb+0x14c/0x420 [qxl]
> [    3.162831]  ? ww_mutex_lock_interruptible+0x30/0x90
> [    3.162831]  ? modeset_lock+0x90/0x1c0 [drm]
> [    3.162842]  qxl_framebuffer_surface_dirty+0xeb/0x1b0 [qxl]
> [    3.162845]  drm_fb_helper_damage_work+0x18e/0x2d0 [drm_kms_helper]
> [    3.162851]  process_one_work+0x26e/0x550
> [    3.162852]  worker_thread+0x52/0x3b0
> [    3.162853]  ? process_one_work+0x550/0x550
> [    3.162854]  kthread+0x138/0x160
> [    3.162855]  ? set_kthread_struct+0x40/0x40
> [    3.162857]  ret_from_fork+0x22/0x30
> [    3.162859] irq event stamp: 1673
> [    3.162860] hardirqs last  enabled at (1673): [<ffffffff97e00d82>] asm_sysvec_apic_timer_interrupt+0x12/0x20
> [    3.162861] hardirqs last disabled at (1671): [<ffffffff980003ee>] __do_softirq+0x3ee/0x485
> [    3.162862] softirqs last  enabled at (1672): [<ffffffff970e4834>] __irq_exit_rcu+0xe4/0x110
> [    3.162864] softirqs last disabled at (1665): [<ffffffff970e4834>] __irq_exit_rcu+0xe4/0x110
> [    3.162865] ---[ end trace 3fbaaa179830c815 ]---
> [    3.162866] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [    3.162866] #PF: supervisor read access in kernel mode
> [    3.162867] #PF: error_code(0x0000) - not-present page
> [    3.162867] PGD 0 P4D 0
> [    3.162868] Oops: 0000 [#2] SMP NOPTI
> [    3.162869] CPU: 10 PID: 142 Comm: kworker/10:1 Tainted: G      D W         5.13.0+ #31
> [    3.162870] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-3.fc34 04/01/2014
> [    3.162871] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
> [    3.162876] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.162877] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.162878] RSP: 0018:ffffbcbe80593958 EFLAGS: 00010202
> [    3.162878] RAX: 0000000000000000 RBX: ffff9e3e957a22a8 RCX: 0000000000000000
> [    3.162879] RDX: ffff9e3e84617a70 RSI: ffffffffc034d705 RDI: ffff9e3e84617800
> [    3.162879] RBP: ffff9e3e84617800 R08: ffff9e3e84617a70 R09: 0000000000000000
> [    3.162880] R10: 0000000000000000 R11: 0000000000000001 R12: ffffbcbe80593ba0
> [    3.162880] R13: ffff9e3e94d30d80 R14: ffff9e3e84617a70 R15: ffff9e3e84617800
> [    3.162881] FS:  0000000000000000(0000) GS:ffff9e3ff7a80000(0000) knlGS:0000000000000000
> [    3.162882] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.162882] CR2: 0000000000000010 CR3: 0000000113040000 CR4: 0000000000750ee0
> [    3.162884] PKRU: 55555554
> [    3.162884] Call Trace:
> [    3.162884]  ttm_bo_cleanup_memtype_use+0x22/0x60 [ttm]
> [    3.162887]  ttm_bo_release+0x28e/0x540 [ttm]
> [    3.162889]  ttm_mem_evict_first+0x306/0x480 [ttm]
> [    3.162891]  ? ttm_range_man_alloc+0xe1/0xf0 [ttm]
> [    3.162894]  ttm_bo_mem_space+0x24d/0x2b0 [ttm]
> [    3.162896]  ttm_bo_validate+0xa9/0x1c0 [ttm]
> [    3.162898]  ? mutex_trylock+0x116/0x130
> [    3.162899]  ? ttm_bo_init_reserved+0x289/0x2b0 [ttm]
> [    3.162901]  ttm_bo_init_reserved+0x213/0x2b0 [ttm]
> [    3.162903]  qxl_bo_create+0x13b/0x240 [qxl]
> [    3.162905]  ? qxl_ttm_debugfs_init+0xc0/0xc0 [qxl]
> [    3.162907]  qxl_alloc_bo_reserved+0x2e/0x90 [qxl]
> [    3.162909]  qxl_image_alloc_objects+0xab/0x120 [qxl]
> [    3.162911]  qxl_draw_dirty_fb+0x14c/0x420 [qxl]
> [    3.162913]  ? ww_mutex_lock_interruptible+0x30/0x90
> [    3.162913]  ? modeset_lock+0x90/0x1c0 [drm]
> [    3.162922]  qxl_framebuffer_surface_dirty+0xeb/0x1b0 [qxl]
> [    3.162925]  drm_fb_helper_damage_work+0x18e/0x2d0 [drm_kms_helper]
> [    3.162931]  process_one_work+0x26e/0x550
> [    3.162932]  worker_thread+0x52/0x3b0
> [    3.162933]  ? process_one_work+0x550/0x550
> [    3.162934]  kthread+0x138/0x160
> [    3.162935]  ? set_kthread_struct+0x40/0x40
> [    3.162936]  ret_from_fork+0x22/0x30
> [    3.162938] Modules linked in: xfs qxl drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm virtio_net ghash_clmulni_intel serio_raw virtio_console net_failover failover virtio_blk qemu_fw_cfg fuse
> [    3.162943] CR2: 0000000000000010
> [    3.162944] ---[ end trace 3fbaaa179830c816 ]---
> [    3.162945] RIP: 0010:qxl_bo_delete_mem_notify+0x19/0x40 [qxl]
> [    3.162946] Code: 89 e7 45 31 e4 e8 27 cb fd d6 eb ea 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd e8 a2 02 00 00 84 c0 74 0d 48 8b 85 48 02 00 00 <83> 78 10 03 74 02 5d c3 8b 85 44 03 00 00 85 c0 74 f4 48 8b 7d 08
> [    3.162947] RSP: 0018:ffffbcbe80633d98 EFLAGS: 00010202
> [    3.162947] RAX: 0000000000000000 RBX: ffff9e3e94d30d80 RCX: 0000000000000000
> [    3.162948] RDX: 0000000000000003 RSI: ffff9e3e94d31d18 RDI: ffff9e3e84612400
> [    3.162948] RBP: ffff9e3e84612400 R08: 0000000000000000 R09: 0000000000000001
> [    3.162948] R10: ffffbcbe80633c90 R11: 000000000004cc80 R12: ffff9e3e94d31d00
> [    3.162949] R13: ffff9e3e94d30d80 R14: ffff9e3e84612670 R15: ffff9e3e84612670
> [    3.162950] FS:  0000000000000000(0000) GS:ffff9e3ff7a80000(0000) knlGS:0000000000000000
> [    3.162951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.162951] CR2: 0000000000000010 CR3: 0000000113040000 CR4: 0000000000750ee0
> [    3.162952] PKRU: 55555554


--------------F0095003FAE693238293E04E
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-qxl-add-NULL-check-for-bo-resource.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-qxl-add-NULL-check-for-bo-resource.patch"

From 28c6b96daee1cf0d26f4d343b6bdad174b51df9e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 6 Jul 2021 08:51:25 +0200
Subject: [PATCH] drm/qxl: add NULL check for bo->resource
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When allocations fails that can be NULL now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 19fd39d9a00c..37a1b6a6ad6d 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -127,7 +127,7 @@ static void qxl_bo_move_notify(struct ttm_buffer_object *bo,
 	struct qxl_bo *qbo;
 	struct qxl_device *qdev;
 
-	if (!qxl_ttm_bo_is_qxl_bo(bo))
+	if (!qxl_ttm_bo_is_qxl_bo(bo) || !bo->resource)
 		return;
 	qbo = to_qxl_bo(bo);
 	qdev = to_qxl(qbo->tbo.base.dev);
-- 
2.25.1


--------------F0095003FAE693238293E04E--
