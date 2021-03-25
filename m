Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE43492A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCYNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:03:24 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:19136
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230166AbhCYNCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krdR8bw/rSNkGcYA5cEx4bDna83BD26AqsL3A8II2Q5Rjpn+w3XoehTqIEUiG6ry9I2fOQaG0Pj99qCXtGy7a9BlWOPkMyzpux/5l0pR7pN7YSmm3W0vFLgdwJkHeL8chVb/m86Bx7IfB1P9w/DP1K8nGqJs7oSyr6fu7CXlAKBj0VtpQNVbZ2YvVtXsHP76QXLqkTfLnL/PvUoddab5dTB9zoM3VG7/MFJI3dssfkiDJX+Cg7tuML3eu1t22X3+AlgqpNhUSLmqhgVOcMMjZnD527b9iBIUvGBEsaXHGDh31jrP+rCfEN6aidy/EpRQrwJ22WdHG03Ye1DeshBWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtP9Zf5uWN+XVpFR/pfy6RBlt6wabkcmIDJ0wXz/J90=;
 b=DV1AfwYHe9AM9+oDqM4pn317irCXX7xde5IDvFG6JkcEbcq/QZgGXJagNo0oZZC/lHlEGlBy4H7g6S0DQL5vW9ceTPXYuz+rZdwfMnjqYCM+xrT83jNpY8vSO0/cIQsyKXJxjqPwpmRr50PHy0qPI+ZWTBK03uji4xN1dXVvTFwefH1yRVQajtrt9D9kgwTOyEz1jgCTCVQTYEcMMV4Rkl+k4BcmjMfUrZS2gervvwUpzUSeGdwJHqM1yieoriSVQEYpJYyogXJ/Rz27R77htUdXz95BeZ6OCqSHgU9UgXvQ/52CnqIysyg+pAF81Rd6eJyg6NjYoEwQZVqObmsvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtP9Zf5uWN+XVpFR/pfy6RBlt6wabkcmIDJ0wXz/J90=;
 b=MpWduIifrgFH2rcA8fQSh1akskphnI6R6DzdLaaxpT72trOk7bGpbBOmtTW+HBI1znXVJyqXwvLuC9D+ZWgJAxsiXIuM0U6K+ky+DdCRZ4YzxFx5uDFJCQNN+wjkutI0bXuiz8OoFzlLuJj80cO4eDSbYj4c4ctL8KpM/ab7K+Q=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 13:02:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 13:02:42 +0000
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com>
 <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
 <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
 <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
 <20210325113023.GT2356281@nvidia.com>
 <afad3159-9aa8-e052-3bef-d00dee1ba51e@shipmail.org>
 <20210325120103.GV2356281@nvidia.com>
 <a0d0ffd7-3c34-5002-f4fe-cb9d4ba0279e@amd.com>
 <d8c5b688-ede1-b952-1bc9-f2aae870a7a6@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fc548803-7e12-83d7-10b8-4774cae4747f@amd.com>
Date:   Thu, 25 Mar 2021 14:02:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <d8c5b688-ede1-b952-1bc9-f2aae870a7a6@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:72d1:2a48:a80e:e149]
X-ClientProxiedBy: AM4PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:200:89::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:72d1:2a48:a80e:e149] (2a02:908:1252:fb60:72d1:2a48:a80e:e149) by AM4PR0202CA0022.eurprd02.prod.outlook.com (2603:10a6:200:89::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 13:02:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 469a88c9-1cb8-40fa-4baf-08d8ef8e46ba
X-MS-TrafficTypeDiagnostic: MN2PR12MB4303:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43031462FFF442F30862F32F83629@MN2PR12MB4303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6u4HD3JFNXB3zI3QwA3sc6p87ZglTOMR5NnWbwrmFLcy4fyhS8CEwkPUFjGaoWShD5U6lv97yX1yxWGoXNXN7+6myVrSzxIqp8fmyB8bvrCS4uWBm1LPxrNIdOuBnMJOXk0Gf87AiXtaztd7hgSIoKashdfCS86V9H+YGleOSEFf3OEdKvscpca6F60+m8f51lSnhvXuQAYzOCXh8QrdKYFGt0a24Q2letJYXQVh0kX6W0Jnjr3qgw7PDBETr7xq48n8mIxIl5JR96onFNcHM/fRc0tvighdPagwUjt9LfG+tObeakYd+YeDqRaNdMwmOisqxERdySDv5enpyenLe4AoMm4+y8BTGzuzA0mpVFr/Kfjw21Ebc9S6dntM6n7W6xI8SyZAe/7hzS4p55j8sVb4zfsbyyvJ9Hum7rAEW/m/Tn4oj3iJ0HwdBdjWeaf9UuEl0OEBSiQTkjIxMtii762cVUliHYWmpPJPCE84IA8j5HZDInJSrEo23uuRgxQuC1ZaH9bRh4YsLF55QhdI/2JJdCiAL/ywjr1SNv1skY0MImXwevFI3KVjQA+6kQ2DLQLUuJzNxcJKNq/qGhoCMIA1fVHtAxxXtOmG8i4JjiHttbkFE3pevjk+4Deq+RW2dXPzAPPcfVGpfvV0dRsbRQQFQLexuwDf/WGFPuH+/kRRItavPlXk3u2N411wjr4TKR+YsSe99S+skNSZ0vS2ZCMIOwmU4tfx0hujLJBF+DhRm7wnPDt6b5ZXWaqm953
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(52116002)(478600001)(110136005)(66574015)(54906003)(38100700001)(16526019)(316002)(186003)(31696002)(86362001)(36756003)(66556008)(8676002)(8936002)(6486002)(53546011)(5660300002)(31686004)(2906002)(4326008)(2616005)(6666004)(66946007)(66476007)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGplbEVBaXNoZHBQWmVITGx3UENEWktmdUhDbW5wTmRObGQ2bmFPZXhoME9V?=
 =?utf-8?B?MHU2eklFSTh2WXkrQUJQVXQ0dC9PUi92aS93Yzg2cWpzZnNQT3plK0ZCSVpm?=
 =?utf-8?B?TnVURm1HVVBWN1FKa3Z3OHcwWURNOWxmTUhJYzNMQzY5YTlHT1hJeUswK1ZR?=
 =?utf-8?B?bUN2ZmZvRzY4SFd3bitRalpEa2RnNmdMc1owNjNlUHhManRHMFdXOGlTdVdr?=
 =?utf-8?B?VU81aGsxcGZYZjVQWU93cEVtOW5yc2Z5UFovTTUyOFJlUEZlL1JGVG9IV0NK?=
 =?utf-8?B?SlZ3QVJoSWZOWVQxckFMYWRDZWppUFRqa3BBSHc1Zld2UnhFUVdGVUE1RlhV?=
 =?utf-8?B?VmorWnJFMHJPVkQ4UmU3ZE01R1BWT0puWFUzV0VndUZIZVE1VytldHR3VFZh?=
 =?utf-8?B?dUx5VXYxaXhRdHpBTGx4YUFON1BGQ1ZIeHZ6cEU2Y2luUERCNFVvRkxqR080?=
 =?utf-8?B?TW41MEV3RGQ4dUZLV096cHM1N3B4UGJOaE51cUR2dlVyRmxOL29GQS9POTVK?=
 =?utf-8?B?UEVoenpyWDM0MmNtQ1hpa2JMZGxMVWRUQ2FBaXk4VXUwbU1vYlc3QXJGaTAw?=
 =?utf-8?B?aklCSUN6Z0NPRWNXSzVVbWpONkhkUGVNeDhZSU1YbmJPZEhLTHZlZ2dWTWFE?=
 =?utf-8?B?VnVRTzgyNUowTjNieG44bDgzRG5uTGtBL0h2ME1Eb0YwNlFEV3dKWVBCUzRm?=
 =?utf-8?B?cFA4WndnOCtCZlgvcy9iajJOOU9yaHVrcDAvMFlzaTh3Wi9PMGN0c0FLT1Zo?=
 =?utf-8?B?NlMwejdiQVZQOTZtMVU2MS9VbGtSeFdEeXhCQ0Q0L1NHVmxEV0hVNXJyNHAr?=
 =?utf-8?B?b2R4RkFLQ0lPT3JuRHJ3THVUV3U4SHBXdnpzU08rcmcycnBBeGRrT2UvZkt3?=
 =?utf-8?B?alE0L0JOZWNHdGlSU3FpUEQ1Qms2VTdoaHJtYkZRSVFjV1JrQWs4aU1UZW01?=
 =?utf-8?B?ME9lMkkyT2ZuYitxMlZMQ2V3Tnl3ZGJCTTJVVDROL1dzUkY2elZBNXpoNDVD?=
 =?utf-8?B?MXZyQVlNQmcwWm92NEhhOVQvd0Y2aG15R3doUDNaYzYydVE3cGpWQjJldHV5?=
 =?utf-8?B?QysrWW9WR212R3BCbWo3Ry85RkFoY1BYanZHOUs5cDB6M1RrMVZnM00wQ2tx?=
 =?utf-8?B?ZU0rU090MS9jdVpzMEVENXViUDNmYTRqeFZNLzN1YlI4WHgwMmcyajJGN3pX?=
 =?utf-8?B?R1pQUmlCZkxjbHBjZnZXSGFDZ1R4OGFEVXVHQ3FsaFExcCtmZGE0R29qSXFm?=
 =?utf-8?B?dGVEUEErcUVuV2xFeUkwVjlHRGtNVnhFR3NtTjBpTjlUUU9ScHEyWnRCbjJr?=
 =?utf-8?B?QllMVndoVnAzZ3dmeHJLUUo4cnQ5dUkvZ1QxY1ltRFh1VmsyQzJheUZPWmlU?=
 =?utf-8?B?THlBRE16TURneTZqMTRmM05oMjVKTnhWVklvNlA5UzJaOE9SalFkZGQ5MDdy?=
 =?utf-8?B?UHd0c2gwS1Z4V1o0Uy9kSFJzU0NpUGR0akliSTZtL0N6RUZZZmZjTDAvYnkx?=
 =?utf-8?B?Z3VXakZ4dWU5a3hPZnJDUVhmdDdGR2l3Zzh4VjJoQlZuRDlheU1KdHUvTEY3?=
 =?utf-8?B?YnlvWjBYTFhvUWhuMTFLakpWS0tqZmlDV0Q5OXp3WnFaRmdMcUFCMlkxQ1U2?=
 =?utf-8?B?N1A0L2tBUndKd21mK3RnVS91ZWs0YWUzSVNKMW11aHRySHdhMGhPcjVHZGZp?=
 =?utf-8?B?MmtVVGlFakozVzVibU81a21hUTJYaG4zclNGVTZDSWhZbmJ1S2o0SUlLUHFJ?=
 =?utf-8?B?UU1DUEdXZ2lWc2xUK1RITThwRFFrRkdpbXhpSXV0aitHOEw3cnVnZGNEZE81?=
 =?utf-8?B?bkh4NTFSanFkb0t6MWRiejlxUFRxSnRHbWJUSVpjNlZOdnVhbW1QREJxSU1Q?=
 =?utf-8?Q?DB5BWU1YyEvHt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469a88c9-1cb8-40fa-4baf-08d8ef8e46ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 13:02:42.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkZSsOdWrQAGJ4hGOEtBIwxN0ZI7cIJhIP6JS8G264NRvYps8SK0DIcBnEj41dCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 25.03.21 um 13:36 schrieb Thomas Hellström (Intel):
>
> On 3/25/21 1:09 PM, Christian König wrote:
>> Am 25.03.21 um 13:01 schrieb Jason Gunthorpe:
>>> On Thu, Mar 25, 2021 at 12:53:15PM +0100, Thomas Hellström (Intel) 
>>> wrote:
>>>
>>>> Nope. The point here was that in this case, to make sure mmap uses the
>>>> correct VA to give us a reasonable chance of alignement, the driver 
>>>> might
>>>> need to be aware of and do trickery with the huge page-table-entry 
>>>> sizes
>>>> anyway, although I think in most cases a standard helper for this 
>>>> can be
>>>> supplied.
>>> Of course the driver needs some way to influence the VA mmap uses,
>>> gernally it should align to the natural page size of the device
>>
>> Well a mmap() needs to be aligned to the page size of the CPU, but 
>> not necessarily to the one of the device.
>>
>> So I'm pretty sure the device driver should not be involved in any 
>> way the choosing of the VA for the CPU mapping.
>>
>> Christian.
>>
> We've had this discussion before and at that time I managed to 
> convince you by pointing to the shmem helper for this, 
> shmem_get_umapped_area().

No, you didn't convinced me. I was just surprised that this is something 
under driver control.

>
> Basically there are two ways to do this. Either use a standard helper 
> similar to shmem's, and then the driver needs to align physical 
> (device) huge page boundaries to address space offset huge page 
> boundaries. If you don't do that you can just as well use a custom 
> function that adjusts for you not doing that 
> (drm_get_unmapped_area()). Both require driver knowledge of the size 
> of huge pages.

And once more, at least for GPU drivers that looks like the totally 
wrong approach to me.

Aligning the VMA so that huge page allocations become possible is the 
job of the MM subsystem and not that of the drivers.

>
> Without a function to adjust, mmap will use it's default (16 byte?) 
> alignment and chance of alignment becomes very small.

Well it's 4KiB at least.

Regards,
Christian.

>
> /Thomas
>
>
>>>
>>> Jason

