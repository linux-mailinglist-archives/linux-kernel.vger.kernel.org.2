Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C631459B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhBIB1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:27:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38482 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhBIB1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:27:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1191IhNm014032;
        Tue, 9 Feb 2021 01:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ef+XzRA/4s/RmfufnqBTQ5LQaokIv1MvcMVAu8e4/IE=;
 b=hJwV7bW+mKkjlmph2eyZKyLn8JHPKW7lom3TQYYAQQOHMxbEzl5b74zklOUh6iGHrN89
 zjeyxUsf9+4DBvGMcDBZVdIpwgtip0WT/RKsbTyjJTpT0FPNIChQ8IRrtNkH4T1GBCc0
 OSKEH31hDgWt/nMOfG/y2ndVbwIDWKt7YWDJcoC2MB5PjN6/RODMfDnZxs02TU6TA5Zx
 eKtis+DcsWZ1K4+0VWkwYH+ltXGRZeuj7S84W1pbHvKe1yvxdpBiHe9Td8TAoC/PHRHj
 hQLIK+KMd2pDtT5i+ZBkcU9T3Q1Q/pNOy6xf5+w5t5HObizWcTJNmYXU6CBrzEtPSuoJ DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36hjhqnxhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 01:26:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1191LB6R196195;
        Tue, 9 Feb 2021 01:26:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 36j51vcq4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 01:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq1yCjH6M9/WD4rD8lP/wR6/OX6tZEFp+GA57FcyBBIOwkk0W4F9kAKMP/DCFCKi2Cq/BrCzFSR/nSD7SDnae7vIlo0uUUY1oXfIT8x01tVFw0PvLp/CQ5Pfnc480ZxCjq6RarxNwjpua6g3PBeZaBCHOevJISEqXmMtE3ddAxillqsQcH+7Lq315AOtZ6aRQQ87jsP94OJwaAeppHL1IiBMLrSLBCqZX8yWzWtrH8JRDTUMaJekScZS6hoN09WcJ58tqYK5ngFNbDjoDcFTMwt8iLomip75H6V4TDjwKeRaujzAF4f2e+idXQ3oy/csVDtVuDdF9cPmo3AAjoebUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef+XzRA/4s/RmfufnqBTQ5LQaokIv1MvcMVAu8e4/IE=;
 b=Uir6yUPpcnQm2wN30kmgxQqk4YV8HzMIxw3TPwAzQT5rsAOxLb+mFLGf+mmD0x7CWTlWRFmmauvoAAw4AJX1zhj/IuXUE4grbQbgESFtR240aa0GcDgqbyxbMurRiFPwfZ/pKqN4etIIdjcdOULcZUic//by871tPBx925xfYEAWBxNsLOEi5X6P63Ov73MXC+4WGXC3YijhBmrVMLBtjxD2P36hdx0mN2COFl3j39s5R6MRobtYqNEk51KRx4QpsTmblwOgcLAWpOJRxmanJ1KE+pFctYSqvgnDcmDNdZTKAnP79AMuCBZSXrgMkRo+pMVgjhL5KhYhGI/ufKtVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef+XzRA/4s/RmfufnqBTQ5LQaokIv1MvcMVAu8e4/IE=;
 b=NfajhYb4YI4CNH6EqAkadShKUO4xcsLD4zkKDJruMxoW49/P6+1c9tp0yD1uYSPXi8dMqYxKfXK417Su8e/0zD3HMM6TNdGncP6qvMCSrQ8fJxh+sJaqN9jBQWJF9LGesWSgmYrbVCZjOs82M4DUHeLZlmW90p4aXBllGYG8Jdk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4451.namprd10.prod.outlook.com (2603:10b6:303:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 01:26:09 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 01:26:09 +0000
Subject: Re: [PATCH] mm/hugetlb: Remove redundant VM_BUG_ON_PAGE on
 putback_active_hugepage()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210208083739.33178-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7e1cdef7-e3cd-79c1-c30c-5f5e9e9f85ac@oracle.com>
Date:   Mon, 8 Feb 2021 17:26:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210208083739.33178-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR10CA0058.namprd10.prod.outlook.com
 (2603:10b6:300:2c::20) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR10CA0058.namprd10.prod.outlook.com (2603:10b6:300:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 01:26:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e743729-0d60-4067-9c1f-08d8cc99adc4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4451:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4451BF707477DFB383AC73E7E28E9@CO1PR10MB4451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dodT6gcLgxEz1utc1gSXWK5Ds3m7CE4ruLRTXDD0Ob9XVN6PNKb+Z4S6mJze910zt7864XnGT4ICTs5tZVWT/8wVslPoaIkUagCty/ibhbT/5ixyuSl38GFhEVAJ99TbfqgFIE5/RG0EUoPPQlkMO34l+CEhgTJ8abLiEg+lNHc6SIoWb/pfIUFSKLuHv9/Vt0+yuwdIvM7XBnEJceSgPaZdE1QCYktzE1NYSswBXyqsxS+NsxPhzfkYyuAAKsHSoh8ot6jN+JlXYHH4Kn7xGRP+69pO5g8psh4Yhk8PNw14lKMaO+k3ESUnxpZRsOh47F4nyEhdui8p5bmq8WZZ7q/sIC73PwktOGXX/UcK7iipU0hkJI9dhOm613Fu3SYMo2NXktSNwoCgZ5JiJbuU/B4zygSXuMnCfPFXdlJXdJGk1UAeJc6jRiFJy3zjQi00CrzBZELokSdlXzrPEPTYcxj8fnNr+iGIiddiSPksDhPuYCmRGOga+UQlP6aaYP812eOfFAGVeAO6d+bOhKiPk8p7s6qaMEZjCO3K5zUowA6hK86NawpLcynJ4Qn/iSPqr1bllVhQcfafmU/LEYp08kjYKLvLwIlj2Ups/CZ+FHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(376002)(396003)(136003)(26005)(2906002)(478600001)(52116002)(16526019)(6486002)(186003)(36756003)(4326008)(53546011)(316002)(5660300002)(956004)(86362001)(2616005)(44832011)(16576012)(31686004)(66476007)(31696002)(8676002)(66946007)(66556008)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RW9lY0Nmd2Y0Ujh5SFVuZHRnSnpFRUZiNytFTWIwSUVrZkpvcjRsVXFPL2hl?=
 =?utf-8?B?ajNLTTlUMk1WMEF4WU5uaG5hN3BCcHcrUndJNjNwQy96VUszZ0ZZNFU3SGcx?=
 =?utf-8?B?NEhFOFd4R2c3M0JqN1hZRmcxVnJLa1kxTCtUWW5iS09xeGp3RjFKaHY5bzd5?=
 =?utf-8?B?ZlN0UkM2MkpzbVpEekJlZGVQYWJJYkpMSEJoMGoyeFd2NHlOUjgrdHk5dzQ0?=
 =?utf-8?B?eWF6NkZiaHNZSVBGdjUwWng2Tllnb056U1gwMkhrMWw0K08vVVFpV0NUbWVu?=
 =?utf-8?B?ZndNazlwdDRwdkpKQzVEaVZidUZ2THdiVzlLc2dJaFBjZWJSQmZBdXFQVjhB?=
 =?utf-8?B?WXF4dmx3cDE2enBIVUhBVHJrUHE4a0V2OW56dVdTV2M0YjRXdml4S25nMnVl?=
 =?utf-8?B?eFFPYURhTmtnTHpla1BuZHg1cytsODhNcnVDL0dhdjVWQXpqWEhKZDE2T1Nx?=
 =?utf-8?B?aEV0RjRkaGFPSmhpVnlrYXp1bHpUcHpudlh4L2dPV2JIUVB4WWZWT0s0OU1L?=
 =?utf-8?B?SWFONzJqbDBsZnU5dmJiSzQyemR2eWNjUHZDUmdvNDlJV0NHeUQybTdzZ0d6?=
 =?utf-8?B?UDJCSk1oZmpTZEdEY25MZ0N3bU5PT0luK3JRQTMxaXI1dldyNTNWMlB0ejFP?=
 =?utf-8?B?RzNvWEVhYjI1OS9zUGk0MERpN2xNMEpKTythV3RNVGJkNEE4di9BT1JmV004?=
 =?utf-8?B?MzRKeEVFMCtEL2xyU1F0b1Y4ZU1Xc2I3MTJ4VUZRRXE4aG9ZcHBBcndxaFZt?=
 =?utf-8?B?dHA2UEJZL1d6dU1xK3FZbEFNdmZKblZRQjk5UVdoU2VoZHNwVUM3ZmphOWh6?=
 =?utf-8?B?UmtrcTdDcC9yUk52aUMwaGM4MUxad2QrdGlxY3U1NGlVRE1XWXlyRXpJd2I3?=
 =?utf-8?B?OE5mb09yVVA2ZS9qZFZUZzQvT3hCNCtyemcyN3dEcnllRVdBdi9XNW9aR2dB?=
 =?utf-8?B?TkZQSlQ1RVN5VGRqSTE3czZaazJGaWZ4Y3ZJS2lhNC9MWXkzTTZsYVVnV05M?=
 =?utf-8?B?K0lzUjNnR2s2UzBWTjB0YWJ0OFBubUZVNWlPbDV2N1dQTzlNcGNpQmFtMEpL?=
 =?utf-8?B?ZjdtS05yTk05aW11MkNZVEtTVkVKZ08rMWtONkJQbWV0S2c5SGMyUVppT0pK?=
 =?utf-8?B?Z3lMK0FpSlBZZmZKbUlzNCs2ZkxjU3NtTmhKUEJkRXNVbnlBRE9DcjRvKzBJ?=
 =?utf-8?B?R2d4ayt6NG41RjlyR2p6M0o1bTM0eEZEVXFicmhtSTdYUURpRmVwZ28zZ3JR?=
 =?utf-8?B?eTVQY3BuNzJvZFJCTnJnSnJUNFlVRnFGaGNQUGtKd3BJYUpsNkpxeUFwT0lE?=
 =?utf-8?B?bUNFZW8wL29Ja0diam5Na015TWd0WlRZbGxtMkFEQ2xQQzAxL2JCNUkyUG5j?=
 =?utf-8?B?SjYxN3V6OGU2VzhtYjhhcTRWMlpTR3JzNVozdVJrMHc2bE9uN3ZlRkJLQjUy?=
 =?utf-8?B?T2tZWnpNei9qQ0hEQVZuUHhDRDdpVkJac2QrR01PdS9mbFlhdVY0UkFPZFJ4?=
 =?utf-8?B?L2M2K1RoUkpyOGZiSlJFZTkvTVliRHI2U3VFTVdXUGpLMjRMbjF2SHJDV3k1?=
 =?utf-8?B?S1VXbUl1TXQxWHpEaVBGMEVuZWhMWEM1TFFPKy93Zi8yU0xqelRTekdYdFhw?=
 =?utf-8?B?VW1seTVmZTE2OWtQWjZuYmtQbDVkZ2s4ZmowZ1lMVmpra1YyTExTdW1PTndW?=
 =?utf-8?B?VGxtTjVTcEMvd0Yrc2JSNjlCRnEzRTRBS3h1Z3VsY1ZPQ1M0amc3T1Njbkhj?=
 =?utf-8?Q?hGNFEMl9NkWq441RlIw+fHNpUZe+knaJC8uRYYc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e743729-0d60-4067-9c1f-08d8cc99adc4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 01:26:09.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFEuYagPNnf+3uN2NI4n9J1sWkb15b0il2J0/8/u0HMRZDC4CHtpooGZdO7v0g4xSTHCDqJ9zbGT+JiAs5rG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4451
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 12:37 AM, Miaohe Lin wrote:
> PageHead(page) is implicitly checked in set_page_huge_active() via the
> PageHeadHuge(page) check. So remove this explicit one.

I do not disagree with the code change.  However, this commit message
is not accurate.  set_page_huge_active() no longer exists in the tree
you are changing.  It was replaced with SetHPageMigratable.  Also, the
VM_BUG_ON_PAGE(!PageHeadHuge(page), page) was removed in the process.
So, there is no redundant check.

However, a quick audit of calling code reveals that all callers know they
are operating on a hugetlb head page.
-- 
Mike Kravetz

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6cdb59d8f663..bbbe013a3a2d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5577,7 +5577,6 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  
>  void putback_active_hugepage(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
>  	spin_lock(&hugetlb_lock);
>  	SetHPageMigratable(page);
>  	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
> 
