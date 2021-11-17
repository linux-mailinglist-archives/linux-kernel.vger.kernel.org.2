Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29B4549EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbhKQPdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:33:39 -0500
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:25765
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237048AbhKQPdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:33:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIDE6Ki6SNSSdd5Ofedgj7EUoaISK0oZpN5cgHF39/DqC1MEeOqFdhoLB3hLOjqjOiu2DfyHXvFEVBMivAu/tsIjxHzCxuj6p0hr58r0GnM7xNnLVzfPvx//K/Zt7fYiuBuKsBNB1xEnLuvqqkFO+1JeyA9jRd4Oi6OGoF7hzHIHBClqUU46CBjVB+t4CGPDsLhSZCfwN0lBEE2jFp2McXLyYe14K0Do6fwMooOM+dQ6ZzwsKZHaVy/yykzYQbyK5gBcDfzbWFTHmrzyG7c3VJc90Hnk9sQKf29nBsDK3xpICktgrJNQnCr2KKRzWjYrYctxy9bpG6NtGmAesIt3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m65Iu/Ub3VgiQSpbKG3GuAv85UhCb4tw18P1N/JRDw=;
 b=EX5IrjBtlTaFuHHNCU1tLWi+MfUd86lWyiXhNFgJtaseyGZGKs11cxiWkYvx7Csh1Q/1h26UyzrRo2BsznAe2CHAdA89Hqw8kZ/dz7gUy2lV4eEeordiWW7Gca/8EuvRAzSX/XpvCnsWFu7c10PTI+YLnnB0SnNWd0eCE6aTv7dtKljd8AJdk5DhG3gDNpq2AsnW4O1Vq1MlgBVuy4gSUUYuIEEzqtO8lVIW/Bhiu4kvMiD02hLdf95k5L6mSo75I7uQkFM1rmPIH5R5rxD+9xuNOijkNRpyI0j+5Y/9STgElQwxfDiUv2m0k7p9b1I5MzRzVBQMWLxdMaBUgY9qCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m65Iu/Ub3VgiQSpbKG3GuAv85UhCb4tw18P1N/JRDw=;
 b=NMSL/kVRImRxHsPB/1Ra2tA0G89amfhnynadfyqKhEO927ZYLYcdWS9Tg7ZaEsyckssDJRBwQyg7nFG4R8UixyGd/63nIJqiz/dIdYrGoL8ZTKRSDkfQ+ok20eSd8Ic5MV5r8zyGXUAKPw4F5HJc6nkpj09sRb0Ukhh7MCJnCYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VE1PR04MB6558.eurprd04.prod.outlook.com (2603:10a6:803:11b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.22; Wed, 17 Nov
 2021 15:30:36 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 15:30:36 +0000
Message-ID: <ef23386b-5b83-a791-e2f0-a72ec610836a@nxp.com>
Date:   Wed, 17 Nov 2021 17:30:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jon Nettleton <jon@solid-run.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
 <20211112173153.7kdx3dptlif2tqbk@maple.lan>
 <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
 <20211117135909.uf3pnhjorllnhcxp@maple.lan>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20211117135909.uf3pnhjorllnhcxp@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0801CA0081.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::25) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
Received: from [192.168.1.106] (79.115.171.37) by VI1PR0801CA0081.eurprd08.prod.outlook.com (2603:10a6:800:7d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 15:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8609e47-4908-40a2-aa41-08d9a9df339b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6558:
X-Microsoft-Antispam-PRVS: <VE1PR04MB65581BDD231DF1D525B29F43EC9A9@VE1PR04MB6558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxgDlFZ1nz+RL3BdJ7z5E/dqkZfGYkyrLgb69w//RkfKoJbwCTWr5uDRfjcbyf5o1e/PwA3/+uV4hl2A8t2fta217SUJnyEe2gHknCtlMbBp1ZNlPtVyBg/IHAngQ6mM2m94A4TqfbdVL3akTC0diVzIrigeJM00aUrktMdPcl2ShvoSB5zQubIS5d5/oaiXQeA+0tEmkk4Bdf5Q+UevZFxD0sxe4eBxFvUrZ16IgER4BbgujII/X/eewMT+/9dp2xOQps/5SnIpgN+Ikw0r9YlCR6jzQ8OEKi+3ZGSvSn25X6BUHEU+zRVxGeuk+nfutTlllefUkOmpQRczvdoZqxy2xFrV04b2IK32f99lyfJG1d+c+e999lUcw0vns5xyimLMYFlWZRv2MBYJcCGIKdi4zPL0fpQmn0lGJfWdv6vRgLIqFQW28eBLOtWDN5ozv3pz0Gf/3EOh4FhxSGROusMreo0EU7x1fRgGHiRk1XobXW76/rJzw2jcv0xGVPosCl2/igJQpGUoF2WekZRVy/I2BHWTYvmXav0JT+66eQ12Dxu95+RAYRX723NBnVadKwk20HZvYRox/6CkO0jVqnji2vBnfYbFLXwxCjQFoJzOpKlYFh9W7NWVuMBFbvEUfTDn9QAiyc7d5SAWhutcgl9e6zpr87zR+cBaFCLSFGMY9W3mremZeZ19cTbEOY847GV37k20Ota375Tg5EKCQOB2GUWacof2tq4eN7aaDyKDZN+lRPzAfbzn3SCdqb90dRwuxkwgv7B7xjfe7ZrC5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6486002)(31696002)(2906002)(38350700002)(66946007)(53546011)(26005)(186003)(66556008)(66476007)(8676002)(508600001)(83380400001)(4326008)(2616005)(956004)(44832011)(36756003)(54906003)(6916009)(316002)(16576012)(5660300002)(86362001)(52116002)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZZc1F5cForZTR1SHl2S2dvdW5qYkZvV1IvQ0ZQajJqaGhkWk8yQmZOZHlZ?=
 =?utf-8?B?UXU3YVM3OWdmNXZHQkE0TFdaNGhzNGJHKzE4Y2RqRUkvM2ZMbXdxbWtZbVpD?=
 =?utf-8?B?dUNDL2pWWTNLc2J3OEk2ZStlS01Cb295YmI3TEJuaVArOEJlaEpYUmlvNjZq?=
 =?utf-8?B?ZkVsUXhSbWVKb2FNTGJoWktVQmxSdzU1RWtWK0s2VjU0eC9xRmNpbGZWYVRl?=
 =?utf-8?B?N3oxd1BlU1NnN1NySmE1bGlwY3ZxY24wU1dzRFZSYUFpenV6bXhESVVVUCsw?=
 =?utf-8?B?cUhqcXBvZEFydW5SMkovQ2ticDIyazBUQmdvRHYrSUlhSHNMc0hLVFpWdllk?=
 =?utf-8?B?d0tOS0FIL0h5NTdSZ2FsSnBubmRkTUd4b214US9UU0pYK2l0VEc4RmROeWwv?=
 =?utf-8?B?MmJzV3M0WUVFL3FRYVd4eHQ1NTl4c0x3QXQzNUdJMWdLenl1bFdPZG1hMnFy?=
 =?utf-8?B?NWZJY0lNa2NKZXVvbEcza1lXbVREb1lObm5zZlpISFc4MXp0UzBoeEQxVWJX?=
 =?utf-8?B?UDduOXplUWRVSi9xVlpXSERnalNtWkhUMUFQNVBwWTlYbVlTekpQOFpEK0l2?=
 =?utf-8?B?Y3ZMdHMrNy84RGdPR2p3ZTRUUkVQQldxZm5wQjRnZWY1dlc4dVdKR0xQTkJ2?=
 =?utf-8?B?RnZhQ3hRRnZpV2Z6ck43TmVwaDZkREFBUW5sbEp2bmZUN0o2a3FOckMwcVJk?=
 =?utf-8?B?NytwR1BGdGUrVW1hM3ovQTA1aURXWDFCclZWaGFXS29SNXI5RFZPbEdoaTRD?=
 =?utf-8?B?bHhSQ3g0bzVOTUFCZU1Tbm54Q0h4NUpjbjdseEhKdnVsNFZ4NG1FamlVV2Ns?=
 =?utf-8?B?NGdhR3praTRYWEY1WEZvOW5tT2xYU1QxeUxYdDB0QWRoSkFSdUZTeFpZSWkx?=
 =?utf-8?B?bzREeXdkNHVUY2czcFlERElxSGJrYXdDK1BXb3haR3orOTJkbWRpTk8wc2JV?=
 =?utf-8?B?K3R6bVNtVlhYM05IYlRYUlRhWHFDRkMvMVQ0bGd5WGRJdHdRc0RTank4cG5v?=
 =?utf-8?B?dGc1N283a3B5NzFtenc5RmJUWUYwdFRzWHJtdlRCMEg3cmMwNElxUXE1ODZh?=
 =?utf-8?B?MnN0eWNzdFhCVjF1TVppNE52SmxWWW9vZGFNaEt1bU12VmNCcFkydnhXUUt6?=
 =?utf-8?B?eFd5V1pzRlVzT3JuR3pMV2tjN3BVSFRsVXhYYnVIdjhMYVFHMzVjRlZxb1pP?=
 =?utf-8?B?UjM3MEhrRlJLNlNyLy8yRndOcmZGRkRFM3VHOEZXczBFdVltdXVGRno3bEIr?=
 =?utf-8?B?cFRMd09HYzQ0WmpuV25YMVJDdGxLOHBuYjlMSnJtbWIvS1liRzlmalo3SmZz?=
 =?utf-8?B?R2pZK1BKcjZ6VGNDbnlOenU5NlNzR09VdkZHSHVTcFphRVIwNFIxVTFIbGRx?=
 =?utf-8?B?Q3JxWHAxZHFIdzRuVHk4UE5BUUp2Y2dWc2U4dyt2czJRY3hDSEovOWlvejJ3?=
 =?utf-8?B?ZzNsTFp3a1BGSE41UDlEcEVQNGVGekFrY25CRnlBNnJsWWhWdXRYSUluemJT?=
 =?utf-8?B?bzZFN0J4UGZuUnFtQTUzL3JLeVVqb0FEMHVOYXFsTEdTZ3N2NGxOYyt0YXBx?=
 =?utf-8?B?cnRleS9aMHJxUENzYlJiTUU3L2QxT3pqRUNRVU1FaVBkSkcwVU9BbE8xMU12?=
 =?utf-8?B?LzFXTEZ3RTJ4eHR2ZmphT3ZhSm0rWVE3MEFyZm1YdXNjRjh1UDErOHJvd2E4?=
 =?utf-8?B?RWloY29FZjVXTWtwbGtMRWdmTTUxZGt3Z1hHT1dXQTZHTjJuc1hxNHNocXV0?=
 =?utf-8?B?M3dZQnBvbTBucEZHa2Y0T2VmUHNvZmlRNEd5OTM2bU8weXY3YTV3UTRVb3c5?=
 =?utf-8?B?RU16RjM4K0M5TXYzS1VtNnR0TGI1MXNjREtzWit2TndRRXFYRVlZaklNcW96?=
 =?utf-8?B?M2c5aHpGRlU5c2xaMFN5bDA2N1c2SzU5Q3JNNGs1WmxydlNPakFPUElraStF?=
 =?utf-8?B?Tmk4Ylo1d3NUN2o1b29tWWxGa01VWTNhRThIU1dJSDZlUGF2QzA5NHdKRU1N?=
 =?utf-8?B?SzlnTlp2dGRUaHEvRHo2eThoamVYMWFRUm9RakpVd3kvcTBEYkIyOW13RVhG?=
 =?utf-8?B?aDBBQ3ZuMnVQMU9kOWwrWXVuRUVHWGdmVi9vOWtpQ3lEdkdlVkE3N2w1bWd4?=
 =?utf-8?B?WHNTSmhRN0JvNlNveXRybUhodFhkQ3ZNOUhPa1I2L1QrZ3ZtY3hvcVJLYVZP?=
 =?utf-8?Q?lApE/O1c7iTXInOnOdCiBp4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8609e47-4908-40a2-aa41-08d9a9df339b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 15:30:35.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmYJ6k1Br/YsJ7JFycnf05D4/Yl6Kskv2WYI7KkDgiwF+K2hFHhfuo0AY7l5wbqldHAd/fP+Fab7XO/mI58aaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6558
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2021 3:59 PM, Daniel Thompson wrote:
> On Wed, Nov 17, 2021 at 03:07:51PM +0200, Laurentiu Tudor wrote:
>> On 11/12/2021 7:31 PM, Daniel Thompson wrote:
>>> On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
>>>> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
>>>> <daniel.thompson@linaro.org> wrote:
>>>>> Hi Laurentiu
>>>>>
>>>>> On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>>
>>>>>> ACPI DMA configure API may return a defer status code, so handle it.
>>>>>> On top of this, move the MC firmware resume after the DMA setup
>>>>>> is completed to avoid crashing due to DMA setup not being done yet or
>>>>>> being deferred.
>>>>>>
>>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
>>>>> v5.15. It seems like it results in so many sMMU errors that the system
>>>>> cannot function correctly (it's only about a 75% chance the system will
>>>>> boot to GUI and even if it does boot successfully the system will hang
>>>>> up soon after).
>>>>>
>>>>> Bisect took me up a couple of blind alleys (mostly due to unrelated boot
>>>>> problems in v5.14-rc2) by eventually led me to this patch as the cause.
>>>>> Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
>>>>> problem and reverting it against v5.15 also resolves the problem.
>>>>>
>>>>> Is there some specific firmware version required for this patch to work
>>>>> correctly?
>>>>
>>>> This patch was merged as a requirement for operational on board networking.
>>>> This was merged as a prerequisite to landing the patches to support MDIO and
>>>> phy initialization in general.
>>>
>>> Interesting.
>>>
>>> I assumed the change of behaviour comes from properly handling
>>> -EPROBE_DEFER (which can hardly be regarded as a fault with the patch).
>>>
>>> Having said that the patch does not seem to be mandatory to get the 1G
>>> networking working on Honeycomb LX2 (running ACPI). By taking v5.15 and
>>> reverting as I shared previously, I am still able to access the network
>>> using the 1G port on the back of the unit (although I didn't do any
>>> performance tests).
>>>
>>>
>>>> The correct solution for the problem you are seeing is the ACPI
>>>> maintainers figuring out how to land the IORT RMR patchset.  Until
>>>> that is done the only workaround is setting "arm-smmu.disable_bypass=0
>>>> iommu.passthrough=1" on the kernel commandline.  The latter option is
>>>> required since 5.15 and I haven't had time or energy to figure out
>>>> why.  The proper solution is to just land the IORT RMR patchset and
>>>> let HoneyComb run with the SMMU enabled.
>>>
>>> Thanks for the update. I'll probably adopt iommu.passthrough=1 for now.
>>> That allows me to adopt a distro kernel when it updates to v5.15.
>>
>> The "iommu.passthrough=1" kernel arg shouldn't be needed. By chance, do
>> you remember what errors were you seeing? What was failing?
> 
> For all testing of v5.15 I had "arm-smmu.disable_bypass=0" set because I
> was guided to enable that by the error messages in older kernels ;-) .
> 
> Anyhow without "iommu.passthrough=1" (and without the patch from this thread
> reverted) then the logs are being massively spammed with error messages:
> 
> ~~~
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
> arm_smmu_context_fault: 1697259 callbacks suppressed
> ~~~
> 
> This results a relatively simple workstation (LX2 + nVidia GT-710 + USB
> for networking) becoming unresponsive. How long to fail is a little
> unpredictable. I assumed that the weight of such dense log messages
> eventually gets into a timing pattern that prevented any useful
> interrupts from being serviced... but that is only a guess.
> 

Few comments here:
 - I'm suspecting that the PCI video card is triggering the smmu faults.
Would it be possible to give it a try with the card out and without
"iommu.passthrough=1"?
 - the IOVAs look weird to me, they should look something like
0xffffxxxxxx or so. Maybe there are issues in the nvidia driver?
 - Would it be possible to share a full boot log? I'm thinking that it
would be interesting to see how the devices are allocated in iommu groups.

---
Thanks & Best Regards, Laurentiu
