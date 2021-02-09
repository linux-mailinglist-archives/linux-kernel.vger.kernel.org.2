Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE8314510
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBIArC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:47:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46762 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBIAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:46:57 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1190eHLo190759;
        Tue, 9 Feb 2021 00:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fuHYv6g6uxb/2HmQDkQ3NuMyX/kiIpKMCyut7DUAgAA=;
 b=ekMF8eGQ7NPSzwtHlrHvNvJTwh/SBy1BROWImKqU6NVb/rNCMtlC3g2hVCge4XiKbmKX
 3YTrh4B/aSoaXWMMV+Uohl/U5ulGAsFElZB9W8jVBLBxqIhMNULvMqBs4BIcZJa41kmi
 bSz8Bftc/cl0J1rKwC/9SbKvuoSyvXVrAnQXqgt+9D7Kj1KevbSt/Kb9G/Mzi/hRqzmE
 BdhYDwRjXTejkTOmPCfagSg+4dxRtmLC8ixCup/s38ov8dV1DwR/rnp/dHl2EsitDszS
 t5LYTXaFp/9/Uh7AO/lJ7YcPGFq79VulpOqks/Dyr9R9U80HDetAnd+HuKqLt6mSj3KW uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmadywy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 00:45:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1190eZH2166715;
        Tue, 9 Feb 2021 00:45:56 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by userp3020.oracle.com with ESMTP id 36j4vqkma0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 00:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5MsYm3CYa1fp59zOmkb5w0XwgJzJ+GgJJXF3/VUHiZK4WJXEkzKbyQxvqL6ApkHmE1tIaMrcZLZHxBXni3Xcmox295ueTN+qfO8CGhZSfXf0v8jL61muEjxFbW7lSll1UfiXTim7dBRkR3qQWHWpKHYOmoxN19bcq/bBAJwEEziELWy8TaFHKqhA9XXfrnhl8A0PWo7ABPePnU87F3UjEfjDlJu4crejZJiSa+gl6IR48jz3O44DdqhmaLxrhp+Rv+LobT0KPA2qvOw94lDki5FZ7YfWF4kyH8nFJ44GPwkaL43qlBfaYts1Pt4uH8c0Tn+ntEvsO2MEMM1GwHDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuHYv6g6uxb/2HmQDkQ3NuMyX/kiIpKMCyut7DUAgAA=;
 b=HE5hHOYjKbytXPGHW++HPCgT3hbogvhgytHoVpk9rpIwm4PR2nd6sKWaO6MRHpngW/gOHWNLUDkfKkBMoCykNHEavLg0oEk7V3EIzrYzTHimZOXIoAB7Pk467Ybcs8zhKncq4knaI7NlWkHCSsW+b1oRYrIN/rs3rn7DfjL8o0StKPYbk72fNxBTt+NbMqYmPZMMkjIrVZBAYFMgwAPtChelSu3afHwQhsQAhQfyiiSOyTcMUHIaWlg55LfSkUnIRWPU5ILdYDJYUD59ie4SYCi7E0LHPngXZ3ugxV6SlyfdjARCatzM5FjQh5dEzhgHTzIRqo8FjzAwVL5zTZ/UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuHYv6g6uxb/2HmQDkQ3NuMyX/kiIpKMCyut7DUAgAA=;
 b=FCpRJX3oEf3/ldMI8ft9kc2bbTUxRYWgILdvSUtam8pS5ZFVNEEKc/PCxEtKEhMcM8CjpN+LgAkOOcAskxDSsNnh6UgZkvWsfY2+Opmy+DB2M+I4D/qHQh8rV5LNu5mdS3d1B7rPVX2rxxcHpdlBAHK/hbLirgKgNge0fBgZlmc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2349.namprd10.prod.outlook.com (2603:10b6:301:30::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 00:45:48 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:45:48 +0000
Subject: Re: [PATCH] mm/hugetlb: use helper huge_page_size() to get hugepage
 size
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210208082450.15716-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3752cc85-06d1-5af7-8baf-2810c98524d3@oracle.com>
Date:   Mon, 8 Feb 2021 16:45:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210208082450.15716-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 00:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b88748-9846-49f8-9340-08d8cc940aa7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2349:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2349D75D10512E4C8D8D3781E28E9@MWHPR1001MB2349.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxmMo33frWpWrirEBi5kcRa8dzy9tHIDkBDbRQXMciLSdWTXWLrh6UQyNo3rKD1L+x9GSugciGLIyspyUg3vJct7LwYvFo8A1ND7CtJ9Yls0RcaCHTDNtZcNXcFpUupLy6bAgPJQZyc4qxAkhfnaTs9nG8AT7Wz8x8iod/H+PvkNeJwaT+aACH/4g/+9XtxHWR0pfJ2dv0VT22oPmrCvhJlRvdE9fVfi4yQjQfruZmoat5j3eosUWvedgQNd5nBGp2z6LbgCUOJ/4kY+bjs7x0uc0phX6vBkLAOH3IgGmFqXF50MMa4wDiW8h24o2Ga+sJfhjzpielwu72jz0zoZBi/halAS7k8dFHrxTi/zA26ZvNvji1rNYiYF+np/rc/dxcombQuSw6R+8k/Y43bDpM6vWr7A6TcgwuTiv//VbYfKhPZoqQVeD3NyLf3ahuSQ8ID85/WEAxwmF7S/j55aLRqn+4bF1Ak1zqyOXEq2DwmchkZdJtfwNQoL8A/ekzQmuDY+fj8s+UuqnNnuIEhr2cOWZNcsvB5xIWN0T72t0ro1n+RA9fH1eAG00bfBXSDh9Rcrc+EwSZBYwYBIhGtLkLqVGuDwGJUhjsofdFidbJrpDiu7aUsH5HlqQaSTHjbH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(376002)(396003)(83380400001)(86362001)(8936002)(2906002)(16526019)(5660300002)(53546011)(52116002)(956004)(16576012)(316002)(6486002)(31686004)(31696002)(8676002)(478600001)(2616005)(26005)(44832011)(186003)(66556008)(66476007)(66946007)(36756003)(4326008)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eU1FU0VXaCt4amplMDlaSktkVzFvclhBOEthZXJ2ZmdXR1dWb1d3cFVOTzJG?=
 =?utf-8?B?VUQ1MzVKUlBjNGIySnR0bllNNmZXa25LR2NYYjIzTGd1czJVUnBsUjgzTGZH?=
 =?utf-8?B?YjNsS3pjOE5HcFRiMmZCbGhPNENZZmpueDJhTGk1RitPSmRlZ1FGZVVHWUQr?=
 =?utf-8?B?U1RDY0lkWUgydGdmNHRaZEtiZWtSVk8zckhmbTBOakc5ZUY5NWhRcjJpWjZU?=
 =?utf-8?B?RzJvK1c2M0xncUpIMVFzeVA5ZnFqTUl2NXMvbjVwMlI3Y0FSc1JwRkZCTXZC?=
 =?utf-8?B?ekF2Mm41emVWR2Fnb3AzZWorWE9ZeElMaUZISzl0QmlKVmFtamEwcVJLUlpq?=
 =?utf-8?B?S2Rxb0N4cm9CSzlIejRVRWszNUYyd3Y3TVFCTTlVLzRQc3FHdnBHVC8rbExN?=
 =?utf-8?B?WGgrdW45Y2FRSEpyamVtTVR2NndsemZ0TUxpcnUyUmpkd3Q3dEk4SkphQVQ3?=
 =?utf-8?B?cEFpVnpJQ0tob2ZKUDE2NWFlY25zQ0xEVEpXcCtpcHNJZ1dXR3licnVzaWVa?=
 =?utf-8?B?NEM3YnNvcUs1SFg5Y1phV29CMndRR3owTnNNOGFlOHgwL0VtOTlNS0lMa2FX?=
 =?utf-8?B?ZFNOZlRrOVdnc20vQVJFbmZJcVFmbGx0MzNQNDJLMmFpSVRld1h1U0QxWitQ?=
 =?utf-8?B?M1RMdFFPa2hjVDFSKzUvRVB0aTFjTmVVUDJnZXJSMTk1RFpJWk1tczRwWWlD?=
 =?utf-8?B?ek1tZDdrTjBBNWUya1dBbVhrbHV4ZjdPb2haa21CaEtHakpMYzFNNjgya0da?=
 =?utf-8?B?Zm5LT2hsaEtGdEdPU0FYb253WjRDSHlnK0s2YlJvSEIzV1hQWi9VbVBkd2lJ?=
 =?utf-8?B?Ky9nNWVlVFFzZVNxcm0wa01IVVJIcDlZczFiSHViNFRXMEtTNnlCQVNTVi80?=
 =?utf-8?B?bmp0eFdCUlE5cDFGOEdwWW9Wa3dpY0UxK0RQUVRhOERwbjNuRi9aMWN1Y2hO?=
 =?utf-8?B?UStPL2VGUGQvVnNHQWNYTXJ5YWVuNVpiM0szVVc3UTA5dHRPUzdUcm5MSkFh?=
 =?utf-8?B?cG1MUCtuMEk3Ty80RVFHQ2F3T0dFbWpvdGx2OWQzc2MzT3hiRDMxQmcwRWlw?=
 =?utf-8?B?T1luTmx5eGlQRjNKZUE2bCtFcFhqQjZEOUpQaWJrMTFHWGFQandPSGlsMERI?=
 =?utf-8?B?MmJpb0JzeFExSVJzMElxSU1IdlBOSkczb2kvbXA0V3FXbVhFbzliZVV5V3RG?=
 =?utf-8?B?ZldaTzFEWFFuN044eURvbkdwUmM3czBKa0dMa2VXQXNhS0FHdDdnNzdzd0lv?=
 =?utf-8?B?MHEvUnRiYll1TjRyL0RSaCtIUjdSZDM4ZzIrUWVsTTNmSjdNZHl4SWtIbTRm?=
 =?utf-8?B?ZUUzMmkzelhmYmRWM1dhVS9HWXJPL3diUCtBRFMyWEJDdSt6UVliTnhxY3ZB?=
 =?utf-8?B?eTFkV0YwNFJtbkd2OEN0S3RxUThkaWJSa2ovMjVvN1V4dW9oUC92cGE2SkpD?=
 =?utf-8?B?dDZaVy9XRGQ0bnNZN2h3NVA4NEs1ZFRyZ2ZVMS8wY2M0VnNtdHF3enNBTytw?=
 =?utf-8?B?eENVaVMrRHh6STJlbWk5Z0JtUEt0cmtuQitJcTFyTWhrL25pK2ZLK240Vm41?=
 =?utf-8?B?K2VZVnFhb2VlY29pdElRUHU3Tys2dG9BNnZsamZ2cUVMVkk2VXROWXdVUWJ1?=
 =?utf-8?B?RUFXWHlXRStMUmh2T0lOc0dGeFRxS01EcXp3bHFMb216bjZzL0V6TTBXV0s0?=
 =?utf-8?B?YmRFNlRmZ21HbllSZTREY3VHcVhKUlJPZzdVYkRKbEhyaFRkYXpOdXdqWFpP?=
 =?utf-8?Q?j4jr5i6a0WAgMRvjwnvi3jZuJav0Q3Erwk8cVV/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b88748-9846-49f8-9340-08d8cc940aa7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 00:45:48.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSyqZsK3nDKWijtPjPY64pD/yI6s6Vwf1VmALSrzjiB8ieCZi7gM98Bmk1/T29BVKt3AyCGuxC3Clt1F/gokQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2349
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 12:24 AM, Miaohe Lin wrote:
> We can use helper huge_page_size() to get the hugepage size directly to
> simplify the code slightly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18628f8dbfb0..6cdb59d8f663 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3199,7 +3199,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	BUG_ON(order == 0);
>  	h = &hstates[hugetlb_max_hstate++];
>  	h->order = order;
> -	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
> +	h->mask = ~(huge_page_size(h) - 1);
>  	for (i = 0; i < MAX_NUMNODES; ++i)
>  		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
>  	INIT_LIST_HEAD(&h->hugepage_activelist);
> @@ -3474,7 +3474,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
>  	for_each_hstate(h) {
>  		unsigned long count = h->nr_huge_pages;
>  
> -		total += (PAGE_SIZE << huge_page_order(h)) * count;
> +		total += huge_page_size(h) * count;
>  
>  		if (h == &default_hstate)
>  			seq_printf(m,
> @@ -3487,10 +3487,10 @@ void hugetlb_report_meminfo(struct seq_file *m)
>  				   h->free_huge_pages,
>  				   h->resv_huge_pages,
>  				   h->surplus_huge_pages,
> -				   (PAGE_SIZE << huge_page_order(h)) / 1024);
> +				   huge_page_size(h) / SZ_1K);
>  	}
>  
> -	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
> +	seq_printf(m, "Hugetlb:        %8lu kB\n", total / SZ_1K);
>  }
>  
>  int hugetlb_report_node_meminfo(char *buf, int len, int nid)
> @@ -3524,7 +3524,7 @@ void hugetlb_show_meminfo(void)
>  				h->nr_huge_pages_node[nid],
>  				h->free_huge_pages_node[nid],
>  				h->surplus_huge_pages_node[nid],
> -				1UL << (huge_page_order(h) + PAGE_SHIFT - 10));
> +				huge_page_size(h) >> 10);

Should we change this to

				huge_page_size(h) / SZ_1K);

as in hugetlb_report_meminfo above?  Or, is that one where it takes an
additional instruction to do the divide as opposed to the shift?  I would
rather add the instruction and keep everything consistent.
-- 
Mike Kravetz

>  }
>  
>  void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
> @@ -3647,9 +3647,7 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>  
>  static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
>  {
> -	struct hstate *hstate = hstate_vma(vma);
> -
> -	return 1UL << huge_page_shift(hstate);
> +	return huge_page_size(hstate_vma(vma));
>  }
>  
>  /*
> 
