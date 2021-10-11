Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED0D4291C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhJKObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:31:00 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:15968
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238456AbhJKOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIPZ3uektzCxCf8+OfyrGl8Y6FTVYfQnQlE63/9tfAivqYhz5Jr3T02qS9ZYiB9oSMo2EpBs16ZvqyQraFLzslFhzi/l6AXH89wGRgsloyekcVvaM2j/eDmxFbEme9qCcrtY8G+57O13LtAfYtNxt0mdBkb/sdqRGKHJygW7ZFgZgHmtM181MVHDaQBSWUsmgIjz+4w6PK0jKiubJxYBeOiPzwCg5qL57tuvghROOfJfzieeljaq8qs5ge5TUcqoKXcnzamb4RlLaN28vXGn2B40ABLOHpGo9PmsCoLqYDg1Xxq+f9kLGk8HqySECGb1nbIVkuMt36AjXsNNa48ruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXDEcQak1R683+v52PBEGe8iOEN4470hgnIsuGRXKag=;
 b=eCYeGuNnD3xH67XEgsbwM8e1PUNuozk548asT0NeyzvHMdIU/4BRkO+xcWDDDNsAmH5SewvKMba7lX9E0DdzHw3xzIa2MQIIhNnjAgMMKYKya7ToozxnWGTTGHUrTBzoLWpfUQiDnIvomwvwKQ4HG6sCMqpVhE6igBM9QAjMFbvuwxV/sLMiS/60ctJ+sm3WFkyBNlQLac/haNEM+iwQdWYdt6PlEhmpvOnluFUBpgygvmCfPsYuAPlWfK4+6ODnNmqL5EIsVeDxVKSW0n6GzQQrLps0ermG9PTUFJWbt0D40YeZiYZJwF1JgMsKr1/Qtb1how0j7gzr5aPG8v7JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXDEcQak1R683+v52PBEGe8iOEN4470hgnIsuGRXKag=;
 b=oYbgzeMZnTgLsnjg9ua6Dziqu+ubClevh3NfMQtDDnSuQfQo8nxK1SQ1njRReHi4da9P//AMJJEHqyw2iW5IZM2daBkkGMh61Yp6GbkAQF0fFcKMbUx1CtnDss7/idYwy86qrDZ1eO70nE4EewtexK4ChL1QldZDIWdV0w8i/VU=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 14:28:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 14:28:53 +0000
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic> <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
 <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a3167c89-51bf-e71f-94c3-1c873007ae87@amd.com>
Date:   Mon, 11 Oct 2021 09:28:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0034.namprd07.prod.outlook.com
 (2603:10b6:803:2d::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN4PR0701CA0034.namprd07.prod.outlook.com (2603:10b6:803:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 14:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e12e7ba4-2800-4f68-56db-08d98cc373b3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51849E60A017567015BA692FECB59@DM4PR12MB5184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTFarVl3O1AKsWb5L9mdAHkgJHbR0mHLq3KS02USDMdBkNYzUkKKxFPmA4gdlqQUfDkABCyRHfRZlHxMf3PFVefk1RiIiYqeh8pqUvKRHy6oQoBvGTuEyo03XPtwVrj4OMmbPFL3mXeenWBLqYohscbcJnRIgYyMhKVV1/8zssDkpiMZ9R/byQO2hyi9Iw5Gd195DvXRGAfMoF+oMF11QgJqE0quT7g5cVTlitNwnv40RWMvdZciqAMWPMs4QmpfV/uQO0MBKaFtCj0Bo2S4ME0e9XyqCMi0FvlVcVUYsVnZzP6KNX2PYNIvOXWLIT+7RVQ0/g9a/KsnhTTZHWUCJVqdwJK4td/bSyzzwWv0OJUQoIdyoJsZT3Nv0ETfWPWHUQW5e+xRlod6Q9wEfZ9RTY68yygNL0diqa5cq6ogoPV1mnL4WyzyA5Z63/EdN20TuN/LjyhGGmw4mysgnUAeJJpQSWI5r/FPuBm1qV9NXsDTD8t9NTMZ3iK/QY17I+Ylos3+zLFyjHYY+wuz7BZ+x8H1rQaYjA2ZHzVv5bfrZUE+FA80gYwXxuJqGrYVVVMegSw6IipqSSgjLGYAXQwqFPrH2Z4MKAMYemmc0LdNM0t0G+15ySAXi7k1EjzWiVocjWEuVwKgBfyL+hpySqsnLLciFloKZzxBGsiAZvLzXyU37v80rl61qI/o43m7aXPJsD96NLUER/xR3HU6xkiX7bqm6cgAMtJTo/2sizvdpbjK+kf5R9tJTzt7BjHiMxNtK700RcJk0pCz+5cS/j9Qhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(66556008)(2616005)(316002)(2906002)(4326008)(956004)(53546011)(26005)(54906003)(31686004)(186003)(7416002)(66946007)(31696002)(66476007)(83380400001)(86362001)(8676002)(5660300002)(6486002)(508600001)(36756003)(6916009)(8936002)(38100700002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2MyYkJDeVpLSWJiV3g2ckJsWnN5WmVkSFUzakxBYU1adXI1OCtjVjVNYVd6?=
 =?utf-8?B?NlV0a0dDNkhwckZORWgrZHU4MFA1S0dMUWFJYlg2aWhzQkgyOHJYdEtjT0Nk?=
 =?utf-8?B?WmJCS0VUUkI0NS9JaDdmYlloTzRYSU5RWmdvdnc1ZHNDZEtkcmIvRTVwVEV6?=
 =?utf-8?B?MVFjSm1laC96RklXNXVRek4xLytRdXkzVS93ckpFWXE0QlhYM3BjQ2pKM0Vu?=
 =?utf-8?B?WUpwZDh5ZHFTbXBVQXdUbjlLa0Nlb0EzbGNMWlFRc092SUQzR0hwWEVZWXc1?=
 =?utf-8?B?Y3l3blk2N0Z1eWtpUEVleWJ3VWx1R1VKSVhHN1ViSUZ6MnVDS1A5eXhqbkVG?=
 =?utf-8?B?dzYrOXpMbndZSC9QR2tmQWRPSTRRTXI0Tlp3bmtzeUw2akhpaFQ4aEVPcU5J?=
 =?utf-8?B?STh2WWQwcDVaekNGaGVRQ045dVRQV05vUSsvc2RwRGZWUytraFpOamN5a25j?=
 =?utf-8?B?WlFObGhBdUxsS1hvS2V1Y09FVXpFNTNMcDVweStscjd6Qk5QMWpFQUtSdWJn?=
 =?utf-8?B?V1VidFBuVzhSZ092NXBVaDljRWsvNFNLaUVmZUFCZjNYcnRQbGxIdG9xOHNC?=
 =?utf-8?B?K1R3eUJBWS8rbVdwbURJWFNTVksyZHp0cFhZYStTTHNNdEJDdnA3R3UycDlO?=
 =?utf-8?B?WU1FR08vRnRpL3ZkWDZ1d0RIQTNyQUY0UDNmODU3M1kvRzV6cFI1aFBMNFFR?=
 =?utf-8?B?amNIUEszY2hVWTYwL0lLSFVWUWhramdMNWZuaDZLMG1WM2sxbnk0MERYUnV3?=
 =?utf-8?B?V01hNDk5MVJuZVFqM3JFTTY4WXNkQ2lxcVBIaThlOE9HZWVyTUV1VDBBNnBR?=
 =?utf-8?B?b2p4REZsVjIxNzNaSUlxeW40Y0VWSVU5TXpSZkQwWnNYSENDa1h5UW9YUVJ6?=
 =?utf-8?B?UEw3ZlRwaHpRNTY2ZjBIZXl0ME9ZcU9YYjQweEJwK3VBNG9pY2RFY2NrK240?=
 =?utf-8?B?OTZtaHEwOERsd1RZWlRhbGJkVmVrbGJzdzJ1WWlyakpiTTQ2T01YaXloOVV5?=
 =?utf-8?B?ZmRwc3FIdzgzR1Ira2FKbU04b2lhTTY0b3hDSzIzN2VjeWozMHFtbnpwWHFw?=
 =?utf-8?B?R3pwUmZicjdrZWx6bFNOTFhvRFFEMlEvaDd2UTk0ZG5qdzBKcjB2Um0xNlpo?=
 =?utf-8?B?Qm1jMERjMkc0ckdiWUxxZ0pJQ3Nmc2doODNNYjhYOGpZV3FaTVI4aUh2RDRR?=
 =?utf-8?B?ZXE1dFFQdmwzcUtZYUdVM01UQ21VOXZ0am9BYUVHSmp4MWRsZzFSSEpVeHJE?=
 =?utf-8?B?N0xaWWlwanBXMjdBeTBxeEs4ODRMMEYyQ2ZPSkpyUTd5clloNnk0aVJiOTdY?=
 =?utf-8?B?V0MzazVqdElDOTNQMnpVSDdnYVAwRkM4Ni9CMnRVb29YcmM4VDNvMnZnVTZV?=
 =?utf-8?B?RjRYMmNZT1Qxam5paWhneVZtSndjb1R3aEpMN3RyZjJya1lTT202Z09HUDh4?=
 =?utf-8?B?VVJzRXE0V3VIdDZTM2xiK1NpdU51K0l2enZXUy9mOWw2YTcvb0t2WS9GWldv?=
 =?utf-8?B?TG9vMTBVNDJtUERsSjkzaWFmemdiaDBNVE1GRkxDWHR5VmZodXJMS0RFdnlU?=
 =?utf-8?B?TVZmZDBaWEZxNVAyMXRvaWtHWXdsTEtoUTRDNkVmckpGMkhjczZkNmdaZTR4?=
 =?utf-8?B?Z1JaS1NrZlJ1TjVIbTNhSkNyUXVBMG52c0pTODU2YTZYUUljTFlaTzBQMlo5?=
 =?utf-8?B?MU43T3ZkYXlQQWFGMlNtekN2ZzNxU3BjUkdSNkp1TVJNV1dPM2R0VFA4VVBR?=
 =?utf-8?Q?znm8iivBvjBGuar74R/nI/O30PBs+fX2dsMcG0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e7ba4-2800-4f68-56db-08d98cc373b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 14:28:53.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAcfb6mjGc2HDrLM4xkkHC0cjcWoV3BS1YtRAG4tUFoZ1/TTZWtWBpnkBtP8JGALAJkmQNnXvFKigYV6gFO4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 9:21 AM, Paul Menzel wrote:
> Dear Tom,
> 
> 
> Am 11.10.21 um 15:58 schrieb Tom Lendacky:
>> On 10/11/21 8:52 AM, Paul Menzel wrote:
> 
>>> Am 11.10.21 um 15:27 schrieb Tom Lendacky:
>>>> On 10/11/21 8:11 AM, Borislav Petkov wrote:
>>>>> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
>>>>>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but 
>>>>>> otherwise, yes
>>>>>> this looks fine. The help text could also be updated to mention 
>>>>>> problems
>>>>>> with AMD Raven devices.
>>>>>
>>>>> This is not only about Raven GPUs but, as Alex explained, pretty much
>>>>> about every device which doesn't support a 48 bit DMA mask. I'll expand
>>>>> that aspect in the changelog.
>>>>
>>>> In general, non-GPU devices that don't support a 48-bit DMA mask work 
>>>> fine (assuming they have set their DMA mask appropriately). It really 
>>>> depends on whether SWIOTLB will be able to satisfy the memory 
>>>> requirements of the driver when the IOMMU is not enabled or in 
>>>> passthrough mode. Since GPU devices need/use a lot of memory, that 
>>>> becomes a problem.
>>>
>>> How can I check that?
>>
>> How can you check what? 32-bit DMA devices? GPUs? I need a bit more 
>> information...
> 
> How can I check, why MEM_ENCRYPT is not working on my device despite the 
> IOMMU being enabled.

I believe Alex already explained that. Your original message is from commit:

ea68573d408f ("drm/amdgpu: Fail to load on RAVEN if SME is active")

Thanks,
Tom

> 
> 
> Kind regards,
> 
> Paul
