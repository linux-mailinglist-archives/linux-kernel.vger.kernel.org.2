Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2763EBED4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhHMXlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:41:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62428 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235330AbhHMXlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:41:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DNWuLA010367;
        Fri, 13 Aug 2021 23:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CdXaAeQXJ4oYatczkfWQsCkmG4krOq2Oz1h007j8i/M=;
 b=O2LNTINziZqOQ0vzk+AHx0vOoEBmyTPfm1nuQMsDb1sXSP9nHjp6XUouqGAc0Y3ukvQc
 V0mNDzJQGoxMMS5OxhyIyV4KuhnR6wPmtfiKelrZfu4kydghimhfBY18HXc7m0zepJCF
 KyJqGwsPkKqMjG6EOiFys9VFHX6QtWSFbiFjcghEusGtbsIQ8Z5sjelHHCmvZ/RQ+shx
 NpcwOWyXVPmxqYDfDHdNF0GfpC6nq8KG1V7Cca3lUgKI7C3uS6VKRGEbFc8Z04gGlXIQ
 29A4lGi8mpeDZoqOKdu+gN3gw6yWxZk/dkcVALPL93Y8tNfWQAdvNje8vniAwziP7AVO 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CdXaAeQXJ4oYatczkfWQsCkmG4krOq2Oz1h007j8i/M=;
 b=cuSAnMUT4MaNU3X+Po2nahX6SCIfnq5i/Q0TaaWJCWKfhqZsKBt/tPw6z73y12lG4D9r
 gEI5tn9eHpWNEWPVkjOv7sLANABkDdZoEVqPz/5J5ItHdpznRZcDFRcegihpo7NOR/gZ
 QRtcB+yczwa39nCVEq5tnF2gKdkFi7h98imtf/Hn3wCepXazRV5Pc6B8KUA/jxI5KjYm
 e0bTJ2kiaYSLWZGWeJ45sAf6cIUQpfgTLO9VII8GR6rhoTilzRJ5izQ2uIyQcw3pbwmb
 GP5XTFmp8l/iWMORm9o0Hce0Dj6Avdwh2k3ysbcotMp6CrVzDvxTURBGt3IlG4KZZfMz Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad2ajma3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 23:40:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DNeZKd100844;
        Fri, 13 Aug 2021 23:40:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by aserp3020.oracle.com with ESMTP id 3accrexhdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 23:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSTJ5/e+5jLZhk/B9Z2uWQKUTZOG75nEnp4JuKtUgGd8nh5r1wgjqR4Zdd6MHCBmRy/acOF9T+Zh+UtfxtqDXWLpKSrsRUZlo3xGPVdpp+nWw1++QkOVVfQezJnWE/RWPK2DKmPann7N5EHhEoASbPtKVfaK8woBpUZCeujQDCKzm+IE+ppnkdaLug23+xzCavDNd+wktTrTsa8YIJ1MGYF/r29kDE/IPaIvVWQWBJXG/dX45wUeiWRmi2DOnqAzb6+YXywM7yarFrS+OvaDHsiDkO89AWAQUqvtXYEmAjDtrJ2VQbyncgDV0iFE+XLzvKmHdiTRJ0e0s87J3xATWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdXaAeQXJ4oYatczkfWQsCkmG4krOq2Oz1h007j8i/M=;
 b=HsFItEDlp6TETIwhGO71RWQ3JzGBGmW3kiwHPHTRW3oJbKYYMX3Ll7vrtULitZeens17E9hpOezJvH1oPn8xxzmBcbhYKj43JGPMpAeJpj4llNDG6rrVR/PuYjSXRvIqQ2fE2RbRqrvIyxrIKBO5Lps7q40zv581T7srRVzsUuZ+CipxRjs0vB70T1bq36s1x0NKnmaFenzoFfeXcVMufVIo04g57xbyU0+cwdPfKt1E6JTifvqBFfb5uoQAw6IOAycfd082cCUUZ78FMmMxIMMYoAh3ZHgbNxPcRKSbeFe5IboJGmJccZNP5Wn2S8ZSFkWv7zcZyzRwcibYP1Zw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdXaAeQXJ4oYatczkfWQsCkmG4krOq2Oz1h007j8i/M=;
 b=t5V2K879Yo2W2UjMmTYPJo8RGM/GNMHYuXP8KR6EhXJHTMK06RZgahNKtSv+OrWHnpbwq3SaEtytN+FS4UHyXOn2Uns5LzIh4ET7ETfV8Q+TLHQiLCmUDk/67yASkBWkrpjHFaRncXPbbvwzy7CWCab0g9T7+9RFWXnifJaw+TU=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Fri, 13 Aug
 2021 23:40:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 23:40:35 +0000
Subject: Re: [PATCH v2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
References: <20210811011056.770351-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9f76b103-ba81-d4e3-1071-89009fb585a5@oracle.com>
Date:   Fri, 13 Aug 2021 16:40:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210811011056.770351-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:303:b5::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 23:40:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 439e44e6-2216-446a-7b93-08d95eb3bf92
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:
X-Microsoft-Antispam-PRVS: <BYAPR10MB299995AA826A7305002DCD03E2FA9@BYAPR10MB2999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEWVoCoEvk4vzYPRqt/Phm7a3TSA5FlTw70gwGaSRXN17x8EY8Prrd0SSR6fGVyVTipKoN0nn2CfvilnRrj5p2306cTgNO/KWps/YcS/J/rd9tGyqwvauAAcxf5PXrnykfYN8Pu+26TT3IbZhnYLNjITg3QINu3By2S/S7zX/ua/nBcTSbo3Xr2xtH1SAkYJCEtf1gZ4o7MzU/a6GyaP6oG8DpASmzSo/Med/VMKRsEKuCBiPjDz196aMaiz2F/pXNX/49qkB0yDU9NUZW/8ttS0G5dPADnoJ5QbixtokE2a0Ugbx1dWqG8/feCmDC/f15Qqg3bsOYXH7ukxapZ2BVm38je+dweWj+05wzO4x0HOMhOjZzTnwyQINDRw08Y9YLBN5QOEr1RDwYba9zr36DJTPk5SirEUd3DzIlENUONaWs2strqRDwwclRj7h9pB20GvwQCG9A3ZYRphe0KggiigRb86jDn3PMDMnzRcOTjFx7LH8s0s2EjmtS6suDm6ZJobYk55HWXQe1G0y8edf3kgAXe+U8eBz3lq/DndCSTIGhe8ASzbkXGKsUhR99yxQ8i5GORKtTTYPajPW+uL+K2KyvIdJg4nwoZmjQ9aZo3Bst7B12559ebVNxnNyfQ7vINVopVK7mGxRIJt2XzMPS3iIagKSnTJIBR5zWdLbXoBh5dRn/cYGhD0Tp1VtXll8/LgM1ly/QipyTdQTVLOAn9V3lJgTC92FK9pJijlcFRUap9N25nktfVBpq1R1qovFkAjiRn6DwVvdXlb2S2e56znmBTSS6YG8Ux0KwTLja6/s2DU+WGgFK78i9c6GmTS0RBHGBr8Q0Yi8GaufR1wCtS/Uhtjf7f+oyn6p6ffhx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(26005)(2616005)(956004)(86362001)(38100700002)(186003)(2906002)(38350700002)(83380400001)(44832011)(6486002)(30864003)(8676002)(31686004)(4326008)(52116002)(31696002)(53546011)(16576012)(8936002)(478600001)(5660300002)(966005)(6916009)(54906003)(316002)(66946007)(66476007)(66556008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVh0S25qNTZ4emhJZUMxL25JTmVrS215bVRIT0N6K21lU1FVcDlDTUhieHJF?=
 =?utf-8?B?WTJ2eUNiMzlsaTFmZldOWVJBaGpkNnRVYm9vRWVWYnFtSnNTT0JVSVJPMEox?=
 =?utf-8?B?RXY2MzRVTmZQbGlKcmtzQThzOFhGMUlSR2xUNkJpNVgwYXJnMzhJSmt0TnQx?=
 =?utf-8?B?SXk1enNaYzcyUEdkdTQ0Tjd3N2FzeVgxVjlyZUZjUGw2c3ovVjFpYzZZRFcx?=
 =?utf-8?B?MlBMWnN3NmduS1VjVEFsSlpoUTVhVitOa0Z2NFdRMDRyWS9oOTNvMnZtNDF3?=
 =?utf-8?B?Q3BZMEYwR2h6VzlYMFR1Z3BFOGtzMWkwL2M4Q2hrMGwrcCtmUmRuT1BlQWxO?=
 =?utf-8?B?UnZOaDhJSUpCNXdscGt2bzBiMUZISStyMFQ0TTVLcnFXWUc3Mll3RXVYUWFl?=
 =?utf-8?B?NzNQZnhYRG1hd1k1NkFFWHR4TXZWOFVpc2V2WUtVTUtQRGFteDRUY0dXTlgz?=
 =?utf-8?B?ZUhpUDZlNm9WT0lubmtvT1NHUW9tM3BPaGR1NkZYbTl1Mk5qSjR1Z09ycTJE?=
 =?utf-8?B?WjR3b0hySzZ2bVZpd2p2NjFNTk51WW9FVzR3OGRqRUdBN1Ura2JBQmtmWTBm?=
 =?utf-8?B?cCtQbWNQamN3Q051WVpIeWFVOWhpL3pVb21DQnlMYkxIakJyTGdIMWlHRHhn?=
 =?utf-8?B?VWFWQ3dtRW9tZU1kVFdYSGNkOVBqMmZpay8rclB1WE1nMFVwOEVGRzZPelVE?=
 =?utf-8?B?NlA1YzQzT24xNjJPL0FWemZjQk1neng5WWhFcnQ5a1N6bHBwaTFXRGRwUjZv?=
 =?utf-8?B?bDVjNUVhSHc1dStqdWVsQ1RPM0VKV3FoM2VhVTk2R0JWZ09wSGdiUnVWRTFQ?=
 =?utf-8?B?ZVBSS0VyUm1vUVZGTFViL0ZxNU9wK1J3SEhzaVB4ejgzTjhDaVQ3OVhPUGxw?=
 =?utf-8?B?d1Yzc0JWV2orUjkweGFlYSs1UVhxbHZlY2xmUlBXQk5EM3FPdFFvd2E5Q0Mz?=
 =?utf-8?B?YmdhcmxVQmdnUkVyK2pBeHpOSU9lek15N05yR09idk11REhIbUdyeG95c3oz?=
 =?utf-8?B?N0VkVVcyOTBYMmVnUlBiQ2VZU2grMjE3OFJnMC9NRGlhNndPUFV6WFZjenZY?=
 =?utf-8?B?bU1kWS83a2hScHh4UXZkV2dVcmZ1bnNLak9ZaE1CRVBqK2Erd0p2MGN5K3dZ?=
 =?utf-8?B?cTRHVTFhaEJsSVdjMTg4RTJNWE1Mc2c1K0dOZndUaWhXVlI3N2ZlUDJMM1I5?=
 =?utf-8?B?Ynd0Z3p5VXFEY1NQSEJNK0VESFk2QVJiNkZFUkhKL2E2d1NtVnd6bUlVQVZl?=
 =?utf-8?B?bWFTemN6dlpLenZEQlNRNXpNSnZabWJUd3BZWXJQVk4ySkJYT2MwQXhqci9i?=
 =?utf-8?B?QlFPbTR5VFdjYnZvSUxkOUY2V2xMaVlOVk5LVTNqTVd0ejlpWmNCQkYyVmUw?=
 =?utf-8?B?ZW1aem4vTWwrMjRYY296RXRaZGZoK1dTYVl1ejA3YzdIWEsrZTM4ZEgxb0pT?=
 =?utf-8?B?a2NnTjZtQjJaWlhiMWVQTzVla055Q3Fwc0ZhMFVWdjRwMmthNDUzN2ZDRmZX?=
 =?utf-8?B?bDR4UyswUlBZZUJJSlJYc3QwMmxRWWlDc2F3T0ZvcUExSDNsdHc5VWZlekIr?=
 =?utf-8?B?MURVTFlNckREckZ0alpVSi9WK3ZHcEgxbFgzcWg2QnJlZGF2d0pUNGZUeEMr?=
 =?utf-8?B?bTF4NGVuZmdNL3p6MHh3bXBvNExoY1ZZTDlSOUJCVi9rdEQ5YkY2Vk83MjF0?=
 =?utf-8?B?MGZKOXlyaXFzVnZ6OC9SMUlLcFBNVy8xOWtFZ1drVUQzU0V0UE5vL0NVc0t3?=
 =?utf-8?Q?M38qx0nsjGeyAeUP4rTqmnzCTUjbV5hlRvK4Nv+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e44e6-2216-446a-7b93-08d95eb3bf92
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 23:40:35.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyrXroPgT6at/1yxMmzAt1kU9Liu395h6emEAVrg5+Np2r8QRghieV4zb4W+8Hphq8k0SUORB1AP585Qn75VkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2999
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130140
X-Proofpoint-ORIG-GUID: AADiosSz61RvrGBILb0Yrx_y_JDgxAMp
X-Proofpoint-GUID: AADiosSz61RvrGBILb0Yrx_y_JDgxAMp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Michal, Vlastimil and Kirill as adding this type of support
was discussed in this thread:
https://lore.kernel.org/linux-mm/3ba05809-63a2-2969-e54f-fd0202fe336b@gmx.de/

On 8/10/21 6:10 PM, Mina Almasry wrote:
> Support mremap() for hugepage backed vma segment by simply repositioning
> page table entries. The page table entries are repositioned to the new
> virtual address on mremap().
> 
> Hugetlb mremap() support is of course generic; my motivating use case
> is a library (hugepage_text), which reloads the ELF text of executables
> in hugepages. This significantly increases the execution performance of
> said executables.
> 
> Restricts the mremap operation on hugepages to up to the size of the
> original mapping as the underlying hugetlb reservation is not yet
> capable of handling remapping to a larger size.

We will need to document this in the man page.

> 
> During the mremap() operation we detect pmd_share'd mappings and we
> unshare those during the mremap(). On access and fault the sharing is
> established again.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Ken Chen <kenchen@google.com>
> Cc: Chris Kennelly <ckennelly@google.com>
> 
> ---
> 
> Changes in v2:
> - Re-wrote comment around clear_vma_resv_huge_pages() to make it clear
> that the resv_map has been moved to the new VMA and why we need to clear it
> from the current VMA.
> - We detect huge_pmd_shared() pte's and unshare those rather than bug on
> hugetlb_vma_shareable().
> - This case now returns EFAULT:
>  if (!vma || vma->vm_start > addr)
>              goto out;
> - Added kselftests for mremap() support.
> 
> ---
>  include/linux/hugetlb.h                      |  24 +++
>  mm/hugetlb.c                                 | 125 +++++++++++++-
>  mm/mremap.c                                  |  30 +++-
>  tools/testing/selftests/vm/.gitignore        |   1 +
>  tools/testing/selftests/vm/Makefile          |   1 +
>  tools/testing/selftests/vm/hugepage-mremap.c | 163 +++++++++++++++++++
>  tools/testing/selftests/vm/userfaultfd.c     |   0

I don't think you intended to submit a mode change to userfaultfd.c?

I would prefer to see the testing changes in a separate patch.

>  7 files changed, 337 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/hugepage-mremap.c
>  mode change 100644 => 100755 tools/testing/selftests/vm/userfaultfd.c
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a3870ea5..62da774802715 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
>  void hugepage_put_subpool(struct hugepage_subpool *spool);
> 
>  void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
> +void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
>  int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
>  int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> @@ -132,6 +133,8 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
>  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> 
> +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
> +			     unsigned long new_addr, unsigned long len);
>  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
>  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>  			 struct page **, struct vm_area_struct **,
> @@ -190,6 +193,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  				unsigned long *addr, pte_t *ptep);
> +int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end);
>  struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
> @@ -211,6 +215,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
> 
>  bool is_hugetlb_entry_migration(pte_t pte);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> +bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr);
> +
> 
>  #else /* !CONFIG_HUGETLB_PAGE */
> 
> @@ -218,6 +224,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
>  {
>  }
> 
> +static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> +{
> +}
> +
>  static inline unsigned long hugetlb_total_pages(void)
>  {
>  	return 0;
> @@ -229,6 +239,10 @@ static inline struct address_space *hugetlb_page_mapping_lock_write(
>  	return NULL;
>  }
> 
> +static int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep) {
> +	return 0;
> +}
> +
>  static inline int huge_pmd_unshare(struct mm_struct *mm,
>  					struct vm_area_struct *vma,
>  					unsigned long *addr, pte_t *ptep)
> @@ -265,6 +279,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
>  	return 0;
>  }
> 
> +#define move_hugetlb_page_tables(vma, old_addr, new_addr, len)                 \
> +	({                                                                     \
> +		BUG();                                                         \
> +		0;                                                             \
> +	})
> +
>  static inline void hugetlb_report_meminfo(struct seq_file *m)
>  {
>  }
> @@ -402,6 +422,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
> 
>  static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
> 
> +bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr) {
> +	return 0;
> +}
> +
>  #endif /* !CONFIG_HUGETLB_PAGE */
>  /*
>   * hugepages at page global directory. If arch support
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 528947da65c8f..aac3308037ae4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1004,6 +1004,35 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
>  		vma->vm_private_data = (void *)0;
>  }
> 
> +/*
> + * Reset and decrement one ref on hugepage private reservation.
> + * Called with mm->mmap_sem writer semaphore held.
> + * This function should be only used by move_vma() and operate on
> + * same sized vma. It should never come here with last ref on the
> + * reservation.
> + */
> +void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * Clear the old hugetlb private page reservation.
> +	 * It has already been transferred to new_vma.
> +	 *
> +	 * During a mremap() operation of a hugetlb vma we call move_vma()
> +	 * which copies *vma* into *new_vma* and unmaps *vma*. After the copy
> +	 * operation both *new_vma* and *vma* share a reference to the resv_map
> +	 * struct, and at that point *vma* is about to be unmapped. We don't
> +	 * want to return the reservation to the pool at unmap of *vma* because
> +	 * the reservation still lives on in new_vma, so simply decrement the
> +	 * ref here and remove the resv_map reference from this vma.
> +	 */
> +	struct resv_map *reservations = vma_resv_map(vma);
> +
> +	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> +		kref_put(&reservations->refs, resv_map_release);
> +
> +	reset_vma_resv_huge_pages(vma);
> +}
> +
>  /* Returns true if the VMA has associated reserve pages */
>  static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  {
> @@ -4429,6 +4458,79 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	return ret;
>  }
> 
> +static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
> +			  unsigned long new_addr, pte_t *src_pte)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct mm_struct *mm = vma->vm_mm;
> +	pte_t *dst_pte, pte;
> +	spinlock_t *src_ptl, *dst_ptl;
> +
> +	/* Shared pmd's need to be unshared, not moved, and we should never
> +	 * reach here.
> +	 */
> +	BUG_ON(huge_pmd_shared(vma, src_pte));

IMO, the BUG_ON and huge_pmd_shared are overkill.  There is only one
caller of move_huge_pte and we unshared before calling here.

> +
> +	dst_pte = huge_pte_offset(mm, new_addr, huge_page_size(h));
> +	dst_ptl = huge_pte_lock(h, mm, dst_pte);
> +	src_ptl = huge_pte_lockptr(h, mm, src_pte);
> +	/*
> +	 * We don't have to worry about the ordering of src and dst ptlocks
> +	 * because exclusive mmap_sem (or the i_mmap_lock) prevents deadlock.
> +	 */
> +	if (src_ptl != dst_ptl)
> +		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> +
> +	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> +	set_huge_pte_at(mm, new_addr, dst_pte, pte);
> +
> +	if (src_ptl != dst_ptl)
> +		spin_unlock(src_ptl);
> +	spin_unlock(dst_ptl);
> +}
> +
> +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
> +			     unsigned long new_addr, unsigned long len)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +	unsigned long sz = huge_page_size(h);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long old_end = old_addr + len;
> +	unsigned long old_addr_copy;
> +	pte_t *src_pte, *dst_pte;
> +	struct mmu_notifier_range range;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
> +				old_end);
> +	mmu_notifier_invalidate_range_start(&range);

The range to invalidate may be larger than [old_addr - old_end] in the
case of shared pmds.  See try_to_unmap_one()'s use of
adjust_range_if_pmd_sharing_possible().

> +	/* Prevent race with file truncation */
> +	i_mmap_lock_write(mapping);
> +	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> +		src_pte = huge_pte_offset(mm, old_addr, sz);
> +		if (!src_pte)
> +			continue;
> +		if (huge_pte_none(huge_ptep_get(src_pte)))
> +			continue;
> +
> +		old_addr_copy = old_addr;

A comment on the need/use of old_addr_copy would be useful for the
casual reader.

> +
> +		if(huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
> +			continue;
> +
> +		dst_pte = huge_pte_alloc(mm, vma, new_addr, sz);

This should be passed the destination vma.  Since the vma argument is
only used in the case of pmd sharing, and we just unshared one line
above, you get away with passing the incorrect vma.  However, this is
wrong and should be changed.

> +		if (!dst_pte)
> +			break;
> +
> +		move_huge_pte(vma, old_addr, new_addr, src_pte);
> +	}
> +	i_mmap_unlock_write(mapping);
> +	flush_tlb_range(vma, old_end - len, old_end);
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return len + old_addr - old_end;
> +}
> +
>  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			    unsigned long start, unsigned long end,
>  			    struct page *ref_page)
> @@ -5900,7 +6002,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	return saddr;
>  }
> 
> -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	unsigned long base = addr & PUD_MASK;
>  	unsigned long end = base + PUD_SIZE;
> @@ -5919,7 +6021,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
>  #endif
> -	return vma_shareable(vma, addr);
> +	return hugetlb_vma_shareable(vma, addr);
>  }
> 
>  /*
> @@ -5963,8 +6065,8 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>   * NOTE: This routine is only called from huge_pte_alloc.  Some callers of
>   * huge_pte_alloc know that sharing is not possible and do not take
>   * i_mmap_rwsem as a performance optimization.  This is handled by the
> - * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
> - * only required for subsequent processing.
> + * if !hugetlb_vma_shareable check at the beginning of the routine. i_mmap_rwsem
> + * is only required for subsequent processing.
>   */

This comment is obsolete.  Sorry!

The check for !vma_shareable no longer exists.  No need to update an
obsolete comment.  Please remove the entire NOTE.

>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud)
> @@ -6042,7 +6144,22 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return 1;
>  }
> 
> +int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep)
> +{
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +	BUG_ON(page_count(virt_to_page(ptep)) == 0);
> +	if (page_count(virt_to_page(ptep)) == 1)
> +		return 0;
> +
> +	return 1;
> +}
> +
>  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> +static bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return false;
> +}
> +
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud)
>  {
> diff --git a/mm/mremap.c b/mm/mremap.c
> index badfe17ade1f0..5f3a7f9362865 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -489,6 +489,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	old_end = old_addr + len;
>  	flush_cache_range(vma, old_addr, old_end);
> 
> +	if (is_vm_hugetlb_page(vma))
> +		return move_hugetlb_page_tables(vma, old_addr, new_addr, len);
> +
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
>  				old_addr, old_end);
>  	mmu_notifier_invalidate_range_start(&range);
> @@ -642,6 +645,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		mremap_userfaultfd_prep(new_vma, uf);
>  	}
> 
> +	if (is_vm_hugetlb_page(vma)) {
> +		clear_vma_resv_huge_pages(vma);
> +	}
> +
>  	/* Conceal VM_ACCOUNT so old reservation is not undone */
>  	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
>  		vma->vm_flags &= ~VM_ACCOUNT;
> @@ -736,9 +743,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return ERR_PTR(-EINVAL);
> 
> -	if (is_vm_hugetlb_page(vma))
> -		return ERR_PTR(-EINVAL);
> -
>  	/* We can't remap across vm area boundaries */
>  	if (old_len > vma->vm_end - addr)
>  		return ERR_PTR(-EFAULT);
> @@ -949,6 +953,26 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> 

Earlier in mremap code, this following lines exist:

	old_len = PAGE_ALIGN(old_len);
	new_len = PAGE_ALIGN(new_len);

So, the passed length values are page aligned.  This allows 'sloppy'
values to be passed by users.

Should we do the same for hugetlb mappings?  In mmap we have different
requirements for hugetlb mappings:

" Huge page (Huge TLB) mappings
       For mappings that employ huge pages, the requirements for the arguments
       of  mmap()  and munmap() differ somewhat from the requirements for map‐
       pings that use the native system page size.

       For mmap(), offset must be a multiple of the underlying huge page size.
       The system automatically aligns length to be a multiple of the underly‐
       ing huge page size.

       For munmap(), addr and length must both be a multiple of the underlying
       huge page size.
"

I actually wish arguments for hugetlb mappings would be treated the same
as for base page size mappings.  We can not change mmap as legacy code
may depend on the different requirements.  Since mremap for hugetlb is
new, should we treat arguments for hugetlb mappings the same as for base
pages (align to huge page boundary)?  My vote is yes, but it would be
good to get other opinions.

If we do not align for hugetlb mappings as we do for base page mappings,
then this will also need to be documented.

Another question,
Should we possibly check addr and new_addr alignment here as well?
addr has been previously checked for PAGE alignment and new_addr is
checked for PAGE alignment at the beginning of mremap_to().

>  	if (mmap_write_lock_killable(current->mm))
>  		return -EINTR;
> +	vma = find_vma(mm, addr);
> +	if (!vma || vma->vm_start > addr) {
> +		ret = EFAULT;
> +		goto out;
> +	}
> +
> +	if (is_vm_hugetlb_page(vma)) {
> +		struct hstate *h __maybe_unused = hstate_vma(vma);
> +
> +		if (old_len & ~huge_page_mask(h) ||
> +				new_len & ~huge_page_mask(h))
> +			goto out;
> +
> +		/*
> +		 * Don't allow remap expansion, because the underlying hugetlb
> +		 * reservation is not yet capable to handle split reservation.
> +		 */
> +		if (new_len > old_len)
> +			goto out;
> +	}
> 
>  	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
>  		ret = mremap_to(addr, old_len, new_addr, new_len,
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index b02eac613fdda..2e7e86e852828 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  hugepage-mmap
> +hugepage-mremap
>  hugepage-shm
>  khugepaged
>  map_hugetlb
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index d9605bd10f2de..1607322a112c9 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -29,6 +29,7 @@ TEST_GEN_FILES = compaction_test
>  TEST_GEN_FILES += gup_test
>  TEST_GEN_FILES += hmm-tests
>  TEST_GEN_FILES += hugepage-mmap
> +TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += khugepaged
>  TEST_GEN_FILES += madv_populate
> diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
> new file mode 100644
> index 0000000000000..b55052d4eadc9
> --- /dev/null
> +++ b/tools/testing/selftests/vm/hugepage-mremap.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * hugepage-mremap:
> + *
> + * Example of remapping huge page memory in a user application using the
> + * mremap system call.  Before running this application, make sure that the
> + * administrator has mounted the hugetlbfs filesystem (on some directory
> + * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
> + * example, the app is requesting memory of size 10MB that is backed by
> + * huge pages.
> + *
> + */

Didn't take a close look, but when building got these:

hugepage-mremap.c: In function ‘register_region_with_uffd’:
hugepage-mremap.c:64:6: warning: unused variable ‘s’ [-Wunused-variable]
   64 |  int s;
      |      ^
hugepage-mremap.c:106:1: warning: control reaches end of non-void function [-Wreturn-type]
  106 | }
      | ^

> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <fcntl.h> /* Definition of O_* constants */
> +#include <sys/syscall.h> /* Definition of SYS_* constants */
> +#include <unistd.h>
> +#include <linux/userfaultfd.h>
> +#include <sys/ioctl.h>
> +
> +#define LENGTH (1UL * 1024 * 1024 * 1024)
> +
> +#define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
> +#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
> +
> +static void check_bytes(char *addr)
> +{
> +	printf("First hex is %x\n", *((unsigned int *)addr));
> +}
> +
> +static void write_bytes(char *addr)
> +{
> +	unsigned long i;
> +
> +	for (i = 0; i < LENGTH; i++) {
> +		*(addr + i) = (char)i;
> +	}
> +}
> +
> +static int read_bytes(char *addr)
> +{
> +	unsigned long i;
> +
> +	check_bytes(addr);
> +	for (i = 0; i < LENGTH; i++)
> +		if (*(addr + i) != (char)i) {
> +			printf("Mismatch at %lu\n", i);
> +			return 1;
> +		}
> +	return 0;
> +}
> +
> +static int register_region_with_uffd(char *addr, size_t len)
> +{
> +	long uffd; /* userfaultfd file descriptor */
> +	struct uffdio_api uffdio_api;
> +	struct uffdio_register uffdio_register;
> +	int s;
> +
> +	/* Create and enable userfaultfd object. */
> +
> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> +	if (uffd == -1) {
> +		perror("userfaultfd");
> +		exit(1);
> +	}
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = 0;
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
> +		perror("ioctl-UFFDIO_API");
> +		exit(1);
> +	}
> +
> +	/* Create a private anonymous mapping. The memory will be
> +	   demand-zero paged--that is, not yet allocated. When we
> +	   actually touch the memory, it will be allocated via
> +	   the userfaultfd. */
> +
> +	addr = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (addr == MAP_FAILED) {
> +		perror("mmap");
> +		exit(1);
> +	}
> +
> +	printf("Address returned by mmap() = %p\n", addr);
> +
> +	/* Register the memory range of the mapping we just created for
> +	   handling by the userfaultfd object. In mode, we request to track
> +	   missing pages (i.e., pages that have not yet been faulted in). */
> +
> +	uffdio_register.range.start = (unsigned long)addr;
> +	uffdio_register.range.len = len;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> +		perror("ioctl-UFFDIO_REGISTER");
> +		exit(1);
> +	}
> +}
> +
> +int main(void)
> +{
> +	int ret = 0;
> +
> +	int fd = open("/mnt/huge/test", O_CREAT | O_RDWR, 0755);
> +	if (fd < 0) {
> +		perror("Open failed");
> +		exit(1);
> +	}
> +
> +	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
> +	unsigned long suggested_addr = 0x7eaa40000000;
> +	void *haddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
> +			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
> +	printf("Returned address is %p\n", haddr);
> +	if (haddr == MAP_FAILED) {
> +		perror("mmap1");
> +		exit(1);
> +	}
> +
> +	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
> +	suggested_addr = 0x7daa40000000;
> +	void *daddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
> +			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
> +	printf("Returned address is %p\n", daddr);
> +	if (haddr == MAP_FAILED) {

Should be checking daddr.

> +		perror("mmap3");
> +		exit(1);
> +	}
> +
> +	suggested_addr = 0x7faa40000000;
> +	void *vaddr = mmap((void*)suggested_addr, LENGTH, PROTECTION, FLAGS, -1, 0);
> +	printf("Returned address is %p\n", vaddr);
> +	if (vaddr == MAP_FAILED) {
> +		perror("mmap2");
> +		exit(1);
> +	}
> +
> +	register_region_with_uffd(haddr, LENGTH);
> +
> +	void *addr = mremap(haddr, LENGTH, LENGTH,
> +			MREMAP_MAYMOVE | MREMAP_FIXED, vaddr);
> +	if (addr == MAP_FAILED) {
> +		perror("mremap");
> +		exit(1);
> +	}
> +
> +	printf("Returned address is %p\n", addr);
> +	check_bytes(addr);
> +	write_bytes(addr);
> +	ret = read_bytes(addr);
> +
> +	munmap(addr, LENGTH);
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> old mode 100644
> new mode 100755
> --
> 2.32.0.605.g8dce9f2422-goog
> 


-- 
Mike Kravetz
