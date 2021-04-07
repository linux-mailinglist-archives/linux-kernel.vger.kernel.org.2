Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B222335601B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbhDGARM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:17:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347469AbhDGAQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:16:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1370GM20166739;
        Wed, 7 Apr 2021 00:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tgZX+5Y0kLNgdO7VIYXmN0xxX/HoBU5aosCf/lHPeiw=;
 b=rAZOPoUJwFHphFEBTMKA9toJLHc4r///0G5coaorjTsjKAGIwtM4HoA0eXpthE4aUUSJ
 7DdxRsW9imrHFbVfkTHCaHeaOVCseQgxskEisTtyYQMx2eUG9noc5g0F8iqT2ZXfwQC/
 F1dKEz/cLM9MRyvAUkio756WIvw47r0SD3hc7qS2WW7irflQouXPHiJ8vTRyEjtbVedK
 9bz/+RtV9SER14KUpy6y9zHEHw8gD4ravaRWEkGRqOTTACLT5QcuIY3F+RLFa9NyL4VT
 E//4BsN6yPKDOXZdiIUmM6rwb7fXi5xAy2IZbh/VP9Jxp10tTppN4kcYvGLr6PBYLECh mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37rva60tdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 00:16:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1370Fv6u181137;
        Wed, 7 Apr 2021 00:16:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 37rvbdc59e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 00:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6TFMm61yqPKwkSIzAm2bl8EJYtmVGbrL2J+j6JncX2vbb0wA2/64zGMfPgtsvZjtWuURSL8ZZIFOtHk6a/n6iPICSja/qf4aZ7qMvoEjVpZiVM9OhXORSEPPJiGjJ3+HynjoWb/+mpflUxR/JuOHmPm5EDU7CZFhTOPtjgwtiUGoz4UAME07guQuclSanxUhVIsy+umgy7GZZka7AL9KDyzyGT3OLPBQ8XfrPti0A6WZdI5srGyZ5qAGStBF9IpzcwnEt+9N9fGaHbTSwCYrUq4k9Ioj8gZFe5gGUnz8uYzs5vUj2bQARusQspRmmvjK6EYGOkWB8wIkPR6qZJpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgZX+5Y0kLNgdO7VIYXmN0xxX/HoBU5aosCf/lHPeiw=;
 b=VA7eFzqNHV1BBnJpxer4118neOCn1O7qA2Ea2ecIytTt4NR3bYxfixCYxWMy1mENevNqwkLQ7oNatHBqhZNRZja0UkSzKmvUjCAiINYZ5vb9iEnyY3jVRuX6od+AN/pugR4vH91EAETz7jObbzsDOUHrepcNfev+Fiu51UTZy8ELUrTcc3J1gihAAgfzbA4k/5oOGQJs4j/mPcKZSCg2TjgUJdJzu9bW37qd6iQqzdAkVkpixUagLNvsUoJgVP2C3xqLWqJFcpJAmTnLnCHy+CYJ0yx0LoSB2B58+ydEQGub0pRXgnX/p/qZFI8ooAyMBzDyWXiFMY2Gx7qhRzEkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgZX+5Y0kLNgdO7VIYXmN0xxX/HoBU5aosCf/lHPeiw=;
 b=VmC4rj9CKAl5bcEKfkFON6AjfL0nAN8xqkNx08ct2/w5beqsZyjt1CwULmAGgeTSjagAlNm3Tef098k9LgY/XGy3yRVhAnIv9Vrx4mB9NZWT0cuiPSt1J1dPRqdx9Hj5/GCHfmIKxaK4iAErVo6kK66BAfdSNE+IvI0slgrUFCU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5438.namprd10.prod.outlook.com (2603:10b6:a03:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 00:16:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 00:16:20 +0000
Subject: Re: [PATCH 1/4] mm/hugeltb: remove redundant VM_BUG_ON() in
 region_add()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, hillf.zj@alibaba-inc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-2-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9c6e54c7-0374-0438-9dc9-5a2635cc06cc@oracle.com>
Date:   Tue, 6 Apr 2021 17:16:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210402093249.25137-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0022.namprd10.prod.outlook.com (2603:10b6:301::32)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0022.namprd10.prod.outlook.com (2603:10b6:301::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 7 Apr 2021 00:16:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 431ecbab-372f-4d01-8193-08d8f95a5e7e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5438:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB543842EC9040ED2F6B92DCD7E2759@SJ0PR10MB5438.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5rYq3QfTsrknBxKe0afWa331obpxQaG9hpYOqij4xMeV7nZUa8sUmAAytqV7UOqWjbC7NpTIvpyVakhqVjLc2BWWoRj5QgPUTr2wsw7bdcyU/7NDHgnPa7tKrhezZKbeUAP+dhaIJzabkoqTIGO3OWgyFkc34gj8yMi40LZowmt9rt84UKlkDqG4oYQfMb4w9ZSpmqsRpROq533Zk19iH9rYucvjrT+y5qrS2UwdK6iHOrfHFxEleScobMWr9b9PZpfmehDPunXGfu1SRe0TvBhx9wlPirVRphUdZfmS3EBtd9RGx4Cmh5c2ne7LTYfB8yeBtxtxggmJQImKhhnTBTdL5TOZDmHQrnwukfdyoOE8TOUgAn/U/azpl0Scz7lP1O5t0kWA3w43mVNvpMrHr0cw8a+QYRnGYD3PHI6JudDDV6eODkNb7P30TUBoliH7PDHKcqfeq6dy8F9CpNj9VY1eUTrQwzqqSOyEsjQVEhGVqibp+iw2vh13vSzsLZ1r7+TQy1Kup+1/blMQ2BTzteo4wlmMk5x5Yi2U3Sf4qUb1EOur6OZm7GwtY78XOg+bMFyDwxUdDfXaJZeR8RYcm9VUATpcTazv4vnzuBXd7DuGqWOzAlEjIyFQsvKvzI8gzmJ0Ir6Tex4m5a9iFmrEw843mJzGJf2LqEpGJM4zQEmdymnWs0uKadAOSbwBZW56Udg275SNYcW8B4SG+vxInpBKOijXVQYZkpGq7c1er6vkmLxfP2ddLktLcsJiXkr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(16576012)(2906002)(316002)(52116002)(53546011)(31696002)(36756003)(38350700001)(86362001)(4326008)(5660300002)(2616005)(956004)(66476007)(66556008)(6486002)(31686004)(66946007)(44832011)(4744005)(38100700001)(16526019)(186003)(83380400001)(26005)(8936002)(478600001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0dRUE9GS08yYVBicGk2bm5DY3FwOWFIN3VTMklTWUVCWjF1Sjg4YVhya1Fr?=
 =?utf-8?B?eVgzTWVqYVRobURKd2RydkZLQTVlalRvWkNzNktxVWlmS2tWSGpYc2lyajkw?=
 =?utf-8?B?N2p5aEdIODVPWFpKa25POXlRaXRnYThyL0Roc2pMdzJVekQrMnpod21UbXli?=
 =?utf-8?B?cUpOQWtqdk5ISmsvUWJUUGtzZHFYeENDQS96QnlzdmJ2NHVieWlBNlphMExp?=
 =?utf-8?B?SVRscWd0RTZLcWcxVUtuOVVCeDJ5QW9UcjRmaTJQTXhjQWFOQVJ3V2FUVlpP?=
 =?utf-8?B?cVdoNUZKNG0xR1J3OE5zZEsxajh4SWhaR0ZHTllGaTJHN05wVTBjL2VvdW5G?=
 =?utf-8?B?ZTZBRGJ5QjdMV051eURuMktVeC9jdUFxeTJoRXNEOXcvTzJUb1BjWWxud0lq?=
 =?utf-8?B?OFRISUZWWGg1UkZRNlF5YlA0cEJKQytTT3E4L2E4b0JHQTBxWmVCekQ5WGkr?=
 =?utf-8?B?OXlrMEltK2F1ZjlRN3c2MUluSm9BWGNZVkJRSTBRWGJYcDA5T1ZYdXdMejBo?=
 =?utf-8?B?VFB5dk95bzlFcUJJclJmOElYUkdNSi9nNzdaUHRCcWhYNllKZ0t4NTd0cFVS?=
 =?utf-8?B?VmZ3Y3RCbHBjVS9Bc2xrcERXS2dsTDF1amtTekw3c1V0blFuNkRlbzdkQnJa?=
 =?utf-8?B?Y3NLMERSamQrVXRFeWpGVFBoR3ZLT0gwZWoyMitmSUt1dldhY0I5RkhGWnNu?=
 =?utf-8?B?QmFWZ1cvaGNJeGtjTDVxSW9OaHd2emRNdk9yR1JKc0I0Kytqa000VW5rZFBP?=
 =?utf-8?B?OHE3TEFTK2FuSFNBcXZ6M1d3eWw0ZzdKRnFoK01XbmxsRXpBUHp6cmVxYjlq?=
 =?utf-8?B?Um11ekpGUjBPYzZLdlpYTzl6TzFyZTloWndaZXJYeSsySklhbXdKUmZtS2d5?=
 =?utf-8?B?UUJzUUdhd2d0NUhoLzVsbGlZRkVFNHFlbkZxa0tOYjE2WURuZDNySTdmRVVx?=
 =?utf-8?B?bUhxcHBLQXhDZ1NBZi8xYTI4KzNmZHp1MG5ERDNKU21zRkNOcmVsYnZ6RFMw?=
 =?utf-8?B?bGtOdzZNL1pjTklBd2R3QzBta3Uzcy9PZGJ2dTNySFVrc2l6M3Ywdk01NllO?=
 =?utf-8?B?M2orNlJ6V0w0YmNWaDIzRnhWaTZKNktrbENBclRhcTYzWmpCV3FpckhzUFIy?=
 =?utf-8?B?cGZiRThRWWxUU2F2Y3JpekhjMVNsSlFYRE9rVUlpUlRkYjNWdW9EbDVGY0R3?=
 =?utf-8?B?V1BDZE8wNGdWbFdvMzVObythTFlZMksxdXRGNGhSWVZ1L3hPZkp1ZEVKYmIx?=
 =?utf-8?B?dFRyckszZVR0akk3a2dhQVNoWWNHQ2NjaTdYV0JKV2hjTWpRWnQxM25uamFM?=
 =?utf-8?B?UmJ1WkkxSkhKeHcxUGthV1Bkc1luOEltOHJQOTQzWU5YU0xEc3Q3RDNBMDJ6?=
 =?utf-8?B?VWJiR0docDBZTXFjclRSZ3JUbGN0SnUrdmZ6Zy9EVEZHSndhNjQwN3JzWEJR?=
 =?utf-8?B?Vjg0NlFjQW52T0Z0bk5tVzFvZHVnaEx3SFpGQXErRkZrSHpPUG9CSWpkdzk2?=
 =?utf-8?B?eEUzZjRrN0RETlE0K1F6U0ZpeEJ5VzZ6Z3JNZ3Vqa2hCQnFzMDlaYVZWQ0NJ?=
 =?utf-8?B?a2N3TE9XMlVXK1FyNDRka1h3VG1rdzNrUWI5UVpydGZRK3VHS0o3dStqbTFy?=
 =?utf-8?B?a09LMGpPOTgvaVptTmtBQkJ5eWpSaVhYcmRIdng3NFJNeDdsbUZPZ3BqQVd6?=
 =?utf-8?B?MkJTTkxkZm9NRlQxdjBGVHhObjhRV2xCZ1QxdDBDNUdMNDVOaTF1WnY2UDV3?=
 =?utf-8?Q?UHgBJ6160EOUS0xJvraAQpnA3A80ize3quhhju/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431ecbab-372f-4d01-8193-08d8f95a5e7e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 00:16:20.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AI8VElWuTtcxkKN5lCaj+XK3IXHBxe5A2o9eiwmhHh7FY4q4J58+9cUmbVBLxzK9bNqDD++aQQPv60FLf7QXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5438
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070000
X-Proofpoint-GUID: Zjwq2tczUMq4hT0RgdwfRaRgqW6rjBCI
X-Proofpoint-ORIG-GUID: Zjwq2tczUMq4hT0RgdwfRaRgqW6rjBCI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 2:32 AM, Miaohe Lin wrote:
> The same VM_BUG_ON() check is already done in the callee. Remove this extra
> one to simplify the code slightly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c22111f3da20..a03a50b7c410 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -556,7 +556,6 @@ static long region_add(struct resv_map *resv, long f, long t,
>  	resv->adds_in_progress -= in_regions_needed;
>  
>  	spin_unlock(&resv->lock);
> -	VM_BUG_ON(add < 0);
>  	return add;
>  }
>  
> 
