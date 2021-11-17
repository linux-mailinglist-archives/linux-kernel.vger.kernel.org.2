Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE584546EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhKQNK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:10:56 -0500
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:52923
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232830AbhKQNKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:10:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of9FF+XkRtw3ny0P+xMdl2IKxk2+cSX/L8Kg/qYseTQsEkY5eHFKvnDTqzr8ryLnhqBMELxcMFzwjp5AkUgYU8eZM6EnRiQ0oBDTKYWk2vNavBiJ4jOB7hgPg7qVAS6indvn1KsojUO4XluMkL7GIw1MD8T5K/ScBF3+/X3U/KQLHC/AByGkkW1CWWcxTEhgxwYZwkKkIaW6vQKLmgKkYvvmTKHQm2slHq1+d9i9FDmrgM+Iytrrn4xGiXDCMhLt5CeK0iZPPEJn4uBaOkCP4x5CqFxLe6AYzo2mgXNMLucjKOyd2+9QwjIr7PtOLoydBfbGuuG/t1ZPFlOcWsxzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHNdOrtT8e5ma8ahQJTpJiSY9u2lKBitN6cDpN4MWFk=;
 b=n8ie9WqbyFmvt9AGTCBq1MCp/gxxipz1QUw5afdx3BBc1WIRqrlA3lX+G1vTEhgQLgBBqmBSCB9PJXG2mKUXiK2/Rsq7RxfHZP5Ms3duC7QptYRf+3K4eWga+FGsyZ4CXZItQOc3PqRgaiixLxSFNkJGm32lyn6GiRc+PyycHP1hBbKQaD+jUrGdBECzbCFQTVNf+ve3lH084WPu82+57z7abHofFB3ZsE6HqFrNS/9LjRT3bhjeRrMcaKeGBGxu3abdrS4MAjj4f6IAFOaLQZi66ZH+eSaxcEUSL7xGsbYPR3tlHRmTbZJnNUzHyLgqV5oG2eO1iYbWIA1rHyJeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHNdOrtT8e5ma8ahQJTpJiSY9u2lKBitN6cDpN4MWFk=;
 b=DbxCE31Q1UcozhMe8m6pXrE8sOc8op8T2vwMECsycvCCJQvRf6enxEXMcfM+gbQkFyKK54LIsdnZmht3Zny4x1UfD6mrXSESPJ33QUp55ah60o4heYevIFJdXjtFYoH4H69lN8U6t8wbjvfWepQswSizylqJlFC0LlYlJ7+5GM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3581.eurprd04.prod.outlook.com (2603:10a6:803:3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 17 Nov
 2021 13:07:53 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::cf5:b5a4:49d:98f1%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 13:07:53 +0000
Message-ID: <9d4ef51d-ffc7-6025-c70f-f48bddc9af23@nxp.com>
Date:   Wed, 17 Nov 2021 15:07:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Content-Language: en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jon Nettleton <jon@solid-run.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>, leoyang.li@nxp.com
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
 <20211111172340.fpn4pou2xwm654g5@maple.lan>
 <CABdtJHtDbTXLPKHQiFCAVPmJ16e1TuOtyCWU9PtUMSKhWvfa-w@mail.gmail.com>
 <20211112173153.7kdx3dptlif2tqbk@maple.lan>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20211112173153.7kdx3dptlif2tqbk@maple.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0901CA0101.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::27) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
Received: from [192.168.1.106] (79.115.171.37) by VI1PR0901CA0101.eurprd09.prod.outlook.com (2603:10a6:800:7e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Wed, 17 Nov 2021 13:07:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d115ff-39db-4b83-9dcd-08d9a9cb43eb
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3581:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3581D3ADE08288F9B24CB901EC9A9@VI1PR0402MB3581.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2diMb5wMnzlUMoDGER3VxuqdxE6ALiAqlIF39j6nJkTjxboNTH4rqWJ6G4r47cpokXlgFlczKiRvlDv26k54VAFXAP0Nf1zn06Exy97wN+aZ+ySAOPmuvbGi10graOexaIHNy83utQPy0el3UAiS3eSQncsy8h3NDHJsyoFSO1qjyga1Kl/1plXTaqi1Jv2DsK8Zev80tGL5R/4nxYGaeLFSoY0bf+hm/7GsEtYLFtso7WxPkVz6IsDY5PjtOoyZChg7nW6SwTLz8nQtG6B8U0oF1dt/Phj2hIbHwJNUsGpSeo97gbQGA/OHeZwyF3CFlCb+IXn9O20xYu7ndstdpsWbrJKyB2vl3JMs1gC1wEscye/wAlfBgBH+3F0WgMMFYQJ/Ya/BKLiBFIET6tLvVuKceKuzH8uVrBJib9eMW2M31YrtO657JCg3G4gx5vjx351Rg18Y9ZklkYl0A0T2xyTEFx9xRDxSlZQ2eLebQRZdbp+Q4onqAlKir+LGiYuEswwUW/xI+RoVu3Gu68dgETX9EwuMem62CZQshO70Y2SaTr6YpO2OTIz5wxjXW8eCuhRS5BMeArfGTRntaOV6Y/sND0RL5CrfFJ3eyo/Ct6tBMtxKaN+3AF2WP3ZQMT0JpCYUgaMDNfN9OLwC+6SorIXuAr+lhRO8efKz9ifwqKImiNjTFyzPKHljq9BuVP5yuKAmvHnbufQZndQFlucvmPTSNETvj2WbfH1UndyFetdrUMQVRkCsduc5tL+B7W2ng0EEIeJPll0rxtO1ciDaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(186003)(2616005)(83380400001)(44832011)(4326008)(66946007)(956004)(31696002)(86362001)(26005)(5660300002)(36756003)(54906003)(38350700002)(38100700002)(110136005)(6486002)(66556008)(31686004)(316002)(2906002)(508600001)(8936002)(16576012)(8676002)(66476007)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZDS3RYSVJzTW40S25zUC81WFM5all1bDc5MzhJMzFPd3hnbFdRTVB2ZTN4?=
 =?utf-8?B?dHRER0x4L1MydHRqU1hLbmIreGl1c0ZsamJKb2Yzb2VubjdUalhjSlRsUDZS?=
 =?utf-8?B?ZGlZYXVaRDNRWVlqSlFWY0pjcVhaNnpxQWNicUZXUGpackxKWWhjaFhWdFhs?=
 =?utf-8?B?aERKRHEvQmZHMVF1ZkhXSHU0MmlhOVlyMmtwKzlxbkdSay9WRjRwdEVKWFdh?=
 =?utf-8?B?WkdzNDljeEVhZ2xSZmRSRmxJMU5nOHphK2dRYStwTkQ3dlJNMll2VVBmWmNP?=
 =?utf-8?B?ZldZa1pPL0F0OHplOVphY3VWd2NhNDVUeFdVMlZIMXUrYXo0Rk9MSno5ZTQx?=
 =?utf-8?B?Y040NnlLaERSc1AzcXZTZTVTNVlLck1OV2tEKzY4a0VQN1NRRGFheWtNU29r?=
 =?utf-8?B?OFpjNGc2UXl5RExPemFLcWxsYmx4WEZoSXFPRTdUYVNuVTJNZms1WCtua0o5?=
 =?utf-8?B?bHRGT001WTVxKzg4Yy9CQUQvSVk0Zk0wYWxOSGtLWlRFcnJmcHR6VFFVUytX?=
 =?utf-8?B?NDIweHN0UUhxaVQ3N2R3ZHZ0WUNydnBBVE1NT1ZzMEl0b1RwZ3NJVk1ZY1RH?=
 =?utf-8?B?UkRXR3QvQkY2N3Y4aTRGK3pzd0JuWWJORFRYb3M0b3lra2F5c1BGRkFLd0V0?=
 =?utf-8?B?NWk5clZ0endpamZDa1VNZnZraTFPK2g0YjFDTkVDTzRNNW1kYXZYZGVmQWVn?=
 =?utf-8?B?amIrS2tPRDVjUk9mSDdxdXhpSm1mZ0RYdmxjVjBQVXo4N3lObTFMY0REbmtQ?=
 =?utf-8?B?VjRVaGhHTTRBdWxxUnRCUFA0QmpjSU1nM21QVjVnRnlTa3VORWF3b0k0eVNh?=
 =?utf-8?B?Nmx0MlhHbDM0NkN5dTlQTGdjYXp2SzZYVjZJZjNXZlM3cTMxS0tucFNIeG5u?=
 =?utf-8?B?UTMwNkRIME1MTVp0elkyaktBYVZFNUtNcUFFSmhla1Zwd2g2WGhjR1gwcWlW?=
 =?utf-8?B?QWUrbmhQWUJvMmtOQ1Vha2o1Uk9BU2lnMWR1WEgzc3Z4MVJvR2FDZXNDcDEv?=
 =?utf-8?B?MkI3YlhmU2NpRVA0UWdjM2cwbHNiT21tcFhrWCtjREhtcVlobktKUWcxU3Fr?=
 =?utf-8?B?dkh2blJmUU52WE5WbCthLzdtM1lXeGQxNnFJc3VGY0FYdE5oU0RNZkI1MVli?=
 =?utf-8?B?Z2tVZ2I0TGw4MzZ5RXBTNEhNeGxGZVNmTndsZmk0TzNZK2liMmp5MTNYS0pX?=
 =?utf-8?B?T0x3RkFuOVNJRWYyU3JiVkh3Mm9pSFc0Z0I2ZGhYOVZZbXg2Q2dzdU1MSVBY?=
 =?utf-8?B?d2VQZkc4NG10WjUzNGltNzgxWHp4Sk9tdzhkYnlCeTJhbXJ4aExuNFJvQXIr?=
 =?utf-8?B?ZVlYRHM4eExiMDRKaFAydkhNYmUzWGxORFAxS2thcmhQYnVEcFBxcjRvQkRV?=
 =?utf-8?B?RW84SmZsTlRDdmQ2TkVtTVVUOHpMdGc4bTFZWTdrMzZvdWJESG52OGIzVndR?=
 =?utf-8?B?dDdVMjJ6d1l3ZjBxaHdLOWhOaUh4THl2bXV5Wm8vTDZJdWlzWFVzdWxZNnVX?=
 =?utf-8?B?Qk9sYVV5YnNFQ0NhVVExdUd4YnR3M0NMZWc4K1ZGMllsaGIxNWd5d2JLR0RV?=
 =?utf-8?B?dkQrL24zanYzU3BzZnRrWU43dkxicFRXQk4ya3B3VFA3aUczZWZ3bGRGUm85?=
 =?utf-8?B?SEk2TS9SaVNncGYxbTNaQ09qbDUzN2Y0bjZsRmJMV1V3OHhPSG9Rc3d1VE51?=
 =?utf-8?B?SjRVemppOHcwQ3VRTTVzOEtwdzdlZ0RXVFJwRjE2d3liNFk3VE5sdThhWWtO?=
 =?utf-8?B?OHRrMkJ4VHkrdkFldkdLemVYSkV1ZkFWUFgzcXRKYzkzTU9rSlByN1lQaTFQ?=
 =?utf-8?B?Qk1qNkdJM0FJZzQxcjFsOHFsOGtJNmw2VmFRUTFYenZBcTJZa0pIRTliclV5?=
 =?utf-8?B?MWlIdUJtSGJ0dFd2NXRpUUZCVXlBSEQ4RmlEcXNOVHdnVUV6RXR4dnAxOGk4?=
 =?utf-8?B?Y3RpRU5oTmI0RlpyYjNOZzQyS3cwVjd6ZVFjRHJkUTZsUG1Kby9vT29QU2hp?=
 =?utf-8?B?b3RuWVNYZDBPc3h1NCsrcXVPZ1VMdmFlUSs0aUJlT3dUc0oycHJJMDgzajRy?=
 =?utf-8?B?a01vdEZlK1A3VEtLV0IvdjlkQ2NidERxNTFlclJrNzYxYS85UkpMb0JsMXBa?=
 =?utf-8?B?dnk1OXYzTEFYZVpnSVdBMnJyV2VrVzNWOE9mcmNNN2FlK0xEalZ4QVhzNXhs?=
 =?utf-8?Q?wxBRnruOdQQW3JcQ/B2y+JA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d115ff-39db-4b83-9dcd-08d9a9cb43eb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 13:07:53.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU01EplMsnAkdPj6VhK/0ZT4CJmLYUWIWZQknsmerk7baNImmZJ7Z/sLPzmLvzqgWMMKYDlvRmrG35FTGTnn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3581
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2021 7:31 PM, Daniel Thompson wrote:
> On Thu, Nov 11, 2021 at 06:36:58PM +0100, Jon Nettleton wrote:
>> On Thu, Nov 11, 2021 at 6:23 PM Daniel Thompson
>> <daniel.thompson@linaro.org> wrote:
>>>
>>> Hi Laurentiu
>>>
>>> On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>
>>>> ACPI DMA configure API may return a defer status code, so handle it.
>>>> On top of this, move the MC firmware resume after the DMA setup
>>>> is completed to avoid crashing due to DMA setup not being done yet or
>>>> being deferred.
>>>>
>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>
>>> I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
>>> v5.15. It seems like it results in so many sMMU errors that the system
>>> cannot function correctly (it's only about a 75% chance the system will
>>> boot to GUI and even if it does boot successfully the system will hang
>>> up soon after).
>>>
>>> Bisect took me up a couple of blind alleys (mostly due to unrelated boot
>>> problems in v5.14-rc2) by eventually led me to this patch as the cause.
>>> Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
>>> problem and reverting it against v5.15 also resolves the problem.
>>>
>>> Is there some specific firmware version required for this patch to work
>>> correctly?
>>
>> This patch was merged as a requirement for operational on board networking.
>> This was merged as a prerequisite to landing the patches to support MDIO and
>> phy initialization in general.
> 
> Interesting.
> 
> I assumed the change of behaviour comes from properly handling
> -EPROBE_DEFER (which can hardly be regarded as a fault with the patch).
> 
> Having said that the patch does not seem to be mandatory to get the 1G
> networking working on Honeycomb LX2 (running ACPI). By taking v5.15 and
> reverting as I shared previously, I am still able to access the network
> using the 1G port on the back of the unit (although I didn't do any
> performance tests).
> 
> 
>> The correct solution for the problem you are seeing is the ACPI
>> maintainers figuring out how to land the IORT RMR patchset.  Until
>> that is done the only workaround is setting "arm-smmu.disable_bypass=0
>> iommu.passthrough=1" on the kernel commandline.  The latter option is
>> required since 5.15 and I haven't had time or energy to figure out
>> why.  The proper solution is to just land the IORT RMR patchset and
>> let HoneyComb run with the SMMU enabled.
> 
> Thanks for the update. I'll probably adopt iommu.passthrough=1 for now.
> That allows me to adopt a distro kernel when it updates to v5.15.

The "iommu.passthrough=1" kernel arg shouldn't be needed. By chance, do
you remember what errors were you seeing? What was failing?

---
Thanks & Best Regards, Laurentiu
