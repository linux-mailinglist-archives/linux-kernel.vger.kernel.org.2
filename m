Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF53455BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbhKRMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:44:59 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:28078
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233461AbhKRMoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:44:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe12Dk5yh1YDhdIiFUQnUvasxQZzqr1+cLtD4Kyub7D6LFSJmJUTxQHbQndtZphRxdgiP1EVaxBYh/nBiDeEkwFVWrCyqpr7V+TWkvPoCF3nSjlNRHFdxV8SqZwhQPX026E/7U5cuwvoHnqNOm6I69uAjs6SdTvSA6b+FLoAuQSLF24yOsByTXnY3C0Lx6G8lwjn3qLOF/Gi3Er+PwdnXXEFFy4j6U67w0f58CLde7Di6wTJN3asB0+wnIa8wwj6vblIS6croEiJoxhSymiR7DGFCSqRPfPiGPBi/Iv6kwuo0Gc9bA5TZDU0rd32otyesgTPBum8C8i0+xWWMWr8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmvVrikzHZBsc3zAxmTQfUmVgpAUYrqEQY1zWFv88zQ=;
 b=MovVYk2PDMpeWGvcQok6Oh9pwUlcMx/sYJUnWkT2shBafR+uCvJL+upcr1vbTv0VngRyqxv8xZPsySTbEA4JE14cN/bxXo1aJNA+kbpntcDQS/uaAlXH+DwVuxyzINsh/Fwy4u2e85R5MqH5qIsN5kqV2U7PEYXBattXn6yWRvOJt4/Ha/35k1w9hNrCwKiPzGpkLepLKF3dCWxVSBU0wl7mAOplnc3+7m66WdgEsvcTOxnUB0vIoF3BYttMEoZlSc6AK++/tEYqYowvbsEGJb1BBKZxmWEyzfdEOxPbb6rrNKqiO34Flq0OPn9E8DlW4glKIVVYrYNMp/uXNOQtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmvVrikzHZBsc3zAxmTQfUmVgpAUYrqEQY1zWFv88zQ=;
 b=rfAHZtq722XD4cUAE/tYsNaD/p5uZ4f9fhSCMH1sdPCCOP8ILApip5wuvtjKzBzR2iSkb2G0IZX3w8ZUoMbHDzI7K6pFAO7BQJm4TlP07jTBNy8TIgIFhqMxyMdcq8aUxBFRvGza+YiMQoz/+LGPLClCn7lqrJDI4d2vrClCXYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0401MB2528.eurprd04.prod.outlook.com (2603:10a6:800:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 12:41:52 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1%7]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 12:41:52 +0000
Message-ID: <e75f24e7-90a9-5673-cf9a-a1f186193dfc@nxp.com>
Date:   Thu, 18 Nov 2021 14:41:50 +0200
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
 <ef23386b-5b83-a791-e2f0-a72ec610836a@nxp.com>
 <20211117170013.otj3gwfqnmvtlxlu@maple.lan>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20211117170013.otj3gwfqnmvtlxlu@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0211.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::18) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
Received: from [192.168.0.29] (78.96.82.64) by AM0PR02CA0211.eurprd02.prod.outlook.com (2603:10a6:20b:28f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Thu, 18 Nov 2021 12:41:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 935619df-3e9e-43cf-4b04-08d9aa90cc01
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2528:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25287475C4A04E8998C53638EC9B9@VI1PR0401MB2528.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIk0HTmJlnQ/RU51xUahZHzI7avdAZ47ZrJY4XFBgaHcY2M3YMc0efddId/9PKVtywCeKpN5HSoOlQxez7zXYEmUco+5m5rlRDX0CrKCnf+9hJNzk1NL7k4RXbDUp6NDX/vmmEuzeeqT7WIoFIaU1kuBNDL65nUq8IRc0WjxnBU7RYtXrV0oCHMhp7kYhAdDD78o9oKOUe/jHZUbP27ZTZ023J2mw58OzPY01vSqfg/7VAm2JL9Boxwd8wELX/usNbHI5utmJLSZ46MCV7/xJghnabie4rUdDb9P8Otc32ZxFier90ygj+UKsNLCOUmCYuPFeCmDc3ll6x0ecgNuzCWePiRFr41VSUn6HP6h3LkZqns7HYRF95HdfRLQXS+uYnNMMjFMUeokaKph+UGL0NgR96lFZ554GwjQIKbtcPFqaBrr3LN65mQe4Od+ZQFSFQ/DgQZ6uZ16pa1bu0BzjxP859SithlK4I+Xf0GMp8e0mIjXWTXK7GXxuj2St4TuO/AHsIhq2esVupew22j75z9n8nfR92B0WNAsXL3JunXFjv0HMUNhLfonYIErK8D9uizH43L//wAz4QrMjtv0hlBhEkBA11CdIFy9onf3mrjzA1vzt6Pmyz9js03w8bRE6EnH5uipRBto3Vw1cEzPFxG4lQT5Sat4nYWqU/YPs66wbR+qCwh0phOLAjTcG46IG9sfLgFIhLtU5PNucUoOrJae3hAG7r5i5W4VScFq7jp3o/iNoj3Z3zR4WxDgplcLHXixoaXT0m/3I8SlvlNdrZMwRXRabBsFEqW2n4YOg5T0de1hfBN/fs85XB/yITYZhi8tE6PpSvPQABst85kXVlULr7z7tQcukkldvAuztpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6916009)(16576012)(508600001)(5660300002)(2616005)(31696002)(45080400002)(316002)(44832011)(8936002)(83380400001)(54906003)(52116002)(4326008)(66556008)(956004)(31686004)(26005)(38100700002)(66946007)(66476007)(38350700002)(2906002)(86362001)(53546011)(186003)(6486002)(8676002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExvV2V1d1U4L1FYNitTamJIc21JVko3MTlzdWFFbzRFQ3RkM2ZlVkczblJH?=
 =?utf-8?B?anBYNmJuaDQ0bEdNb08yOC92MzBUZlZmM3pReVN2ZWpsMjl5ZnJ0UHhlNkRE?=
 =?utf-8?B?bUZGK1g3cUh6aTQ1MmxCemJIZ1hpeTVtVTZjRjZFMDhWeGVhYm9Ed3NtZTh4?=
 =?utf-8?B?SHc0akVCOHBnaVRndVBmSGQ3M3FuOUdnVDQ0RDVMMElncU90cXM0STAxRHY4?=
 =?utf-8?B?bWloM1VncW83THBKczVpM2VvazF6NHRMR1NsbzFmTVhDSHU0ZHZUbUVZa0wv?=
 =?utf-8?B?ZWV1b1NuQkRqVFhvVWxoK0lIUGJ5akRLdVZNcFk5SnJLZGp3N1VUa3JZWjJQ?=
 =?utf-8?B?Rnl5Z1NKMzMvZGx4QWJsU0xkbTUvT3F5WnFVK0hWU3ZNemZUOXErdkh0bFNh?=
 =?utf-8?B?dS9yamsxL0JnQzgycnZmTzhWUW93UnB5VmZ5MmRnR25yRUVicEJ3d3QxS0tG?=
 =?utf-8?B?Tzd5RzZleTk4L1Z6Z2hvMFZ3SjNnbXNzSGFsZCtvb3FNNUVvSFM1dysrRWlB?=
 =?utf-8?B?czdiUTZTc21zSHd4bTdNSjdJdk1ncFZuNzNtNzA5MHdoWEVVN2J0SGpEdm52?=
 =?utf-8?B?TWNzcE53S1ZWL0ZoZWNnc2hGQ2QxQlpEblpRdE5ya095TEtPeGxCUFhtY0FT?=
 =?utf-8?B?QVNNOFZrM0NnVzFZdXc3MjBSNHlodkliR1VPZmw3SHRMdERSVEwyTjZaSVZp?=
 =?utf-8?B?WXk0TGQ0MG9aZmdoTXhkS1hPMEJPNllFQWdWRGdsVlFkVU85MWg3bmJaQXc1?=
 =?utf-8?B?SHdDRHppSVJic3A1amNmRS9MRjZkdkcrR1JrQUdqRllWTVNyd2hDQUpDcFUv?=
 =?utf-8?B?dFhjYXJVeFFjNE9UUFBDbVcvTUwvakprUzB2WXF5ZHdVUE9JSm94M2VkNjhM?=
 =?utf-8?B?NVJVcnNFYnJMNFBZTFZrbFAyTG9JUnl6eTJTYXV5ZkFGZHc5VENURWt2QnFN?=
 =?utf-8?B?eDVsSEZnK2RabWVvcE0wWmtXSUNvRkYwdXBzcHM5Yi9ON25wL0FFdFZVU0pj?=
 =?utf-8?B?M1hJU1VENVI1WmxLVHl0WmdoZmNWaFQ2V25JdmFmR2UxVVowVDFwdUVxNGdn?=
 =?utf-8?B?cjk5Y1B0OVg0cTBqOGVLZHp1bFlTVEFGd2pqVEtXVGV2U0RpaHNCWThxNDk1?=
 =?utf-8?B?UjRiYmJqeUY4cktNSlFtUUxJRE1KRVVLQ3ZjNTNZZ0p3TXJsWlFtQ25PbkhG?=
 =?utf-8?B?YWl3Ykxqa1h2TWN2b0Y2NlJmN3RrMHZHMldtZHJ6OUVUR3o0Zlh5ckVYcitZ?=
 =?utf-8?B?R2pXaWIrWUN4S0p1SmQ0M2YvTnhKWmJqNFBIakxObXA0U2szVStSYmNEOGxm?=
 =?utf-8?B?UTh3dkcvQW05ZVBZd0JubkcvbXpMd3IyL2oyejZBSWJvc2JQbUpzZElHT0lq?=
 =?utf-8?B?bHFOTGgxYk04WlYyQm41clB6eWpBdWNnY3hkNm1DTytyRWJzakY1b1ErOTZ6?=
 =?utf-8?B?ancxUzF6dkdCZTd0eVdOZGdoUnYvVFg1V0tLLzdKS3BVSFB5WlZRVXJyQlZv?=
 =?utf-8?B?R2wrRlZVZUdRSGk2STZpSXFjbnF5aGQ5M2JtR0xkUllVazBpS0FPWlU3MzEy?=
 =?utf-8?B?WVdLcGdFeDlhSlZBbFk0QUJoeDc3K0VMUkluN0NERExMeWQyMFE0S21ZRkJ5?=
 =?utf-8?B?d1hMQlFJc2hvTmZYVVdPcVo3ZHVVS2RIbVNtQ2k3dWZLWkJrbGZ5SVp3QTBG?=
 =?utf-8?B?MzJWdmZHbEVtU2kyRE9LWk10UVAweVJaWWoyY0Rma0swRGJCSU9DWWtJcWhy?=
 =?utf-8?B?RzFPcTREeExLWEpKNnJvallvLzVpM1owd0RwYkFqMVFNS016RmdPWG1DTk1o?=
 =?utf-8?B?a0RucUtuSHdPcmQyNmNENHdIUWs1eFhTcHVFbjhzQldaU3BNeXVoV05KdzV4?=
 =?utf-8?B?a1lPMmVQSHR5eHltdEkwenJFMDJ5RG55NzdLWE9KbDJXMXhpTVV3T1hlZEdP?=
 =?utf-8?B?M0FkU1FUM0VRMmdTalhRYVRvdkRndHNDc1JGT2FDUXVRbzh5clV2U0ZrNzFl?=
 =?utf-8?B?ajJ0akNNZW9DTDlIWG83ZVVUcTR0SmI3a3phUVVFczJCQWluemZkWTd0bTRD?=
 =?utf-8?B?ZW54RENrYUsxanhSYmljUy9CSlV0bUo4b3RZaHpSQ1crTHJ0clZuK2pQeG9R?=
 =?utf-8?B?NzdqYzI2b3l0eUpsdjBFYmNQMFR5VUZXWmhtcDVsZUw3VUdHb2Q5aUh0M3R3?=
 =?utf-8?Q?IxEXLDxDNU2+G0anCtEgLUk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935619df-3e9e-43cf-4b04-08d9aa90cc01
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 12:41:52.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA14ON6C8Nd5ZLjDxqrW2CzgJ6ZoOlwwokJhoEM7RQrXsDwYO97+97/s49vs9+JWs6To0oYHMyFgjw8BehLstA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2528
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2021 7:00 PM, Daniel Thompson wrote:
> On Wed, Nov 17, 2021 at 05:30:32PM +0200, Laurentiu Tudor wrote:
>> On 11/17/2021 3:59 PM, Daniel Thompson wrote:
>>> On Wed, Nov 17, 2021 at 03:07:51PM +0200, Laurentiu Tudor wrote:
>>>> On 11/12/2021 7:31 PM, Daniel Thompson wrote:
>>>>> On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
>>>>>> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
>>>>>> <daniel.thompson@linaro.org> wrote:
>>>>>> The correct solution for the problem you are seeing is the ACPI
>>>>>> maintainers figuring out how to land the IORT RMR patchset.  Until
>>>>>> that is done the only workaround is setting "arm-smmu.disable_bypass=0
>>>>>> iommu.passthrough=1" on the kernel commandline.  The latter option is
>>>>>> required since 5.15 and I haven't had time or energy to figure out
>>>>>> why.  The proper solution is to just land the IORT RMR patchset and
>>>>>> let HoneyComb run with the SMMU enabled.
>>>>>
>>>>> Thanks for the update. I'll probably adopt iommu.passthrough=1 for now.
>>>>> That allows me to adopt a distro kernel when it updates to v5.15.
>>>>
>>>> The "iommu.passthrough=1" kernel arg shouldn't be needed. By chance, do
>>>> you remember what errors were you seeing? What was failing?
>>>
>>> For all testing of v5.15 I had "arm-smmu.disable_bypass=0" set because I
>>> was guided to enable that by the error messages in older kernels ;-) .
>>>
>>> Anyhow without "iommu.passthrough=1" (and without the patch from this thread
>>> reverted) then the logs are being massively spammed with error messages:
>>>
>>> ~~~
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
>>> arm_smmu_context_fault: 1697259 callbacks suppressed
>>> ~~~
>>>
>>> This results a relatively simple workstation (LX2 + nVidia GT-710 + USB
>>> for networking) becoming unresponsive. How long to fail is a little
>>> unpredictable. I assumed that the weight of such dense log messages
>>> eventually gets into a timing pattern that prevented any useful
>>> interrupts from being serviced... but that is only a guess.
>>>
>>
>> Few comments here:
>>  - I'm suspecting that the PCI video card is triggering the smmu faults.
>> Would it be possible to give it a try with the card out and without
>> "iommu.passthrough=1"?
> 
> The PCIe video card does not cause the smmu faults. These still manifest
> when the card is removed (and with same IOVA).
> 
> 
>>  - the IOVAs look weird to me, they should look something like
>> 0xffffxxxxxx or so. Maybe there are issues in the nvidia driver?
> 
> I guess there could be, but why would a problem that bisects down to
> a change in the fsl-mc-bus initialization configuration alter the
> behaviour of the PCIe graphics driver?
> 
> 
>>  - Would it be possible to share a full boot log? I'm thinking that it
>> would be interesting to see how the devices are allocated in iommu groups.
> 
> See
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgist.github.com%2Fdaniel-thompson%2F07489561f14965fd1af7d5bd4340f54b&amp;data=04%7C01%7Claurentiu.tudor%40nxp.com%7Cea1a5bd1614a4fc6c71f08d9a9ebbb15%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637727652186934191%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gYsxsm20NsCKKbSXWPentLAJJPAn6A9hEh3fAKBn2Kw%3D&amp;reserved=0
> 
> It contains three files, all gathered with the GPU removed:
> 
>  * Logs from unmodified v5.15 with iommu.passthrough=1 set
>    (networking is good).
>  * Logs from v5.15 patched with the revert I shared earlier in
>    the thread (networking is good).
>  * Logs from v5.15 without iommu.passthough=1 set (many SMMU messages,
>    networking is broken).
> 

Ok, it appears there was some confusion on my side, sorry about it.
So, to summarize:
 - the "arm-smmu.disable_bypass=0" workaround is not enough in the ACPI
scenario but works for DT based boot
 - the result of reverting the patch is that the IOMMU for MC is no
longer configured (MC device does not get configured in SMMU) leading to
"arm-smmu.disable_bypass=0" being sufficient
 - for ACPI too boot without "iommu.passthrough=1" the IORT RMR patches
are required

---
Best Regards, Laurentiu
