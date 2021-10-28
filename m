Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA443E00D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJ1Lev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:34:51 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:52161
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230122AbhJ1Lel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfADh9wrmvCQwHnR4lR0BBTkKekwPI+Zc+131vpJkrngW6Br/tMi1s1fTjdlvHfyidG0MFQr+ckci36xdrfwEzrfPAPdXi3bGktMyMbH836cUCQK1K41Mjt+AIIhozSW29H7F+udEFJs/WgCU3iQEHKLtnxPUyAA7d4h0kUQViDaKVlYTl55fmTC1fi/V/U9QuykUzyZ8I5aS5XpFOSHfL0buS9NlqOPtAebq73rwLNVq3NE8FW9T2Kkv3S2Ompzt5/pov2Vk3sdnRMh/B+mxCRJqW1p+Rfz9q97KJ2+/HY0iohdPcX6S+HispFs5xOuP0IM3CQ1O9k8bTKo6bDckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuqfFf8Jxk2JK9DKOyqwE3i6/hG5D6koovUwoceEFSM=;
 b=I49hGwh7gUvnBx7I2HLNSrQAq6RWHnRYpe2kecrUfUQElFLV7yYEGeCf6ZUKx2ApL6XZGsWIYZowmrC5KjSDisdScB5NiG1kFOFYf4Fhan7xO8jt7p7CB8Yd66pQW+AhwIfGdIwPCU1l2xPa6reqKgZbJg7G3enVPHV4AdCObcCH7jAfVv+oXgyYkVZHNODoFzdgL1AMGeX4afAUwNCB8nRCZMuvOOC+SbieVhsXK/XhG2c7q2xvQ6LpndVNd7Sblh24Wb/cX+D+vMS7/BbZ3XABxB7xG49ikmlASgx+IozWgMorxVrfNkz5TL/g4oKo5YsVtfDzVnuxM8JabmNlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuqfFf8Jxk2JK9DKOyqwE3i6/hG5D6koovUwoceEFSM=;
 b=c9UYHmS04dcjDmYmD/qNlJ1SxOzFA+7u02AWYgLvb49T1M9VmMwdZU0tTZwTttc/7thQCJY3xSlzu7Ud37mZOYKeuVhhu0+mCOPTNZgIUN2bf2J0ASG1hS444rCwOUAvkD9FCcjxkNTtF/y4suXHtXspxJV4qE78nhkOZ7Q9BR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VE1PR04MB6368.eurprd04.prod.outlook.com (2603:10a6:803:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 11:32:12 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::e180:2765:97f4:cae5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::e180:2765:97f4:cae5%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 11:32:12 +0000
Message-ID: <69bd66c8-d4f5-7649-33bc-71a507c65ce1@nxp.com>
Date:   Thu, 28 Oct 2021 14:32:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 4/5] soc: fsl: dpio: fix qbman alignment error in the
 virtualization context
Content-Language: en-US
To:     Leo Li <leoyang.li@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Youri Querry <youri.querry_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
 <20211018151034.137918-5-ioana.ciornei@nxp.com>
 <AS8PR04MB8946734C740B202DC3CA88F08F849@AS8PR04MB8946.eurprd04.prod.outlook.com>
From:   Diana Madalina Craciun <diana.craciun@nxp.com>
In-Reply-To: <AS8PR04MB8946734C740B202DC3CA88F08F849@AS8PR04MB8946.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0084.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::37) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
MIME-Version: 1.0
Received: from [192.168.1.211] (188.25.165.160) by AM0PR10CA0084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Thu, 28 Oct 2021 11:32:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567af497-14a9-4acd-94ce-08d99a069586
X-MS-TrafficTypeDiagnostic: VE1PR04MB6368:
X-Microsoft-Antispam-PRVS: <VE1PR04MB636842CBD47164F62A2F7FD9FF869@VE1PR04MB6368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHRrR0EIKOfgbWljcuPqXEb1MBRqvJq2VqtjaoiRAxiR3ee5hWOmuuU4UJnMFjgZJGKaW1KyDrs4/ajT4HGPyx6cnZxgw9sJSATB6GlzxC+i4dpm2Rn2dBZm/iUyKhgHjQJlVEYk6s3yQ+Ehj3yIWF/50p4vSk5MPjPS3meffWaaoLNxvOcox0qxo/kh3i77/yh91GH+pjQAXtRc2FH9fEGcneCDeDueZF1pRujOU685z0O5qYUMmhZZrTp5yEoJlzM397Oa78+4hz9jMhrMcnnJwEZCSNW3emdD2zl47t1Ds+BUty0PSGFsswiLqRI+7G3rtMNjcAgRn6j6WEuRqTQrKGko9V/5XuqMy00IeGp2hrKFlz5zHC3RroS8K5dpTU+ihc7sXgX+NXTeapjSjHhehK7hwuq4w3YvPX/+xN1rzkscV/so78B8Mui2+RCU+TLN7W73nAngQC6DPFqvVnHF1d2bPocBUF3YqO2xVk4PxxbwqDLnv8EednfFDDrp0zxDTQPF2D/KICMOH6Ou/i+gXNsZhewZ/7kQbFr4Cu4oe2ReiBskHgy+Wf6gfPdzVhOkuB9xt5tD1OtH+bkSulxOsoxuczgeJfPLCObUURZLhT1l8OnAQ2a5g2zkSQK8j1C3IQJTORovumT9PFucSqREWBdvVN6tNCJI5lIZ4UjEaw2EbWEbzWORmcopd25X6paVQdba3d1l8ok4/D6NP27t4ZgSDkqYLCN013BITFGRQuwNYBxKIdJRS56NN/hExlTFGlSQaHeOycmDeBbuJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(83380400001)(2616005)(36756003)(6636002)(38100700002)(38350700002)(316002)(8676002)(5660300002)(508600001)(66946007)(31686004)(66556008)(66476007)(2906002)(16576012)(53546011)(4326008)(110136005)(86362001)(8936002)(54906003)(52116002)(6486002)(31696002)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZPSVluZE0rVFZKMjNlWUo0ZE5kSEtycTlRZVlVeUNvcEJvdEkrUjR4bHkz?=
 =?utf-8?B?SVlleGZpNHo2eVJsc1RXajA1R3NIdDhsK3pFKzlCa3Z1LytsSjlmOWp4SnNR?=
 =?utf-8?B?dG04ZllSTDUwcXV2bG41T1dtM2plUUNxZENtN215R21vOHVDdHUxdG1vMmZu?=
 =?utf-8?B?ZUo0c0F2Z1pvaEZ3clJXUVZPUk82WVJjMFdYTlFJZVY4eDVOWFpOL284VGh4?=
 =?utf-8?B?RXl3TVhQL2dqSkUxTkxVeUo5OS8wbWFLakZNR1U4T3FiOW5oa3A1YWFVLzQv?=
 =?utf-8?B?UnBkM0V2cDEzSE5lbnpITTQrZHd3eDdQU2MyOU1CYVJ1NWtuZzRzOU9HSlF5?=
 =?utf-8?B?UzJyblBab1YyZURJOTlvYmc2MVhSZU1tQk55YjROalNIc0RWbmVYQkRHenB2?=
 =?utf-8?B?ei8zYjUvY3I0U0hMMkxhcHhJa3FWUyt0Wi9Gcm5vck5lSys0OUJva2JYa3dZ?=
 =?utf-8?B?SEpwVmVBSlE5NUtoRDJlSDN2ak1uZmtCbnN3TEZCdWhvQ09wdmd3YnNlU2Fq?=
 =?utf-8?B?VEJ4a0svbmhINUdWOEg1QzZMZ204TXJKU0xvcXRoQTk3VmgwTW9LWmswL2hS?=
 =?utf-8?B?NE1ibE9ud2crc0xzVGxqalhUQ1lPdXJWMFFHalRBWTdZQS9RTWpHTEJ1Wm9S?=
 =?utf-8?B?NVhWUHRFcERHM09Xb2phblpvRW42VXhsUjF3V29DMFlwMkF0T1ZYc3U3elRG?=
 =?utf-8?B?Zm1qdThrclRwRGJzVHc3ZTNnOHNkRXJRNnAzYjIzd0Q1Sm5CdFBtc2RQU0Js?=
 =?utf-8?B?UlBPQzViRk83K0ZZVGE2cHBPTEtTVm9LSjUwSGRkYWJEZ3pUZ09ZN3NTZlQv?=
 =?utf-8?B?OWlNS0dZQThTUXpGTFZEVXU3KzlFNEJWS3ZlRjZpZWNNRy8rSkViZmk2dVJl?=
 =?utf-8?B?RFFGRTBVUXFtUERTZk9GUW9IUDZwMDlQVFBJeEZyK0NTT1pYbkt6enhlVm9S?=
 =?utf-8?B?VER1T3JvZFNuUHF2NEhQZGphRzMwcG14ZEJEcTV5Nm9pajY5SWZSVXhNc1VS?=
 =?utf-8?B?YVRsc3I0b2pWSHBjZzQrbjFFaVFoOHAyZXZ0Mm5pVTVBSmRlcUpoeW1KRUkw?=
 =?utf-8?B?bUIwMksyNWd0eHE5QjBiRll3RGhUWHRxdXBBOXFMb3BnYkRqbTNzRmNLTEF1?=
 =?utf-8?B?Q2RPODRjVXJqQ0ZBN05qSnlCOGxCU3JpMHlycEtib0dLdkFxRlh0SVBrdnFL?=
 =?utf-8?B?LzVyb0RRVTNlOGFvblRzeW9Qd2trbnZqYlRLOE0rUG54MnhQbTRjdTdQZVZR?=
 =?utf-8?B?RzNEU0FBcGpYM2wvY1VJaWNyamd0ZGgwSVgxbXR0Z2JQS3ZBa0xGcGhEcnVm?=
 =?utf-8?B?LzQzSmp0bzNJaTVZM2hhQnZ0TTF0azNIRmZlQ3pLQjZxSzZPbnAvV2hjQWNq?=
 =?utf-8?B?MHJabHRtZG9vNUErVm84UHpXbEVndUpNeHFOYlZXWWhlZm8xeTBERDVZdmc3?=
 =?utf-8?B?bGl3OWRNN2VnWVN6UmVLWnVkcGQyamN1Y1lWZnZMU3U4TnE4d3J5ME1wT1Bi?=
 =?utf-8?B?aGQ3amtVeFM3VXlGcDlrRVRQME1vY3U2OE80Vnp3bjdXVnZxQ09ERlRCRmRB?=
 =?utf-8?B?QVZtZUl6emZXL2l4Umd2eUxta3hXS1dFUEgwMTlraEcxTzNvNTJsMEpaVTcv?=
 =?utf-8?B?V2hXLzlIS1F4dG80a1E0bi9FdUg1NHdwQXRxZGcxWUx0d3REc25Ha1pMYVhz?=
 =?utf-8?B?UXNESDhOd1R0Y2MzbGR6YVJiY3N4MjhFSzNDeTZWeUVGQUU1Y1JNOU1iQkpa?=
 =?utf-8?B?eFpINWRadVIvbmNOSkRiVnI4MWZqc2VLc09GWXZuZnpjL0RPNjhUVmhRdExH?=
 =?utf-8?B?aUFqRnQxK21MbEs3R29iYTlseE5VOC9HUWY0eFVMVXlnNHpHK0FDYkVCMzgx?=
 =?utf-8?B?STVKOGU4RUpKNVdRRTJvN3N2cWswSmVYdUxJZStJZjVRTHdkUVJFd0NjbWV2?=
 =?utf-8?B?aHNLMnQ4MUd6ZDNaNFVVL3lOTUdVL1diNWRFOTFCbUl1dWQrQ3BmOFRkOWVo?=
 =?utf-8?B?d3RiTVIzYVVkOXIrNktSdXd6V3d1a3pJU0FrTWxudXNVblZYajVmZm1qbjY4?=
 =?utf-8?B?aENXRTlnK0ZFWkV5ODlyQnJFbmRzNXphSkozaGhWMGhYNnk2YTRsdDlHQVFW?=
 =?utf-8?B?bGxBNXkvWWkvU1E5SFk0R2JsZnd0azZSMGlxemY4dWNRczE2VGV3K0tjM2du?=
 =?utf-8?Q?gEL9L//Ia0aL/YFYOjA6nXU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567af497-14a9-4acd-94ce-08d99a069586
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 11:32:12.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6A/7iatK/PkNsrIzfwgpwmGyaYD8kxZPvucrrydcIECz3JoV+jsTtlUw75n5+wk3LtZM7VAJ/+RIYmCplFCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6368
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Just drop this patch. I realize that the implementation is not correct. 
The problem should be resolved (if possible) elsewhere.

I will open another thread on the relevant lists regarding this problem.

Diana

On 10/27/2021 2:47 AM, Leo Li wrote:
>
>> -----Original Message-----
>> From: Ioana Ciornei <ioana.ciornei@nxp.com>
>> Sent: Monday, October 18, 2021 10:11 AM
>> To: Leo Li <leoyang.li@nxp.com>
>> Cc: Youri Querry <youri.querry_1@nxp.com>; linux-kernel@vger.kernel.org;
>> Diana Madalina Craciun <diana.craciun@nxp.com>; Ioana Ciornei
>> <ioana.ciornei@nxp.com>
>> Subject: [PATCH 4/5] soc: fsl: dpio: fix qbman alignment error in the
>> virtualization context
>>
>> From: Diana Craciun <diana.craciun@nxp.com>
>>
>> When running as a guest, under KVM, the CENA region is mapped as device
>> memory, so uncacheable. When the memory is mapped as device memory,
>> the unaligned accesses are not allowed.  Memcpy is optimized to transfer 8
>> bytes at a time regardless of the start address and might cause alignment
>> issues.
>>
>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> We get the following feedback from Arnd about this patch.  Could you respond to the comments?
>
> "This patch looks very suspicious to me, I don't think it's generally safe to
> use memcpy_toio() on a normal pointer, as the __iomem tokens may
> be in a separate address range, even though this currently works
> on arm64. Adding the  (__iomem void *) cast without a comment that
> explains why it's added seems similarly wrong, and finally the
> changeset text does not seem to match what the code does:
>
> According to the text, the pointer is to a virtual address mapped as
> "device memory" (i.e. PROT_DEVICE_nGnRE or PROT_DEVICE_nGnRnE),
> but the code suggests it's actually write-combining normal
> (PROT_NORMAL_NC)."
>
>> ---
>>   drivers/soc/fsl/dpio/qbman-portal.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c
>> b/drivers/soc/fsl/dpio/qbman-portal.c
>> index 3fd54611ed98..ef9cafd12534 100644
>> --- a/drivers/soc/fsl/dpio/qbman-portal.c
>> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
>> @@ -679,9 +679,9 @@ int qbman_swp_enqueue_multiple_direct(struct
>> qbman_swp *s,
>>   	for (i = 0; i < num_enqueued; i++) {
>>   		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
>> half_mask));
>>   		/* Skip copying the verb */
>> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
>> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
>> -		       &fd[i], sizeof(*fd));
>> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
>> EQ_DESC_SIZE_WITHOUT_FD - 1);
>> +		memcpy_toio((__iomem void
>> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
>> +			    &fd[i], sizeof(*fd));
>>   		eqcr_pi++;
>>   	}
>>
>> @@ -763,9 +763,9 @@ int
>> qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
>>   	for (i = 0; i < num_enqueued; i++) {
>>   		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
>> half_mask));
>>   		/* Skip copying the verb */
>> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
>> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
>> -		       &fd[i], sizeof(*fd));
>> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
>> EQ_DESC_SIZE_WITHOUT_FD - 1);
>> +		memcpy_toio((__iomem void
>> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
>> +			    &fd[i], sizeof(*fd));
>>   		eqcr_pi++;
>>   	}
>>
>> @@ -837,9 +837,9 @@ int
>> qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
>>   		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
>> half_mask));
>>   		cl = (uint32_t *)(&d[i]);
>>   		/* Skip copying the verb */
>> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
>> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
>> -		       &fd[i], sizeof(*fd));
>> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
>> EQ_DESC_SIZE_WITHOUT_FD - 1);
>> +		memcpy_toio((__iomem void
>> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
>> +			    &fd[i], sizeof(*fd));
>>   		eqcr_pi++;
>>   	}
>>
>> @@ -907,9 +907,9 @@ int
>> qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
>>   		p = (s->addr_cena + QBMAN_CENA_SWP_EQCR(eqcr_pi &
>> half_mask));
>>   		cl = (uint32_t *)(&d[i]);
>>   		/* Skip copying the verb */
>> -		memcpy(&p[1], &cl[1], EQ_DESC_SIZE_WITHOUT_FD - 1);
>> -		memcpy(&p[EQ_DESC_SIZE_FD_START/sizeof(uint32_t)],
>> -		       &fd[i], sizeof(*fd));
>> +		memcpy_toio((__iomem void *)&p[1], &cl[1],
>> EQ_DESC_SIZE_WITHOUT_FD - 1);
>> +		memcpy_toio((__iomem void
>> *)&p[EQ_DESC_SIZE_FD_START / sizeof(uint32_t)],
>> +			    &fd[i], sizeof(*fd));
>>   		eqcr_pi++;
>>   	}
>>
>> --
>> 2.33.1

