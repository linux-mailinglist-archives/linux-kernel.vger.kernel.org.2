Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23035E93E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbhDMWt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:49:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41928 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhDMWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:49:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DMiom8129645;
        Tue, 13 Apr 2021 22:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=coZ42yIgFdFt37nmlCce2VoO16jgm5kAXsHRAgRwZbE=;
 b=MduSiLJHPhBSypwcBEuvOCaAVadGCfWyI8aITUkZTUcOM/I+aEjf30iM5mrrbFt8R7DR
 gPlpV9Epiz66ITHXMdntpR902bpFb13fzXRJ5/OyR08iZPclPcM9LK5QvMy0b6kzmYM/
 ql70PWN4JmJbhMNpEpQGEu63GO0GnX/A+cNByGTh/SmT4sVGN0zfQsaGRFKAGTCEq0iY
 nTV5mySGAgSNkOdYUFMfYNyA3y6EDFDUMm4EYOKsEEu2Lc0rjglRNQ46PLfA35TGUCI5
 qmeS9uysubkKioOtT5n4jw7l04v1/B/BgghWRGGez2aRw4furOs0FXfGPDRhLVcTcz8g 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymgmb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 22:48:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DMiMhd064367;
        Tue, 13 Apr 2021 22:48:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 37unxxfyap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 22:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTymvYSyUtfK3I7Bfd4ooBnCvZTmUpV1wkCtwQmH4bW0++9CT93VHSy54qwOx7baSZXJQabwNPl5sY8us71H6CDYkK00rR5FdkAs6J5j590+xSardXMnmSQCw19GqQTnFM6BULlHCJwBS/E68UttcPiIpC0pzDOgv5GOALcAmcVu9ZFuRyJkN2+BIVz9pJ7p3Ma+hJf4g1Va6rB28i8a/W0mqW41fMgPXC5ONmFtWyeagIkaBslNqrfqNc6guFIi7tizXu4GpgHL8/3qatLY8D9EQbv0xtltFhAePzqT4Ie4QZUAr3zqicTIGi9gkyjUbQjWg/2qnfXSxWkeHrcejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coZ42yIgFdFt37nmlCce2VoO16jgm5kAXsHRAgRwZbE=;
 b=kPmTa2a5VxNPOso75QxyA3XnuwPxuhQlCfLcdLZ67akfXYVXX2bUucHBtjhaNSlUP18vq0DAKLu0B8cKPHRSnLr2r00zpgCVEkY4B0gQN77pO20RLe6+37cEVqMCAoIej31YT8EqpFEG2dzbKYvoz4sYSdrM9ALawF2zpZmtOOcLuopP1pm7sUujuaXudndr1fybKuRoR6lxmXz1F7Jh6/IUIcslLSDKc9w6eAMP3/h72jvpcE60wXddSstPTQWsXezn9P30dnCRT9RPk2lxdTs6UN/dpKWIA/Et4juGeuZAZcbaCUlAUAwqNipE8igW/gMcX6ZbDTTeYAlCx5ZpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coZ42yIgFdFt37nmlCce2VoO16jgm5kAXsHRAgRwZbE=;
 b=LxE7LdKG6FjEavCL2S6Le8IMXDah5gbXzmq9/shUFBW5Pp7w+o56YFXwabkr1/Oo3GpiBKLpmuWTuRHECdiNcilJgFsw11GkDJ4CK1cJhRNZeOgT9KUxjpzxtQarpDnlYtTqcNlRxezTlLFBbacngEnE1HYojbXtcx13KXaPfDk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3688.namprd10.prod.outlook.com (2603:10b6:a03:11a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 22:48:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:48:55 +0000
Subject: Re: [PATCH v7 6/7] mm: Make alloc_contig_range handle in-use hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-7-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <722f9a5e-ef0a-508a-e58a-6c3eacb5d1bd@oracle.com>
Date:   Tue, 13 Apr 2021 15:48:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210413104747.12177-7-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:303:69::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0030.namprd04.prod.outlook.com (2603:10b6:303:69::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 13 Apr 2021 22:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2404cadc-6c33-4a92-7e3d-08d8fece5161
X-MS-TrafficTypeDiagnostic: BYAPR10MB3688:
X-Microsoft-Antispam-PRVS: <BYAPR10MB368818A0530DE261A1D520CFE24F9@BYAPR10MB3688.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWwPKPJKJmq6ot5rllznilOdYxYGXMKIG9nA7uTxC8VHydMaF11Td+dcOdwQ34OSqai4ZhFSe6HSWw3tPAsXUxSJ0kG5/WkGgTuAntd3Fhbo7IgdopuLIhTVEtKfYll8bFZrhlqPwJRMQUArJIxPGoEkuTk/Fwgxes58NSGJcaw6BskHC7Cq4bXlgx0R3IvTH9MAaeJIaN3Z4JIsHvcWmgViNB/g/cyZJUgFHEdjrLv0nwvU27bAbqTQE2OEzD/iw71KBkqtb8AOfdpyQUxXhDt143pM5wJ2VrU7fWcaEGDFItaXNEjx9wCzcZ27gQITVLOWSkQFx2xeJ95l5WW9cJYgtpH7ByAwikUy25bus4hjpC7um98dqBQ40LLn/IVgPBE/hY44Upa1OUl1CX7pz2jvZPlRH5hRcMDqAy+EzBKbwGofYRZdRVreBZO7Hj6xGv7zZh4VZAEbg6mVayM+w7sRspBXJl1EOFY839Nx5WyXI9Budy61Xli/bOUVmrp/IcYfSlWBfk2ggnMLLowM7fI5K3v0P6b+Dg1N5iLE209hGrroeaxsOtIDBQ5IUH5GxvtIZ/hmuhRHGY71kjJ/eQ3e7YPL1jRMHtFbQh+KNnhHo+zoEr3619TQuwadf3EnW1HxpifA5sbdhod4dn74OQSu8xZY5anCKBnnEss132MnxXmXyt882zs09BNq/aa97AKVD6UGla1HjyVXksQDvH5Vc7rfxmjVUxs1BZOYkCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(66946007)(66556008)(8936002)(52116002)(16526019)(31686004)(956004)(2616005)(36756003)(53546011)(8676002)(86362001)(66476007)(6486002)(5660300002)(2906002)(16576012)(54906003)(478600001)(110136005)(31696002)(186003)(316002)(38100700002)(38350700002)(4326008)(44832011)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3E1ZDFOTFJmOCtNa2tvZEZzU2xyZkw5K2hnZkxva1N0cy9hNzJUQTBUZVpX?=
 =?utf-8?B?QmxwaU96U2FUU2s5UFFuZTFJa2tLVkdWR3JmOEtzd085UjQ5Tnd3S08reTEy?=
 =?utf-8?B?L3EyVEUveGN2MEg2aHBZcFMybmxpaEVmQUp2RUkwcWVPZVVpRVQ0dHBOQ21w?=
 =?utf-8?B?cldBWm1BY3NUTVhzdzRMYlNNUUZUUDFCeUxhUHBjVS9yaEtzVVVHZTRuUnY0?=
 =?utf-8?B?N29PUUxsdTI2dTFoOTYzd3MzYnYwMi9CVTAvenpLd3FObWwyMzBQM2JiOC9F?=
 =?utf-8?B?VEdjM0JmYzJ1a0EzSE9aUVJWTHE0QldQaWtGSHJmYi9pL3JYL3RDWlAwb2Vt?=
 =?utf-8?B?MWxFeGc0dTJPZzM2SmUxOVpuNEFrMDVXRlI4dTF4Q296SU5xeEJMMm5CclV5?=
 =?utf-8?B?ZXQrOTIrcDJiRGpkUWJuZk5MRmJ2TzRaMUlCZGhtVzIySzdYeGVBUkJPUXhj?=
 =?utf-8?B?TGo0MjZXMnB1YUhGTzdCSUYrN2ZDbUhyRzhaNXFLTkdML3FlOGQ4cjFGckR4?=
 =?utf-8?B?NnpzYi95bnh1UzJtN1A5QU1YZUVjRkFsdFNNR3FRN1htcERNZ0NUZHpvYktY?=
 =?utf-8?B?VDVKRXp6MTU1dTBrdUliT201V1lheWxUSUdkNjN2ZjZ5dklBT0R3dGZsQVV4?=
 =?utf-8?B?LzZHT1J5cXYxRkozSElxbkVWaTIxQXpYRExNdjhlTnI0T2NlckpqL1pOMjg3?=
 =?utf-8?B?TVluV3VJVWRZVjZmMVF5b3pBNWpobE1LTThFditVL3FZTms5M1ZTQ2ZhZHNY?=
 =?utf-8?B?dEhCeEh0NWxOdDBQWlpjbEJKTGM2Mjl1eVUrZExIMUlxYzU0SEJnVEszeGNF?=
 =?utf-8?B?dzBQWXEwL3hReFNPNnlUdWZ5RnY0RGEzN2hFVWFoak5Rb29JUDBpdzJlQ1ph?=
 =?utf-8?B?VTl1YSthM2ErRW9VUGlEdjVHVjdXbjB6aGlnb2dZN2FYM1FzY1F5QlpjWnVw?=
 =?utf-8?B?ZUhJMUY5dnN3cS96OGdFUjE1cnUxTVBZVGVHNlFBSVZESkw4Y0dmMVFMYXIr?=
 =?utf-8?B?OFEyR2w4bXNjQk43QUVjMVZzZ1luVUpGOW1FSEtnMUNGN3N1bXVtVjhEWlBz?=
 =?utf-8?B?QUZCT0k2eXgrSTQvTkJmMnRPVWcwd1ZjQ1dKNHFmUTAyTVg3ZTNIQWFhU25r?=
 =?utf-8?B?dXFtNkExcm50SHdQUHNmZWtLVFJIK0tUODdqNXd0OHhyK0RvSnJNQi9JcVBz?=
 =?utf-8?B?bUtzd3hmUzZ6eEVqQnREQ2lBLzRkMHBYdXRRSHdEZHI5RmZhaUR3VUdSUTFL?=
 =?utf-8?B?WS92QkdBRE9ZK09Ia1RIb1FzSjVlNmRlT1g4WWtGbzBKK1RQTGxGZUMzZnpX?=
 =?utf-8?B?ZnhOMU5UU0h2eUdJL0QwRVVLaXh3QWw5N1ZjQXBtemREMjhNZzRQdHB0REpp?=
 =?utf-8?B?dmZ4akpCSE1wbnB1Sm5tRnB6VjFhWkdWb3kyRkVicGx2MDgwMUtmNjlvVVhk?=
 =?utf-8?B?dkpZOVNhNGd4ZThlWmlqTFpLQTBhU09Fd0NXdTZnbFNaR25ld2pNdTg3ZjNt?=
 =?utf-8?B?UlZsdmdWWHQ2RjYyOTJCL0JmRm9UbnBtZXhhMFp0eXA1UUhwcnZqeGVFZ2dq?=
 =?utf-8?B?cm5WZHgxdmNua3VRU3Q2NmFlUUlKTXNqVldRY1NKT1dMb3RlMExiVDFWVm9L?=
 =?utf-8?B?U2VtbGUyeGVDd2hHUUNrN3QxR3RUeC9xb0dpVXVUS2xrc3JDMm1ZZ0pjc2Zy?=
 =?utf-8?B?Z09hMkp4NERwMHIzMUowYXFGblRLdk5VbkNVMnRRbGdsMXo3R1RTdXd1TmVM?=
 =?utf-8?Q?WE2QAYhmeO43AekWvoUDq07GAr6KAk/MkOxhyh0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2404cadc-6c33-4a92-7e3d-08d8fece5161
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:48:55.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTOrfe6TrWhR6cptS3nrth4tQPOOkLza/tz7fqtd4DXGSuhWy3Lw0CgijW6rY0NNMRk61hfnu5WeEE9xgXU5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3688
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130148
X-Proofpoint-GUID: Bf0-XHfjBJ5U4NHeJ2Ti3v7mQbEnxDX4
X-Proofpoint-ORIG-GUID: Bf0-XHfjBJ5U4NHeJ2Ti3v7mQbEnxDX4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:47 AM, Oscar Salvador wrote:
> alloc_contig_range() will fail if it finds a HugeTLB page within the range,
> without a chance to handle them. Since HugeTLB pages can be migrated as any
> LRU or Movable page, it does not make sense to bail out without trying.
> Enable the interface to recognize in-use HugeTLB pages so we can migrate
> them, and have much better chances to succeed the call.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

One small issue/question/request below.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4a664d6e82c1..24a453ff47f2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2270,10 +2270,12 @@ static void restore_reserve_on_error(struct hstate *h,
>   * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
>   * @h: struct hstate old page belongs to
>   * @old_page: Old page to dissolve
> + * @list: List to isolate the page in case we need to
>   * Returns 0 on success, otherwise negated error.
>   */
>  
> -static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> +static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
> +					struct list_head *list)
>  {
>  	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  	int nid = page_to_nid(old_page);
> @@ -2300,9 +2302,13 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
>  		goto free_new;
>  	} else if (page_count(old_page)) {
>  		/*
> -		 * Someone has grabbed the page, fail for now.
> +		 * Someone has grabbed the page, try to isolate it here.
> +		 * Fail with -EBUSY if not possible.
>  		 */
> -		ret = -EBUSY;
> +		spin_unlock_irq(&hugetlb_lock);
> +		if (!isolate_huge_page(old_page, list))
> +			ret = -EBUSY;
> +		spin_lock_irq(&hugetlb_lock);
>  		goto free_new;

The label free_new is:

free_new:
        spin_unlock_irq(&hugetlb_lock);
        __free_pages(new_page, huge_page_order(h));

        return ret;

So, we are locking and immediately unlocking without any code in
between.  Usually, I don't like like multiple labels before return.
However, perhaps we should add another to avoid this unnecessary
cycle.  On the other hand, this is an uncommon race condition so the
simple code may be acceptable.
-- 
Mike Kravetz
