Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA230F7EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhBDQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:30:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbhBDQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:29:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114GF3Xc064864;
        Thu, 4 Feb 2021 16:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aU/LPiVglrVqcxWUmi4zz5D7r0rN9QWjH6hR3mu+S+U=;
 b=P84OEMY6UHOtzMFviXidvkamD8VNbJyvmu1seXylj6UcsxBT/6RuTACeEHP30PBVG5ZC
 gVRIKdG6aJ4HpP1OBpP1m4D/5ThtoCeU7B5+do4bDlVhcNQ7EAiAA5aMd0+rkEdibAus
 8K06X24G5OQ+AdmU7ORAeA656s4NI4YAfFjueYkf9LL3ndW76VeO6T/KBRoWcv9jtnLZ
 kV7xoNDAbToVXIDM6EljlE53bDVLHQhAkPFxvVmys4D0l9GmA3Q9h8QYwFD0mAYOgqg8
 pc52S0jx6CKnV31zPkvcHG/Sw6738JfUFS6xYgo8y2fXx6odYw7oZ75gzZae4H/crCSa Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydm61ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 16:28:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114GGKnU097124;
        Thu, 4 Feb 2021 16:28:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 36dh7vce59-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 16:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaZIUQEHT2/a2X8tneJ1fyE4nJcr+qMtlCs2d4FwtDXv+1u+etGv6hQOlGQyXX42Rp0/UML1OC7wY2rvxkXgNfIQTm9dRdfoyI3qWTmete1MV+0H6xJjzFDz+NjqJvBWB+XXHr9jgdUgCH9cBz8Llu5MhVJjbFZ9ER+XnN7Sm4ytos1J5v9Yk+A6N3J+z+vZgrHpMgDZA3QKHF9tRozmM/wzA8yyEUjdNEfjK1A6JQLpHnBAj07cNz4kkvz5sWxMCDI0nORrZLB/SnszT8uS8R1q7NpTRF4phGzOs7+6ZsXn77OHwlLXEDw1iW8Zl+Dpg9dhaZ8vCqwNyh/q+Sg/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU/LPiVglrVqcxWUmi4zz5D7r0rN9QWjH6hR3mu+S+U=;
 b=Bv+y2khehorN6dpXGltp9vWzy6/aB6MNQb9F+nOLcI1W8eJ8823N3sdjkGyZTs2hE0MjzKLoOs5Oz9P8TyASws1Vm0FiUiWHUfSHJDhyLFuGMcMixJm2Ivr/JNZoVq06OCAjnV+d5zAjjtoNVVu/GFbe8pIAZ26sZs82z+OSfiY4Cr07+hTzo/7YPiH99RHu6Tw2bTnfJJEHa0E1RBGroCRefdgtAza82Wn6zlAZx8kdo5yz0ugNq1gZhpJdNw9AEuyIPR1A0c8FXLjsosP/3Fpx2yOhS35OAhnjUDWWt2lhABJw7OfzYDb4/WrOaTAeUWdxkSb1Ug851BR6PDMl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU/LPiVglrVqcxWUmi4zz5D7r0rN9QWjH6hR3mu+S+U=;
 b=nqfAixryC+LN0k5aoKFnwnx5xjBjwZTGeqwuOjitmlgf3gewpFDqnuYZ+CBfrCOxkelSwSWtfPT0P2p4WjveWwR/OnqVyaGQoy9VRmRfWeHBf0Rhlpt8S/2V+JaUjmUf0E7b2LOveUI9qf/sm9m6kzg9A1LthZiIBks7iU+XL+Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20)
 by SN6PR10MB2704.namprd10.prod.outlook.com (2603:10b6:805:49::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 16:28:19 +0000
Received: from SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::d47:b19:f750:c969]) by SN6PR10MB2701.namprd10.prod.outlook.com
 ([fe80::d47:b19:f750:c969%7]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 16:28:19 +0000
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: Remove unneeded return variable
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1612408323-23579-1-git-send-email-yang.lee@linux.alibaba.com>
 <cea953c5-79e7-8bd3-13ca-8ee4f25ff03f@linux.alibaba.com>
From:   Wengang Wang <wen.gang.wang@oracle.com>
Message-ID: <a1bfdae4-9b54-9797-22fa-0361292dbcaa@oracle.com>
Date:   Thu, 4 Feb 2021 08:28:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <cea953c5-79e7-8bd3-13ca-8ee4f25ff03f@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [71.198.166.82]
X-ClientProxiedBy: BYAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::39) To SN6PR10MB2701.namprd10.prod.outlook.com
 (2603:10b6:805:45::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-158-151.vpn.oracle.com (71.198.166.82) by BYAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:c0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Thu, 4 Feb 2021 16:28:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94b834c-3111-4f22-3926-08d8c929e1e0
X-MS-TrafficTypeDiagnostic: SN6PR10MB2704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB27043E6FF1E7C4851952FDCACFB39@SN6PR10MB2704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUhmR0CoU5Esmw7VI29qlZMsd8Mw4l4VZehSScL4OOeTkBdYmwSdv8sTfuWX4x0socCZBqB1XbMrJqODotST5v2r3rI5SWQ3yrEkCFyMXSDQmc1xX0WQxqgUofDvHJi4f72BGsujt3ylnFTlnuqr07lDBjVtuXBifIB3nMy6k1UegjKITiqe+PfSF+UYuIRNirUSejkO8+tdmHtuxIh0Q7eeZI2Kb1AYxTuvTdKkqAaEz6iCitliKsPVcOr4LyJzA4suMRrJWCbG3HM0uZ+15cQOwagVAInOnFLo985xPVcrYsqAnkxNrm+c4pSlGTJ64jwvNlRRdp0m/vG0QoexAkVpmWIOIXEznQtLi8uThRVP/mw9gAxvxcbOVvgSfY/Chdg5xs/J4y4bQlni2F4AZEjiJ8iH86Zvfj3KfCGleFRjDU/aSBYJAmlUx2NBSEAZ3FzimTUrjnPkfXrKO5UQe3HxpYwhYP7v3IRB9BvRmcfgGPSjIP4bl5OYULhLKWUtDhybdTF9FzDn4jdPdklBMKH1tGg7BmeBKDOkqqN/U6iHsRyKmaWI0qhNJrie8OKp6TmJZGaBhr2RNYDYlg9D0HnB2Gq4co8bKgTfWew5S4LnEPghvYBd/PARzV7NpgIs9EOTxL+W9K+elsfVWzss1QoxLrOyoB5xcdt2fU/+qH1+xNqenI//ChuT4eP+jh7I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2701.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(376002)(366004)(31686004)(2616005)(36756003)(956004)(8936002)(31696002)(110136005)(316002)(8676002)(7696005)(52116002)(4326008)(66946007)(83380400001)(478600001)(66556008)(966005)(16526019)(53546011)(26005)(186003)(2906002)(86362001)(6486002)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VnFiSGtISW9iTWFMTk1Gak83eFFsZDQ0S3JaTmdId1dadVd1Z2xtbGxoekJp?=
 =?utf-8?B?ckUwYnBFdnhhbm5wWkt3YjVkR0QxWnpKTjhEOUhLRlZqOXlFSTlSb2hVdDFV?=
 =?utf-8?B?cVRSdHhLTzcwdUVLWDZ0SUVMTy9hdjFhblAvVUZoeTkydUdORW16N0VDUUh6?=
 =?utf-8?B?NXJyVFVENFlPdTZFK014R3RTQklGTHBzWERLT1ZvNjRJeDBCNHBqUnRWT21i?=
 =?utf-8?B?NlFnSEF4KzVEelVqVTNESlhnWS9PaWU1bW1qT3ZZWDlWRmxNVDRocWJlQVIx?=
 =?utf-8?B?L21aZmE4bmoxL01mR1RPenlxZ1h0QWUwVkhOdVozVGdob3VqZnB4RFZSM0hk?=
 =?utf-8?B?VmordTZBUEgxYjdNV1dpaWp4QTNjdnpndTBMQmRkR25Uc0huYk1RQU8xaUFv?=
 =?utf-8?B?WmZuV2JVRTRCS3phcG5Ta2owb1lEZEpUeXFaTmNoNEtGYVZzS2VDM2xuanEx?=
 =?utf-8?B?VlpNcGc0S0sxNWZVMklrcHhKZ1diVy8rRkFoNDFobGVBREJ1RlVwcEw4ZnM5?=
 =?utf-8?B?aVl1NklCTVl3YkdPOEdKbTViQ1IyYjBvTzNTeUc1T2dtaTBYVC9iL1lHR0lU?=
 =?utf-8?B?NmRPdUVMK3p0VWZhajZoMzg2MkhlUVRVVHlvT1AyWUF5MDV5VElsa1Z3amNH?=
 =?utf-8?B?U1NyZUt0alc0REpHWENPaHdIVWhSbEhuWEFxd1N4V2E3WGlIM3gvLzY3Yi92?=
 =?utf-8?B?NzYxcVpqTHdhWHZReWZ2cmhyU2Nhd0FGbE95RDVRb2NTbVRNZFNFbG5yUzdw?=
 =?utf-8?B?M0FRdWw3ZzRMOUJEUW1RSlN4S1dkWkl5Tzh5Zm1mTTRaT1o4dzV0VUN0bFh1?=
 =?utf-8?B?N1MwUC9BN0tqOGo4VXVzUVpFY0FSZWllUUI1c05qZ29LOU55Nm04UDhqcWhp?=
 =?utf-8?B?MlpOb1kxMVF1V25LMmVaZlBDVHRueWtTRjdoZEFvOWVTRE9ManZCM01Nbjd1?=
 =?utf-8?B?bTdtUkI3MlFvVnhpVVJwWHNFUndrUHViSEJOcjdpeE5mcmJ4dEdqdXRraTM4?=
 =?utf-8?B?V1M4MHJpT2xzQjJDTTFGdnF6M0lJMi9JbWZlVExQZVFZRWl2UHFLMGZ1R2x1?=
 =?utf-8?B?NGtLZlA0Z1ZlTjNhaHFhSElYY0FENWpNRlpqVEpFSXJDNWp0OXkxS1YxbERo?=
 =?utf-8?B?MFNTQUVpQUV1eXBmeHVhdCtLUzc4UlRWUEZUamlmVkR6eUR1bzJHMXVvVlM3?=
 =?utf-8?B?KzhoOVNCSFFMbHdPRkNibWJHZG9ma25pQ0FEeUFWNXozQzB6L0NQYnZqcmpN?=
 =?utf-8?B?cHJ3N3FESmkyMW5IQkt5TzNpKzlYeXRSZGZpaXdyNnRvUWxZMDZDM29LK0c4?=
 =?utf-8?B?bkwvMDhqMWNKdTlkcFZFQUd2eWFzWWZEeXp4SHNuZGdDdVp4YkIwMHpHbEZE?=
 =?utf-8?B?WlBQZjNMVjB3VWFJOTdzeGpsZFNJWi9RdGYzQzBrb1J0OEl1YUgydU94dEI1?=
 =?utf-8?B?cUM1Rmd4Nk5sR0Z2bUE4NW40SzE5bytZZXlyVnBGT01nb1JJMENtMFA4K3RV?=
 =?utf-8?B?c1Rxd0FpTUhkcjZRMWRwNjgrRERiZkdIMFgvUmJQbEVYNy8wSjF0RzR5T0VX?=
 =?utf-8?B?cFNxdVlnaHNsWTg4eG83d2FrbFBpdnduL0orNVRIRkNtNitkdzMyb0txcFlr?=
 =?utf-8?B?a203WkVlWmk4QS9kWDRMTmNxdFllcnNwdzA1bU9pRUpHbGFCbkNpU1d3aTVn?=
 =?utf-8?B?aG92d29pUU9jSlBhY0h3RHFxRWZ6M3EzbVhmQVJpYWJYZUJINHhoanQ3WGFN?=
 =?utf-8?Q?jlKEqvDerzA+Gj6/g5sYe/nemBx3zoERXyDZBlZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b834c-3111-4f22-3926-08d8c929e1e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2701.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:28:19.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CIp22tX0LHPOxEe9TNXpCFWoIvbVclTNH9iBlFYq0CUOjNwCg+I3z2F6noa52WHjP53Cw1tnGXfL8tDTZEYe60fCfnPnfYIvsdloMH75/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2704
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I think the macro of map_flag() is ugly. Yang may want to fix 
that first.

Thanks,
Wengang

On 2/3/21 9:12 PM, Joseph Qi wrote:
> NAK.
> This was discussed before, please refer:
> https://oss.oracle.com/pipermail/ocfs2-devel/2020-April/014969.html
>
> Thanks,
> Joseph
>
> On 2/4/21 11:12 AM, Yang Li wrote:
>> This patch removes unneeded return variables, using only
>> '0' instead.
>> It fixes the following warning detected by coccinelle:
>> ./fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags".
>> Return "0" on line 84
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>   fs/ocfs2/stack_o2cb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
>> index dbf8b57..2da9633 100644
>> --- a/fs/ocfs2/stack_o2cb.c
>> +++ b/fs/ocfs2/stack_o2cb.c
>> @@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
>>   	}
>>   static int flags_to_o2dlm(u32 flags)
>>   {
>> -	int o2dlm_flags = 0;
>> -
>>   	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
>>   	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
>>   	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
>> @@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
>>   	/* map_flag() should have cleared every flag passed in */
>>   	BUG_ON(flags != 0);
>>   
>> -	return o2dlm_flags;
>> +	return 0;
>>   }
>>   #undef map_flag
>>   
>>
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
