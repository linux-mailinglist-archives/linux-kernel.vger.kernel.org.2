Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54330D9D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhBCMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:31:13 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:28897
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234057AbhBCMbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:31:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLTPdMCRArN2gAE91bB5fgigK96i7qHUq2iDX9kXj7CmlXlEQ71vdVEmq12IeiOV3L0MQt0jcgadxndlwrXh1Yfw7qC4qxMIioqKiAs3MrYybUbb8DfO/nEko7nQjpILbqY0MSfq/lz/DSPHJ3E4lcqk8RvlDWA930mCt7iVq+s1i0xGjjjJh7ZEw21y1aDVjeU2aTUgw5H2zIFqvqD7TB+lOS0Xuo526fTxbDNJPOFs9sxnYjdq7dzXBJVzOQNbLp9KCcSpGU5emQuXXLob2aQKpiJc+5Fm7bqe2dCN39bJomJ5AYC7UJVsqHu3KcxNv0K+/zaDtlmmaiMXpnzSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgjFn+tnBcIc0c7j9a1gwO9rtslW2C5ZjgyvfuWSwQI=;
 b=KusDwlHCKzzfkRUP+TwIVXperZWrMxv4Me0YW6gqSccXRy3CEyLNk1WU8aXnDif18zc6k2YuDFspUTgwDtJlWChmrzxtrxyxc5zo95X2UXtgS9WJfLKbnW2hSyUPq/UoGTvwAPZoDhcMcrEYa107OvKoL8PeB1Rd2F+x85pWQQMKlDPrfNfY/h+00M2HquqiJ4uKTu7f8JoCz/Iz3Q1X5KenH3k9blJpsBNXv3ktl+n/Iu8nXaKGpT0dALwWEpTe/5kOeGIl4GBqzgIXHnq/ie9aRHSyBL4efdAmoFRv+1iOxPZoT60RXe+UzGYgnGY0E28d1jvJzVDGd4B0wVqZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgjFn+tnBcIc0c7j9a1gwO9rtslW2C5ZjgyvfuWSwQI=;
 b=rVfzo9iaHRaxMPrW29NA3L+X3xG5DPWyHV6yxPBFEJVou/XKhAOab8SKAtWTZ9UCjcTBQzjxxbGHc4rjQ+nTZwSOKbTvef+jH0c2HeCd2ztanTb2Kp2YNdc8ul11lHJ7VDfoHJOnm5gG/41ICKwpI6trFcwisqc3Kkdb4XIny4c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4781.namprd12.prod.outlook.com (2603:10b6:208:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 12:30:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 12:30:13 +0000
Subject: Re: [amdgpu] deadlock
To:     Daniel Gomez <daniel@qtec.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com>
 <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com>
 <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
 <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
 <CAH1Ww+Q=9TnxB2QW1=wb-NAoYmt0_+DueFj8vowqPjPFe_Cw8w@mail.gmail.com>
 <538682ee-3e12-a345-2205-2c0f16b496ff@gmail.com>
 <YBqWCgTPTLomYvAt@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e34c8d2a-aded-a3be-334a-2adc4d552373@amd.com>
Date:   Wed, 3 Feb 2021 13:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBqWCgTPTLomYvAt@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0302CA0030.eurprd03.prod.outlook.com
 (2603:10a6:205:2::43) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0302CA0030.eurprd03.prod.outlook.com (2603:10a6:205:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 12:30:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1d09eec-7328-4739-6244-08d8c83f7439
X-MS-TrafficTypeDiagnostic: MN2PR12MB4781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4781A0A2244F8BF5A597F00583B49@MN2PR12MB4781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ9a7h7Ot+oU2poryjOEr3TCB3mTv6iSrj01ZM0dGHOKOdw0x0NFGIwMaAWNsngNNNRGi/YOv2g1Y6vINGvm6f4j7ms9UL+IC2FE7TnNsmUMGJk0gQnnC6IZ0YyJhqzs+vVRAVxOmvCbrDeV9EAsYN9A0lXiU32Zgdbe8ZlywdhkRYm40FJ4DMNyEsO6OsP0j+T4hWoP/u2Ogr1mYJNRbQmWEGGvXOw8YQrjgvlTx10KKqLDtvCLBdf4XwIFRhOM7k3WWJATHeqRJYZnYPPKbidvDrlf33Dkcz75LHS99Qg5CGZUJgaZ9tAT0hGd9tHQL4zox9pNuTRm9cy7YcXwkcS5fW39fPzJ0qtFnbpA1yO/1Pol9sgZlDwJzDHfTohNaCm2w3TKPPhgG4cQDJh4YO88kaWZlSxP3qsNhIjslLDYIVK7jvex8d2k3icBV2ssbtuzU/52itDxWK0w9pKYCLL/VCP/bs36DUlIw0DPtPHIpQoqr5pIdGLszy4u51SFqWgO/gDChVwh0Ofth6ezHlwQBOVRiT1y7eDfnBReGNWbsyAHZ/M4op8XeOxptF8XrlZ1x+FROb69cz7w2OMvPXTB8J6r0T+5wtdc+9M0Ii8OXRU/mOFta9bImyrSnn3fFS5cUdbH6lHNpdrCORGt3tSAYwKjq/uCURpLmwPKDwqlezz/R+AVcuVxnI+9pc5/VJgeaUaNaeZ9xUA64e+hMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(83380400001)(66946007)(66574015)(6486002)(52116002)(66476007)(31686004)(478600001)(966005)(8676002)(16526019)(110136005)(186003)(66556008)(36756003)(45080400002)(5660300002)(31696002)(86362001)(2906002)(53546011)(83080400002)(2616005)(316002)(30864003)(8936002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWpydEVGWEtTcGVWTVZoRGp4VXBZRTNNaUdxUlJnc3phNnowY0E4bXErb0pY?=
 =?utf-8?B?d3dselNJeWNNL2UxbFZhU1FaTEVLVWVLS0NKcGpqdUNkZXBmc0RKeGY2eXBW?=
 =?utf-8?B?MmhCUVVKa2pIS1B6ZU15SExRUkJHTGh3dkNvYkwrRFVjMGVNK24yQnpyQjhq?=
 =?utf-8?B?N0twemd1aWM5S0Z2NGFiSFNRMWdUZHRPbG0yUEFhaTdoQjNuSmd2YnpjRnNF?=
 =?utf-8?B?VTZ2c2F5dVFNSkRON3B1RVBiVVh5QlJDUkxaVXpoRFZINGZqVmxpVzhwWUVu?=
 =?utf-8?B?N0tLdFJHZmpPeEdOSHl4ajEwOERNazBKeXdETHpQWUZaTWY0V1B2NGdjbmxC?=
 =?utf-8?B?Z3Zwak9ZWTV0UXdsMDRpb2JqcmJjNDNuTW5yM04xVkgweHF4QU1wOWl6WE9r?=
 =?utf-8?B?L3V0WmM5dnJid2poSHlkWDErVjQ3RVR0ZVNMYnF6ZG9RWGd3U01QVmRLOGRh?=
 =?utf-8?B?M3pjSlRoTGNnaFdxUnVTbkordVhoL1FRTGQvK2lMOEJFWmY0eTlTdmRxUDRv?=
 =?utf-8?B?YUpvdW83YkxQTWMxYnc2VTI0bGFJb09McERwQXFmK01nemZlcVc2VWtYZllq?=
 =?utf-8?B?WDA1UVdZL2hNYkgxMWpmdkp1ZjJxakFkMXY3R3IxeVNwbUtiN1lONEtrcCtk?=
 =?utf-8?B?WHBpWDJHWVdKVXMvWTFHZGZyU2EzU2hRZjhZV0tyeUwzVG5rSDJ3a2xqY0NS?=
 =?utf-8?B?MjQ5VWF5UDlTdVNsR05Wa09kS3RvZEZaQXVraDY3cHNIUEpRYUZRWTBldG1G?=
 =?utf-8?B?R2xuenRXVkZpVHpWREFwR1FTZW5RMzhXamFmTWNOQXpVLzc4cXNETTJSd0Fv?=
 =?utf-8?B?b1M0MDVaZGlXSTAzcXRBZzFFbi9DRjcwUy9OVjRZTW1ydkZ2bC81OTY3RFZY?=
 =?utf-8?B?d3gxUGljbU1JMjk4S2VESnJsTmhpK0xsZEVYcDZ5Q1VqVno5dW1sQWRuMndK?=
 =?utf-8?B?alFZRE1YRXAvOG1pOFRsZjl3bk9VMTc1dFpIdWNiT1IzemFseko3RWpmQmxs?=
 =?utf-8?B?a1hOM2RMc2QzUUpGWDd2L1NuYTBKcTFubGdiWGh5S1c3VzNkaldGTkkvNENu?=
 =?utf-8?B?YzI1L2NVYmpub0lDS3NibGxIMnFuY3l0RU1BMmlYOFh5SnlnVklWMFZJZ1do?=
 =?utf-8?B?N2xNd3d6eWorK3ZDTlNqa3VlNkhoajAyUk5qWUtteUh6OC8xZ0pZdjZiSDZW?=
 =?utf-8?B?ZmNKaVZMajRMQjhYYzBTVWVKZGR3eVp2QkIxZkV3bDF5dDlOOFZzNEtoNENV?=
 =?utf-8?B?cEQwbTJ4QnlQcDZ5VE90Wi82T1VHN2ZvVjNNUUNOZnB1YldQNVhLUU9FMWVq?=
 =?utf-8?B?WHRRYmxDZ0pzZERqdDkxdHFQaDd6L0ZsOWFiSUYveWd5ZFRSeHJERWV2SndV?=
 =?utf-8?B?UTFOellVOStSUVVtd2xIN1JyNDRaWUpoTUlGUnkwM1BaQndvQmlxTlpIZGtJ?=
 =?utf-8?B?NWhlQUtERFRicHd3MURGaWhZejdUdE9ybXdPcUtjUmdVRVRsWExDTXFSV1h2?=
 =?utf-8?B?T3hKZWVtMGZvcVdma3oyQ1ZkdEhrNHBLWkpsRUwvWmltbnhQNEkwZmJ1M1pr?=
 =?utf-8?B?aWdjQkQwVkNUMlFlcDYxYUg0RTM1Vnd3aWo2YkdOTkVjZEgvVTlJc3RHdnVK?=
 =?utf-8?B?bFQxWUdmV212WTVpV1Fvdm5RNGdrV0lyeTJNaHhXN2xtRnhyODcySmpVaVBo?=
 =?utf-8?B?TUtHNVUzNTBmM1ZtQTZ3QTlTTHliaDQzSU9xcUVnWVhEMVkxRGFBczBvN0Vh?=
 =?utf-8?B?YlRtcHFwWGg5RVZKdVNWSkNwY1VCWkNvYjl5WDhBMFg4WU1uY1hzdWdpU1RV?=
 =?utf-8?B?eE5McWFUZXdhN1VvWWgvaE8vdlJIMlB1amVtamhHcWtuWWtpZnZWdnVVS0lt?=
 =?utf-8?Q?vI39/QwAr5jAZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d09eec-7328-4739-6244-08d8c83f7439
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 12:30:13.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzKbOWDmVny4YlJIsOsJG27f9WxFjaGZo5zOvlgG16VzigUdDjMkgXiEjMAd1THv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.02.21 um 13:24 schrieb Daniel Vetter:
> On Wed, Feb 03, 2021 at 01:21:20PM +0100, Christian König wrote:
>> Am 03.02.21 um 12:45 schrieb Daniel Gomez:
>>> On Wed, 3 Feb 2021 at 10:47, Daniel Gomez <daniel@qtec.com> wrote:
>>>> On Wed, 3 Feb 2021 at 10:17, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>>> On Wed, Feb 3, 2021 at 9:51 AM Christian König <christian.koenig@amd.com> wrote:
>>>>>> Am 03.02.21 um 09:48 schrieb Daniel Vetter:
>>>>>>> On Wed, Feb 3, 2021 at 9:36 AM Christian König <christian.koenig@amd.com> wrote:
>>>>>>>> Hi Daniel,
>>>>>>>>
>>>>>>>> this is not a deadlock, but rather a hardware lockup.
>>>>>>> Are you sure? Ime getting stuck in dma_fence_wait has generally good
>>>>>>> chance of being a dma_fence deadlock. GPU hang should never result in
>>>>>>> a forever stuck dma_fence.
>>>>>> Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't go up like
>>>>>> this.
>>>>> Maybe clarifying, could be both. TDR should notice and get us out of
>>>>> this, but if there's a dma_fence deadlock and we can't re-emit or
>>>>> force complete the pending things, then we're stuck for good.
>>>>> -Daniel
>>>>>
>>>>>> Question is rather why we end up in the userptr handling for GFX? Our
>>>>>> ROCm OpenCL stack shouldn't use this.
>>>>>>
>>>>>>> Daniel, can you pls re-hang your machine and then dump backtraces of
>>>>>>> all tasks into dmesg with sysrq-t, and then attach that? Without all
>>>>>>> the backtraces it's tricky to construct the full dependency chain of
>>>>>>> what's going on. Also is this plain -rc6, not some more patches on
>>>>>>> top?
>>>>>> Yeah, that's still a good idea to have.
>>>> Here the full backtrace dmesg logs after the hang:
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2Fraw%2Fkzivm2L3&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885971019%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=a3934SOOSFtRU3RraUe%2BWDgAEDefENxQZcd0prmSZXs%3D&amp;reserved=0
>>>>
>>>> This is another dmesg log with the backtraces after SIGKILL the matrix process:
>>>> (I didn't have the sysrq enable at the time):
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2Fraw%2FpRBwGcj1&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=nPom9VwIrEZF02hSEnC5Ef8lHdQURMELCapIhwKk2JE%3D&amp;reserved=0
>>> I've now removed all our v4l2 patches and did the same test with the 'plain'
>>> mainline version (-rc6).
>>>
>>> Reference: 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
>>>
>>> Same error, same behaviour. Full dmesg log attached:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2Fraw%2FKgaEf7Y1&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=WQw6g9oA38aT1VuuZ8%2F1Y43pG%2BPlV%2F9%2FRHjKdGvZLK4%3D&amp;reserved=0
>>> Note:
>>>     dmesg with sysrq-t before running the test starts in [  122.016502]
>>> sysrq: Show State
>>>     dmesg with sysrq-t after the test starts in: [  495.587671] sysrq: Show State
>> There is nothing amdgpu related in there except for waiting for the
>> hardware.
> Yeah, but there's also no other driver that could cause a stuck dma_fence,
> so why is reset not cleaning up the mess here? Irrespective of why the gpu
> is stuck, the kernel should at least complete all the dma_fences even if
> the gpu for some reason is terminally ill ...

That's a good question as well. I'm digging into this.

My best theory is that the amdgpu packages disabled GPU reset for some 
reason.

But the much more interesting question is why we end up in this call 
path. I've pinged internally, but east coast is not awake yet :)

Christian.

> -Daniel
>
>> This is a pretty standard hardware lockup, but I'm still waiting for an
>> explanation why we end up in this call path in the first place.
>>
>> Christian.
>>
>>>
>>>>>> Christian.
>>>>>>
>>>>>>> -Daniel
>>>>>>>
>>>>>>>> Which OpenCl stack are you using?
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> I have a deadlock with the amdgpu mainline driver when running in parallel two
>>>>>>>>> OpenCL applications. So far, we've been able to replicate it easily by executing
>>>>>>>>> clinfo and MatrixMultiplication (from AMD opencl-samples). It's quite old the
>>>>>>>>> opencl-samples so, if you have any other suggestion for testing I'd be very
>>>>>>>>> happy to test it as well.
>>>>>>>>>
>>>>>>>>> How to replicate the issue:
>>>>>>>>>
>>>>>>>>> # while true; do /usr/bin/MatrixMultiplication --device gpu \
>>>>>>>>>         --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
>>>>>>>>> # while true; do clinfo; done
>>>>>>>>>
>>>>>>>>> Output:
>>>>>>>>>
>>>>>>>>> After a minute or less (sometimes could be more) I can see that
>>>>>>>>> MatrixMultiplication and clinfo hang. In addition, with radeontop you can see
>>>>>>>>> how the Graphics pipe goes from ~50% to 100%. Also the shader clocks
>>>>>>>>> goes up from ~35% to ~96%.
>>>>>>>>>
>>>>>>>>> clinfo keeps printing:
>>>>>>>>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) = -1 ETIME (Timer expired)
>>>>>>>>>
>>>>>>>>> And MatrixMultiplication prints the following (strace) if you try to
>>>>>>>>> kill the process:
>>>>>>>>>
>>>>>>>>> sched_yield()                           = 0
>>>>>>>>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
>>>>>>>>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
>>>>>>>>>      <detached ...>
>>>>>>>>>
>>>>>>>>> After this, the gpu is not functional at all and you'd need a power cycle reset
>>>>>>>>> to restore the system.
>>>>>>>>>
>>>>>>>>> Hardware info:
>>>>>>>>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
>>>>>>>>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
>>>>>>>>>
>>>>>>>>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>>>>>>>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series]
>>>>>>>>> (rev 83)
>>>>>>>>>         DeviceName: Broadcom 5762
>>>>>>>>>         Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
>>>>>>>>> [Radeon Vega Series / Radeon Vega Mobile Series]
>>>>>>>>>         Kernel driver in use: amdgpu
>>>>>>>>>         Kernel modules: amdgpu
>>>>>>>>>
>>>>>>>>> Linux kernel info:
>>>>>>>>>
>>>>>>>>> root@qt5222:~# uname -a
>>>>>>>>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
>>>>>>>>> 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>>>>
>>>>>>>>> By enabling the kernel locks stats I could see the MatrixMultiplication is
>>>>>>>>> hanged in the amdgpu_mn_invalidate_gfx function:
>>>>>>>>>
>>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
>>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
>>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
>>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
>>>>>>>>>
>>>>>>>>> I can see in the the amdgpu_mn_invalidate_gfx function: the
>>>>>>>>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_TIMEOUT so, I
>>>>>>>>> guess the code gets stuck there waiting forever. According to the
>>>>>>>>> documentation: "When somebody tries to invalidate the page tables we block the
>>>>>>>>> update until all operations on the pages in question are completed, then those
>>>>>>>>> pages are marked  as accessed and also dirty if it wasn’t a read only access."
>>>>>>>>> Looks like the fences are deadlocked and therefore, it never returns. Could it
>>>>>>>>> be possible? any hint to where can I look to fix this?
>>>>>>>>>
>>>>>>>>> Thank you  in advance.
>>>>>>>>>
>>>>>>>>> Here the full dmesg output:
>>>>>>>>>
>>>>>>>>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more than 122 seconds.
>>>>>>>>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
>>>>>>>>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>>>>>>> disables this message.
>>>>>>>>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
>>>>>>>>> ppid:     1 flags:0x00004000
>>>>>>>>> [  738.358254] Call Trace:
>>>>>>>>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
>>>>>>>>> [  738.358276]  __schedule+0x370/0x960
>>>>>>>>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
>>>>>>>>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
>>>>>>>>> [  738.358305]  schedule+0x51/0xc0
>>>>>>>>> [  738.358312]  schedule_timeout+0x275/0x380
>>>>>>>>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
>>>>>>>>> [  738.358332]  ? mark_held_locks+0x4f/0x70
>>>>>>>>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
>>>>>>>>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
>>>>>>>>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
>>>>>>>>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
>>>>>>>>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
>>>>>>>>> [  738.358375]  dma_fence_default_wait+0x214/0x230
>>>>>>>>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
>>>>>>>>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
>>>>>>>>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
>>>>>>>>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
>>>>>>>>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
>>>>>>>>> [  738.358710]  exit_mmap+0x2f/0x1e0
>>>>>>>>> [  738.358723]  ? find_held_lock+0x34/0xa0
>>>>>>>>> [  738.358746]  mmput+0x39/0xe0
>>>>>>>>> [  738.358756]  do_exit+0x5c3/0xc00
>>>>>>>>> [  738.358763]  ? find_held_lock+0x34/0xa0
>>>>>>>>> [  738.358780]  do_group_exit+0x47/0xb0
>>>>>>>>> [  738.358791]  get_signal+0x15b/0xc50
>>>>>>>>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
>>>>>>>>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
>>>>>>>>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
>>>>>>>>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
>>>>>>>>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
>>>>>>>>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
>>>>>>>>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
>>>>>>>>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>>>>> [  738.359069] RIP: 0033:0x7f6b89a51887
>>>>>>>>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX:
>>>>>>>>> 0000000000000010
>>>>>>>>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 00007f6b89a51887
>>>>>>>>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 0000000000000007
>>>>>>>>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 00007f6b82b54bbc
>>>>>>>>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000165a0bc00
>>>>>>>>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 0000000000000000
>>>>>>>>> [  738.359129]
>>>>>>>>>                    Showing all locks held in the system:
>>>>>>>>> [  738.359141] 1 lock held by khungtaskd/54:
>>>>>>>>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, at:
>>>>>>>>> debug_show_all_locks+0x15/0x183
>>>>>>>>> [  738.359187] 1 lock held by systemd-journal/174:
>>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
>>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
>>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
>>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
>>>>>>>>>
>>>>>>>>> Daniel
>>>>>>>> _______________________________________________
>>>>>>>> dri-devel mailing list
>>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=OkFv8jiehNoa46Q%2B5yOXUg29cRbzl8voV2GqC8j1V9Q%3D&amp;reserved=0
>>>>> --
>>>>> Daniel Vetter
>>>>> Software Engineer, Intel Corporation
>>>>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=m0e9DrqnuYQoJYwwZAyonKlSfkp9hFTRNoT53OY3IbU%3D&amp;reserved=0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=BuUCnnGsKhSQc0ldgBPVBIQxYUnvIPwqqLMe81ynrgY%3D&amp;reserved=0

