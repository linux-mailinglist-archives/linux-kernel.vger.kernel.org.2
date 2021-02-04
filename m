Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3B30FF6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBDVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:40:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhBDVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:40:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114LT11j048601;
        Thu, 4 Feb 2021 21:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WrM0+wXPe2yVnRJn2cq6RO3cpLKGoPaz28ZlD/tGZ6Q=;
 b=SrwQRMAlw6eGooQyW4mCDtl19R+UEqe78TQKJQgxZNVrpZktbjxUtkZXPWNvFo+JufXo
 w1fQX2MTA0IRUBM/K45Y0hA06+EsYhxxYC4O0pSPfAPLGuwajk7pfxigClnEuY279yKe
 yiR4w/c4A+fvAEXycuC2faGFliX4eTvRLfy7VXjyZli9KtD0u/CIcDDP4pMZiiiqFBFx
 eqvKM4voY94JNkKViXzmLCkPpCyp17rdIhVp9X0QYMbZ5/XKB22F4XS0U4fDQWTq9Cy2
 LknDTk6638j3H43npIP7wWFMQShMY48krwbtI+NZzz2rbh0nPvPpdnPZ1IriLodAAFJg tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cydm79jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 21:39:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114LOiEG023230;
        Thu, 4 Feb 2021 21:37:32 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by userp3030.oracle.com with ESMTP id 36dhd1y3gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 21:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhYeVSOPQqvn+e/JU5+pxUo/a4lysnSKowJaYVUDeyMU9iTUrp3pHazoxnmHAejeNfrk1Qdlu6kPDxX+8Db2NlA8TY6p1NbkPssH0FRp3uHJplqwAMkKrD/94wWKBFrOCcbGRq+3+UYHG2xlVtAdCNrcoOjSLgHBROgHvZPs2dW6LwqJ/pQyoAb4U4EQmh+K1I6DdMdt0MBKAqUIRMHVe/FuwiEB4lOsyMPkxfEgzRn+G2i2eip60NIM4ae3xK1/g15TtDMCUUpf0y3dejLGnuxv+EnIUsT5eHp04+BTrOjk13yBoTh94kEwykLLl1d9FMC0w2hM0UPBWT5k/jdSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrM0+wXPe2yVnRJn2cq6RO3cpLKGoPaz28ZlD/tGZ6Q=;
 b=FNTeVIszL94Upv1/Dh1TOeeAnzxUAcCSg82hG8CI34IuGlLgTClZTERWx+lKx9Ovw09i4/L1WecjXakxj9goyzkI1jqMIls8rIvxnp8tUhoPV2TAyBXNF30NSVajInjMrjdthCE/nnUdQ1+2b/DWhQnftkj/pDGdW1/vL0ukCMwvkokEgf4H2iRdpywmhmxdNFPj7c/kEN8dKIwRCtpVifxaCu+3sZ9r1/Joqp//zvAlC/pBnqt02ILHvJ14FGmp3N/omXleUmwI+V43fqa/N0dda/02UxVuE4xNWYy19W25lyHDky+VIsDZu1QuMrIWpTfR4X3hJbN3lP6r0+DD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrM0+wXPe2yVnRJn2cq6RO3cpLKGoPaz28ZlD/tGZ6Q=;
 b=M+cvchaSCmLvUzy18YC2wIaEOHwKN367RLruzIy2PANU7XYtTY2QKr0VWhyPW0kMaRfv3iGX7T8IlrJceIN1KVpSzvhrVv7fVcbvDkjamTbnMWOmwqwT/55Joqeox3VZqEMEGEFfc+/6xfNDblg4p56E3cN9D7I3/FjIaOMxnYg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1935.namprd10.prod.outlook.com (2603:10b6:300:114::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 4 Feb
 2021 21:37:30 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 21:37:30 +0000
Subject: Re: [PATCH] mm/hugetlb: use helper function range_in_vma() in
 page_table_shareable()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210204112949.43051-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dc041a30-7ed7-d4f5-9db3-10e352c5e6c4@oracle.com>
Date:   Thu, 4 Feb 2021 13:37:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210204112949.43051-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0357.namprd04.prod.outlook.com
 (2603:10b6:303:8a::32) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 21:37:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a711282c-557b-4e15-6538-08d8c95512f6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1935:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1935CEBB88E2508698680324E2B39@MWHPR10MB1935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmE5kZv2QbNpyO/cLhm5wPbLg72K9r/d/iTLfp1sCGql1rnTOxWotwa/lIaSU5r4Yob+DIUSrZ7N/Hv3tHZyYxQpjrNShb6dxxC9BKuokf/UZ+EuNbU1N/SJu6bv2K4SJUoq3REDCxJJO5dEUHDqglXMqWEP4mdc3I/oSqRgq1Sv4poqzA4ZZZfWEf9UUFpg77mZg2OqoG2cPGYPNmI7ybECi6jk/vI7DPzaUwJb6bb180frIe8ceszHC7fAk55zYtLsNSYYzrLd7I6V2jN9zSXUpWTb9O8zhutYy/g7Isx4rm6pAlsccKn0Act33wgPK0XQkVkC47tZaUX5Qz14rQ/tNaymOEhfsKUSGKZIRYMUHnfAqBddkKyV5y5sy9DYBdgRUsSeq4pMgSZNafV4m5K6GzB7BCPlvRv7aoCHhnllCPBOyBTTXSCyqtNFBiOrG6fzMpffFJ4n15xBd4j+xHSsyIEfyultW/60wCDlck5Reby4GcjinBLgCRP/V4jhbAMAuaZnK7A5aSEen9oohG/RoUuS5k9sXarKb+3625bBYxyC86gjkdIcdyDRFKkuDlKiIX44kXBjVn1ZZHCWFpmHypcwZfpNK/NJIF196O8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(66556008)(31686004)(316002)(44832011)(86362001)(956004)(5660300002)(2906002)(66476007)(52116002)(8676002)(16576012)(83380400001)(66946007)(4744005)(26005)(186003)(36756003)(478600001)(53546011)(16526019)(31696002)(2616005)(4326008)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ay8vVUNRWm83Tkljb0V6MG9tcFBsWERwdHF3R05FemRkNjkweitCNURMSFF1?=
 =?utf-8?B?Y3p0VzBYU2F1QVIzOTl0cU56OFRuemdXL3Rud2pwbnFzbFBvRk1RcHhvU1hY?=
 =?utf-8?B?SWk4ZHFaazhpK0JVMklPVVg5RWxITzlEOGU3T2gxdzJ5NGZKZmtCcktJQ1FC?=
 =?utf-8?B?eUh4M1JWY0V2V3FDTDI5eE9IYkJzYm91cmNpeTlROC90Y0FFZkk5Y3hPRVRz?=
 =?utf-8?B?QXZMcUF2L0JiWmxJbUNDbGJFc0tSRlROK0pGdXgwTlk4SG1jSVUyTW9SK1B0?=
 =?utf-8?B?VU1NTUk2aUJBQktYdVNSZWlDMGtxTWNSaHE5Zldua0NidUhmWlFWaHpNbGxn?=
 =?utf-8?B?ZDdUODB3b0lpY2NIc203bThQWVhSMGt6eVBrVWhQYzdwZmovRnBEeW51Ukwx?=
 =?utf-8?B?Mno1VjNnaVUrZ0ZYUzN1M00wbFloYUQ4dEt5NVhWRVRycENaVmR2UFhvbXNC?=
 =?utf-8?B?QU9tU1hvSFlIbGEwNFRhbkJ1WndndkdWWE1qNXF1RTk2K1lqWit0N05SditS?=
 =?utf-8?B?ZW53ZlpvcjlDT3FQWEgwVWJFNFhzMFJGa01kNnVScnFTVnNleTZ0VWYrODFT?=
 =?utf-8?B?VVJIWEdoWkdydm1VbHlkMGladThyY3YvV29DcXcxcW5YU01VNmYyb3BkNlZs?=
 =?utf-8?B?dGtYaDNvSm5HczJreDNOa0F0UkhOMVhCaG5CTzEvendNeDRlelBSWDd0QkVG?=
 =?utf-8?B?TThMb3pSSzdyRXZlbXcybXBKTHF5c1dYNVluVStWYXNBNmhOWkxIcGo4UFUv?=
 =?utf-8?B?TTdNYWUxVEtINWFNWkphenNEVkRxVmdBQzdNMDFLYVZta2dlVlhLd3RDMEtz?=
 =?utf-8?B?a2hLQ1g5M05MZ1JwSjNzZThzeCswRDhvQXkvSlZxUjkzUDgwSk9HQ3pvR2N4?=
 =?utf-8?B?ckd1T3FYclcrZ1BGajJtTzFkSDdUczJtVGNNSzRUTDB1eGNPWEtNVSt4QU4y?=
 =?utf-8?B?OUQrQ01EMVVlayt6ajl2R0RSNHNMb2FvTDEzQndMT2p4VW45MDh5M1orNzZw?=
 =?utf-8?B?aGVJbGdUTkZYbzVadzVyZjAveHRpc1llMGFMeW9LSTdoNXRMMnF3K2F6Zjk1?=
 =?utf-8?B?NWZuVGVjRTUrL0tENlk0K1VtWHZyQmVwRmNBcXhYTFBsMzVuc1lYSXh1Rndm?=
 =?utf-8?B?WXFaRFVzM2NlMGxJeXNtQXFkQWNPNnV3Z0JSbU5sbE8vcUNScU5ETG5iaUpJ?=
 =?utf-8?B?c1NjYkVTaWZyQ1I1eU1WMmlEUUVGNit5QXYvd2VwV2ovdU5OM1VWdlRrVmV1?=
 =?utf-8?B?RlBBb1lpeTV6empNMkt1dXROc25zL2RwVmMyYkcxUVp2Z1BsdGUwUmp1UXJt?=
 =?utf-8?B?SXkweWhSWC80VS9EME1zcDdQRzR0UzJxUElLL1gwbG1QT1Nhd1FDVUNvTjgx?=
 =?utf-8?B?ejZYcW93OUd3M2JHeU94bG5CUlhoOVdqeWh1TStVUW90bHZuYjhHM0kwUFJ5?=
 =?utf-8?B?TTVuVXdVYjJOTDVkSjN3NERxeURsbThKZnM1N2ZUcTd2OTJsTFZ6VS9hdWFE?=
 =?utf-8?B?OHMvTERCOXoyVVhXYkZoM2xaYVY3b1pYSDNkd3RhWE9VcXpEOTJkQlZmOHNl?=
 =?utf-8?B?Q2dGck1rR0dkU3RRWVdZLy9WcnJRYzluQ2NUMExlVGFIclMveEY0cms5dGVC?=
 =?utf-8?B?em5OQzZjdmh6N084Q21scWFhSm8zZlJjK3l3ekRsYVorMERPN3pKd2M0Q0FW?=
 =?utf-8?B?eWk1NkQzN2xnNjJCSGFHNHhjVi90K1lFaXJjT2hDMWRWRGYyTno5MTNMY2t6?=
 =?utf-8?Q?1wCXXA+tqgNkMemuDaF+ansUQAqb+tl4qHrh5OV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a711282c-557b-4e15-6538-08d8c95512f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 21:37:30.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cA+FvjOb754NLNjRE6gH+G3V4BK1VCDnPCFB57Ogu9zEdxfW6Kj98nU+URvHCGiWIHnCs2s8BVciyhAzXCn9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1935
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040132
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:29 AM, Miaohe Lin wrote:
> We could use helper function range_in_vma() to check whether the vma is in
> the desired range to simplify the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cf82629319ed..442705be052a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5237,7 +5237,7 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	 */
>  	if (pmd_index(addr) != pmd_index(saddr) ||
>  	    vm_flags != svm_flags ||
> -	    sbase < svma->vm_start || svma->vm_end < s_end)
> +	    !range_in_vma(svma, sbase, s_end))
>  		return 0;
>  
>  	return saddr;
> 
