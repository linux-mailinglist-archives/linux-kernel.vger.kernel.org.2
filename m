Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D25E33CBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhCPDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:07:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCPDHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:07:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G34beS071122;
        Tue, 16 Mar 2021 03:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lkD3w3blf6X2UwGAlxiOCKcEY+JwURTA2fTSaUO+NMM=;
 b=eaTwYlHu6/zLmt2Ey0P5KNnKQHnwYyjrNDdISoergVqbrk8C7T/5nIuqK2a1DhwccNH+
 TKkzamHEqFOsOkNQYV0SE02z/56dakDgv3gdFmdCS5j1xQjkWLV45sRvwSKbauvMZQMr
 TFyNvCB7uo8esM5Dpo8EyQWeErkC4UPB7G441NkOE1WwiOEDmAICilpOgWh+3RR1lFqL
 IV9s4iB1Ktr880odaj5670HBmmeh/aMsDT2SVGe0BYoUW9L1UEA8sEBf88fud+HI/n1q
 T2lI5WPuBUBSPfklncteKOct+HYd9gFpMF3dcjOWzC9T3fV8kVMnFjXv/bPtMsScf40I BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4ekk303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 03:07:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G35nQa071771;
        Tue, 16 Mar 2021 03:07:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3797ayg4gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 03:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MByzmlMJIBS7rbmrDsfrsXp/PkkSdC/FRhm7fb90soyIkMmUBj5D6rLhQ1C51m3HJOXHIIAqNsiAZdzscLl2A5NDUEJfRCs6uE6Dqsx+gnnWGwbcVogOnYkdSobP+Ixh7jeDZWf2D1mfrw4C456Kseoz+pMpZPuWBaovnCeStey9kaIqp/eD6RU/ScgakVf2+Hk84LHpYmY8iTWvx/RYLjrP3ZcOQGMdECaplz8uOfpF99o1PloPn7CLuLclbPlGzYYTjbYHRPbRB6ccdElY2xG9ZPiM1fcmx4VeZpVp9cD1OooTXr6B2PnDPhv3TSCVQAqAW+MlcWeyLJ3/BYa2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkD3w3blf6X2UwGAlxiOCKcEY+JwURTA2fTSaUO+NMM=;
 b=UzwKr0fRpAMp6Nc/kExq8dSwy3Q9xpoEhLOlxZ16BaNfhfaGwM2kBuq97dDowlJgtJ/FHAG13wQQQv5RHTw897rJCaSPmGxk7tMX4sM1euTfU8YD6ODlTcWP+Ho/BQ8sk8dsQTy0c2KaUm6+4IX7c+ek0hqqIfdgNG6pDaRPk2bFGdfgGgQVoxFjzXYL3yCHcsrjlkmDQl2YqA8YMO8EXDX3bobRUaDORiKc5UZvYUXaa7+lhj0xlyhBUQAgyWHXNnDJMVLolSC6eJD4q2dI9KkXdD9V8yhOA31B2mOfA1nH/6IPlNr2lXTnJSlZASmGLwAlfHVpH2og3iuCdMkdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkD3w3blf6X2UwGAlxiOCKcEY+JwURTA2fTSaUO+NMM=;
 b=Dfge/+MM3kPGqDCLDoS1G9h/0ZWwTdACuEPMpWJCD+QXMk6KT4ahcskN5DbUiigkU5Z8OXQ7CK3GWWMeydCgY9auFOSA+WI1Yq0xtUvh8saq0QKq6eJv7qjlKyC/788f8aD0mzToPwIk0XVseifkw0MGHtT5Ed9T0w7YUHnM01M=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2949.namprd10.prod.outlook.com (2603:10b6:a03:8f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 03:07:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:07:02 +0000
Subject: Re: [PATCH v2 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210316022758.52993-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d87264fb-0005-4f8b-7551-a5439108e9e1@oracle.com>
Date:   Mon, 15 Mar 2021 20:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210316022758.52993-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:301:4a::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1201CA0024.namprd12.prod.outlook.com (2603:10b6:301:4a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 03:07:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be66f4e7-d43d-440f-4ee7-08d8e828925f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2949612CD0CAED7F98E4A0D1E26B9@BYAPR10MB2949.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aer5yvwzSg1k509nPk1rFPknt/kPSq1MvnJDk0s4klbNfsiu8EymHFVZ4TuRxz3NdbILuogAa7l0ZEfXQUEqahz9f+Rdt+wwURq2TrRybV754NlRjtfzYWNNSPPwGWWQ7t4zCio1rY2PG0J+n+MrATUggkQKa95q8DE7FLqZMTf5M1X8Y6yop5yQ5cm2A+RV3IT7nciEei2zgmqkVRXf+UrmCFbuLjeg3PMPrxoS7eN/4xJllaHZSYxygfZFLxC7uLc3rOCaceewmxBGi4hUQQgQLmZoUe/ZvsXYwKULLkl+LmU3cMK3VRxrIvSbnQuFTJ6VK3Z961POnGl0beWwv6MJZIbBECmrs77OjduJjrxpk1I+N50reAdOInQsPHVoUof6lSIkGrYnsve4guXUJeqdckFcM7b5wcNHNq7jyG6EbPMGR+gvNcFBbOJ2CqMVxcrc2rSquAftc2Rgtwlu3SG/PrnkSBgKHI9TQdgMoq2aMIRPq4BOauES/TJ4+pIO/QgZow6wT+Xcp15avUAYNcDcpA3TIJfXHg2GGWAIwJIlBMlvOhV5od/niBFEGDCpTn2R7aIDSO+0fknq7PMpEgyoTCKtYMQ02mTXATPwVtr61i108ESCpngsE8/THSvSOJ/qtOBqWybpTnOl1MnP7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(316002)(6486002)(36756003)(31686004)(16526019)(44832011)(956004)(186003)(4326008)(16576012)(26005)(66946007)(53546011)(31696002)(66556008)(8676002)(2616005)(5660300002)(2906002)(478600001)(86362001)(52116002)(66476007)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGpuZE5lNkhkckpOajhySEhGVkIxeFg5amVFN0RrZzVwMTMzSW9PNWRRcVd5?=
 =?utf-8?B?MCt0a3RPYlI1cXhnclF6Z0hlTDZtUGtSL2JHS2hRanpwTTgzS0c5NW5pK29j?=
 =?utf-8?B?T2tTbHBrU3pnQnlzQWtnTi90Z1pJbzk0cGxXZDQ1b1B0aUVSeklSY2FaZHov?=
 =?utf-8?B?SHp2QzBkL1NKNTFHM2NQejlMZk1IMG83TnZteml3dnhITHJIMkE1ekRjNEJx?=
 =?utf-8?B?NVk5b1RML3Y5elJqYTYxSWRpTUN4M3dWK3hVclZNU0xYbC9DbWRwSFNZSmwz?=
 =?utf-8?B?SkdaQVVQeDJkYmtLTWp1ekdNbytxRlBjbHpMMGEwdE5XbkFQeVZFbG1OOE8y?=
 =?utf-8?B?b045Vk85Vzcwd1BFd2pEMjJITW1kR1JvTkI0VVV4RXd2Tld4MDFSY3FNTGVJ?=
 =?utf-8?B?dERGRmhIc0FodUhlZTJRZVBxOTdsR1h0SDdSUWhZK2FSbXdMcUUyTmVJNFVN?=
 =?utf-8?B?V29QSUV1Y05BV005OXZYQWoyNzFCTXVXWlkvcjZBd21uY0Q0dTh4ejNaYXNB?=
 =?utf-8?B?S2pvY2RHOUFlL2Q4dmdTMHRPWkdUWUpaWTVoVUdtQ3YwK1BseHZQbnI0R2Fl?=
 =?utf-8?B?VW1LamtCUXppOHRBbXdKS0krYllqQzBkSXo1YjVTN2t4YWJrV25Ec25XNzVl?=
 =?utf-8?B?NEp5MmJoa1YzdGNsQU4rK1hoTThyMXpUQ2UzODBwZjlPenBlVmx2Rmd1OVJF?=
 =?utf-8?B?SkkxQyt4b1FWU0oxcVJ0UHNGbThSazA1N2FTTW1KMDBYc0VOSVdUM3BtMHFM?=
 =?utf-8?B?dXdaUDNPTGwya2ZYejJITjNCUmZhd0NNOWR2N2J0b3FxM2YycDg2TFBGRzdF?=
 =?utf-8?B?K1N1Q0V1MGo0c1R4SkZmVEVxNStsNk02RUtwS3dCUWV5VXJjMVRseDExcVhj?=
 =?utf-8?B?YzcvdEQrUXRzQXRZR0dkdXdUbnJBbnVPM2hybVhMR2tLM3VoNlR3STRBdHBa?=
 =?utf-8?B?VmVSUmVESFdNZlk0d2Z5VWZpVTltK2ltWDlvYnNEYThRQ09CclhSVWRWWC90?=
 =?utf-8?B?QVdualk1TWxuZ3J4dHdVZTJBMC9pTlErQWI2ZjkrNkIwSXV3UnpwcjVZUWlw?=
 =?utf-8?B?WU5MQWlHWU93K1J0UE02aEtpd25nbFNXekxqcXFMTTdvaWgwQit1MUdDSGFp?=
 =?utf-8?B?WEZZbTBlcWN2NWt0dDg4MzltcGxqcHgzQmt5RG80Y0NzTDdoMmFmTFNNaFV4?=
 =?utf-8?B?OGlyQy8ySUZ6UHAvaHE3dXQwY2wvL0I2cGt5V05kR2xkdkZ4bjhrVzV4K1Fu?=
 =?utf-8?B?UFp3MTFWanBQaDFaOUltS0cvNS9BaEg4LzlXajBId0dyNG5ZbEE4UlFPM1JP?=
 =?utf-8?B?S2psd01RQkk1eFFKZWZXYUFzdWJuSFBlalIzRlJIckI0NkMyWkp6am4waEVt?=
 =?utf-8?B?NUFrUnI1TjlBZ3IzbHFpVmZkcm9kczJqc3hFWFd6SlorUGp0OE1sbjQrNm1n?=
 =?utf-8?B?N0tOZUtSN0t2aFo2aHU3SzF5YjhjaTQ5YmdjbktKN3RUZ2ZCYXQwV3NSb2Fj?=
 =?utf-8?B?V3N2WHpDQUhHUStXNmtwVE9uZWJNbGhzTXB4aytja3c1REt0dG42WmZwR0t4?=
 =?utf-8?B?ODFHMUZQbGJ0OWlMVWk1Umt3TFY2WlVVMHRDWSt0MXpCSE5VTnBzdithKzVQ?=
 =?utf-8?B?TER1cHVMY2dvZ21LSlZPd0lTbzB4NGtuZnNCYmxYVTZTOGRxSTk0OHpIOWhV?=
 =?utf-8?B?VTVmdDVPbnpBRkcrckpYeUZBWEdvVU5ma2tKbWFHcCtRdFJTVTdTa3dwK0k1?=
 =?utf-8?Q?AIpGIZFdvXocb4B2QddzYfHg8XqViE5iDKe9ppk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be66f4e7-d43d-440f-4ee7-08d8e828925f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 03:07:02.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwvIxuNklTzcTHXbRZBr8bdTqlujkI7y2wjtIBzKCEizNDnlTOjz6wy0obC978ciAJgyPNoVRuKEGAz9zxm64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2949
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160020
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 7:27 PM, Miaohe Lin wrote:
> The fault_mutex hashing overhead can be avoided in truncate_op case
> because page faults can not race with truncation in this routine.  So
> calculate hash for fault_mutex only in !truncate_op case to save some cpu
> cycles.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> v1->v2:
> remove unnecessary initialization for variable hash
> collect Reviewed-by tag from Mike Kravetz

My apologies for not replying sooner and any misunderstanding from my
previous comments.

If the compiler is going to produce a warning because the variable is
not initialized, then we will need to keep the initialization.
Otherwise, this will show up as a build regression.  Ideally, there
would be a modifier which could be used to tell the compiler the
variable will used.  I do not know if such a modifier exists.

The patch can not produce a new warning.  So, if you need to initialize
the variable then do it.  My Reviewed-by still applies.
-- 
Mike Kravetz

> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index c262566f7c5d..f7ec94bc7337 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -485,7 +485,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			u32 hash;
>  
>  			index = page->index;
> -			hash = hugetlb_fault_mutex_hash(mapping, index);
>  			if (!truncate_op) {
>  				/*
>  				 * Only need to hold the fault mutex in the
> @@ -493,6 +492,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  				 * page faults.  Races are not possible in the
>  				 * case of truncation.
>  				 */
> +				hash = hugetlb_fault_mutex_hash(mapping, index);
>  				mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  			}
>  
> 
