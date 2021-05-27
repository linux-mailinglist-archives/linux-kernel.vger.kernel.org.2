Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B103923F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhE0A5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:57:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27934 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235024AbhE0A47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:56:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R0snqS007637;
        Thu, 27 May 2021 00:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RuKXTDLwFwGxEae04mGgrvNeJD0bQuHyZn1qArKUWbg=;
 b=xBMtu+GBkS+vIssMyorXIqf5FyrodllREQPugUaJ6bOgcP5dkusKc68nPosGzWUZ+yd7
 UANtNQY5MXLXt05nw0L/1MEyMQVVeC9FkC0QaKqUZyryKA7eXbObZd7Zjbb4qNQl8b2F
 dtJ61yoi8hRv0tCLiaVFcUveK+JjWFo7CrXR4TmQD55gxp01RXXqL53jKcD5hzPtWwfs
 uHU8YvLnPPpL759G4n4H2WlBhYZEzSoeqIDqs/1wzHl3Zfkip6isn8WryoxZ5xldZRTu
 E13Y0flhVOTFLyi+VbL9TrbXIVdUGZabHsAFo3CFaNLIgJWrnM0p73D9Gj3GcD383YK/ sg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38ssybr4ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 00:55:13 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14R0sjHc002428;
        Thu, 27 May 2021 00:55:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 38pr0d5eu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 00:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGaWleD6ZzitFOSk7lh3/XIB7ImDoHizMiy3oCWGF90lquL5hWYkG34iVX9EXilkgmdtCko+vVqhRPbofACuRnURN/irLqOgwM57mU/uIJysp6I7YrBFU04c530/njjMWAkK7zTi+7jsdqaDLyw4y4UhZnp3dPeRxgTUApkYwMQI3M9LfLSst4oHRZJzHllxyLqIEmYH8cMw557PRxkEr6tQT/O5ToskhEtgnmvdUCQQXb39HASQgznu3adHHZitHwdMPXmBf2MCUI2KqNl3Mp3DmdtcXxmjQNGPpB1ZHHrr8W2vjT973YvwkEZtLfGXZMkCKvMIiqmFq9mfOm6/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuKXTDLwFwGxEae04mGgrvNeJD0bQuHyZn1qArKUWbg=;
 b=KokQy6WnmZeG3Q54nR6EwOFdb8LXGW7ZdtmuVNsnVy9iSns2jwdHXPlUybnIT32d4Qt/jl3jphIs3acx7K1wtsc3/ADkwYhGIgOzOa0So84gXP7b7LHgDoNg+n8qVKOkLpHZ8Ir3Ew8+YiNQjB07PjyW7AwGTZWiLDM8fgvc+tMpo/T8U2tf/wZ75h+s6n6WXGxKpdhkLmfn14FnvF2h7Jy90W0EBrdFDZVu9F5lVPsgoayR9V6hCdTvZCsjdSoJIEWTgf7i/dW4nSbMC7B5b3jW8VbLgm/tUm/Hzm53gZZBbUSELtNjop9Q95Ox7LJNo6JUJDu39taKXuwDSBS1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuKXTDLwFwGxEae04mGgrvNeJD0bQuHyZn1qArKUWbg=;
 b=PJLqAeZUF0/xLvVn2GzzfcUJrqmjmRfaDFXPh5gWJc7VLxtiFDvwANZeNruE0TrXkr3kBzVzvMqCZza7PKDNm/y8siL9QG9FzGnHNLo0CrskxmVgx5RMsYgoofaPdEyz1F5ln6t0lbKjK2A/H1nimLB8vWA66lIwG+QiVEUBAX4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 00:55:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 00:55:10 +0000
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <adab93b7-1418-a955-9932-54981744b7b0@oracle.com>
Date:   Wed, 26 May 2021 17:55:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 00:55:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff78aa0-535e-48ba-3e6c-08d920aa13f3
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4783:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4783CF84F5B646E4C0FA61DAE2239@SJ0PR10MB4783.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+OS+Als95oL1EA6Ln3HjKbJx9FGHJ0cjia90jhp8zP11n9zskqcztA2imsi4FVA1fKNRnqFyCAMEZd7RSs68N7T8XGIO0xp+xEbWdooS3AypRtrPfFDj97zECJUO+9onbWDqSK6VGYCbetlOQoYg+XJkXL05O71gJvFVRzsBsLT0ohibuMNeg038rlaZY9YaKh5mwbvRdiv3woGRp12rD9Ftcwh4auivvIKAYBXlGnGRL6fEvvFW/KJK97tKHK6OoX2IDmhaW1KGcxcc8zP5CjPZRzIokyj27DM3H3zo/rowRiVtjhGy7BQLCo8FpXCZdpCRKUC9vshypTQ8ArT96zO2oaqw3ps4msch9lytvwtD+Iok9oOZR47qliO365KrGZdiksexMRHRYtHJ75L9kx6+9d+oigU1c0fJGvhLGPKDcJUyOyRDqZcPiLBhvKBCYMKtYHl5zr9WdLqp99MnrO/3c0EGCpq81dcjvv1UwvbH/c5sgrpZQ3UMs97H7SMGm6yxtO1WrbekMkLQwpIUMgsCE39Oy+rngDyQHOabvTs10pwF93DNFhjCFbGsypDBtFi9JoJ4hPg+XgfYWBfFdJF5hGts6Axr7yBn9XBhSVlsHdjvdKFT05yLs/Kwn+DwTLoXKPGSEgVmyVvBR0/Y2e20HHR92TjVTbC9/c4nrD8vqwgttsyMOQQFlomdajR7PaVAxnCBdUyKZKqd1WDWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(53546011)(44832011)(8936002)(5660300002)(31686004)(66476007)(16576012)(83380400001)(54906003)(31696002)(2616005)(8676002)(478600001)(16526019)(186003)(316002)(4326008)(26005)(956004)(66946007)(86362001)(36756003)(6486002)(66556008)(38350700002)(38100700002)(52116002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVZadjVkamZxME5yTjVMK3JiaVpSaDM4ejg5SzZKOThxd2pjaHlUTEFMZEF4?=
 =?utf-8?B?VFNOMVFuUk1sVGhXZ0JQaFJRYlp3dmRwM1h5QkNBZG5CL2lpZVJTengrTVdY?=
 =?utf-8?B?MXhVVmlhWHkxWDRuSFZsblcwUHVUTjlHS0ZMdUJRelhKZCtEWFlSa1NpRGx0?=
 =?utf-8?B?SkpsckNpTjh4WXhvb0g3ZmtIdUVDTGI0NnNaOXk5TEpPMXF6Lzh3SHIvSDZm?=
 =?utf-8?B?VVN0TkJJeVhIU2UrSklSQVJibHFURkEySnJRaEtmUlBmbDRjOG9qeW5oR1hS?=
 =?utf-8?B?WVhGRE5xbTZDc1U2UXQ4ZVM3K3Q3d1lma2w2SzNta3hiMmJoSTVCUkRGb3Jy?=
 =?utf-8?B?bEtic0RtOTllbzgwVEFEOGlXY2lYcUpVQk5JM1ZJVUVOZlhlcE1SZU85OTFY?=
 =?utf-8?B?WUNNelFObVZZWmJ0RXlnQk0vVUFKaUh5V3EwYWpQTlNMY1dOcThvdURZeUkv?=
 =?utf-8?B?dE0xeU5aLzJRZFFzemVlSjN1QU5HSGNsalZJSFlzalRnYTRDZFpURm50K3Qy?=
 =?utf-8?B?TnUybEFVNU9LUWZkekFyVVVTS2R3ZXByRmxhY0Mrc0h5TVdFczkyNXo1Sm80?=
 =?utf-8?B?MkU3VjQ1TUV6WTJCNXJ1N3IrSmhyQ0oremdVUHFJblBxREF1VmorUDVYODBh?=
 =?utf-8?B?bkZuV2xFano2ZEZaODJWeWRCZGFTVlFqYVE3c3N1cXQ2WUJ4QUlWTzI4QVB3?=
 =?utf-8?B?eVdlUUdUOSs2MjBCWmF5TU5HZTdKTFEyZU0vWlBabGtzUTRsd3o0OXU4cVE3?=
 =?utf-8?B?VWpUamhWMU5mNDRDMGRFV21XcGRIN3hoVW9uWG5VSU80dnlkMjYxaFhzanRi?=
 =?utf-8?B?bjJvUGJBT0RmNyt6a0RBMkJQUnVSRElOQnlibzQ2aDFtMWZ4MW03R1hyeFpw?=
 =?utf-8?B?UHdZODQrY0xQWS90ZTZzRlZ3TXpsWjE0WVBtckZnQTZzeU1RaWR3YTFyOWFz?=
 =?utf-8?B?RDEzRlFCZ1czREZyQk1GT1pQdi9TQk1TMUVTaEh2c3B1ckdZTkNoUU9oYkt4?=
 =?utf-8?B?cGt1Z0RQcTRENmE5Q21EQ1VwYUZIUjEvZHFOVmZYdUgyekduZEdPTlp1eHZs?=
 =?utf-8?B?dEUrcmNDV3RGNk9RSFJkWllQNTNMYThwbU8zMVRoeFdESk14OXJkWDZxS2VQ?=
 =?utf-8?B?ZTlTdkVEQ1NRa1RaN3k3ajV0eUt6ZjdQV04vVkdtRnMxdUZJU1Z2blh0bnR0?=
 =?utf-8?B?ZVQ3bFRUbEU3VWFWS2Y4MVVybVV0Y0pnMGE4ejAvUmFUN3NFYTRaeENoUUEr?=
 =?utf-8?B?QXd6ai9sQUl1MFpoOEJyeXh2YXV2OWpydmxyY0UzY3F3QVlpZkVFUXJLRDFv?=
 =?utf-8?B?VWxKYVFyT0J6Tzk1aEpGWTZkZGR0bGVYdzNPelFYYkxhTi9ldUZaWVNtSEQ2?=
 =?utf-8?B?SVRRQmZXUU1XZ2FHNmQ3QU5EclpYSmkzdzFFYSs2NWlFMUpMZFZsaWcxUDVw?=
 =?utf-8?B?dTZDSEhkQ1UxTHV6YS94NGxVdmpGLzlNK0pmU2RPN0lJZ3FvSmhrMXhONXhP?=
 =?utf-8?B?b09raE5PbEhNeVBRS01KZFBqYTg5VE5wcU5XSVN0WG92NDJ4cHFKUEh0aEhX?=
 =?utf-8?B?ZGhwa0F3UXNMcTNWMGlYaTNYTGw1TFZJNFE4SUVyUk1OTTVlTU1rbnoyWW5W?=
 =?utf-8?B?dFhiS2JIakEvbHZaMnZEaldaS2R2VHpWZ2l5cnROdGxWS1Erd1VkRitxUlFr?=
 =?utf-8?B?NUI3aEpnRUNveTJEbG9JUk1rYWRCOC9ZOTRseFBia3hSRkkwZ3ZNN042cEJz?=
 =?utf-8?Q?I8uHfwm5BiCa5dkbgBcnk4ABJ2ILS6P1DYgPGGY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff78aa0-535e-48ba-3e6c-08d920aa13f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 00:55:10.2944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lNXHcFjhFvn0VNRF2+u9NJ0GdqasIxhlswD8t/CON8PxjAKI8DKy3rYjoslvIqkVmh45Mz1jdgya9NFs0a3Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270003
X-Proofpoint-ORIG-GUID: -7EQpg1SQGllCJ_nAK-CE1Pc560OySUx
X-Proofpoint-GUID: -7EQpg1SQGllCJ_nAK-CE1Pc560OySUx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:52 PM, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When memory_failure() or soft_offline_page() is called on a tail page of
> some hugetlb page, "BUG: unable to handle page fault" error can be
> triggered.
> 
> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> page points to a head page, but one of the caller,
> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> which could be a tail page.  So pass 'head' to it, instead.
> 
> Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Naoya!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git v5.13-rc3/mm/hugetlb.c v5.13-rc3_patched/mm/hugetlb.c
> index 95918f410c0f..470f7b5b437e 100644
> --- v5.13-rc3/mm/hugetlb.c
> +++ v5.13-rc3_patched/mm/hugetlb.c
> @@ -1793,7 +1793,7 @@ int dissolve_free_huge_page(struct page *page)
>  			SetPageHWPoison(page);
>  			ClearPageHWPoison(head);
>  		}
> -		remove_hugetlb_page(h, page, false);
> +		remove_hugetlb_page(h, head, false);
>  		h->max_huge_pages--;
>  		spin_unlock_irq(&hugetlb_lock);
>  		update_and_free_page(h, head);
> 
