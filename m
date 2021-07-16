Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF18A3CBC68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGPT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:26:46 -0400
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:15456
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229611AbhGPT0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g62Ef1du4cJD4L/YvOe2jHccK6ZtO7rrqlGlAGxfOkasw9xtIuHLOPZV3jD10QGA3akl20o9gfnJzgqOJVpSoOaohvto5R3XVEhPxAiYjpMzLV24QmgiHrEXHxm2UYzi4BoCv7culMwiBr0OERGyicg8FTPp4UjKEHYGdzfyVbXLGsgY2+FDMepzCT0omMBVgmkfJ7z39OTWe+na+xc3TD+WVljkD02UHW12UvgS9kuU/m8DbGVz4weXJ3P1yhluIPskci7I/sADnyyQU8vSJCYTEUGGpfPi71hIXI24YM/Sq6/jJ2yeDnWDJqkLKDn+U8OchfP9I+uORrBmqVoJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZZ7qMTJPcKFiSumq+cOQoJU63h9sSiG3FP2IOisto8=;
 b=cn0/4mY5zUyA+Q6rqNNiWNpWPpJ8Ib0ZxwfiYXgRN5Cm71BT4H3FXWjAVnLfxwcZGnQIikK5u7k/ipu0cbqNLT6OqypV60Fm0mWsgu5KIOkA0xziwUl1lDan80cA25JnsMvzJ9+Ei88rvre6GFjOnPAlNrvdwdglzZbRhxf519qYiB4xEAMnqCZjz7rOYno9lwpd1bJDIMwDwLUCJcSzrRR5ETpOb4AKhhdobsmN7I+gkbgLisLRX5PPM1KFXhRfscVVQqKvb/6Fy4uvmhwzcwvUSX7w45kpisrt9YnoJp7BomRe6HqW5VoCo1yOu3ELYcpiUoz1t9rs2NJ/P7E1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZZ7qMTJPcKFiSumq+cOQoJU63h9sSiG3FP2IOisto8=;
 b=LzE1jXKyCv6MohmLRcTUYIvaCPlCXk8KtjFdsBmgFPys/6Bn4eNKEp0fqsVHheEF0zfg8dtylJyL1FBTxrjBi3oWU/+mdjY6AFFM6m0qtfCqJbw/BD2c9NFa62gfWge2sYqckRFOO2C03upzYnVk53ybkUcsWkz1S/yNsWA0D60=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MW2PR12MB4665.namprd12.prod.outlook.com
 (2603:10b6:302:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 19:23:46 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::d0a9:a5f1:ca5a:b439%11]) with mapi id 15.20.4331.026; Fri, 16 Jul
 2021 19:23:45 +0000
Subject: Re: [PATCH V2 12/12] ASoC: amd: enable vangogh acp5x driver build
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Alexander.Deucher@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210716150809.21450-1-vijendar.mukunda@amd.com>
 <20210716150809.21450-13-vijendar.mukunda@amd.com>
 <87h7guduto.fsf@collabora.com>
From:   "Mukunda,Vijendar" <Vijendar.Mukunda@amd.com>
Message-ID: <ccb08af8-f349-7460-8ad5-0cfa0fdad4b1@amd.com>
Date:   Sat, 17 Jul 2021 09:12:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <87h7guduto.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.129.9.28] (165.204.159.251) by SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 19:23:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7b5242f-4b65-41df-df10-08d9488f3ae8
X-MS-TrafficTypeDiagnostic: MW2PR12MB4665:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB466527A7E7E4C360E12D191197119@MW2PR12MB4665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZ4kCrl33AAZILYz931o0UkvdozfVqnz1qBvWuZIYmZM5PzuEz5XKwccqGAK0HMwdbklOTW/P7zbeo1EeMEd0l6J7BSeOYHslffZ9VRB0JbMmszL0qD7s5zYTqRJ9DgzIA0lUVTRdje9XCPSKR7ZHjkbXfcegnVCLk+PsgPKB+z4rgQ0iP2sh4rEMfQ2F1mOrB9diV3fwwvup+iWEoVQABktxs+oKwe1tupHqtzVakqtFw20CO7TKBFq5ESmXo2ZWlHKwr+ZIs6P96D54gwEdGb2gn4cRj0N/6+A51UZlge5SaLcU8dzI2i2czZjs+9QFDYWdOt7jGwcTBm0yzg6Xnj2VrH6XUP3wRqlNod7k4hFVFHvbredGUsB05Sq9LEhNDBCAUf0H0GwVRkXwOIpy2nwlrOsFEkO3y+uC7sABIjsoOisnuRp3gVUxAq2B+YjZq44RZoQ/F4/W9iy0lRKi5gObxQA1a20oX/PAHuZfkCpBYhmjXrRD/DTPjLGWIWkhCXQGA+sJcydtG9QvCpDDHvaXvVinqqFCuFdLLkI+8P++hpJqHMf/ad6Rzl8ZAFUcCnZf3c4wXpD8LpWvbBjuvz7ssT+wcGgUfcbdu0uddk7bh/iYlbHlLcycnbyqhtL8TIc8sxAKxMcsBfFp0yOKXuoJT0Cj10ym5/y9YT1UZgDG0wjgqDqTaoNhpbLtds6gF1wNQeGxvQJWfJaHs9biB/moZK+dbA0l6ZxZaNfAUR+zye6iVHTtOxI04va5VGZdWgGhn6/zNsq+xFcX8BEZium5g4U4EtlXMB42H1aFgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(66946007)(26005)(6666004)(66476007)(186003)(316002)(16576012)(86362001)(54906003)(6916009)(31696002)(2906002)(66556008)(53546011)(5660300002)(36756003)(31686004)(4326008)(8936002)(956004)(2616005)(478600001)(38100700002)(6486002)(8676002)(42413003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdRYUpYV3RZaUFodmZXaWw5VU4yS2dPY0sweXZERmN6aDVjSVJzNWIrTFhr?=
 =?utf-8?B?dUxCbmxFVFhKQ0QxWFAyVU1lZWlkT1doN29xVFVSenZsMmc5Zmd6RTJJSmtP?=
 =?utf-8?B?MHBZd3FWMDlhdUdpQjZ4enYwU1BHT0pZbmcyN1hpN3c0U3lXN3RVWGhwRGRh?=
 =?utf-8?B?STdVSXlSZEpubzVYMXJPbTJna3p0OWlKVnVGMU05NVpoSDJxUjZQYmxXa3pB?=
 =?utf-8?B?T3A2eTBrK3EzUm4xV0c2cVNuYTB3ZFJOTTNFb24ydGFwSDg2NXJBdEVqY2kx?=
 =?utf-8?B?TEJvdHRiaTFxdzh0UlZIM2ZldXV4dW5zV1pzMllmbWJwYW1WZWIrOFg2a2NC?=
 =?utf-8?B?Yk9iVWJXei9lditUazVtLzh0NkR2S1VNTVBDTGJiQWV4QURkMFU2SGVOUmVo?=
 =?utf-8?B?azBwcU1RRjVBdU5HSENQeGttb0ZVVUFoZkFvVEFuWHpaOHVOODlpVC9LUzdq?=
 =?utf-8?B?NnY1M3NkYlQyaURTa0swanM3cnBpUENpbmJjWWlmNEJkM0REbnNHNVQvbDBw?=
 =?utf-8?B?VWQwQWZXQ2hnaHRFSldRM2drUGhMTFZORzVTVmc5QkJMTVJlelVBOS9JV3V4?=
 =?utf-8?B?QUk0WnVRdmdsYXhzNTBxakt0dnMwbGQ3OThFT0tPQmRHY1gxNHpBbWNkZXhi?=
 =?utf-8?B?YytPY2RsTWovZHlZdld1QkM0VWlxdStCYkd5aGlUQnNOY3FaY3FGd2xISzlp?=
 =?utf-8?B?UmNHNXM2eUhpRHcyQ2hzbDhDYUFLQUM0M3hKdGU3amQvQ3BhYjdRaUpJRGhJ?=
 =?utf-8?B?bWFPTHliTDFYSHB2ZVAreXNWdThCUFBGZFlOR0dPdy80bHRDd2poa0t6UDJv?=
 =?utf-8?B?ODVsM0IrbnEveC90MDFYSHU1OG44Q1VzNDJVaUh4U3QreUdtbGpIZzN3YlF0?=
 =?utf-8?B?bmI3SU5MUmRvenViU1NwQmtROVlwYWZwclk2dzdPb3NFQUxsRVppRUJwOGht?=
 =?utf-8?B?NUUvclFhRXlnMUUzOXRGK3IzaWswMFFnSlBrVTB0aGxId1RsMFMrRy81SlhU?=
 =?utf-8?B?SzhjTDM1eCtwRzh6bksvaUoxR1kwaXRGUHhwcHlIdkozOUxPREc5RzhaOVpZ?=
 =?utf-8?B?aEhrQlpONnFGbG51ZThZNE1yWjFqK0JsMjEwREgweStHQkt4OUVGQUo0QXdP?=
 =?utf-8?B?cWFtZnJ6L3A2ckFWOWdvWmV0OWxNZTBRU1Y4Y2ExYjVIK3g1WVRXaXhMTEpm?=
 =?utf-8?B?R0t6clQzOTg1UmJWa2RjbUVOT1ZFUFVORkx0S1FNWTRnbU03ZWs3VWwybEZs?=
 =?utf-8?B?c05tVWg0bW8xRXRuczdWd0IreWFDWFhXZmYydEs5WCtSZVNmSVNuRVlzTE9E?=
 =?utf-8?B?R3R5MjNVQjhnWEZ0b2FNWFhROUh5VXNsNC9GMkVwa0JJQWFsRE1PWU9sOTBI?=
 =?utf-8?B?N3hpNkhhbS9GRlFxTGoxRndwdGIvOWdVODdIRUt4Rmk1MmhqRnNWMDNTSEpT?=
 =?utf-8?B?QS9Iblh0VXZBQk1UeG9LcmRaZG9HelU5YU05TlplWnNkeFozT1pYU2VGdXkv?=
 =?utf-8?B?MW0wRkNSNVU3VnJ3OFJJbFNYZ3ZmUWF0akpsL1FRVldsZkRYOFA2VkR3Rmht?=
 =?utf-8?B?aWFjYjl0b05OaFUwZXdaMDRDNHJvT2x6a05zSkFlbkpCanQxcnY3RGVxS1Az?=
 =?utf-8?B?ZVpPYjFBd1cwWFpKWVB6MFQzK2pPSktLVFVyRmxlSUFyNHdpaEwyMmxsRTE5?=
 =?utf-8?B?a1dLZEhnQWdMNkZzNUdrYzBPSWFWOEd6VUZGU0txT01sZFMyaHFrT1hxbDNq?=
 =?utf-8?Q?nFgo5Rb2u4BZsYRpY8zEXm2PBcSmjxXPOBhaFi5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b5242f-4b65-41df-df10-08d9488f3ae8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 19:23:45.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUj0Y6wAoXsfUSdZqKZ2aJqpzz5NRh11NFCujwigPu1/kTuW8w0a8dPmRVnQnyA1jB2y/i15u7fhMurjwrl3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4665
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/21 11:06 PM, Gabriel Krisman Bertazi wrote:
> 
> Hi,
> 
> Vijendar Mukunda <vijendar.mukunda@amd.com> writes:
>> Vangogh ACP5x drivers can be built by selecting necessary
>> kernel config option.
>> The patch enables build support of the same.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>> v1 -> v2: remove extra line in Make file
>> ---
>>  sound/soc/amd/Kconfig          |  9 +++++++++
>>  sound/soc/amd/Makefile         |  1 +
>>  sound/soc/amd/vangogh/Makefile | 11 +++++++++++
>>  3 files changed, 21 insertions(+)
>>  create mode 100644 sound/soc/amd/vangogh/Makefile
>>
>> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
>> index ba5a85bf7412..cc48d4e5b080 100644
>> --- a/sound/soc/amd/Kconfig
>> +++ b/sound/soc/amd/Kconfig
>> @@ -52,3 +52,12 @@ config SND_SOC_AMD_RENOIR_MACH
>>  	depends on SND_SOC_AMD_RENOIR
>>  	help
>>  	 This option enables machine driver for DMIC
>> +
>> +config SND_SOC_AMD_ACP5x
>> +	tristate "AMD Audio Coprocessor-v5.x I2S support"
>> +	depends on X86 && PCI
>> +	help
>> +	 This option enables ACP v5.x support on AMD platform
>> +
>> +	 By enabling this flag build will trigger for ACP PCI driver,
>> +	 ACP DMA drvier, CPU DAI driver.
>> diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
>> index e6df2f72a2a1..07150d26f315 100644
>> --- a/sound/soc/amd/Makefile
>> +++ b/sound/soc/amd/Makefile
>> @@ -10,3 +10,4 @@ obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
>>  obj-$(CONFIG_SND_SOC_AMD_ACP3x) += raven/
>>  obj-$(CONFIG_SND_SOC_AMD_RV_RT5682_MACH) += snd-soc-acp-rt5682-mach.o
>>  obj-$(CONFIG_SND_SOC_AMD_RENOIR) += renoir/
>> +obj-$(CONFIG_SND_SOC_AMD_ACP5x) += vangogh/
>> diff --git a/sound/soc/amd/vangogh/Makefile b/sound/soc/amd/vangogh/Makefile
>> new file mode 100644
>> index 000000000000..ae2cda804e2f
>> --- /dev/null
>> +++ b/sound/soc/amd/vangogh/Makefile
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Vangogh platform Support
>> +snd-pci-acp5x-objs	:= pci-acp5x.o
>> +snd-acp5x-i2s-objs	:= acp5x-i2s.o
>> +snd-acp5x-pcm-dma-objs	:= acp5x-pcm-dma.o
>> +snd-soc-acp5x-mach-objs := acp5x-nu8821-cs35l41.o
>> +
>> +obj-$(CONFIG_SND_SOC_AMD_ACP5x) += snd-pci-acp5x.o
>> +obj-$(CONFIG_SND_SOC_AMD_ACP5x)	+= snd-acp5x-i2s.o
>> +obj-$(CONFIG_SND_SOC_AMD_ACP5x) += snd-acp5x-pcm-dma.o
>> +obj-$(CONFIG_SND_SOC_AMD_VANGOGH_MACH)   += snd-soc-acp5x-mach.o
> 
> Looks like CONFIG_SND_SOC_AMD_VANGOGH_MACH is not selected by another
> symbol and also not configurable in kconfig.
> 
> Is it missing a kconfig entry?
> 
whoops had the wrong tree checked out. will resend the patch series
