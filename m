Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC3429A58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 02:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhJLAUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:20:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33290 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhJLAUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:20:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BNPPvk015545;
        Tue, 12 Oct 2021 00:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8rmpL1Buyed+8yKt9wcEms8eGKf83RsIz5tiOpZUg/8=;
 b=RTc0JsmM1z8wS5MQxt9txhaRsOOolryPTNfIh8jlPIP9yjnL03s7vO4cd8z55678nkWu
 SMwctXIWGsUiD7vdvGEkjH8XV5vWygxpVzP7SikHjmJbwbTReAaSb3CFxYwUSVQUsZXX
 nFAwtsz7cmVcvF9xjKFu0HRZ03sO7/FLUw9aZO15ISxVeqR1VpXr8tTM4x2bHFbashEN
 i/Gwf2EvB1b6r/T0mfnzOYvK4eCLIGFHRoHnhTL63WWc/hSc5QRuN6gWP9NSS3N4lK+f
 iPAmHD9iu7OKcPlrujJKuNCbAhu6d2AnC302eYL4GmfWBtUJBvItxgjPeB+FK/h6vmuv Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq3bbgsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 00:18:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19C0F3kt145385;
        Tue, 12 Oct 2021 00:18:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 3bkyv7wr6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 00:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azmYuxQo7Y4qhDMtQX6LFLiOkKbgh0TVRwIUlL0qB9scJV26f51bePDI0meuRirKT+STAH1ux9XhGKTO8JILbT0P4oguToTgSWHZ3WnED3UR9h/c9T4XlU9oe54RHdWKdFUw8uwNWPnGxezW1RqBIpndD/BdEA2GiBK+9rDhMwJ15bFdtTuCx++Yf0HD4c5S6Y6DZGfCsFBzHGsCO8HT404BeaXKbxk3p+iPpKP52d4RMvs6Ja4sKsgSApqJdNbVJW0dMq6sFqYkUiW1HdVFQYdAD8Vwz6L7jG2HiCeSEGT9UaXeu8eo5WbVZDWd5eW1z0vRdWay5q+oaGhla6aWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rmpL1Buyed+8yKt9wcEms8eGKf83RsIz5tiOpZUg/8=;
 b=hMku1Iv4wvrnA5TnqdpjJnVtdqZ7eDFG3uCNvjyOEBrsTyLGOhaDYYzD6QMCBwG5AIyWRZ6YR6+Ba2F2ng3iOiU8Bj3jvMbVEwX/Lj60/61BxMxAq0jvdu6ZYk2tdkt6KvW0r9lnASLBZv5DuCjWiMgZREC0PwvWjYulj8SBirVvzUzw567yQwl7aHz74fWbqpuFFSR+5ThRqreWK37AEtF4p8jlBWEGx8x2g4ysHdp4dQMhcrmLLPYV4hVL6yFjUhF2v3Tijbn3W2uPGr+ooblCmlfT2fKRWFQAQjLfKrsi1RlBi+YGkZ56/hgWqulmJmmiPFyUa7vmE1vRIHeWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rmpL1Buyed+8yKt9wcEms8eGKf83RsIz5tiOpZUg/8=;
 b=QrpaV2NPP1he2gO7Sq8MyzP9xbC/XpgQSSMSVoMG3wqOCCSx0BaDZqIiXmRAPePtET+OBjMgDd3HZ3omDBF7zVZ1LaObFwsbINlvpJpRsTqlrOv4DNpQNtLtP7PV3DmueaDzB+Gd9t9mFLq5bknKEEgJTEZHCvc4oobXRd032Ws=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3351.namprd10.prod.outlook.com (2603:10b6:a03:14d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 00:18:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 00:18:32 +0000
Subject: Re: [PATCH v5 1/2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
References: <20211008183256.1558105-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b889652d-7050-a721-367c-dcf3ff084daa@oracle.com>
Date:   Mon, 11 Oct 2021 17:18:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211008183256.1558105-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0258.namprd04.prod.outlook.com (2603:10b6:303:88::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 00:18:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71cdbf92-059b-47e7-a0ce-08d98d15d304
X-MS-TrafficTypeDiagnostic: BYAPR10MB3351:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3351FDE9982732AA9EE9BF7EE2B69@BYAPR10MB3351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKubVQB720pnidx+c6MB5DTOZ93RIyHtkdA9/mYv/78B45kbKL2CJxWGWp+yt+StKrEUdtubTlh6vnywbFKK0D8MyRjMmzxjpP3NMFOJhSkN95FJUd6wU1++YGML6XSVvjyCYStwxZptL2Z6JEIyc3ASrC+vuNY0Duo/rZik6vMazieiI2SagthIV4S3fZr8G5cfYLQ2N8gQaDjyuPeYE1tPdWYLs3qarIPZO7dY2o4TB9TXWxBt9n43uo9idlIwo7PxNlKkTxUsxzLlwplBLhBy6urUs/MnYI5XFLR0zqpdcBL2LtQfearCZJoBkBtg3+fFxlG42masLUyiZ30udsTbogzl8sA31oOB6sTwi3Eda00fceekgHiDKaboF52lhjCSpYHFXqNBZpcVYstGljDz0nYy6anEDPsfCUSJBPewrMERKr1v3ZYA0N9MkVjI2jF8sQV8d++AGlxsh/xNxf7/32mjn2AW774ac7WNM5D4ZnbSC/snjkwYD4n9R90tn2PYC7lzSOUVLqJNi+FHaexKDgnPO9d9EdLy/+dQpl8/wwj1Zdci8RNHIu92cylKpceMb4uc2PUMCHJ1MGLoTu34Y4bacm1dKZ26eMixMS3M/ZpTS1QtnEESnq84aTjl8deQfbAH/v9/tc3KY3/YIULQe1OBaeN7gofXm5YBfOWwkOCHE4OqqL2qUxNlLiMUD0l/bnXBrL/+qjW7ap7Z1jjcATurLb/eAkz6NJQSanL3NeB+MkMgv5m5Iy/2UFKssyEsz2CE5Y/0fpph4OVDhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(31686004)(4326008)(186003)(2906002)(53546011)(316002)(16576012)(26005)(956004)(2616005)(54906003)(36756003)(52116002)(508600001)(38350700002)(31696002)(38100700002)(66476007)(66556008)(66946007)(86362001)(44832011)(83380400001)(8676002)(8936002)(6486002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk9hVEJXdFphMVdOdGtmd0RQZ1IvcU1xUUNEMmtOcGtvRktKTWJ2WVBQTURF?=
 =?utf-8?B?bWx3TjRaVUtDazdiM1FMR2UyNFBoTHJKL0d0VGRzOWFmemxwUVhOMS9od3hX?=
 =?utf-8?B?R1FnUE5VV2s2L284eUlYV0x0M3lacUdhdHRVd0hyZ1REZFVQcC9LZ2dxL3hN?=
 =?utf-8?B?S083QXVBOWtPN2MxY29MQURsVFBrRW5ibG1IQmdLSWhOTU0xRm5seFE5andj?=
 =?utf-8?B?MVBCZWk0SXR1dWUyeVQvbUJOeWZ0NG1qK295R1J4RWR4SzF0OWppazB6MEdU?=
 =?utf-8?B?cDBUMGR5WVRxYkZuNC93TWl4UDFDL0JhVHhHNGY4ck1CbVpTQkN4RE1KeWQx?=
 =?utf-8?B?N0hwSmpQTmt0UmNaZnZvcTF1S3pSdkxaNTMyR08xMWdHYm9ra1NSTzk2NzZO?=
 =?utf-8?B?U2o0WHlQUjRsZzN5TEs2emFnbjc4czlFSWFYSktkK0FEclR4N1FHWFNqL1gr?=
 =?utf-8?B?OXRnY3l0T2Y4bEJiV2w5RytlWXhoZ1B5TGRhcjhPeFNWZHVtUnBGNHZ3Z2RY?=
 =?utf-8?B?S0ZoR3luM3FyalVnM2dyTlNjb3RPSkhUWndWTGhBczRIei84bWZXU1dRZFFj?=
 =?utf-8?B?ZWxMZWQ5VG5RM2tJTnEzZVgybUxEaHpIend4Q0U0YjRIQWZFYnIzcFp2T0li?=
 =?utf-8?B?OG50b2o0dTZzN200OU01ZWlDcjdEWlJZdElodkJoaEtVZHJjZndMTWNLOFdW?=
 =?utf-8?B?NFRNeUtPeU16K1FVb1llUTZxWUIxeVJoQ2dWRkhNU3I0TGppcWtXU2N2c0dE?=
 =?utf-8?B?YkYvVzJNVHRYa2FGbU5TOWVPTmtWYVYrbEQzblhaeG1CL21DQmhYK0hGeXZK?=
 =?utf-8?B?RGRna2RER2hJZ2hUcGhxSW5HcTNlaGsxUHRUVjdiODM5dk1IUHh4OERzOVVB?=
 =?utf-8?B?YUFTalkrOXVWQXRucTA4UFhFYjNNenF4L2lUT296ZUxiY1RtdjgrU0tzS2xX?=
 =?utf-8?B?aThYYlA3a1VEVUNaU1NjbkhLUGtHQmt0R05SK2ZvMnNvU2NkcVZZb1FGT2Iw?=
 =?utf-8?B?eXMvQnVXSWVjeUk5WGNPU2VXNzVsQkNTenpJOS9lZUNoNGVkZFY5N3dWYmIw?=
 =?utf-8?B?ekNBYVFPa3dZNlJ2NHF3ZjJyN0lLTGtlY25CbkpJa016OUN2M1FEL0pKcXNZ?=
 =?utf-8?B?eU1yVWVhR2U1eEYrUlFZWG5hVXJwSitMZkMySTNnM3ZzQnYzejRJaVpvNjFC?=
 =?utf-8?B?N0FOVXcrZGxUQ0V1K1hWL2dwZ08zOGJFT0Q5RjdGTENsMjJ1WkdJNFA2aTZz?=
 =?utf-8?B?RUp3RmFrYUZ5V2dBdTM5WHBlN1ZxZlRuME11VjJUNkkrSytzTlNlTS8vY09T?=
 =?utf-8?B?WVhZSzB2OE54azFveWRoZ2V1dmsxOXFmVmNvS0djZm1MY2VOWW5NSkRBSExK?=
 =?utf-8?B?M2NMYWdpM2xNcFlYZ21QZ3JKbzZiYkxjSEU4RVRxOEcwNEt4YWZnN2dXcm9i?=
 =?utf-8?B?N3Z0di83UVRKNTNydXRQVWRqV01zYTZIWVFYSm1yZGM2MFY4TW1nbFdoeXR2?=
 =?utf-8?B?ZmQyUk5PS3Frb251cDB5VzgyRHBHTFhJT2U4Q1hkektYMzBCWWNxakJJSHlt?=
 =?utf-8?B?d0VzOWxpdmpMSEw3M2ZSZVJKbUgrL1orbm5tbW5DQU5pZG1lOXlFZFJSNE1i?=
 =?utf-8?B?S1p2Q2x3SmJBT0NVV1R1dnlYMDVnOGRJSmlPa1B3SVJPV3ZiV2hQSm0vbHhM?=
 =?utf-8?B?MHIvMmFlczIrcEt0c2tZNFBKZ2VJY1MxVTNYRkxEZm9McUNLTFQvREM2ZUJm?=
 =?utf-8?Q?8KMdLCqXdHqxVGEvRQWMRv6uVOgag35Pa2UOSdh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cdbf92-059b-47e7-a0ce-08d98d15d304
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 00:18:32.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GpKMxBGNKkDluqkS3h1m3cXtv9hrhyvcZaf82/h0HzPWYakLbc9niHx2uKLXbE/q6ekwSzZHwoiTA1fVQXWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3351
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110120000
X-Proofpoint-GUID: W8yqrRIjeLv0Ih6G72GNVYi85Zex04Yy
X-Proofpoint-ORIG-GUID: W8yqrRIjeLv0Ih6G72GNVYi85Zex04Yy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 11:32 AM, Mina Almasry wrote:
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
> 
> During the mremap() operation we detect pmd_share'd mappings and we
> unshare those during the mremap(). On access and fault the sharing is
> established again.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
...
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6d2f4c25dd9fb..8200b4c8d09d8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1015,6 +1015,35 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
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

Are the *...* for special formatting of the words somewhere?  Or, just
for simple added emphasis?  This convention is not used anywhere else in
the file.  Unless there is a good reason for doing so, I would prefer to
to drop the *...* convention here.

> +	struct resv_map *reservations = vma_resv_map(vma);
> +
> +	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> +		kref_put(&reservations->refs, resv_map_release);
> +
> +	reset_vma_resv_huge_pages(vma);
> +}
...
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c0b6c41b7b78f..6a3f7d38b7539 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -489,6 +489,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	old_end = old_addr + len;
>  	flush_cache_range(vma, old_addr, old_end);
>  
> +	if (is_vm_hugetlb_page(vma))
> +		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> +						new_addr, len);
> +
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
>  				old_addr, old_end);
>  	mmu_notifier_invalidate_range_start(&range);
> @@ -646,6 +650,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
> @@ -739,9 +747,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (is_vm_hugetlb_page(vma))
> -		return ERR_PTR(-EINVAL);
> -
>  	/* We can't remap across vm area boundaries */
>  	if (old_len > vma->vm_end - addr)
>  		return ERR_PTR(-EFAULT);
> @@ -937,6 +942,27 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  
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
> +		old_len = ALIGN(old_len, huge_page_size(h));
> +		new_len = ALIGN(new_len, huge_page_size(h));
> +		addr = ALIGN(addr, huge_page_size(h));
> +		new_addr = ALIGN(new_addr, huge_page_size(h));

Instead of aligning addr and new_addr, we should be checking for huge
page alignment and returning error.  This makes it consistent with the
requirement that they be PAGE aligned in the non-hugetlb case.  Sorry if
that was unclear in previous comments.

		/* addrs must be huge page aligned */
		if (addr & ~huge_page_mask(h))
			goto out;
		if (new_addr & ~huge_page_mask(h))
			goto out;
			
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
> 

-- 
Mike Kravetz
