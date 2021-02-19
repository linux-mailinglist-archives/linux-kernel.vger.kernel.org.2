Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2F31FF41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBSTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:14:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSTO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:14:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JJ9Lxx050577;
        Fri, 19 Feb 2021 19:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=U4vFt8NUxmegS8j//Tgm0qJxmSzxouC/uoWg6mUv0gk=;
 b=XaaGEybQJZvMYAVIkdWmkMK1dIWHE0GyW8vJuiUaRmYP0pnGl8ceWLGBbQUK8dckneZQ
 LQdaVrNtfOURKBqF4zALJO0frCgJxmEz7hxLpiZHSXq9TmxnEWYBWQQNCjNy49dvfku1
 Jb51dcjLUoJ3Bi70g1L4rVyYGkFjjEHMiRvKfPtXZE17U1/NEQxDHNIwiMhkZSKHGEon
 s1Tbttwt5Lc4Sa8hVBi1mSCQXHU6GAK50FAcyIct3IUvp4tSVy65CooXw1JTj+bAyp0e
 vHqQCkXyRQByMQrWz1SuIxXUYMUDMavjxmiro0HB21Si7ZgkaijInDPBElwLzW9BH4KV KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36p66raj77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:14:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JJ9nhD140557;
        Fri, 19 Feb 2021 19:14:04 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by userp3020.oracle.com with ESMTP id 36prhw06j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Im/UPyIWWOGt6y2rJy7TQ/ouRXj6NjY3TQWtNHy0c7WSuWvnVQSFxGe1ez5DHWyURUABRLg2/oU2um9DiI6Yw4tTAT37+7lYO6dpEjlJBhmUJc1g7oTkoJD00Wtxvv7dtMFgcLhNNTBlFa2zZTx+D61ICnzihrUDNbY8MPL/ntInwgR77BAdzRBBFaCR+wPOOjn62mJICoaAsHiXO0v5+R7AOps0P6OGQcpZWWC7j8ky1wDfokwO1+I+DVMx5qXJaKpWf6vwtd5tB0XWLSngsSWH8CAlkAxb+sJqbcp8SrH0/OWDkqrdmvoJen8VZq+5GaEgq+493U9q0786+rKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4vFt8NUxmegS8j//Tgm0qJxmSzxouC/uoWg6mUv0gk=;
 b=hwRKdhtgIw9pWu+BMnajQUpe9jveJBNjbm28+VCBgKNh1qmZp4T1jUY+o8rcn2GFrgTdy7Z8i5KmRikV1rXmA7dlOwyh40CfZc5CPx0ftI+CwmmTdTEnDw+QWMOSfncBRxjNBP1M1O5ROJ8mb2JVQPT8X4hijaHrose+j2dkXAkBXcsnKg1JM9dHKUc66OYDVzAs1VCNUNJ0tcf4TNJszEG+tt7diwFzNEE5zvjNszmG6n7m7QeWv/XD0DI2enmSiXGxfBLN/IvVNG/qRYL+rtYaHovmVRX1nV14xo3YqMUX12+i8PZEjrhK/xPcK5tRPFNtmbIjT9nnTNOloITnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4vFt8NUxmegS8j//Tgm0qJxmSzxouC/uoWg6mUv0gk=;
 b=xkumf1VszTJFNV5qKorN7F7homjWcWPfH4WEhJWbiZyNGsmWNXBMwT1LNEyRfkAjepZiVFcsIT/iXWKQa/8F57dL9k4HYBW6pElVWdIqjjIdWactA0fBLZeMxd84chBHmx3jXjP/K89zVwPT0Cp2uLe8tiUe3WFvky/B/h1Qx/I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS7PR10MB5069.namprd10.prod.outlook.com (2603:10b6:5:3a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 19 Feb
 2021 19:14:03 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733%3]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 19:14:03 +0000
Subject: Re: [PATCH] mm/hugetlb: suppress wrong warning info when alloc
 gigantic page
To:     Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210219123909.13130-1-chenwandun@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <46e76ac3-def1-80d4-14f1-61f7cd00d033@oracle.com>
Date:   Fri, 19 Feb 2021 11:14:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210219123909.13130-1-chenwandun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:102:2::22) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:102:2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.10 via Frontend Transport; Fri, 19 Feb 2021 19:14:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 944340ee-40e0-4342-d259-08d8d50a84ce
X-MS-TrafficTypeDiagnostic: DS7PR10MB5069:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5069A5CD5D1CFD7CF1451ECBE2849@DS7PR10MB5069.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8simjxmpNsmM7h0aANX5rogz99q7DME8EDeqwlFFQPxhRLlqMpJ5bA1LLFs40A0jSOHQh6RdIvO+kje6ABH8ONCYC7pEai5ho0SQjf7apigZ7JAqLFY0rZuxbTac01YqEEDciTnL09UVCD4Phq5d6M7z6yV7uvaOQc/Grz3IotzYcjAb7I9qXhCXey8AAU51G9SyGSfzj9y9b/IB82gqilAvda7J8ky9NH/83Saa3x3GDj4XaREL2McQ7/LDg3U1vqnHJly93utQMwtPOA89JYvOgKXZO+WIzp4eaoQ3edVFhtdH89V3EuWga4FPLnr8R+AK8VirSqcEdc6bhJgVkoZ30oB3VPfLSsAVWRzgJbUrBTNW6E0Fo+dwVWM1whI/BOipSdInHrdWfNTOpG1bv+15hdEtsp59s4ZaTe25kcUhQcX2Q5HUQXtnAILtYEamBLUv5MWeR0aHie3jBCNv0wMl56Rv+sbSk8TLNd6OCYuCikC2CyDKs5lswD4zK99FUNZd8bniarcKpxQUKoZq+uyQrS4erH9M58YjXb6I51Ajto/G6z6LpWUsdjOmjYGSvE6uZtIt2Y39zg+H3X9zVpEBAf8GeShIgjikvO9dAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(66556008)(44832011)(86362001)(2616005)(26005)(16526019)(2906002)(316002)(8936002)(6486002)(186003)(8676002)(83380400001)(5660300002)(31696002)(36756003)(66946007)(31686004)(478600001)(66476007)(53546011)(16576012)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ei85NEFhTkZYWG4xMTJhRU94VzdxQjFTYjVISjJ4dlExU0xBV1ZST0tHVElv?=
 =?utf-8?B?eDFwdExXTmx1czVNbXVzSHRnWmpvZ3E1cTNYTkJQWmRlRTV2R29JdHpaOTdR?=
 =?utf-8?B?K0xOclF4SjdIckNMSitKSDRXU2t5c3I5UjJUUmhKdThPU091V2wvSzdpV0F3?=
 =?utf-8?B?ckdicVd0ZzZZOG5pV0Z0aXBlUm5Qd0VhRnRqVmRBNkpNQ0lhVXR1d1g5Y3Iw?=
 =?utf-8?B?Ukp5OVZEZkR5bXJ3TDhMckZCQ0dTM3QrR0tNK2hKOGYyOUJNeVpmUWxrRkZO?=
 =?utf-8?B?MDZ1Sm0reXh6SDlzV2wrYXVucG5YSjdGNUtHaFdxM21iSk9HS0ZsWDVTdmNv?=
 =?utf-8?B?eFdGanAwUkF5enZ4dU10MzVwTnVpZGZnNmpHbW1UTkFQVkRRNS9sRE5NN3NM?=
 =?utf-8?B?S0RBblJLbXRpdExZb3lGUHBNbWwzdDdRYnVMWUNiWnlWaDlWcGl1NG1oMDJq?=
 =?utf-8?B?STZ6SlFaWlpmQ2FYUFN2cWt5a1FmSWg4TEpTTDl6RHpObWhpY1NWMjNRL1Zw?=
 =?utf-8?B?Uk04Y1UramdkV0F1eTVOVkNhU0FoVk9xaHJIN05DdUhnYlVPSC9JZWxaMTJU?=
 =?utf-8?B?V2g0SWM2eGh2eXZXTkZGWUUwTjV4YVlIa1NqZkgwazJseVdMZlYzblZhM002?=
 =?utf-8?B?Vkk1TDZiS2cwY1dzZkNFSWc5T1dRRXB0OGpwNDFWc2dGTEYyZEhDM0FVREhI?=
 =?utf-8?B?WXMrZFZsK1NKRXRFcWMxRGVoRUFPNlRVaUhvUXE3MWhnNlRsOUJzSUNMMlNi?=
 =?utf-8?B?emhUOXIyUmN5QnExUThKSGFYMFd3T2JZbWJDbnFMY1dWU2JNeUdBa2p0My9N?=
 =?utf-8?B?M2FuVjBlTEt6OGZGdXFTdXlMQmpIYzVGb0dzSTdRZjBPK3ZuWjJvR0hyOXNC?=
 =?utf-8?B?NGxmMWQvQWpHYWpjKzh5WkE3Rll3WjhPZzdaM2NjaC9nNDFkbis1VXBGM3di?=
 =?utf-8?B?dnBDUEM1Zys1aUJFVWUxRjJJOUNnelVaRUFtMUU3NEx1b0FQSmdqN3B6NVBj?=
 =?utf-8?B?NjMxK1FBSzRPTG00V1Q3YnpJSDlPaExlWGhPZzBEd20zdEVwZWQ1SHhkUUhD?=
 =?utf-8?B?a0xITnZibyt0QWNjUjlvbEVCVzZFV3JNZGRRQ0tiRS83QWpDczJKNThldHk2?=
 =?utf-8?B?M05vZFAxUkYvM28yRnNJSWlCdUpPamtDd3ZRa1VuVVU2WmUxUlZCSlg3VGt6?=
 =?utf-8?B?U0U5RkYrNmFrbVZMckVyKzk1czVQSlhFTWlYdmp2Z3FwUU5uWEplZGs0eEpr?=
 =?utf-8?B?L28vRzdSQ0tZWkRqZnFIU2hwM3lOYmZIZ1kwY0FLQlYyUUsxaEhjWmIrZlQ5?=
 =?utf-8?B?cFZlWG91YjJoUGQ5a3JxRmgvUU5ueUFnMTMxMXhNeXl5eDFtN09UbDY0QUEv?=
 =?utf-8?B?aVpvRjJ6MU8xRWF3R1Uvc2FiVE9NSUpYY0RlcnZ0bGpvY3MyeUFWTEF0VHBF?=
 =?utf-8?B?S202L0Nna1QvZXNqMXhITUtuS0d5SVdxRHg0ZnJBa29Da1EvRFpHSTJEdnVo?=
 =?utf-8?B?d0FacC9FYU5lbW5UclkvQlpZY1llY1oralVRaU5CZUlIZGZPWlZUSUxzOTNQ?=
 =?utf-8?B?dTdzaGV2aUtQZHVyMDV2UzZrVmd3UUxNaXlrTE5GVjJZeDVRU1B5MERNQUtH?=
 =?utf-8?B?M1dxdGgzZTZEZzhHMjdyMTdOcDltcWx0VTRKc09TTytaN2tmRE9zQ21DSlVh?=
 =?utf-8?B?YXBUakQxUXJVNTVxOFBtQldOT3pIaStjVUZNSjNRM2VXTGdtUlB3N2lGaENj?=
 =?utf-8?Q?IKVR5mePEV0ZF9OsKB1CAxYcpAzNA9q1VxttDjn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944340ee-40e0-4342-d259-08d8d50a84ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 19:14:03.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoVv0q0EIApQaq2+1Csrz/YexHuQN1LKhHMRlSK+Sns7+EQ+p+jCy4BnhYx4/Fr4m2kYUjpVDJwx/jd0OD53BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5069
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/21 4:39 AM, Chen Wandun wrote:
> If hugetlb_cma is enabled, it will skip boot time allocation
> when allocating gigantic page, that doesn't means allocation
> failure, so suppress this warning info.
> 

Normally the addition of warning messages is discouraged.  However, in
this case the additional message provides value.  Why?

Prior to the commit cf11e85fc08c, one could have a kernel command line
that contains:

hugepagesz=1G hugepages=16

This would allocate 16 1G pages at boot time.

After the commit, someone could specify a command line containing:

hugepagesz=1G hugepages=16 hugetlb_cma=16G

In this case, 16G of CMA will be reserved for 1G huge page allocations
after boot time.  The parameter 'hugepages=16' is ignored, and the warning
message is logged.  The warning message should only be logged when the
kernel parameter 'hugepages=' is ignored.

IMO, it make sense to log a warning if ignoring a user specified parameter.
The user should not be attempting boot time allocation and CMA reservation
for 1G pages.

I do not think we should drop the warning as the it tells the user thay
have specified two incompatible allocation options.
-- 
Mike Kravetz


> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b6992297aa16..98a49cb9250c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2465,7 +2465,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  		if (hstate_is_gigantic(h)) {
>  			if (hugetlb_cma_size) {
>  				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> -				break;
> +				goto free;
>  			}
>  			if (!alloc_bootmem_huge_page(h))
>  				break;
> @@ -2483,7 +2483,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  			h->max_huge_pages, buf, i);
>  		h->max_huge_pages = i;
>  	}
> -
> +free:
>  	kfree(node_alloc_noretry);
>  }
>  
> 
