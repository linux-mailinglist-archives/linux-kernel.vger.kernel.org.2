Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8B32AE30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360700AbhCBWXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:23:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55534 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384406AbhCBV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:56:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122Ln67A012383;
        Tue, 2 Mar 2021 21:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZzRaWU8EnpLk1Ao9pJyhNubNa5a7iWnLwWoG6z7QpeQ=;
 b=ggek9ryYoQWh+1khil+o3ndI/jzDl/9w4JoHxN/jVXuiu1rR+s0lk1i3wEgAKuBLKITe
 LW3Ik5W8Djkdo2+hbX6rzXQdQ2ZKTtdFtXT4/usl3eRWoOg5Zk1a/az8QGCOwcaFzNyQ
 Dr0UPpdlU6zDVMsKemZCOxA9HJI3sI6a+0iGffDrwFflLsronU81gn6j4dQQYqbo13s/
 8CTIJ0zWLRABR3q7UluHAc1vXABZ9o85aaZ8Qu9zCnMVOgh7gntl0mY/uO23DsCXNAi9
 LJM1+UddCupfDJONs7xJSQ3dCBikpxKu1y5ggxtQ0iptHmGZ02wbd2+07i/KnOABbBlm 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36ybkb9f1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 21:54:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122LkZ5F112235;
        Tue, 2 Mar 2021 21:54:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 36yyusm8hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 21:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSiyczUe5KyjFdDLMwPJo8+xWPNJgEXLYmYdGdmQIoYhFLiK4581r6niDB5OTXKT47OzIrE6MS3MQq8gLG5UJW0Jp2orvAqi4aiYXo6zFc6VUuAD0R/CQgkzKUYKF8FZ98EQeZriZQuFiNqvQlwnzlSJEL/CY95Vykd4hurwce4IlXId0lYVtm1btaOeDNuiD14veFiHaQ9p4HJzUisj0pT3kKsWwpD3DoLamEbs1m6j31eRlTDr0wpKwdp2B4rufXoDyesS1pkoqjA/HCGwFrUHzkGdm7ccD0R9fDBxfYKISHOtc8SNLgRJV7K+eDwgi8Hc0DMoPj372HWIPWxSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzRaWU8EnpLk1Ao9pJyhNubNa5a7iWnLwWoG6z7QpeQ=;
 b=NbP4XLure3Wzv4b/ZftoSKPNU1m8OxitWZt9CIUbIolUSxQCp0eewUymREYbPkRtuhoA/AfGHm4YFkt5J3EIWnOdhykNgOHMfEOm2NkH9X2C/j6Wbrc+LSJkdg0PTlLUaScPIYlVDFfrlP5jtCS985aLMylUlbvEVR2umIUwUQCpTcEw76IJJDE5eg445T6MlUx4XpHBF8mMrmHNUa5eEBpBQTSJR2wtwwX5eakn/fDfscuJG8sY1ECD0io9OU6HjDHDDVIU9cO7xpylVpCtoKlUqhue3yxbcaPcdp2ou6FStzaTarC0HCbNhdZ9lFkf2W4gy14X1X/H4uwYcaJMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzRaWU8EnpLk1Ao9pJyhNubNa5a7iWnLwWoG6z7QpeQ=;
 b=EV+HFM/tSz5amwTTWdwKqB5lVeJQ9OAXRE8+bizZbNZ/nhup1XOYitc9z8C7NInZWHEntxsv+BYrWog64JF9tusNJieaGyt8O1la9kNEjJJAdnXoZ+iQleG6F4YUL80+vNo87iFMOcX2EADFXzqUMZYuc2rNM0pYNyRpMw31e3w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3907.namprd10.prod.outlook.com (2603:10b6:a03:1fc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Tue, 2 Mar
 2021 21:54:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 21:54:25 +0000
Subject: Re: [PATCH v2] mm/hugetlb: remove redundant reservation check
 condition in alloc_huge_page()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210301104726.45159-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e7b7532a-6087-7307-1f89-f7db26004bae@oracle.com>
Date:   Tue, 2 Mar 2021 13:54:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210301104726.45159-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:300:129::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0029.namprd21.prod.outlook.com (2603:10b6:300:129::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.7 via Frontend Transport; Tue, 2 Mar 2021 21:54:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e1619a-cc8e-4f4b-ddb1-08d8ddc5be87
X-MS-TrafficTypeDiagnostic: BY5PR10MB3907:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3907BEFD4DEB3505E050CE1FE2999@BY5PR10MB3907.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVBTQqyilBgOEJM8LtZ5wRhGea+QwYQuy3ZE1PBfJDFCWgRPBJgxqSFSju/Qnb7IilfMu5B50Yk1fVj0EAoqrZ1JwK+Z5X0C4spktzLLlN+YjlVCeNpiNQ7ddg8dSZOOOoAJK5DRN4j/C++8lMks+etZ9ceaeWJDrUhqJtVDTXpUKHay4PWDRBFEVkOc83xQ1qGDgZPerZINQb4gtaxPG5uFvZagnyEsldq1LwgVXXJxu3Y937Ee0pShMd4LfE3pmE8EPeWJ+gAIXj9TTsyRpFaJ7FFJIzQXnBq2yM8cpGwdHs2A3ZP0iXGb+3PwvuaGER8EpedfP0AeWNwZTbJSuzyOS35zwUCSCNZ5NC6pPskj/hWHdBNDpM2pCMMzPe9DwY8vNDXghuWQm5taN4gPDy6GSx4JYYVBgqum625VEIup/9VJktcLLahUViOe+/rCfs7wA9Cf8HrYVBqVZAI2zEQJCoVix6SGLkpD8BrI2zxrARstWF3v6pH+WVss6DmRGQU40StIyeIDLyHzN/JZqn5fNX/hiAQlHbR+KN2nrQrF1fKpyHpqpwZIwwAxJc3ECDIOFbfgwVhee9jcGb6n0dTV/3yuoxs5HHNYQ6we61QWCFA4t2Jo16np2G2ljFPg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(8936002)(66946007)(66476007)(26005)(5660300002)(52116002)(16526019)(478600001)(66556008)(53546011)(186003)(2906002)(83380400001)(16576012)(86362001)(36756003)(4326008)(2616005)(956004)(44832011)(31696002)(8676002)(6486002)(31686004)(316002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UVErMjNZRWprTVBtSTlzMDJ6b3cvN21vNTNJOFpEWGdjNkk2MkVadEtkQ3k3?=
 =?utf-8?B?RHFaQnhVbTJUenlWRCtDWFViUUZSRE5aMFNIMEJZK3QzMDgzYXhhQ3B6S3d2?=
 =?utf-8?B?VlhwTXdFVTdrLzZpSkpNNzR3dkd4eGxIdjhqemlvOFpjbWJnTnhxeHNZZE5U?=
 =?utf-8?B?VGNnRkg5QWVLZy9qZUtianU4dmNid0VVakxsYitCQlQ5b3krQ0RxY05kUmFV?=
 =?utf-8?B?TC8ySFphOGI5aHRPcUgrNkJuRnNiYnJxaVNOQko2RzdTakZQaldvVDc1WUxq?=
 =?utf-8?B?M3FuTm04NUtKSmpwTW1Ja1pjVk5vUSsvWGRYbXBrak9LVWZSUTNta09uUUdV?=
 =?utf-8?B?bmZoOGs0TEJRL0wrWGRld0g2K0R4dmRxdndYdEVoY3VOeUZ2c1RkVGc2eUJN?=
 =?utf-8?B?UGM2UEFqYTAra3ozYW1VZVcrYjcrODNwUFplYTRJN2wyT1F1MWVwL29acjJK?=
 =?utf-8?B?ZHluaHpubFdsZ2o2eVZ3akhmQlFvQ1FzRmxmTnJQWEVwU3ROTHgwVHdkbnhm?=
 =?utf-8?B?S3Bqc0FRZndIUnhhZVllNWtFV2lJdXVYY3pOSFRsNzVBVHA1UVplNUdhenh3?=
 =?utf-8?B?OWxMSE9aYU9sVk1VMGxYK24yVmR5TDh5dkdwU0dOOG5QN21pRm5SclNuRDR2?=
 =?utf-8?B?RDdpeHdKWjhldjAxRWh4VVA3clBIOHdJK2xhMUpCNGdhMml2cmMzYzgrL3Ew?=
 =?utf-8?B?aU5OallYbWdmdFNOT01WN2E3Z3oralR1Ni81a1VLYVBKbEVBcXgvTGE5a29y?=
 =?utf-8?B?a0xkUVAzYnJwRUhlOFZIcFEvS3crUFF6ajlqS011N01wR1JDZmhRUzJBSVVj?=
 =?utf-8?B?eEMvNXdFTTdOUVpBWGpyY0V4ZVh6ZmpHTDh5YTF4ZmtQRHd6MzB3QmhtUllF?=
 =?utf-8?B?bHVFd1RqbXdVdWtYZ2tJUzBMMHVjaGFHN3Q3VG5LaVQvT3hDaXJPaHdrMWlo?=
 =?utf-8?B?MFRTRmNIQzZDbDMxNUptN1FEMHhUTXFmZDJSTTJ6aTd5MGlrYVpsYk5sSG5P?=
 =?utf-8?B?b0lRN2gwamtvSVNDeGRzWGVoMm1LaTJiQmwvZUFpZXZzU0RWRmducnFHb21Y?=
 =?utf-8?B?dEdiNHMrcDN6WnpURUJRQ1B6NlNMMGhLNnRRdUt0eiswVFBocnB2eXFpN2Y4?=
 =?utf-8?B?NlFXV1RldTk5b01NZTdTby9PMFpWSmZ4RkNRcU9UcTJ0OWNMYVFRL3ZUSGM3?=
 =?utf-8?B?K2tIYVpzL0JUeHJ0RmR5NWowL08vOHFPNkxENC95NzRzUDQrcEZxR2lyMVNK?=
 =?utf-8?B?eWhodFl2NmY2d0VOY3J4YU1QMjFHbnMxTHZoN2VTWkpvK3lLY2dMS2JMZTI2?=
 =?utf-8?B?aVNHQ21XVGtCc3dxbk9NRFZWZm5tU3pVQi9yc09Rbmx5M3JlNU1oZDJGUlkx?=
 =?utf-8?B?WnI4TmNWNzVNUEhTeWluN3B6TG53U3c4Q09RMjJOTkx2QU5JNEVpLzI0dHpo?=
 =?utf-8?B?QmkzMVhRYlAzdjZRYlVpUS9IOE5Dc0YyMHlkWndGOEVTUGt3SW9uY1BIbzVk?=
 =?utf-8?B?WVB6RytKc1pDOUJaS2RlSm9FOW9renF4RTF6REpUNGdncUNsQWR6NXYrNzh1?=
 =?utf-8?B?akk2VmpGT3VDaW95TVd0WWtWN0MrUmJ6TW9uQ21NSTd5L1BZY3BmZ2tiUm5u?=
 =?utf-8?B?NENlRHpQbVBvSm1tQm5wVngyWHJOcWZPM01lNi9KbXBjWEFWbk1tNmFCQXJ6?=
 =?utf-8?B?SVMwb251Mk1mVUtQVkQ0Wk1mMUZkd1pTVDB0ZVFaQjZVc2xQTWJDQVBHTktF?=
 =?utf-8?Q?J/p0Y6mytdE3TYoWM86T3ynhAaW+s7vmafssxHU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e1619a-cc8e-4f4b-ddb1-08d8ddc5be87
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:54:25.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUMwE1BZ1b2u8oDvpduooIBHyw68Z9bE9tgBnODJ5fPZqxq7SVm2gOuOIFbkhWZ/HXLGUc5MSyJcaZOo0XHI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3907
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020164
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 2:47 AM, Miaohe Lin wrote:
> vma_resv_map(vma) checks if a reserve map is associated with the vma.  The
> routine vma_needs_reservation() will check vma_resv_map(vma) and return 1
> if no reserv map is present.  map_chg is set to the return value of
> vma_needs_reservation().  Therefore, !vma_resv_map(vma) is redundant in the
> expression:
> 	map_chg || avoid_reserve || !vma_resv_map(vma);
> Remove the redundant check.
> 
> [Thanks Mike Kravetz for reshaping this commit message!]
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 60c67eb016f7..060005b868cf 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2314,7 +2314,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  
>  	/* If this allocation is not consuming a reservation, charge it now.
>  	 */
> -	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
> +	deferred_reserve = map_chg || avoid_reserve;
>  	if (deferred_reserve) {
>  		ret = hugetlb_cgroup_charge_cgroup_rsvd(
>  			idx, pages_per_huge_page(h), &h_cg);
> 
