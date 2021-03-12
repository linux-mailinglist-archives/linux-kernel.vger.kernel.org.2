Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C35339813
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhCLUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:14:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46856 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhCLUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:13:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CK9dii147529;
        Fri, 12 Mar 2021 20:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T/IbeDzam8FFEPAoPCyV87WKBGLeyZHJlwXV+iD7Gso=;
 b=WNhn9GsxJ9qxs6Uib9vcqoOQh5MdXWxKmOboO+1GOwCZJwh7/8gAvcVT8p4T0lETlV0B
 JHijWX3wV5NxpdjQUU0IIiBYejxAcRVFWlAoP6BfuAnMV69TNeflwqGLr79we9epaUPG
 QCKVAP2HztBJbkzA1jle+ZQE3a1se9iTZrxvBi3HJ6aMXl0EOaK8c+c0HJOXzTiPC58e
 DiHrlGlpV89dCf59Q2oMYUtr8fzDHIGCXCAGQY9PWZuoDVrN2BxOcp1bFDpDuoYZjLCJ
 JfLDjhKJSvn/hnE2poTYIbPHQUokm1xHsFWm6QbiVuQar24+9bm0X8tCSw3+sKTrVDCw hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 373y8c36f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 20:13:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CKCxCm054572;
        Fri, 12 Mar 2021 20:13:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by userp3030.oracle.com with ESMTP id 378f52r137-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 20:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8+CLZbSKz9tbE2VavP90fL2MLL3LQyqId7sJrub0YDhY5Whb6DftLst5pPXmMl0tajNYTtQUA81wobQAqozTVXVrOw9lxXb+vCoRrzwc2hkzSYLqv7lH2eBn7aJLVXjTQs4Vxgh1mD/ZxV2FFACVN4yosJ6eHE36ssGOLLmdrRTLBLAl2LxQMDgb4o7yFrnJVRkyO84knRwBzcMrkJuQxrdKQ2l2QWeWw+XcC+c6uS2bFoWTdoxDeBcNPlwg2bk1iuLKcdWqujIJmXzMeX/0XwsYv/gBMjBvXLmEl+QSQ5cVXOof4CVE3hOPmwksxQF6+wj21MeqG23xYJLMMqsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/IbeDzam8FFEPAoPCyV87WKBGLeyZHJlwXV+iD7Gso=;
 b=Sy/EadQexwWNWZlw0xKRI/kupTuDzypUr0JYAK+RDoav16AagEeKzlEIp+8KbudAwmfXwxRauZpUBERc4fB8FVF7Capelq3jJe2EHmS8kWWQS9QAIndI4dDtTStySoXeu5iQFSLBGD8YK+g7Mv4bsk0vu030iTTH+bBSll3KVe/8J5EgjbVxx9hgLHxCpvEBoegWZm2z2lG85L+Aetp8glnyfK73hE9t7mRoLEZ+oNcAeiCGKggByN3J/O7Fr3o5rR6Hep/wHqjWZKJfkj4by9HQxdsn1Kc7AVjPl9WNJDKUfsAT0De6a0PP2CAvh4VrpxFv6UylhFlxTYQ+Fp1U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/IbeDzam8FFEPAoPCyV87WKBGLeyZHJlwXV+iD7Gso=;
 b=DRrXjvbK23loK80x5VAS5MOLX1swZKDYqc1Sf081EfZ46Nqj/JYkMxAk4OVqcHB2upyP+iWyWSkYzkWeZQmJIbX6sQyINE/JeJ3x5UvK/OM9fc7ozmtsXy2i39JTnQ0hoScaAi6HhpkxBc6ADodPMXW034js8nThkhIL94GZkn4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3157.namprd10.prod.outlook.com (2603:10b6:a03:14f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 19:58:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 19:58:14 +0000
Subject: Re: [PATCH 4/5] mm/hugetlb: simplify the code when alloc_huge_page()
 failed in hugetlb_no_page()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-5-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <987f50e0-5511-7f53-c4b9-d8878d840bb5@oracle.com>
Date:   Fri, 12 Mar 2021 11:58:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210308112809.26107-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1201CA0001.namprd12.prod.outlook.com
 (2603:10b6:301:4a::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1201CA0001.namprd12.prod.outlook.com (2603:10b6:301:4a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 19:58:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a660517-2b3b-40ee-c030-08d8e5912bc0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3157D610884A33D705DC6D48E26F9@BYAPR10MB3157.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+o2i6MZWefI5g1FkksdnUWifesngHcEmjdy5hpwua4kvE2M/xoIkRIgvG+z+1cmsDhTHuTHNg4J/Jx+X8W32l+Mp3tSKs++zWRFPcIJ5lCAZoid3lSwPJ5UQjser2ZTcidlKCbNHi3CxkOQxf/36ypWu57W2rEv/oBjANhionAtfCxP/qVdzf3mzgVCRP9ZnXYYKHdPX9ewOvVVtDINrvcD/uk4pgOZ1s6IK6QHoMqxagUj2HtWzEhDYK6+5r4W7dwbtCWJZmAnGqAWUGWMC3F+/qhztqUNXBsFEO0Kgp52o8ILIe6J2Z81ni/1Da4MdUgNd1GJP9kBUWp8UtIS2m+Ah/Cdqnp0/bGiRGcMYslwVzYP4QU6ZsT32IfFf2pFO92sBwk49NmyIILFYBfWq48q28IfLkOdl++aJUV40akWPit0R7dXIqBIzP9Lsy44Icev+tSNQANj3mo/oZOvHzomYWCEB55MnLFT3wTXI5LPYCml4sZEpH0krvZArwr8A03204XQM2qabFnLLgjJzABWwQtxlD5+0COdtkj2GXZRWN+xPCnlp9nw3XlPOVQ0EZ/75GZWzMSVPVsI4GNOyPR9UaEAPbW9LVFKgvdSOXV/loZ5Gq/vIbpjCH4ki6/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(8936002)(5660300002)(2616005)(66946007)(956004)(66476007)(83380400001)(2906002)(31686004)(66556008)(16526019)(36756003)(4326008)(316002)(16576012)(186003)(26005)(53546011)(6486002)(478600001)(52116002)(31696002)(44832011)(86362001)(8676002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eDMxc0ZmL2lmanB2dW0ybGZNUExGTmlERDdCTHBmM1VITnNPMUdWYjg3S0lr?=
 =?utf-8?B?VGdRMlY0cm9zb0RpeTI1dFBFZyticTdNOENweFVvLy9DMjBBWFNPeTRMZWFu?=
 =?utf-8?B?RFlSa252R0NDVXl4T0diS1pvZjVxRDZzQUdpS1B2Z2pYUHpVeXFJMnVnQUZ2?=
 =?utf-8?B?UWV2N0dGVldEM0N0V0I5SDJ2Q2FHZzhxSWpZZ2dsNC9VNHI3T2VZSGF1YjRS?=
 =?utf-8?B?ZktWejROY3JtYzRXa25vWU9Lb1Q2UWIxNWttQ0tVeXNDQkhiMlNVblorK2lT?=
 =?utf-8?B?eksrNUt3eHYxUjhVUkY3K1p6TG01YmxQTmQ1Tm5hTHBYUzJUUXNDMm1iSzZV?=
 =?utf-8?B?QXZ6MHpScWVFLy80bWpvTFB4N3ZWZkgzSlk5bGNYWndTZGY2dHNkT0c5MFdq?=
 =?utf-8?B?UXZzV3Ryb3NxRXpIOExOZVFFVHpJdjB3YVJLaU9KT3oxbXBOc2hiUlVEUGdz?=
 =?utf-8?B?QlIraUVEcWcxU2VUSytiMXVZMmNJMW9DMW91b2R4aHE0eVhKNTI2MHFwQ3VS?=
 =?utf-8?B?c3FwekFRUDNITzdMMGkyd0tqcm9WQVo5cWxBUFFKU3BjMndzYWZZdmN2K2po?=
 =?utf-8?B?VEt4dUk3ZWlHaFc3d1lxTjlLT21jWWxYSzRaZXh1b2hUdFovUTRpbnpzcXlC?=
 =?utf-8?B?WVlIZTZoOG1aVVYrRTRFSC9vTHFGd1kyakNjT2JlUWowQnBObXZCMUdDeE9J?=
 =?utf-8?B?SWJ0NkhZUW1DQTlseWtxUDBrTVBFSWxOa0hyU2RUdkJlMlBmUGNHcjJleHQw?=
 =?utf-8?B?M3k0cEJlemRWNWpIanBGZ0xMVFd4WVo0cUFacHM0Sk5OaTU3bzYwQUhML0Rm?=
 =?utf-8?B?M0NTYk84QUIyMkY1QnNaM2lwRHZGNTBEVHFaRmFobzNud0s2U3ZabFkzOVBH?=
 =?utf-8?B?eTd5dFBLNnV1V3ZKVVVZcFBmWVAwZEVxV25oSWpKUEZ1d1Y2TmEwYys3QS9j?=
 =?utf-8?B?bVh3UkVMaW5OTVB0VHhKWUJiT0UrT1N2ODVrMkEwMitDTGJJTzJ0Uis2WEhv?=
 =?utf-8?B?WHdwRm5NdExTUTVwbzJNL2tPdjY2S0VOK2FZYUFWU3ZaUTNTSWRqak5KL2RE?=
 =?utf-8?B?WS9RaGQwL0hYcGNrNDZ3QUpGcUh1WVlrcEQrVDkyRFE0QmFyN3B4OTVXL2hh?=
 =?utf-8?B?bUdWK3VlYjNsZ2Fuc1NQb3dIL3BsNEhQOW1hYTRnWm1hdVhNbmE5WkwreTNw?=
 =?utf-8?B?eVUvTWU0SXdJYXAxYnZ2ZG1SdGd3OE9YTWcrYkx5bTBVTnk1eGdENWVjSFFH?=
 =?utf-8?B?VnZCTjFCSlRHeisvbWxpVHRnUmk3Um5XV2dSRHc3TGNWTkNtOUhVUXBxZDV3?=
 =?utf-8?B?UkJ2emI4ZkQ5SU5jc3ZZYWl4SCt6VnpvRFJhTnYvamdEWlpqUzliMmNBOHVk?=
 =?utf-8?B?MGxBSnNybWV3aTlxQ01yU0FvUDhDNktTeWNSYVhYUHpNRHNJYm92dHRVRGZ1?=
 =?utf-8?B?eW4wRnBRQjZNb05QbmlzVGVYSkFUVENVUFFtUzk0a0NBb2NaQ2Jkbm11c0Yx?=
 =?utf-8?B?QW1HbkFKOERqU3ZWbjFkbGZvMitJSVFYZ2ppeHFXcGl0MERSZXpBRHpuWWhT?=
 =?utf-8?B?QmtyeHlDS0lydUFvZkRESmJjLzE3YWVPYi80bXdENHBmY3g5OGhmTDI5bkxW?=
 =?utf-8?B?eDByRndYUFV6UmtIYkRLQ0ltbVA4azkyL29zc1dvTkF6THFxY0NqSUo1MUpz?=
 =?utf-8?B?Sld4dXliYThISHFENGNNRDc0M1JIY2VnTHNUUlRPWDYyQ1N4WjYvY09TMGdF?=
 =?utf-8?Q?91zUEtqhr9wG7N/5+2iZBKZx4FZ9rEwHdvXWM6W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a660517-2b3b-40ee-c030-08d8e5912bc0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:58:14.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSEeuZNwYjtVbgAwq2mwnDZX6tYS4u+zQstGG6HS3s1UojmQc5kIZFuvqL2mUXdPGR3lnf2h5+SlqcMznO3wcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3157
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120147
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 3:28 AM, Miaohe Lin wrote:
> Rework the error handling code when alloc_huge_page() failed to remove some
> duplicated code and simplify the code slightly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 695603071f2c..69b8de866a24 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4337,13 +4337,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			 * sure there really is no pte entry.
>  			 */
>  			ptl = huge_pte_lock(h, mm, ptep);
> -			if (!huge_pte_none(huge_ptep_get(ptep))) {
> -				ret = 0;
> -				spin_unlock(ptl);
> -				goto out;
> -			}
> +			ret = 0;
> +			if (huge_pte_none(huge_ptep_get(ptep)))
> +				ret = vmf_error(PTR_ERR(page));

This new code is simpler.

The !huge_pte_none() catches an unlikely race.  IMO, the existing code
made that very clear.  Would have been even more clear with an unlikely
modifier.  In any case, the lengthy comment above this code makes it
clear why the check is there.  Code changes are fine.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

>  			spin_unlock(ptl);
> -			ret = vmf_error(PTR_ERR(page));
>  			goto out;
>  		}
>  		clear_huge_page(page, address, pages_per_huge_page(h));
> 
