Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F05323370
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBWVs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:48:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhBWVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:47:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NLOf2I145609;
        Tue, 23 Feb 2021 21:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kRoOVAcOR+wj24IwgdyjdUiR+j+iwKnBzYAsNV/Obzc=;
 b=0bHCUqm5JJuQXY9PcJZ4mOPZOm8LS7lUcCGw+hpuPgLYsx9Y7DS5Fwmj1UxA0SaxzZfZ
 10ORBqVm5Q9qvDpEzCJtuql5fKwhLXrZh6hL3xU5FipG3YNjGUKHkt+cFSejHVi3lsC5
 /xo62gkKWYnCCt5dzh6B1btI6xQGdx90fnAVhMox0X2MwTVzblTCtJwWFRj/BPmg04Cj
 2+md7dDMnZXFsjricGIGE66+Z2As65blHSuv4+Iz/XMWe2yhya83k8FhaoNJs6Gl5/l2
 mC3fbZkkKoJB9dArW/SnenzHVq/rieLowQgQmLwKOR+D6L2YYtS/cpwDG8IHg65CQr9v dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36ugq3ftv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 21:46:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NLkQCe191617;
        Tue, 23 Feb 2021 21:46:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 36v9m55fvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 21:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji9kgzhwHcqEr/+Kp5l/wuACZTJAkWa4d6pl8Q9MeN/MOwPBirXGsgOk8HbOPUEmUj2Y3rSKKbLMjR+E4vp6BXTCiWGn4TDYFY0A92qY4F+Gb70Zk9njM3pMdQ19EJaOPVpVW3jLkw5LOE1GtMQM2d9ffdMChYHFCn/0uhFyE6yxGGShRMiIfAG8O2ONdZKamBLBkIVKsCIcLZfxdfiNTyt6OzlWXQa++5Ajktse0JOUwqCyH4o2ucOV+bEJWOjkzlBCxiU8vmGLPNyaD3M7WGrj8utap2Qlvu3ZgDeq8Q8coBRe/jPculPTCgqTrN9h6OHjsh0+83dPhMMYUeVXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRoOVAcOR+wj24IwgdyjdUiR+j+iwKnBzYAsNV/Obzc=;
 b=U0ahULKsgHG2bz7IwuqHIc3NUKl3vRfXXqq4LK25dP2YeO3gG/kh2GJ64GycFnnwXnaqhGMuw/8pIDXqPQsvy07XoJy0Jr8ah3wMHmudi8BwwPzGw5e/GQyar27/1fyaXmYy+y3Qy+36f9fDAmU6iWAsXhFEh5aHn/Lx5zbuwRKA7ImZOBids1i6Rt/fXBc1WMPw7z5t0/hYnVz4HPREetW++hR7h6NJmYbERskN1276vVygm/TfqhHVFVPD1Asj1b1k4LUodep7JLF3Qa5RCWgBLMw+ol2jjDxmpY0OSndIYaNQaDtcHjGkX9Vqp8B58ODvo8Qat3DfeDv1I+hVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRoOVAcOR+wj24IwgdyjdUiR+j+iwKnBzYAsNV/Obzc=;
 b=Z1jAYISuDdxmSZYiXkSPUEKruUHmooZlyoZoQBMES3jFZ6TTBmRxT/E9TvlUlE9OClfUVJRNDsaXfjNwUnG03vXsI0Kz/1AJ5t0ol9pu2OowNnGIG0cLfMumPKDC7323UuYokFbD3yn/oTFtVC2an3LbAnqOW6P45ou3TBMwhLA=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 23 Feb
 2021 21:46:34 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 21:46:34 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <56c97056-6d8b-db0e-e303-421ee625abe3@redhat.com>
 <cb8564e8-3535-826b-2d42-b273a0d793fb@oracle.com>
 <20210222215502.GB1741768@linux.ibm.com>
 <9773282a-2854-25a4-9faa-9da5dd34e371@oracle.com>
 <20210223103321.GD1741768@linux.ibm.com>
 <3ef9892f-d657-207f-d4cf-111f98dcb55c@oracle.com>
 <20210223154758.GF1741768@linux.ibm.com>
 <3a56ba38-ce91-63a6-b57c-f1726aa1b76e@oracle.com>
 <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
Date:   Tue, 23 Feb 2021 16:46:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210223213237.GI1741768@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BYAPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:a03:117::17) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by BYAPR08CA0040.namprd08.prod.outlook.com (2603:10b6:a03:117::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 21:46:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd3e2a0-319e-4d67-f64d-08d8d8447d0a
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB43130AE76838F6FF303540C5E6809@DM6PR10MB4313.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FwedqmYKr1bP2/TkEiUMFTm72cZAlGsq6bJ/NFnT1Tze0CN48Si9d2wUG4nPf0JXbAbVN0lDqkOOnLXGz9ZMd32jNO4luXvuNs1Bl0E/NuvphLy6sTVJ/KHEo17wS5S/IGcOV/v128ytw926+ziVGewdzTCVLRNlqITxJNemD4X04LRz7WqxiJq9OAH1MmSK5SILX1wPCh/WlqrRuF4z39NImUTh7PzS/UGrG1I04rQuULW46FIEFxBEDM6r4b+gB85zVFzr+4xxWPQb9z3438u12i30T+gL/kt+LGydyH1PsAb3BBbS82xx5ft7CogHYc4BHETn+jiNFJmXdYn4d9If//poRcPKH4NMGukqyvRoA5x467bgcfgKMbLh9aDMTuUwEFuB/ds3cQfiKDaXSqU4Rf3KZr+lfAAA86LixB1kq8GbFpfeby5x4A8ZIgdfSkU69Il9LSJ4TEUkBorFkyfXEP5wumzwOrZI+CmBUztlI8Uk6Gq5AnoqPIy7mn0pJDTKJ/7y88IHXYf2sYHjJqoiDpWOp87NM0tfv+j6Mo8OiWFFBXjfDV11ZZeEjCH+OBHW/iGhOySeMBSZs/X8LeZXoNtVCKJA60DbLDS8sU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(6486002)(86362001)(5660300002)(31696002)(44832011)(66946007)(36756003)(186003)(66556008)(16526019)(53546011)(66476007)(54906003)(83380400001)(107886003)(956004)(4326008)(31686004)(8676002)(2616005)(45080400002)(6916009)(26005)(36916002)(316002)(478600001)(16576012)(8936002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bVlibUkyK0xrbGNGOExveDhvT1JVeUFzSW1HbldxTnRKYmhjVlBHa1VNNHI5?=
 =?utf-8?B?dnNLTmVmYlB6NmMycjJkRnZySEVLTU4vZ0ViaVFzQ2hZNTlXbENvSHVVQW5F?=
 =?utf-8?B?T05acnRpZTMzZkJYMzhqd2I0RGFMU1lwN1BrR0lnUVVUUWFPR3dPaWw1ODVp?=
 =?utf-8?B?WGh4RDBzR1Bla2IyL3lCY3VVWlpPYlRyWWNacitzZ3hRZ0dVK3gzVTlOYjh5?=
 =?utf-8?B?WGRMY2ZMUUtLTDFTd2FpcllCekxjM2ZIbm42T2hBMy96YzE4cEttQ0lUWTdN?=
 =?utf-8?B?UmdiYkZVSnZvRE9rUVAzRWlPcGRONjFIdGJVdmVRbzdJbFZFc0dWWFpUa2Vh?=
 =?utf-8?B?MDZIdHRBdG8vWmg4T0JCYlFlc1FMS3VaSWFXV3R0S3dBRFpWQ3FqUE5iejVh?=
 =?utf-8?B?MFM5Zy9MM3M3UktBby9JLy9UT3dPSGkyYUtKQk8yb1Z5c1BJQ1NjNTFPZC9W?=
 =?utf-8?B?QlZBRy95Q0dwL2JyRWlkR0ZEMlRoRjRhWjY4eTRUWUtzaUQzNks5VU5vME1G?=
 =?utf-8?B?OEEzZVEyRHYvQTZKMjJNOExSWG5ZTmdkYTltSTF4aW4xcmM4alJyRi9rV0pD?=
 =?utf-8?B?QTNoR3VEMWp1N01uMWVaVFpyZENCNFduR2VaRzdTU3ZtTHNkalQ4eTMvRWFp?=
 =?utf-8?B?RVZuSURLOVBjUFA5VE1IcmR5Zllxd1dGMWh0UUltcjQrWnhrUEN0WlU3QkU3?=
 =?utf-8?B?UW96TGlKdENmWHB0K2RUY3A3RGY2cXZ1c25SaHN3b09ua1lIZFBZZ3pxQ1VF?=
 =?utf-8?B?MytWb1Q2REdyZmJDa1J2MTdRYmRsQjRJQ1l1YlhNL25IazN6UXhTU2VDdWhL?=
 =?utf-8?B?UGxPYVNOY0NjOXRTdHRpZDE5Sk1qeGViSUd3VTNDWmtUakJmSGRXdU15WnFS?=
 =?utf-8?B?VTc2T2JGY3doclV1bVhTakV4NUs5cFZpeXpXVzAySmc3dUVYN24wYTBsVmM5?=
 =?utf-8?B?UVVHTkJpMzV3TE5OZVlhN2dPRnVId0NQSDhOcHNqK1BvMzhNdkdBV2N5ajRI?=
 =?utf-8?B?WHMwYlI2NUh5M2JqYlBGZDU0QTNINVNCRUtXNHB4N2x4TDVWUFhYVUNIOXlS?=
 =?utf-8?B?Z0ZFdjNaMUZTbDZyTENvem5lbmxwdEIyNWxmVVdHNER5cFVDN2NTRDJJTlhv?=
 =?utf-8?B?MHhmaWZGSytrYVRmbmgrM2NXd21tY3JyOXQ1eC9nNVRBWmVET1ZhTXFuUnJZ?=
 =?utf-8?B?d05PMEpSRzljaHhIYlJxdGtvdnNqa0NDVnhuMFpnRnFJSnJJejZUd0R3THFH?=
 =?utf-8?B?cUxISXFoRjR6VkVZcnNCQmFuTmlES0dYZURoekppKzFFbFRqUVZrQ2lFeWVo?=
 =?utf-8?B?QlhtdHN5c25GSUhYRm5RU3FjYjBDMzNuL2ZlaVVqcmZaaXRWZWZaclh1ekdr?=
 =?utf-8?B?U0VnRXQyOVRHTzRkY0JJTDlYRk81eVVueDRBWVM0Um8xYU1sVG9rNm95VzFr?=
 =?utf-8?B?bjAzckx4U2p3OEtWMU1SRHl3a3JualJhdW0zMmN4ekpja3lVcndhVjdhSmx3?=
 =?utf-8?B?NGs3L0VCMWdCd1dDUmNwWjB6ZVlZQWJVL2l3NEt3THJDMFZQa1JQc3FrTThz?=
 =?utf-8?B?S2VUUHpDZ2g3d0MvdWkxSFhhMk1tNEtndEdCVkdtWGRZK2FiZlN2ZndCcis2?=
 =?utf-8?B?WWFMYWN2bkgvTTM3YUp5NHU0NThvWTRLMEwwYjgzRTNhcy9KVlQyTlp5SHFP?=
 =?utf-8?B?K2VWWG5HRVI1Vjh3Tm5DZWVjQlBLUzAzaWxGNkpFb0lqakR3T0ZxNmMzenVD?=
 =?utf-8?Q?9XiN2NxxScpi47Hc5RsBCHosc9sUmKjXWD/3Wqc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd3e2a0-319e-4d67-f64d-08d8d8447d0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 21:46:34.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnmA8ae+yXcwUtixHSPtxtVWjUfygfZhWx31OD7PY2kOSwxEs/ZMX3nXaxC56d+7Ilys23XHF/lB8IZIudKAjX0LcsQtGgjckjfCqf+sdv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4313
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230182
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2021 4:32 PM, Mike Rapoport wrote:
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 7bdc0239a943..c118dd54a747 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
>   	if (acpi_disabled)
>   		return;
>   
> +#if 0
>   	/*
>   	 * Initialize the ACPI boot-time table parser.
>   	 */
> @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
>   		disable_acpi();
>   		return;
>   	}
> +#endif
>   
>   	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>   
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d883176ef2ce..c8a07a7b9577 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1032,6 +1032,14 @@ void __init setup_arch(char **cmdline_p)
>   	 */
>   	find_smp_config();
>   
> +	/*
> +	 * Initialize the ACPI boot-time table parser.
> +	 */
> +	if (acpi_table_init()) {
> +		disable_acpi();
> +		return;
> +	}
> +
>   	reserve_ibft_region();
>   
>   	early_alloc_pgt_buf();
> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
> index 64bb94523281..1be7481d5c69 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -80,6 +80,27 @@ static int __init find_ibft_in_mem(void)
>   done:
>   	return len;
>   }
> +
> +static void __init acpi_find_ibft_region(unsigned long *sizep)
> +{
> +	int i;
> +	struct acpi_table_header *table = NULL;
> +	acpi_status status;
> +
> +	if (acpi_disabled)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> +		status = acpi_get_table(ibft_signs[i].sign, 0, &table);
> +		if (ACPI_SUCCESS(status)) {
> +			ibft_addr = (struct acpi_table_ibft *)table;
> +			*sizep = PAGE_ALIGN(ibft_addr->header.length);
> +			acpi_put_table(table);
> +			break;
> +		}
> +	}
> +}
> +
>   /*
>    * Routine used to find the iSCSI Boot Format Table. The logical
>    * kernel address is set in the ibft_addr global variable.
> @@ -91,14 +112,16 @@ unsigned long __init find_ibft_region(unsigned long *sizep)
>   	/* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
>   	 * only use ACPI for this */
>   
> -	if (!efi_enabled(EFI_BOOT))
> +	if (!efi_enabled(EFI_BOOT)) {
>   		find_ibft_in_mem();
> -
> -	if (ibft_addr) {
>   		*sizep = PAGE_ALIGN(ibft_addr->header.length);
> -		return (u64)virt_to_phys(ibft_addr);
> +	} else {
> +		acpi_find_ibft_region(sizep);
>   	}
>   
> +	if (ibft_addr)
> +		return (u64)virt_to_phys(ibft_addr);
> +
>   	*sizep = 0;
>   	return 0;
>   }
>   
Mike,

Still no luck.

[   30.193723] iscsi: registered transport (iser)
[   30.195970] iBFT detected.
[   30.196571] BUG: unable to handle page fault for address: 
ffffffffff240004
[   30.196824] #PF: supervisor read access in kernel mode
[   30.196824] #PF: error_code(0x0000) - not-present page
[   30.196824] PGD 24e34067 P4D 24e34067 PUD 24e36067 PMD 27a0e067 PTE 0
[   30.196824] Oops: 0000 [#1] SMP KASAN PTI
[   30.196824] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.11.0-f9593a0 #10
[   30.196824] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.0.0 02/06/2015
[   30.196824] RIP: 0010:ibft_init+0x13d/0xc33
[   30.196824] Code: c1 40 84 ce 75 11 83 e0 07 38 c2 0f 9e c1 84 d2 0f 
95 c0 84 c1 74 0a be 04 00 00 00 e8 77 f2 5f ef 49 8d 7f 08 b8 ff ff 37 
00 <4d> 63 6f 04 48 89 fa 48 c1 e0 2a 48 c1 ea 03 8a 04 02 48 89 fa 83
[   30.196824] RSP: 0000:ffff888100fafc30 EFLAGS: 00010246
[   30.196824] RAX: 000000000037ffff RBX: ffffffff937c6fc0 RCX: 
ffffffff815fcf01
[   30.196824] RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 
ffffffffff240008
[   30.196824] RBP: ffff888100fafcf8 R08: ffffed10201f5f12 R09: 
ffffed10201f5f12
[   30.196824] R10: ffff888100faf88f R11: ffffed10201f5f11 R12: 
dffffc0000000000
[   30.196824] R13: ffff888100fafdc0 R14: ffff888100fafcd0 R15: 
ffffffffff240000
[   30.196824] FS:  0000000000000000(0000) GS:ffff88810ad80000(0000) 
knlGS:0000000000000000
[   30.196824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.196824] CR2: ffffffffff240004 CR3: 0000000024e30000 CR4: 
00000000000006e0
[   30.196824] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   30.196824] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   30.196824] Call Trace:
[   30.196824]  ? write_comp_data+0x2f/0x90
[   30.196824]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   30.196824]  ? ibft_check_initiator_for+0x159/0x159
[   30.196824]  ? dmi_setup+0x46c/0x46c
[   30.196824]  ? write_comp_data+0x2f/0x90
[   30.196824]  ? ibft_check_initiator_for+0x159/0x159
[   30.196824]  do_one_initcall+0xc4/0x3e0
[   30.196824]  ? perf_trace_initcall_level+0x3e0/0x3e0
[   30.196824]  ? asm_sysvec_error_interrupt+0x10/0x20
[   30.196824]  ? do_one_initcall+0x18c/0x3e0
[   30.196824]  kernel_init_freeable+0x596/0x652
[   30.196824]  ? console_on_rootfs+0x7d/0x7d
[   30.196824]  ? __sanitizer_cov_trace_pc+0x21/0x50
[   30.196824]  ? rest_init+0xf0/0xf0
[   30.196824]  kernel_init+0x16/0x1d0
[   30.196824]  ? rest_init+0xf0/0xf0
[   30.196824]  ret_from_fork+0x22/0x30
[   30.196824] Modules linked in:
[   30.196824] Dumping ftrace buffer:
[   30.196824]    (ftrace buffer empty)
[   30.196824] CR2: ffffffffff240004
[   30.196824] ---[ end trace 293eae51adac1398 ]---
[   30.196824] RIP: 0010:ibft_init+0x13d/0xc33
[   30.196824] Code: c1 40 84 ce 75 11 83 e0 07 38 c2 0f 9e c1 84 d2 0f 
95 c0 84 c1 74 0a be 04 00 00 00 e8 77 f2 5f ef 49 8d 7f 08 b8 ff ff 37 
00 <4d> 63 6f 04 48 89 fa 48 c1 e0 2a 48 c1 ea 03 8a 04 02 48 89 fa 83
[   30.196824] RSP: 0000:ffff888100fafc30 EFLAGS: 00010246
[   30.196824] RAX: 000000000037ffff RBX: ffffffff937c6fc0 RCX: 
ffffffff815fcf01
[   30.196824] RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 
ffffffffff240008
[   30.196824] RBP: ffff888100fafcf8 R08: ffffed10201f5f12 R09: 
ffffed10201f5f12
[   30.196824] R10: ffff888100faf88f R11: ffffed10201f5f11 R12: 
dffffc0000000000
[   30.196824] R13: ffff888100fafdc0 R14: ffff888100fafcd0 R15: 
ffffffffff240000
[   30.196824] FS:  0000000000000000(0000) GS:ffff88810ad80000(0000) 
knlGS:0000000000000000
[   30.196824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.196824] CR2: ffffffffff240004 CR3: 0000000024e30000 CR4: 
00000000000006e0
[   30.196824] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   30.196824] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   30.196824] Kernel panic - not syncing: Fatal exception
[   30.196824] Dumping ftrace buffer:
[   30.196824]    (ftrace buffer empty)
[   30.196824] Kernel Offset: disabled
[   30.196824] Rebooting in 1 seconds..

George
