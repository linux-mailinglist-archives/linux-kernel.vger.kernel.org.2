Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279CB31F26B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBRWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:39:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49802 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBRWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:39:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMYcSp024600;
        Thu, 18 Feb 2021 22:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eHb2mZ9ltLpw731ZT6S5p21iyJdnLLEYuOnPQfVPA2k=;
 b=eGJaLj9LSbPh3Z2vedYUKp4At4H9b4I2ox/cDFrBZNb0+3kVi/+XTnBjs2Koa2TX70wu
 Yln4onkJcqNj7XkHaZr1ZkgzCuhaXhOYppOnCxy0+xKNsdDHGQCBwWJ5HfocCdgN6qWg
 +YVBjH4S0TjXrw7eUG5SIGdFRHIiSauIvw0FW6k0ziAW4iW++IiA3ogtIhBCjAkjJm5L
 hUPczs7Ghag10cF1a7N6U7+cfO4m8nANF1DfpMgyPf+oO7dt5icQ1rRrzsjGLKzlJDg5
 w/UKwLWnchxhXIkWpSxw6zrGHOtUVvI+USPgZ/Wyn6zVmJw88EzIw0P7Eu7BCZrP3e/P Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnqhj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:38:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMaHrG070735;
        Thu, 18 Feb 2021 22:38:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3020.oracle.com with ESMTP id 36prp254va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHC9kuayDkfHpmUK8JpxStMiiG2wA7N5yfYiXzyDH8njh1+ykLQwp8rw7Yps7CBsIZpRr6woze+/9k5AE8h9jj7bfFI0PVjZfLGQtoGQV7aMQOkeajD1h5qnqykFQyjj8xF3d/kszEyz7pp+cpQm5aTYYS0E0qbazyp/c9IEX9tgSz4v573Qiy9T7JQMan8JzbuLqP4uTlWMyMj4x/J3icsl3Nnyd22BKeDOowEoOvj6XLxZVTuXNNlBN5UIMi8w9XLNGh8O/8NxTyVbozjIw4OoCTwQ7aBiSuifGM6V67ayz4qkBjmwe7lN/0XyjfzTY7yrpfnQQlbbhNEfj49C4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHb2mZ9ltLpw731ZT6S5p21iyJdnLLEYuOnPQfVPA2k=;
 b=eZrIzg84eu5iuHVrY+muORUXanW/jyiAiPdrabVXZPITxxHBSFgRe9M465aJv/pf8UL+Bi1IIX4fDcGl7Dt9aU2e/6JWaOk1tOE/iOY2NO9573mpftqrBhn47x2lgVxAHzLDZ+D4EW1lJCZAzxZL3QKSHTAycO8l4lKaQJFmTis5B96/WS+8JO3IZFheXaj4eg1DkjMtborcmPRumgtwkRUN7PHGnudAzKStpSTmfz2ncSr4IT+TwTEsszbrdO2Abr2vgbdONBt5wBlomUhfhQKJY3KJVqiAbHQ36EMHuc2XFnHDRf26GY3i+rd7kr/OTKiRz8YUUKToILgvnY/Wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHb2mZ9ltLpw731ZT6S5p21iyJdnLLEYuOnPQfVPA2k=;
 b=ps+PgT4QO6HHLiAEI7x2HEUis7Yt9pjeHhxB+n7Rj8nTNCyQfxZMDE/y+IpRqM6+zS71rUdXgF2vn2121a+4qPrvzzGmM7dF3cpmzugjthxDaz6SuPhXib4gWS19wPrj/H86TRMFi/9qJcaDC3sDluTRT1g8snykq/7DxADMIn8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 18 Feb
 2021 22:38:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 22:38:20 +0000
Subject: Re: [PATCH v3 1/4] hugetlb: Pass vma into huge_pte_alloc() and
 huge_pmd_share()
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210218215434.10203-1-peterx@redhat.com>
 <20210218215434.10203-2-peterx@redhat.com>
 <76fee968-cfc2-787f-7e48-af781563756e@oracle.com>
 <20210218222757.GA6669@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9d93ec4c-4cb9-c3c8-5b73-ae00c4fa9435@oracle.com>
Date:   Thu, 18 Feb 2021 14:38:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210218222757.GA6669@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0143.namprd03.prod.outlook.com (2603:10b6:303:8c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 22:38:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9718b5fd-6564-4dc3-22ea-08d8d45de467
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-Microsoft-Antispam-PRVS: <BYAPR10MB25524E881BD3ED4A7A67857DE2859@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg00Jy2MS4jZZtdmOGzhGLr2eQbEQ59acWNng/mwis6EeJ2Z/Xvb66uxP3mlotVEzfJnYYOv5QCf0W6L+4zUUB2q+CdPpqbWH9xR3C3YQJV0mfGvD1zPqJ2KVcneEZyiTM0MBtMrg8M934/p9xuc6y9d5b7egIh1Hoq9TixOnCDtcCa2dAYNcKok/eiucT5ahNDNA02aYhyFSM2daWZrJOoASxpmd66R5EGWzytuR2UGHcBjbvDJiIF3quz5KjwDqK/dgfrAKRH1qjDCN570/CDvIu4e9f0eINAUT9/c0Bi/nTthb9pFwVuz8rtttq/lwrdWuET00iwmg0KIuf6iAIIDkLn2xt0CRabiUrkWlNiS0FxLNhDJU+fyQTI2u3mZXhEXzfbEgSU5o4AZIPQaM323Eq5VLV0jc53MTaRHNd1u8xOJkLzoP0cir8KG93FEpAjX6ll0HOvT5pRyYD5fX9f1Wo4uiCPZme5jutAKiJHbbthdPalBqBoiwM30cGnWc9SLQA3zpp3GY4QOT5DEsmHzMxjCnAQ2cOL7huC2azA4wuNUAlXNMPXRO0iyFEGVaOT3hSqY8quY291JZMl6W74QYjhltXcOJD7aFw0+TRjvQUs5omuYh+VCwsH0HVYV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(366004)(376002)(44832011)(54906003)(53546011)(86362001)(186003)(16576012)(5660300002)(31696002)(26005)(66476007)(2616005)(478600001)(956004)(52116002)(66556008)(16526019)(66946007)(2906002)(8676002)(36756003)(316002)(6486002)(4326008)(8936002)(31686004)(6916009)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cTYrWDNnTlAvQklrQWhVM1JYRmxUZkNaaW9jRFJFZVNKTytvQTNLSFc2UEZB?=
 =?utf-8?B?Zm1wV1RFM0xHa3Y2VmJyazZjb1pscmEzOEpuUXRFbEc2Z3BOQ1d1RW9hVEo0?=
 =?utf-8?B?MkUxYlJ0WjQ3UW8rVzRUQUJhUEt2akZzdUpIS1p3VnB3V1NDV1lPRmNjVnp1?=
 =?utf-8?B?OTU0MjVuSkpVUnJzTUtiSElUM2drL0hGNlpKMzNKTlF0ZC9WSzZuVGxuYzdl?=
 =?utf-8?B?SmlFVE9rZkp1Z0xjQUQ0czdmc3hUNGNBMjFhWXJYdjR2RnlBNWpqNlZHNHpM?=
 =?utf-8?B?QVJ0eXpYeWRWOU9LS05ZVVVuV0RoS1V2bFUzcHNUSHZmWFpodGt3Q0pobVBO?=
 =?utf-8?B?OU1oNTNVK0dJemJKR2NwL2Z6RXNjN1JEeStuekNOd050ZU9VNFpRTW5aNXB3?=
 =?utf-8?B?MWVvR01sanAram40ZFUzaEYzY21LTEN5UWdpMGlVeG1DZ3lqSmxBUXN5aHN2?=
 =?utf-8?B?NUpCSGhQM1JRNXJrYTNRdlFKSUhDcjJDT2ZzZy9MbmZtV1pQbExsbnh4dmQ2?=
 =?utf-8?B?dWVyVHR2QWk4cTZjRFUwbmtxdnZ0R3I2RjJzdWsxNS9LSjk0RFF2cytjZEE1?=
 =?utf-8?B?TUxYZktLNWFEL2tKaVlVVytrc3RmbjFRaDhRYVRyaUVFa1BrRjN4eDhLMnVa?=
 =?utf-8?B?Q2VZL2o5cHhsZGV0dVJwdmVId201RWh5TDRRemFuWE1JMkxLdnJPcEIyakZm?=
 =?utf-8?B?dmRTM1hmUCt4QzBoR0h3TGNyWUo3NnUwZEU0ajZqMytseEVCVkcxMFp3c3Fh?=
 =?utf-8?B?dmVwWlVRdWUyYjdFcGt4ZE9QVktJUk9zaE1GdFZqU1lwWG9pWllrWGVsL0V3?=
 =?utf-8?B?SWd2SUI1eHVQRmUvdjRvK3ducTBEMUVMcXNrd3U5UHVnYWFtTi92QUlKT0w1?=
 =?utf-8?B?SDJWbFVQWGJtWXBFdUtiU2xIZEMxMVA1YW9vL1MybG9aZ3o4anVwS1dCd08w?=
 =?utf-8?B?N1BRRTY5OURyZnFIQ2VKdUdnRDFRdy9pL0ZDOEF2V1BmeW4rZXlncXpYSUNa?=
 =?utf-8?B?YkZNdVEyZ2FidS9QM2lEUHcwS2JmbUdxTkZCc00zNnhDZmx3Q1dDN05iaWcr?=
 =?utf-8?B?VU16OS8yc25wblZEalRxUFM3WTVXQWFLZU5La2NjR2xRalhaRUxlZGxXQUov?=
 =?utf-8?B?aFJIYmxtY053NEYwUFFuWkxPb0R2dExPRk1LU25yWGtiWmtkY1UwVHF3N2Qr?=
 =?utf-8?B?azJWUHlXRVhTdW54cWsvVzJiYWhtazFkWExRSVdob2xMQkdhSlQ4VmNwdWZX?=
 =?utf-8?B?MHNSVGJrd2UyNE9kQ0RMa0IxYlFweHFYek1vNHkvamNQNWRXZDh4RHJUbDY2?=
 =?utf-8?B?Y3h2OG1nN3ZMZVRpMVZ3TGdnbnFieTEvczRyNUFVNEV3SENBaHRSRjFQc3hV?=
 =?utf-8?B?cHdDa0xxb3FvV1orRStnbzZkVEtSMWswNFhpYWt6dlIycFVnSEZ5ajVOQU5y?=
 =?utf-8?B?MTN6bGpoSUxUMFZKQzBpbWhueTN0QUUzbUVRMk9hZ0NvUmw4dVk4Mm8rS0dC?=
 =?utf-8?B?UlFlWG1KcmVZTlViT3JGdjd4UnNHVTR5NExMNTBiazFRTU1tUmtoVHVjdzlV?=
 =?utf-8?B?TU9aaytMaXdCanJIWlQ5dUNSQUgxOG9QWEp1LzNEZDRWM2d3ejRKcEo5Tk9o?=
 =?utf-8?B?Ky91aDB3NDd5cUUvdGMxSzB2MkZFRFY0dk5FYXp5VWlxajVMbFloNEk2eGdh?=
 =?utf-8?B?aWwvSkM1ZzBYeG5Gbm9FNGxzQk92dzVNV3lXa0htTytaZExFaHc1eS9YU0xP?=
 =?utf-8?Q?mS5orndMsMBQ3rg6tnl9vphSCaumQ7WBrc8+vWf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9718b5fd-6564-4dc3-22ea-08d8d45de467
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 22:38:20.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEBgML3gLDaMOdwmyrdGNd0IVLbeTlaxlpDal6PK7o7DhHmOlv0r4gXawNdjLTNGkrLKAr81mKjrevAAU1KRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180188
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 2:27 PM, Peter Xu wrote:
> On Thu, Feb 18, 2021 at 02:13:52PM -0800, Mike Kravetz wrote:
>> On 2/18/21 1:54 PM, Peter Xu wrote:
>>> It is a preparation work to be able to behave differently in the per
>>> architecture huge_pte_alloc() according to different VMA attributes.
>>
>>> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
>>> index ad4b42f04988..97e0824fdbe7 100644
>>> --- a/arch/sparc/mm/hugetlbpage.c
>>> +++ b/arch/sparc/mm/hugetlbpage.c
>>> @@ -280,6 +280,7 @@ unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&p
>>>  unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
>>>  
>>>  pte_t *huge_pte_alloc(struct mm_struct *mm,
>>> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>>>  			unsigned long addr, unsigned long sz)
>>>  {
>>>  	pgd_t *pgd;
>>
>> Didn't kernel test robot report this build error on the first patch series?
> 
> That seems to be irrelevant of this series:
> 
>   arch/sparc/mm/hugetlbpage.c:269:22: error: 'huge_tte_to_size' defined but not used [-Werror=unused-function]
> 
> Thanks,

I thought the error was caused by not deleting the line

	pte_t *huge_pte_alloc(struct mm_struct *mm,

when adding

	pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,

as above.
-- 
Mike Kravetz
