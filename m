Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9429534808A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbhCXSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:31:55 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:22176
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237536AbhCXSb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIJq1KFmf0EJ3eJf1odh5a1jIKIG1fGTnaqoElw+QXXhRyZcAWS3t1klbChP1gAa/Tpd8g1aB4CtPcs97fICbLRc84fud1FRMpIwFqwk0xIzdwK0sf46U3di6bHfiF5xWKOnRmqIlOy1McdL4w8Q6T2U+SPieF87nCzxhf/HmCbLwzEDxOaNoq0apaDnTzUmFdUqNtGtfD7M1CVKIZTowibz6BB/1YtW08QUer1vQ85dAzSnGRgurzL+r/7NIK5TOpUgzi20ZgCBgnm2u0zfMDJhIEAmeBhulOrnAo92X2Zl+Vl1XVPR+BnzloX5SnRUvsn27V9BtZx54iLiq0TCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70oLEhjenFsX2AHhizNRgWcIwYLfNDOM3gtKqz6v3xo=;
 b=jY8efO3b912ACpBHqG41LvqsQdUlhI46MBsIxwRW1kz54y6idhNOY1SAumRXV2j5m8nKnzJ6c7AlDpzDNK8pGV5vPJBs+UOY2xikNC6DRdclryfiGhxLt8G22qMiez1dZOMDdMEcjix3vGwxcDVivZ7hfZrsxvy11f4eBzyIOgTI9eI1/8KhVFrvFz5hpyfOkLzNrkqbQJjvyQQDgVa1uHUGq1ux1dAGFca6IqlztNfewqqjz8HXg0jelfZLy4VwwNEc3FYouwKBU2ZBCgh88nZAfmfpxLAGrCDWfg82lB3pw3h/NPEKTnwG4IAfnS8pQaFIDQYcLR9TSweEg1ji1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70oLEhjenFsX2AHhizNRgWcIwYLfNDOM3gtKqz6v3xo=;
 b=ImQO6cH2cQ5A8id9TauScVee7P3aZgJp319v+vB90ktdpN8UDyYPo74l93pzeaYD5qItPq+XLy6H28+ZqPso+qlXHK8SvtS5EiPFhDmmReW0ZctQwLJMxDfZBEjx5lIQNnn5R8vCxBrjzuvS0kJYZ6sKVCXknm2VInX40qbNg+A=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 18:31:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 18:31:23 +0000
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local> <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
Date:   Wed, 24 Mar 2021 19:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210324163812.GJ2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:d95a:1638:1804:512a]
X-ClientProxiedBy: AM4PR0101CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::46) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:d95a:1638:1804:512a] (2a02:908:1252:fb60:d95a:1638:1804:512a) by AM4PR0101CA0078.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 18:31:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 876087e0-05ed-4a26-c311-08d8eef306da
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38851BEE305C616C7DF7BFEB83639@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: em+Pch+O4kvLZc8km8O8D+mKzORj4Et6AKRzLUS6Arm3H0HUD9PxpuLxKsF0m005ukxOHKc5LhVpy3zylVtKF99V745FsrnDsgTX+bgzzk0U7Dv1+QHsBIcX3YIHTrSgoAHtN2T3YlhmvF3Q4BFB6q0p2UNHsBYB6YjcyTUTN1XO94q5iA6Hm4J877VWzOh/tkUrA1uZr50DwfYszm6FK48quNdW6+hR8fQu0sZQj2+SsF5T5ONkrLCNJZ/uu07Opv6kI8vhDofYfejneNMEnBY8zmRG3+o/MtofOjVSN76p0MZv/n4JJ3c865WrPc7/6ioq4lrasyg4Ie5Frs2+L6jOsyC+2eDEeUSggVKIXJL/KnAULnq5aOL0GLCoSMCgpj7r1i4TdADC5Wm2qm5konb+38b2s5uysL8mJXBQqkq5bzngucm/SSpeMGJrtmECAmzUlFccKX5hLeD/Oqtb6Fjp9PSyDUsSrq6yApAa8UA6y1NgqNA4rz7dZfD+c+oQaT5ymjVyMudCzU4L5Zz+12q57fuGOthb78PqfAwVwBaUpgGejPLNKpsC8G475fg4K4tO1/ik+1VG1coV/KGBWIPjuk8MOjztjYkRPa+9SgTZn2NlZwT2MF051OQRJE+/NUwdmZzBtMWhBbTH0zeJWzw2CHrqconzqrxeF7IpWf0eZhvM9mImUO8Y/Z7dT4iM1C8sXFLCVHrYe0DU2fV2DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(52116002)(38100700001)(66476007)(6486002)(54906003)(83380400001)(66556008)(4326008)(86362001)(2616005)(2906002)(31696002)(66946007)(8676002)(6666004)(16526019)(478600001)(36756003)(31686004)(316002)(53546011)(186003)(110136005)(5660300002)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aVFNSUE4eTlQRTZ6QWtycGtOcXFZdG5Db0JtNXpFVVkyU1VnZDJrbkl5a1lZ?=
 =?utf-8?B?N2VxMTcrNDZpNkM3bUVQN2s0Q3FBeWp2L0o5UEQ2YXJCSGkwNjNFVXpQVFFP?=
 =?utf-8?B?bk9saFpsWlJJcGlNL3FYdURKTXdmaFNJSDBHNjhaVzZwd0s5bHExNDYrWStv?=
 =?utf-8?B?Z05OYmlUUElKcUZNNUc2T014UGNLaEgxOHg5TUNBVW9XQnhDMm5uM0VxQzJ0?=
 =?utf-8?B?cXVQV2V1Yzh0T2dEOFhvZFd3UDdscG8rYzlMS3EvRE1acHppZUdYbkpvWVQx?=
 =?utf-8?B?U25sTEtJNFc0NVNNL09GTGwvbU9WMDNGMlkraVprVGVOaFh2QU95bmNoYnFM?=
 =?utf-8?B?ZlZtNVQyeW4zdlp4SVRPUGV2K3Frd3B6eVY3THVkSHRTdFN0QUc4QlhkdE8v?=
 =?utf-8?B?OFh1VlZlc0VoUUlDeExRMkVsTWtSKzhBak9kYm5sRXljUFcxcGN2RkRQNUZP?=
 =?utf-8?B?MllOamZjaWpaSUVXZHlHU1l5ZUI5VUltQ2U0TXRaUTVoZE55dE80ZXJKRTFj?=
 =?utf-8?B?ck5Wb1lKT2FIMGVXVlVZMzY3SG10aFI5d1crdzhZVTU0QisrMHIreXpSd1J0?=
 =?utf-8?B?UC84T0d6SThqNmk0Tm1aN09RWUN1NGhCeThDZ0s1a2RFMnFYaGhManZiRUt1?=
 =?utf-8?B?Unh2cTM2cExSbUhiamR2SEl1aW5VQTJmZ1QzNFZsL0RXZFVTK3hDTXFqekln?=
 =?utf-8?B?d0h6anpHQkNMUzVKalUzMG80eFdiMHhMNC94cHFiU094Q3JXSlJrdys5U2pV?=
 =?utf-8?B?bzdBejYySzE5QW83WjErSHRKYkdGbEVvNEp6VWlCS0sydE1EOGY3V1VOek1D?=
 =?utf-8?B?Vk5rQ3orSWhPbnFqUHhGK3Y2WndqeURzTDQzczN2NGRKMUlZYXJlQURZTjJo?=
 =?utf-8?B?RERoWjVwNzFXVzB0K2sxL2NnUkhLaGJpeWg0Q0p2eXpLeWcvT1ZuaEQ5UEdH?=
 =?utf-8?B?NW13RnpYamVRV2pJZ2lDTHhHT3JGYyt4ZnErdmhOY0xGWk5DNUdnbHQ0VTcv?=
 =?utf-8?B?VHUrL1Q5ZnYrQjg2T09OMDY3dDFWVklNbTYrbWxTMEp1ZkNuQjl2VmcxVTF0?=
 =?utf-8?B?S0NlMmdZZzdUTlRQYnRaNkFaNmZISlI4THloeUI2cjFOODhkam9yUlYvZFVB?=
 =?utf-8?B?SEV2M005OWVkN2MxbmtpRWVUU1Q5cU8zanVUQXY5Wk50K1djZ2YxMmlKcEFP?=
 =?utf-8?B?ODV3R2M2SEhSYUdjcW13YmFLaWVzcmVhbUZUT0pNb3poN3RJK2huUDgvY2VG?=
 =?utf-8?B?UExSWGpNc0tJYWh4cWFTb00xcFBOV3VxcitZZTU0emhzVDNrRGdJNkhHNDRq?=
 =?utf-8?B?WjhXU0pFMUVERjZ4cVpLR0FTQzRXc05WcHU0ZFh0K0EzaGt0bGcveGZpbGNH?=
 =?utf-8?B?TDZKNCt2ZytyMVdlRzY2TEIvUXlBQWZCeVFRZE9rNExjdWJQdjhSTWFiNlUx?=
 =?utf-8?B?UzhzS1ExQ2p1MTRjazRNVjM1Z25nOU1WZG02Si9uUFQwZ1lYMlNWNklUSzFv?=
 =?utf-8?B?Y0tock9ROE5uZzBWU2M3bW00UFYwNXpXMXRpY21ZV05yWG13T1NmcmhPbTFm?=
 =?utf-8?B?K1N0Z1NIZk9Ka3Rqc0pBQ093Z1B2UmJiN0QvRitBWlNEUE9pdGluMyt2ZFJx?=
 =?utf-8?B?Szl1YnVSM2ZKdStjcW11SEpac0thRGNMazQ3Tjc0cDJCTmJOdXY0M0hsTzB4?=
 =?utf-8?B?Rm9yOENIdmh0T3AxQ1orVGZMYStZV2tUUnU1Y2cwdWRFcjYxWU9JOEN3Mmpr?=
 =?utf-8?B?L3lmUzRhYjhOL3RBTG1ZU0Y4Zjk5bks2TkZJeGNpM0hmbGZNZXJYZGRhMXhq?=
 =?utf-8?B?ZFB3cFU2Tm14VWxvWlUzbkZEdDhUV2twSDg4TnB5SFZnV0VHaUYwQ0k2TmVr?=
 =?utf-8?Q?KywB5Qlki0eZA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876087e0-05ed-4a26-c311-08d8eef306da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 18:31:23.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnYDzwIEOntfstXa9T3SkLUOrmx1sANSXpEYeAYTDYy5ICWC3nQzPDgiW8fik4SV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel) wrote:
>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström (Intel) wrote:
>>>
>>>>> In an ideal world the creation/destruction of page table levels would
>>>>> by dynamic at this point, like THP.
>>>> Hmm, but I'm not sure what problem we're trying to solve by changing the
>>>> interface in this way?
>>> We are trying to make a sensible driver API to deal with huge pages.
>>>> Currently if the core vm requests a huge pud, we give it one, and if we
>>>> can't or don't want to (because of dirty-tracking, for example, which is
>>>> always done on 4K page-level) we just return VM_FAULT_FALLBACK, and the
>>>> fault is retried at a lower level.
>>> Well, my thought would be to move the pte related stuff into
>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>>>
>>> I don't know if the locking works out, but it feels cleaner that the
>>> driver tells the vmf how big a page it can stuff in, not the vm
>>> telling the driver to stuff in a certain size page which it might not
>>> want to do.
>>>
>>> Some devices want to work on a in-between page size like 64k so they
>>> can't form 2M pages but they can stuff 64k of 4K pages in a batch on
>>> every fault.
>> Hmm, yes, but we would in that case be limited anyway to insert ranges
>> smaller than and equal to the fault size to avoid extensive and possibly
>> unnecessary checks for contigous memory.
> Why? The insert function is walking the page tables, it just updates
> things as they are. It learns the arragement for free while doing the
> walk.
>
> The device has to always provide consistent data, if it overlaps into
> pages that are already populated that is fine so long as it isn't
> changing their addresses.
>
>> And then if we can't support the full fault size, we'd need to
>> either presume a size and alignment of the next level or search for
>> contigous memory in both directions around the fault address,
>> perhaps unnecessarily as well.
> You don't really need to care about levels, the device should be
> faulting in the largest memory regions it can within its efficiency.
>
> If it works on 4M pages then it should be faulting 4M pages. The page
> size of the underlying CPU doesn't really matter much other than some
> tuning to impact how the device's allocator works.

I agree with Jason here.

We get the best efficiency when we look at the what the GPU driver 
provides and make sure that we handle one GPU page at once instead of 
looking to much into what the CPU is doing with it's page tables.

At least one AMD GPUs the GPU page size can be anything between 4KiB and 
2GiB and if we will in a 2GiB chunk at once this can in theory be 
handled by just two giant page table entries on the CPU side.

On the other hand I'm not sure how filling in the CPU page tables work 
in detail.

Christian.

>
> Jason

