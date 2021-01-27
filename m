Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33630502F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhA0Dts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:49:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40412 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389700AbhA0AHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:07:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R03qof169235;
        Wed, 27 Jan 2021 00:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kpH8MzUF0mYI3VtWEra8uXG8OaP66htqxGuzKr1qj+g=;
 b=iJPOjSEMkdhYLjwxYrPMGB0FBU6Kc9uoHNsx+NujvP8ywN453tIOwyivkaPpdixX6uiJ
 h0wpkT/tyhjFRGl+gSaGi+o4buXtP4egyqjkffKcXHDuERPGJBbwdovFs8bh8FiMrVyK
 NzegnXMMmTzT98krjsOuvcSQhNPj5OVZ2XaYJAOrGXJUXZijUseAAgGbekzXTIEkEnkp
 RtC+eLw+YSKXcv2mMn/YfznVFdv2rHpBuQLReXSZ6Nf/lHCpLENDRGFQzFUTt+ZhuY/W
 cxdvBtFLkejzO8PgyW22L6I7T07OzexgypBBaE43NU7B85RUprpqwqTxjzZde8LKSx8F kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 368b7qvmnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 00:06:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10R00YsD102353;
        Wed, 27 Jan 2021 00:06:44 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by aserp3020.oracle.com with ESMTP id 368wpyk423-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 00:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZALe1TdUn1QDDSBJejMarVGgMo2YrH0aheSPTKWFGaB7B72WIxOdnqwHlTISh2VfBLoZcOr+osBREOTIDeq4iJYfw4YnsmysVpkEa7UmyFl2Hyrax112SB1MdIolnth4gEOW9KZ9MLR/608jCUNsy0/HnkLkyp60DozSLqhgPoFJxrtkWLPA3MMAfIhyWKAiHsM2S8lBfombq/p6u0vf9aawy4NY8Dt49xvIrHxfbyF279CXFMRfHqIWtUOv8Tapmm8hUp/R8lLTvKOOq4Mna46kllH7eqCf7q7xyLHPyyMhtJ6sOL5uMXpgbNNJqZ+7Q+P0RafsNgmfxW82+RFcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpH8MzUF0mYI3VtWEra8uXG8OaP66htqxGuzKr1qj+g=;
 b=MpzXQGrsQrcvsFvQ7kq7opn8vq0z18wLtNHZWCnSRFO+av2Ahf9ux3BM4Q9imcqvbZfA1oGIGAH6K8wR2JUfKnz6ie3dNzgtkQKOPXoQZ5VBj1w7bxL/6LxcvIY3yd6Oev/UQHTRkzCUYtz3fdp4CyNzRFCBjpQxbT6N3KzlRTlHUT+I2qjKZK+ZldeOtp0aB1i5JI4GL5XSoucBDRveUevIsUh+pQH9hcioOwKvn0y8BICBDB0DTZBctnvR4ARSvJS60I/j6mxFAe+LiO4gTjcMk4HitZNpS5qEtThR3po1oqG/uZKy/gXSux2JW3sCp0EfuK63lWX+7YzTG6u57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpH8MzUF0mYI3VtWEra8uXG8OaP66htqxGuzKr1qj+g=;
 b=QoR1W6jLSy3eG5eIaf+/UGXmkKb4no2c0Mqi7hR5fn1i3Lk6iCwGVi5yiX1kG0uvs53kY88pOZSdXarRL1C1g7nVfobWFZPyGqduKlxct89dVEvNWyF0d7liYsrlSU91DN8iuLReQ9OKbyMY7qsBvmLdqBZwrRDBAQOOpBzh3sY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2174.namprd10.prod.outlook.com (2603:10b6:301:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Wed, 27 Jan
 2021 00:06:42 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 00:06:42 +0000
Subject: Re: [PATCH] mm/hugetlb: Fix use after free when subpool max_hpages
 accounting is not enabled
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210126115510.53374-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a5952a6f-aaf4-b542-f9f1-5603658a602a@oracle.com>
Date:   Tue, 26 Jan 2021 16:06:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210126115510.53374-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1401CA0017.namprd14.prod.outlook.com
 (2603:10b6:301:4b::27) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1401CA0017.namprd14.prod.outlook.com (2603:10b6:301:4b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 00:06:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e954cda4-8df1-49a2-6edb-08d8c2576d4f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2174:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2174AC4B33BC561977041B82E2BB9@MWHPR1001MB2174.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58fPjox4hogIEey9ykqG/ydWXH8wSXfRg54+OeKcjUc0AHaRguvSKVgYxnkoOvIbanzfGgkZfO/oQZb+4G1f3XVq6VOAQgcEmFWbkXMi7IvtHgCQiRRTjVs6Wb5NTqQw3Fr9ILzRvxieZ/YdVsAa9wft9JccGmlIMy1a1Kz3m18287Cv/0oSevjWY66iN1z7iRdqsoJqbiI9QMFZqO2s5IT58BEqpmXhJUUbG8xwGt3IMCEHuB92/FomkDfH+WPwATsi3gsOZaU2hjYZXVWXZ+BEi61qQFVPf3qAGh4zGDKAR2vr+YBPJcmwyaLtlb32aqvFcK4wlaqUDY+PcORs7lgAdnNrK5jOZ//TWYPrALjIHBxc3IPph+8sQytoIvRycX1oot5rdIyNT40sLC3Nhls633Dr8qOULd9nXxrMw2TXg5KGv6VEWGHBlTpAP/b4x7tna5DCtC1Gn7DioP7swy4uJB6DmJopQjnyKlEIYU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(316002)(478600001)(5660300002)(16576012)(8936002)(31686004)(956004)(15650500001)(186003)(16526019)(52116002)(83380400001)(66476007)(26005)(86362001)(6486002)(66946007)(36756003)(53546011)(44832011)(4326008)(2616005)(66556008)(2906002)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aXFaSWtYS2w1N1kxMy9TMlNxTWVkQVpmS0kvS3NIbFVQdFRBVUtiNjF2WXd5?=
 =?utf-8?B?aVViUk5YY0tEb3hISUk4aXJLYVk2bXVsRGJUUDh0ZzdMRC92NjJ0aVFGS084?=
 =?utf-8?B?TzVmSGswK1o3RjJWL1RaaG5Ga0xaeCs2d1k3a202MG9JQW9Ea1VYTkF6dzZT?=
 =?utf-8?B?NnJIdFQ3b2pyYm11b2NYczJDUDJZL3E3ZFNiNS9lYVVaZkE5ckVVVjJoV0kz?=
 =?utf-8?B?TDB2SllmMEp5anN3ZncrZVN3bHZqRXdSWHkwN2xVWWlPUXpKTEpVM1VCOGJJ?=
 =?utf-8?B?aGlRR0dkS0h3NGFQcGIrRGxhRVcycHFENUpoU09ZQVRXWHhSM0dlMVplZWMz?=
 =?utf-8?B?YzgyemcwRnUyWFpJTml0OXdwMStOc3BxVW9sQXlYZENoa0JYZkRNZ3lGcXR4?=
 =?utf-8?B?dEdqOWtBMVJGNjYvSENpQ1RsaEF4T0tYWG5HMGZ0SUFneXBvSTlMYWpZeFBl?=
 =?utf-8?B?MVRjaThFVGxoaS9RbXExcG1qV3h6Q2ZFTmNZbE9IWFBYR1BYbXdNTnJuaEND?=
 =?utf-8?B?azh4S202RUMxR2lQcCtvdzBtMkJSMmtoeDdUajNaWE1qbUpFbGxOUzR0L05Z?=
 =?utf-8?B?bWlLK3paaXF6WWNxMjlXbXNUK1FTaEU4em9wZ2tGRGlJay94QW5zTFU5c2h3?=
 =?utf-8?B?ejE0VDN1YjBvZnRrMHFKcVkwUDV5THhEUlBaZzNGa3UvR3NRRTNxMkRMcENq?=
 =?utf-8?B?WVJQeDBaMzVwS1g0Q0FIVFpObDlJMFNmWStLYW9XWlZoSFBEMmxhek9OcVlJ?=
 =?utf-8?B?alRER21OK2tyTFBuTlMwOFkxV1VtZnU2VC9mc3owSk03bDVkbjNrTkVhcXhP?=
 =?utf-8?B?YkpzMEs4NzNBMHpTdmEvOU1rY05iU25pMDN4WnhKR1RnK2hGbVFBeTdMcVBh?=
 =?utf-8?B?azVSclRpcEl2Wmx5ZENjMjJvVHRCMGlEbkVCMUhSODgzY202R0RpQU1FOHcz?=
 =?utf-8?B?SGZNWVVBVDQzZTBuVjUwTGdRQzB5RGdTSERzN1ZVdDRXMzdicytVMGIvTjlM?=
 =?utf-8?B?aUxNb3FwU3dHUXYvcUhiNHpNeTFUcWljKzdSZXdaRUNDMlNrWlg1eXA0T3JH?=
 =?utf-8?B?Z2R2VDdDSlRPOU80ZDJFSU1DUlRiZFhUTStIN0RjbmgwT1pabjNpZzdrQWFV?=
 =?utf-8?B?UTl1ejRHOXJoUTBWOFV3OVM4bVdIemp5UDNGMFU5T2dyUFB4UURKR3BRUUds?=
 =?utf-8?B?aFZsMllURnRZM3dHY3VZb0JRUHhDL3MvU0JSOUp4STNhOXJGWHoyUVVyNmxt?=
 =?utf-8?B?TlNBSFdrRmpXekJBSjF4K1VoWlU4VGNoY1VyYk5WbGFKOGx5V2RjR3pKYU9p?=
 =?utf-8?B?OFhEOG9rK21uVzVTYTRDRW1NaWNlUzZkdkFYRDkvTkhwMlZ5UTdTUkV4SFIx?=
 =?utf-8?B?NTkwUmxGZWFPeDU3Vy9IWVp5NXNVdHJ3cjJGcWR3WHkvaDdBTlBERmZ1VnR2?=
 =?utf-8?Q?LOmoFBUb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e954cda4-8df1-49a2-6edb-08d8c2576d4f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 00:06:42.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJH1PJwwr08GLVHd8MhDgh+Swb6rdRcCbx6PXglbFy3wEJxkFiG9EBJJ2QMKuLF5YMTctNk6pJ9Q4rY5p+wwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2174
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 3:55 AM, Miaohe Lin wrote:
> When subpool max_hpages accounting is not enabled, used_hpages is always 0
> and might lead to release subpool prematurely because it indicates no pages
> are used now while there might be.

It might be good to say that you need min_hpages accounting (min_size mount
option) enabled for this issue to occur.  Or, perhaps say this is possible
if a hugetlbfs filesystem is created with the min_size option and without
the size option.

That might better explain the conditions in which a user could see the issue.

> In order to fix this issue, we should check used_hpages == 0 iff max_hpages
> accounting is enabled. As max_hpages accounting should be enabled in most
> common case, this is not worth a Cc stable.

I agree that such a combination of mount options is very uncommon.

> 
> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 777bc0e45bf3..53ea65d1c5ab 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -97,16 +97,26 @@ static inline void ClearPageHugeFreed(struct page *head)
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>  
> -static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
> +static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> -	bool free = (spool->count == 0) && (spool->used_hpages == 0);
> +	if (spool->count)
> +		return false;
> +	if (spool->max_hpages != -1)
> +		return spool->used_hpages == 0;
> +	if (spool->min_hpages != -1)
> +		return spool->rsv_hpages == spool->min_hpages;
>  
> +	return true;
> +}
> +
> +static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
> +{
>  	spin_unlock(&spool->lock);
>  
>  	/* If no pages are used, and no other handles to the subpool
>  	 * remain, give up any reservations based on minimum size and
>  	 * free the subpool */
> -	if (free) {
> +	if (subpool_is_free(spool)) {
>  		if (spool->min_hpages != -1)
>  			hugetlb_acct_memory(spool->hstate,
>  						-spool->min_hpages);
> 
