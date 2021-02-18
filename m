Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45E31F221
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBRWO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:14:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBRWOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:14:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMC0BR150764;
        Thu, 18 Feb 2021 22:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=eHTb6ZF1InQ0cO7Ax8FLHuoXKUNnGm8BnVkcj6V89YU=;
 b=BYuGZDOSlh8MtQf3MEpfxEUHNEb9DSZ38rKOc1ky3nswhEkkLlzJgf4mA/QTlgIfhF1A
 yM1Zk9WPH/u54durM6kWxxHkCiZ+CRBihN4QdW3sN9mhUKV3h5pAo+pVqsE1WrlTH2Ee
 u7+xeG5osltm9V3mTT1mF4L2i6GuaU2h2JIuus7baZJQVsb5gZ6x8BbKAzzVnkwpwCoH
 N8Rp+kIEJIfKQJuPJw7OXFl/egOMJ190QHl50gW59aYMw0wKCrsKes9wGTfdLnYG6rmQ
 NmWTHhawaDlBNXKwGOy//zN62T6VcX2aM8kzULoGwxtfYxPA9uvIIue7UH9ZMELTPgti Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36p66r7k6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:13:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMADZu137989;
        Thu, 18 Feb 2021 22:13:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 36prq137ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWP+x1eid7Oaemv8V8XgENS/q8M382QxhqEIRfb7BKWVHCClGOJgltlWffmnBIm+Q+KI/erJNPYXxfvrFkXT9A6A6nTy/+B5unIhzGEZmxqYIukJ+AJ0Kd4PayQET4BCplhL6Ho+JFnhbIkiL7SdiLHbsBAbTpst9qP2I6mAhJX+pFUC0LEwgQXkzPUQxGb3iFpBH6/2TPsUC82UO8cvDaaKprGu7sTOIXswrMQnf3T+HEwujQnJkldtlCrIdisfHOuKbZFxh9SqK78wrEW9PSzQvTCjOuShrEivRZYIlkwvCn8/CrS8CVKZ6oAT/xYwwijNDR3UzMXSzkChMsXhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHTb6ZF1InQ0cO7Ax8FLHuoXKUNnGm8BnVkcj6V89YU=;
 b=PUsREnpKfWUhirvMOjXZzWi4Q/wi5uBo2XeXyaoFKtz0nqGaqrpM9qucrzgkOcH55+RH5BWLv3+/zDsr4cMwvDdMjgfzTlREdYmhUsQAiq2mQS+xHxD071wtBylDaDru6AnZ5FZokZRn2lo14OmJTAzjhexcp6CCL/SSip8S3/bNDboEv+fK5Wj5sC5ZPOI6mAHBQIMqkVeodSZ/rj4yu4c7QbEPs7saMhhnFPeOhox7x888hb9blp41ghz8qrqaUfIiPmsGgj4OaMuPo8Zx475nr/nChUvIjzBUcPBjskLMGQhJLMBqru55caEVH0y1Vxablx4/Q8+Bdf2R2OEnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHTb6ZF1InQ0cO7Ax8FLHuoXKUNnGm8BnVkcj6V89YU=;
 b=BqPxbsAwKzy+Dgdyr7nDl4C6ZU1aC+Mymqy8sWDRHoFOEVMl9jlgcBFLrkWn1dSMZdaJ+blnk9nm8VBNML54VfRIFQcCW6D0af8Uf3LaRj+ysEYWhvg9o5mFNK9OmI5mV5mKnL87iguDhKAjpRJsEeuqbc7bJAi0mpcJqsxWwzU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3446.namprd10.prod.outlook.com (2603:10b6:a03:86::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 22:13:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 22:13:56 +0000
Subject: Re: [PATCH v3 1/4] hugetlb: Pass vma into huge_pte_alloc() and
 huge_pmd_share()
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210218215434.10203-1-peterx@redhat.com>
 <20210218215434.10203-2-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <76fee968-cfc2-787f-7e48-af781563756e@oracle.com>
Date:   Thu, 18 Feb 2021 14:13:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210218215434.10203-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:104:4::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0165.namprd04.prod.outlook.com (2603:10b6:104:4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Thu, 18 Feb 2021 22:13:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7e3859c-7f18-463e-2aae-08d8d45a7b95
X-MS-TrafficTypeDiagnostic: BYAPR10MB3446:
X-Microsoft-Antispam-PRVS: <BYAPR10MB34466CDD3AA1B6563B1B14C4E2859@BYAPR10MB3446.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoHjDbW/qdmK95bl4zkfZypqTwgCORhfXoS95Fr5nCiqzx8XeusezKmjKxhVan2rIE/0t05p8U4FZU0MSOzcT2NXTtdbWxjkdcVPO9OO4wgEt/7M4vmgBD8iJbjEzofrptcEYiQfU2GNLPubyav2Kqaggdt6ezPN+Mj5dcTqdru2ccZUY88u/kpMdT7oliBEICrR+wZbXPppkf2A8j+1jITsmLJTqSYPfh95PHj3wFi63UfILanwJB6bCg7Rfz9IN96xp8XvkpR4WLegFqXtIHeybzxSzKvBT57L65yMJ7KNfDr7CVmPjL7J2g3kJ0IQ8b1TcfsLXDoXbZF2aR2g15jpd8Nl+ucPrN5yFUWdRA2hlpC/lcSgDGWEFRpF14tU6Nar4jey0AVmGqswhSWTWSniRgB4/2KdnOKJsLcuxAKcgvfIi3RAteYy+/aGSpKclMnBiVk3SBpjJv1cMfZ+l9sj7fMcPbOHi/Y5KKV2pxFYxWuxamUYMcx3vesTG95YhIUIAbFPyBqrxx+5oG8IzJHLzH69fLWY45Zb2WfCRYImhMWTCuI5y+MQfYNq7o89NCeIUnYDeg7hniz8cLC55TNYGd29s/pyfej/HeZw6w9A15MjtfnkmDhFJIAYJWLu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(8676002)(2616005)(478600001)(66476007)(4744005)(31696002)(956004)(53546011)(44832011)(6666004)(16526019)(316002)(2906002)(16576012)(5660300002)(52116002)(66946007)(86362001)(4326008)(54906003)(186003)(66556008)(8936002)(26005)(36756003)(31686004)(6486002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGJsZ3lyN0VYaGhXUzR1eE5VdW4rQTlZMm5nNkxqZmUybUszSVZ4cThlZm04?=
 =?utf-8?B?ZlVoRTFrUlBmTGlnOGQrcGhSa2s5TkpiVVJMN3hQZ3kzWnd4TGppWHJudGJB?=
 =?utf-8?B?SzZVeGY3bll6NndCOXhnMnJrTk1nZklHYTc4T0xrSEEzVEx5NTQ0czFNSUZN?=
 =?utf-8?B?N0xUUlRUR0VEMFNZc1A2ckFGcjc5MURCK2hrR2NCVThNVXFtK2QvMVUrWnll?=
 =?utf-8?B?ZUdVNXZGV2JjQmlGLzRaamowV252YzJCMGNmQXB2UVJTZnNxWXl0V0sxVS8y?=
 =?utf-8?B?SXc3RENnaXVUQlNRemxhcU11MFpjUXVoVTI0WTlIZUVSTFhaYS9JbXRvODM1?=
 =?utf-8?B?RWxOYXo3aHEyb0xRN0JCU3djdFkyUk5GTmFLVmphNlJvVmVGczhDZTIwV3lD?=
 =?utf-8?B?SHdlQ2lXckZvSDM0MlV1Qk10RlFlVXo1ZWdPcFQwQ1BRMDFydkxRZzR4Nmlh?=
 =?utf-8?B?QnNpNXd3WGdoSUhCZnFnWkM3bS9FMnhIbnhvMDRUV0ZkM2ZWS0V1QkxHTHZI?=
 =?utf-8?B?a3NNcGQrYkpNSWJjWlR4N1FnRkV6bDB5L0JBVi9GeE5mOTZXMDNQVS9VSitK?=
 =?utf-8?B?MkU2TVE3YXUrbEVWWGJkUUtJdU85cTRuMnMzTmlDYlM0eC85dHRtYVliN01j?=
 =?utf-8?B?aUYxTTRWanNncmZISUk0VzVSWHo2dHhzUERHSDhtRTZRV2pQcXd1K2dkbHJR?=
 =?utf-8?B?SnJHNXpCMkJHNnJQRFZnMmRzOGhCcVVJREdjcSsrSVJMU0NUeVJ4ZXJxSEtR?=
 =?utf-8?B?TEJ4SCtLRGdtMFZjWFVmdlFpZGFPLzBEZHBQTHVNeXk4ckEwNDd3UzZWT0Ji?=
 =?utf-8?B?YjV0WThZU2I0RDRleW1sR3JsVnpRb1NDY3RFUnVSb0hUakFzaDdOQkJrMjRi?=
 =?utf-8?B?aWFsWldhNWlKOUt3RlRBQUEyN0d5cnV0b2pIUHdHaGRZL0UrN1lXbnZDb2lu?=
 =?utf-8?B?SEdPOGVoSlZxYW9kRkJOV3JxSmMwWW9aWWtCK05jL1JjOWJHOVZDdkZXbGRx?=
 =?utf-8?B?dlErMlAxdmpzV1pDM1BXUVJhczQ4QzdTK2lkbDlOKzEweFBVTkhPTkppc05l?=
 =?utf-8?B?dlcxbEFRN2YydHowRjRacWYwQStDdmY0Vk00V1NleHhGam5VNHlRWWQrdVhH?=
 =?utf-8?B?dUFLY1ZBbHdLSU9ab0QyeTFWZElVUUx5ZUY5NVk0RHJFM1pqblpRN05xcWZh?=
 =?utf-8?B?b3hzNU9uejVaQ1IvMWxuQXd6cmMvN3g2NXovWWE2ZHYrcC9SUWtwT3ZLYi9Z?=
 =?utf-8?B?WWEzejJEeWh5blR6eDRYMy9LNmJSajhtMGRWUkFpcU40YUZiTmtsNjhHOGZZ?=
 =?utf-8?B?cEJncWVDR3NrRFJQZGFsOXFyRFdSYlVFNGt4cTFyMGUwbU1EcXBZTkkzNGJw?=
 =?utf-8?B?a2ZDUkpveE1nRjl2Z2pBOUx3TExhWnBXMis1Tkx0TXI4N1lpWFFmRDI3ZURC?=
 =?utf-8?B?TDQvMm9RRGpMbGQra1NHNFZFZSs0VmZmd0RVWTdSSm5iSWpUMGpYYi9saWdw?=
 =?utf-8?B?VDJIYjFQMVBzK1JNVUFuWHRTbHhQcSs4QjlXUnJiTkJVb1htM3hHWndTNU0v?=
 =?utf-8?B?c0Y2T1lRSTRscVowRERqUUh6R1hDWm5aUmsyZDE3a2hSZGVDVzY2MmlqUGxv?=
 =?utf-8?B?M0c0Zk1QVkVxWThiTnZZV25SdWYwL3lSQXJQTjUzbFdaeFlsS2hFZkI3Si9t?=
 =?utf-8?B?UTNHNDAxOEdUVGJEM1BReTIva1N5ZTJYMkcvZnFIMkExUHpzRUNLTHlWRlFH?=
 =?utf-8?Q?dEy4cKRewv7b9xcAdD+SWlqpQ+9yQPo6UAtiUoC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e3859c-7f18-463e-2aae-08d8d45a7b95
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 22:13:56.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1qUT+Z/Q98ue4/QLuLfbVYJHRBDO1caEIppLlPTsBjvwP4VW42vZQfOg54LVD0R1vLzCfUA/A3ilDPijm2C+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3446
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180184
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 1:54 PM, Peter Xu wrote:
> It is a preparation work to be able to behave differently in the per
> architecture huge_pte_alloc() according to different VMA attributes.

> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index ad4b42f04988..97e0824fdbe7 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -280,6 +280,7 @@ unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&p
>  unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
>  
>  pte_t *huge_pte_alloc(struct mm_struct *mm,
> +pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgd;

Didn't kernel test robot report this build error on the first patch series?

-- 
Mike Kravetz
