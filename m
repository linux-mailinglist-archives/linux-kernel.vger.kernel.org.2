Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00714349360
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:55:10 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:40161
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230076AbhCYNyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:54:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVwfINsggBvTR0HoGIlHgEBEHvzHGXSpPU3P1J2SIhbXU1oiJVaSjeoyJgSsBzUDFNkrWZWL+AXsDLed2pt9SrvgzD1lCc3IrTSTHnL5SMagnpiVAxrti7JZntpySFwbId+6DD6VK8qDOOFIHy1wazd5hl7VgJGyj8AvWRN1Y5y436B20y9t/d9B0ML5CvL1BP2a5ApnJjgLR8JVPrba79UYa89L5hTloH3Q8v5CNWrTfg0YTfMGjHCTqzGE0924FllLFABu88jTaRqfO8TTN4ByFhWADVPLGz3AtlU4XCcDSWVYJJsRjsgRH2Hh0YmJDCCGISc6+ooha2n5yDOhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErS6VkbXMbaQ4oeF02Zrp98JvYd8uWTDhyyQrh50eLw=;
 b=T8mzDM5aAOVfEbI0YORV4wLEwjVZ9e33VDwN7T/9cJQoPCg7hF6GTPxdU73IvTwjVPOWNPt4fEqxpxy4vPaGBpjLj5quEbI4n2MnBZAtke7rvPdrl4cmoZD08Ptp+ze5o1rYOF8LX60/NMKW4E5cjbmE5yxn1JI85e9zCYCv2hZzR0j3KgjaHseFSNL+ojKxdNMqCKboUv/uu+ejFDSRK2Ywpo16uDL6Xc0WQ1ciHYlVxT6T8ZIpOD25Nd5RA7mKGPBokOJF8g5WOjvdgtte/7o6sAxjGbz3mZK8hWOfFQ0DPYSS920QfVCW/TpXFGyyVOOU99keItRHU2MXhlWeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErS6VkbXMbaQ4oeF02Zrp98JvYd8uWTDhyyQrh50eLw=;
 b=AZKlipjPrXAcpAdNG/z2ugsHg5vlkA0+opsiNucnTnMjtSeVXR5+FUii6jMBV2anrc2o87VxaJFzFS3wHI2CIXbyoHznXHKju88AJZchH6GuTL3IC4NwjpDGfhHpYPzGyZA8c0LCcKT7gUiTSrrOZU/r9qOeBiDhGwdvJHHKExE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 13:54:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 13:54:37 +0000
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
 <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
 <20210325113023.GT2356281@nvidia.com>
 <afad3159-9aa8-e052-3bef-d00dee1ba51e@shipmail.org>
 <20210325120103.GV2356281@nvidia.com>
 <a0d0ffd7-3c34-5002-f4fe-cb9d4ba0279e@amd.com>
 <20210325124206.GA599656@nvidia.com>
 <00f79bae-75c4-d694-8dc9-35ac21cd1006@amd.com>
 <20210325131756.GX2356281@nvidia.com>
 <13227fd0-6c41-992e-63e7-877f718c1577@amd.com>
 <20210325133347.GY2356281@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8cf06da9-2a08-45c4-1339-bcc38fdd04df@amd.com>
Date:   Thu, 25 Mar 2021 14:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210325133347.GY2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:72d1:2a48:a80e:e149]
X-ClientProxiedBy: AM0PR10CA0083.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:72d1:2a48:a80e:e149] (2a02:908:1252:fb60:72d1:2a48:a80e:e149) by AM0PR10CA0083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 13:54:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a89d22c-cb1a-4fce-fe50-08d8ef958750
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-Microsoft-Antispam-PRVS: <MN2PR12MB436063F32133C69879A99E6683629@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXUcIYf1MfcwRYM4OHLfJ8xxn/ichgM/Je6D878IvfM1sR4sI9DgNUlFC60+BkDvwoTJ9KJDn9/OV7TqafJf4WettxIah0HNKfT6wFT8Ruh7lZ2UxbTdJkb4Apbn/dtBe6n+t1oW3t0Fio32NolESPfLEXgZ4OvW76lXTl6ULx7KlP3IYOl+hgvG/Uo6zwIlnCFaMhPjuxv5UHgbEqgNt3rye/yT3uxpGSPi+zmsw8xyn7czhqpS+ALPLuRkCE3fRWfp9yRJnwL2K2lyks1LQwmSDjmKjGE37vhHbsbXKoaTTfjU+QJkpgfbjTbn+/7vIXpBY8fvazQkS8kheOcyIzLdOUpNeL+9GG/VWb2hosZyPmg54LoZtlJSq9BowGIjajyLQdqz/THggkACQ/c5ZfZ0WcBS0/Awg+Dqs2nQ66J2JCoTHMGASAtLF/2MwkXI0aLBmySztPCc/A1OMKVrA0vrdGo2YP9sJOeEvwLwrs+KBOM0djp1J1I66fmTlP1QD9pUDifrYwbWtbPsvfmza6Zh/Q6k0R2r23Gt8/X2zNoQCwQWeGbuyrGgy8DwFx3iJx0fqCOHf37+9e59fRfCf6XxXx9EwZo0QGm2dzgWUeDYM2y7qB+vzqp9rbhxk7/Y7jydSFrJHGGYYp6Hxob6jcP6OrVVz8KpCDRlh2k9mV/Fzj9w5rGkh2V7fTBFI5xwG0fwk/0NiwCVfEGYOg8Vcc7uBrR3I/hn/KRgnPtQ0UuvmvJO1JO4QXzUCo3AIUN3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(5660300002)(8936002)(4326008)(478600001)(2906002)(2616005)(316002)(54906003)(38100700001)(31686004)(186003)(8676002)(6916009)(6666004)(6486002)(36756003)(52116002)(86362001)(16526019)(31696002)(83380400001)(66946007)(66476007)(66556008)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWlYcEQ4V0VtbEI5dGNocGJHc084cFFuVUVaYmxleVZrbVJGaE1ZZHRSRURv?=
 =?utf-8?B?TGt1Qnh2eGxSNGlPajdENUtNZ2wxeTUyVUFGVm9sUExFaTBhbDM5SUVOVXYz?=
 =?utf-8?B?NGRMdzF3REQwbmZFd21ZZTM3dEJQNUEwYkJuSkMrVHcxQzZoNGJNU0x1Y3FO?=
 =?utf-8?B?SFBaL2pISmdwKzJjSU5hZWZ3aHpzSVFJWGQ5UVRDSnJJV1hUeGNhcFNyRmRi?=
 =?utf-8?B?YUtHSGRGT1hiZjJHTWF1UFMvZ2d5UkVmU0dsSEdqQ1E5S2RQU0l0Q1ZDVFlh?=
 =?utf-8?B?bkRTUVJOV2REOGNPa0hnZ1ZuSUs5T1ZiUzhFcnd6blRlOHhRTmtEdkpvTW9I?=
 =?utf-8?B?UUZPTFZIMTJDNmU1d0t1RGZFTFFrVjJkYS9oU2hMWGtwMXFwdWFlcWJreFJH?=
 =?utf-8?B?MFdGbDdCbXEvZjhSV0pWYlFrbGdQUTlhelB1TTZ3dmlzOUR6SmlPZkwyV29m?=
 =?utf-8?B?bS9mdGJLRVdlZ29qcktneUQ3YzZxdStZSXVsaGFaVHE5WVhDOStmdU51MXEx?=
 =?utf-8?B?Z0ozbXVjZ1p4QnJsZitscUZaQUVoQnhCTjl3QlgySlREME9wcjV6VmVmVDBT?=
 =?utf-8?B?dTZvcUJTMEd5VFpyaVYxUUwySzA3Z2dkUi9uTFNPMUwrSEZYRWNsdmJLN0I4?=
 =?utf-8?B?VnE5UXFvV1U4c3JDbGp3STRBMVVKWVBibkVRcFY4TW5uZ1NTQ3MxbWtSSVlI?=
 =?utf-8?B?OFYwUU9XdktJMmR3eTRvUTlhbmEzVHpCdXVTTGdlYllqbW0zdjNFRzFXNkkr?=
 =?utf-8?B?dHVXTWZya242Tkc4Z0xDMWVrSFk1ZUlCa2RqN2loZ2pYRFA3amZhbFExajFs?=
 =?utf-8?B?RnYwWUpnUWJLMlFIdUNKeGgzL01zZ1NJQjVKQ3Q5bnd5cEs3VWlrNGVPdVVn?=
 =?utf-8?B?b0c2Zkl3L2pBNm1vNzV0Z2VlNzdrdHVMT0k4V3BGV29jU3lQZEFiTVk2cmd6?=
 =?utf-8?B?WEkvM2J5NThWeEVHeWZCclU5VWdPNm9QZ2VyaHpXbjQ2RGVuNm0wZzdpa2lz?=
 =?utf-8?B?VHlZSUZMRDFHcTVlcXpHL1dpbDJjOVllOVF4MHpGTW0zQ0JPaWFzSTc1dnNu?=
 =?utf-8?B?MUtIT2lyY0NWRVlHdHh3R09XYXVGYWtBSElZK0RTMGFMQVI1T1N1Y05ldEpN?=
 =?utf-8?B?cnA5THpRbVQ5L0haaUVEVHpVWG1LNEtFT1BkQVEzUXl3MkNVMTV4Qk00SUwx?=
 =?utf-8?B?U2cvNXVPSVJJb3pPN2gzK0w4K2tkdi9YY1JiUTZnRGFnM2h6VlNQWGVQdVlV?=
 =?utf-8?B?S0ZhdHlUOEU5bXFGMUh5WXJQYzlCcDBCQzdBOGpvSEdNeE12eFBOL1JLUmF1?=
 =?utf-8?B?d2dzSjRvVEVNeVRETGlHUkllQjdzYTB5bGRjcXI2TTdMblJ2UjliNkt1NzNM?=
 =?utf-8?B?ejE0MmVxTDArUzFLeWtTQks5OFZxa1RUM1lBc2xSWHhTaDMyeENRTTN2UGxE?=
 =?utf-8?B?YVROTkFlWnlFb0xyWGY1QktzeDJJaUFhY1IrSkt6QTRoREdUYnNHam13TE5s?=
 =?utf-8?B?b1pJcTVPSW1ZZFRUYzNqczV2dkVoaVJXUmpTaVNuL1JrOWlXK2VQQWl1VVFD?=
 =?utf-8?B?TGlrZ2Q4ajVWeVNvaHJRTUs0a1B1bTl0cno5MjR5T2N2cEVKY3pxNkRxc2NJ?=
 =?utf-8?B?bkl0cldBT04zcS90V1BSU24rN3pzMXNiSGtONjExWVY1T0xaZDJYMi9Pay95?=
 =?utf-8?B?MGE0SUhqZVRKd0xhVGlVR3RkVjRZOFNISWVxdVByUlk0eXZiUzE3cG85T0hy?=
 =?utf-8?B?ZEhGd0k5VFJwMnJoM0NpNGhQVENueVRFNnhXQ2lEV3NDSCt2YjUzd3FmN2hm?=
 =?utf-8?B?ZXYzK0doY3k3ME9jOVdIOFgvRG9mR1RIamZHanFNeks1cU9PV2FFWDNVZHpU?=
 =?utf-8?Q?RLNDsghjvFImy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a89d22c-cb1a-4fce-fe50-08d8ef958750
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 13:54:37.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CETze1o8cvBvh7hmnM+WVhfHuW4n9CC26pArczoOMayxr6Ebhfwz9ltRSAz5UUs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.03.21 um 14:33 schrieb Jason Gunthorpe:
> On Thu, Mar 25, 2021 at 02:26:50PM +0100, Christian König wrote:
>> Am 25.03.21 um 14:17 schrieb Jason Gunthorpe:
>>> On Thu, Mar 25, 2021 at 02:05:14PM +0100, Christian König wrote:
>>>> Am 25.03.21 um 13:42 schrieb Jason Gunthorpe:
>>>>> On Thu, Mar 25, 2021 at 01:09:14PM +0100, Christian König wrote:
>>>>>> Am 25.03.21 um 13:01 schrieb Jason Gunthorpe:
>>>>>>> On Thu, Mar 25, 2021 at 12:53:15PM +0100, Thomas Hellström (Intel) wrote:
>>>>>>>
>>>>>>>> Nope. The point here was that in this case, to make sure mmap uses the
>>>>>>>> correct VA to give us a reasonable chance of alignement, the driver might
>>>>>>>> need to be aware of and do trickery with the huge page-table-entry sizes
>>>>>>>> anyway, although I think in most cases a standard helper for this can be
>>>>>>>> supplied.
>>>>>>> Of course the driver needs some way to influence the VA mmap uses,
>>>>>>> gernally it should align to the natural page size of the device
>>>>>> Well a mmap() needs to be aligned to the page size of the CPU, but not
>>>>>> necessarily to the one of the device.
>>>>>>
>>>>>> So I'm pretty sure the device driver should not be involved in any way the
>>>>>> choosing of the VA for the CPU mapping.
>>>>> No, if the device wants to use huge pages it must influence the mmap
>>>>> VA or it can't form huge pgaes.
>>>> No, that's the job of the core MM and not of the individual driver.
>>> The core mm doesn't know the page size of the device, only which of
>>> several page levels the arch supports. The device must be involevd
>>> here.
>> Why? See you can have a device which has for example 256KiB pages, but it
>> should perfectly work that the CPU mapping is aligned to only 4KiB.
> The goal is to optimize large page size usage in the page tables.
>
> There are three critera that impact this:
>   1) The possible CPU page table sizes
>   2) The useful contiguity the device can create in its iomemory
>   3) The VA's alignment, as this sets an upper bound on 1 and 2
>
> If a device has 256k pages and the arch supports 2M and 4k then the VA
> should align to somewhere between 4k and 256k. The ideal alignment
> would be to optimize PTE usage when stuffing 256k blocks by fully
> populating PTEs and depends on the arch's # of PTE's per page.

Ah! So you want to also avoid that we only halve populate a PTEs as 
well! That rather nifty.

But you don't need the device page size for this. Just looking at the 
size of the mapping should be enough.

In other words we would align the VA so that it tries to avoid crossing 
page table boundaries.

But to be honest I'm really wondering why the heck we don't already do 
this in vm_unmapped_area(). That should be beneficial for basically 
every slightly larger mapping.

Christian.

>
> If a device has 256k pages and the arch supports 256k pages then the
> VA should align to 256k.
>
> The device should never be touching any of this, it should simply
> inform what its operating page size is and the MM should use that to
> align the VA.
>
> Jason

