Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E933F32343F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhBWXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:34:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhBWXXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:23:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NNM0eU007194;
        Tue, 23 Feb 2021 23:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zvnkFAyLxHVZyv+iUM17R+EYVqoxQ6vct0U7szKy+i4=;
 b=O9RYjaquuKP+S8QUR9mR+zFPDUWNgA+P0n0wHzsAdpDgR6cAdRGWDjYE7bVgXJjpBkwI
 y4ZIe+UkDkY2mzdl+B6dDhkPCbkeuxw8ZW7SuHR+hh3n1RJdUK4PkNisrNmNGlfVDZJp
 kkRyEcPqIDZG5YQDJmf02/UlRqHNnla6WiLF5SN8NiFxrOqYbp3gXrf+qiJ2Z1JheIv9
 MwPkvNAPdEWjVDSliIbENcT7FQHN46GG+8328sBLClWb229nQMgUaeSh6rHJw8raQRi+
 lkKJa21dxLY/Bus/n25UhMStMgnpPO1iSNgzf9k/lzDO22fHuTIQ5cpRE7jimz+yMJPC jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm95ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 23:22:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NNKRCC146389;
        Tue, 23 Feb 2021 23:22:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 36v9m57wsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 23:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRyWfSju3Mn4z7NSOqwD9+ym+2ZE7IvoDLIrSkRmMPEedPC14YHHJy0DXfY675CI+VXN8lpXdSsO0tYaSjp8b8fdhIan8G0XOQZQHEVVSQrBLv4Fkzv5MLvf3qHZ9A3akx2ZPQT8yZG8LyzYnnxjgfaStvvJUyWueD4hBqw3t0Vwyok+k528sD1fHn7QoNqQ7HQ2uG8NRBNWkh7ophk9nx18fBtJNn5ddHrOf5PAzJHCF+mluRnT7L6BxiW6PmdHwaRF7HCnTV+N9BzQXwL6ito69jcGemA8VU4Ptq8r7MHie8VJGXSgmxPaXdAldMbdY9dplNYvQyZxBGHkEbyALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvnkFAyLxHVZyv+iUM17R+EYVqoxQ6vct0U7szKy+i4=;
 b=H6MbymZIROGHea1CDDgyoW2cqeMRMZMGV9kLhqHtgWznwQNFQc9P4XNT8W4ipQ0Z2QmItwFM/Jwn0q61/v428YvAWjfcU0DWfxqH+MTAbgUSVod/Cj6b3vHHKxtNQVv+0V4igGjd5myptCoGmFNlZBFlWzVjWXM7ZXCrljRjMAdmeFjTHD1eum8LHRQFejok0NbYSyp8e9bi5pclAs3RBtjA6waJtygjRKcg7cavsnjU1ztl90TG6T31vmzSzzTU5FgudAACSlv9caRe7YtRM2zLfLY/37AqqjGUrvfXTA6VC2WGEfms+ldsNBOtOz8kPltv95rBAw4UwAUBGyc4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvnkFAyLxHVZyv+iUM17R+EYVqoxQ6vct0U7szKy+i4=;
 b=qwGGC5r3WNR4jKXqMWXsAXmZzHuhR61gRkNvCclUcbzvs4W4qhTk2urSXKDsu+Cu8KRlH83gvQKUFRYKzRzjviRb4XejopnQ9RLfW3wt8g5LMorG90Lo0T77OmtBEZU9bsIb7zn9OOC71JSnIe6RV5F1T4qHSKsmgd2/kK4Ghps=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4322.namprd10.prod.outlook.com (2603:10b6:a03:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 23:22:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 23:22:00 +0000
Subject: Re: [PATCH] hugetlb: fix uninitialized subpool pointer
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210223215544.313871-1-mike.kravetz@oracle.com>
 <20210223224540.GB2740@localhost.localdomain>
 <53527e9d-d09b-7287-9f79-ebdbf4e9bc7a@oracle.com>
 <a7f063ea6b5eae4a4fcf038268e3a604@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ef62ac45-9ec9-2582-3e58-7efc0609221f@oracle.com>
Date:   Tue, 23 Feb 2021 15:21:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <a7f063ea6b5eae4a4fcf038268e3a604@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Tue, 23 Feb 2021 23:21:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a43d220d-efd2-454a-b714-08d8d851d216
X-MS-TrafficTypeDiagnostic: BY5PR10MB4322:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4322F616AD9739AA261B3DCAE2809@BY5PR10MB4322.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPPRZ01RYHz3NutxMpbQQ8AQ/ObMVh1ozM/EQm7JMcaDmMKuUs2Y8ascjD0Rhlgim7ZEdPIFnl5DnX4oGnuQtNgc4aH63+WWalOM3oFpmJMyFpvPGR4Du/6WkP375/Q2Irf5ZydIxe/r4SpwiEE+OH6mH4fo6GUJ9QspXn1LibEZfYPKcOAn/BFNK7C4g6p/8gRlOYVMkcWS8UpC8K3vhfCRKl1C07luXnr7cHm7LKTinHXzPd6L2DNgS6wbp8gZa/S6/odmEh+nJJG8slkXCw7OrYIcjYEg2HLEaYwI/l31nhjh/xqL0gCEHfT9CCGD3U6LvNp2hDgbJCAvtnPkH9usQvVYSZVeqvPXofYPoud29hbAwxbrCQkwM0FLPdgezTZQkBWDSjpAwhbovKW+x2BL0JAHsGodlRZ5ZeQ5bSic++XpdE+sYphoxOxO0DB0dG/zy8oR2ojkyOfeSqxKZDMhin5dZCv2InJYcdK4PRoq+wBbY6igRP12DDCEcke8UuSwHJ7Qx1XoR+er45uzJ1UKPy25TcsJ+F3y0Fr282K5G6OXI2Cx9qQL4fp366io9xqZsh56T9CjCw+YH6y0EkOgjVOy0Ui/UcS3VbCN+ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(16576012)(2906002)(53546011)(54906003)(52116002)(316002)(86362001)(44832011)(66476007)(5660300002)(6486002)(66556008)(6916009)(4744005)(2616005)(8936002)(8676002)(16526019)(26005)(31696002)(186003)(36756003)(4326008)(66946007)(478600001)(956004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TGMybE1CcjkzZjNnRlh5MjA0YlgxbHhsSnNSWDBheUFtVks1RUdjdWRmay9r?=
 =?utf-8?B?WitvTC9RVVNQMzhkQnFjN1lNWkV2N1dpeHBIcEw4MjMzem5YOURZbVZvOHFu?=
 =?utf-8?B?OXFVdHh5eWxrUlJPM0pZM2JIL3ZRRHBjcnA5VmhPWGZzbUF3akdScmhlTEEr?=
 =?utf-8?B?Q0JqOWdOTFNZTHFoVnlGYjhEVjlCcndvT2czNDVxZkU0YVhmZ09lNDlYSm1w?=
 =?utf-8?B?c1BxeG5TSVBiOFNMQXAwT3hMbzc1aHl3YzEzT2N6RWN5Q0EvVWdCRDg2MVox?=
 =?utf-8?B?OVg2WFozbGVwbElCaVlVM0x4R1d2cFdmcVJNYjM2YXVWSU56SkdFdXBoZExN?=
 =?utf-8?B?cWRVc2JSelpvNlR6bGlSMTZkSm5WWVUrQlpMYmpjNTg1UEhmak1UR0ZJZWND?=
 =?utf-8?B?b1RIMjJRNUluTDE5aXhIeXpsVEpBODNqWmQ1OWhUZ3Y1RkZJY0RUYUVoeVhJ?=
 =?utf-8?B?Q2ZudjlpZ3JiRzE5cjNKZlNEd3BmZ3FhNXN5SVo5M1QzVWNhSXQ1dGgxWldC?=
 =?utf-8?B?S1ZBbHNiY05pM3hqU3lUMk9UQ0c0OXNId0JEWTBnVG9kc28zKzZUbGtXaFd3?=
 =?utf-8?B?R3ZBNDRLQWoyNitSd0FYL3k5ZFlXRVdHNm1ZMnBwb1hFYkN4TzNtNHVpS3px?=
 =?utf-8?B?Z0pLOE5FN21LNjdUTmI1SEFKSkFIem1Lamovc0JIWjhTRXR4d2VPanR3TVJW?=
 =?utf-8?B?bWNJYnpieWJwN3loQlV0MGZMS3ROTU5xd0Nzdi9ObUR5d0Uxc0cvT215M2JE?=
 =?utf-8?B?SjFhRE9JM0NPR0Zid2djRWpMcEJIT3ZmMXY5WnUxcnB1VCs1WVU3R1FpRVZa?=
 =?utf-8?B?c2gzbmxmTnhrVjdsUGlBTjZHOFpRdnNGWnVLYlllZzU2T250SzlVcWNZS0lo?=
 =?utf-8?B?UkEzVlNtVmd1aUZZQk5KQkxWajlxR0ZHYmQyM09rNitTT0J0Q0hBL2lpbU5B?=
 =?utf-8?B?VndodFQ5dmxQNEg2ajlJYkZjOXErNUFteUlEMW5KSEZQWjE3QUlqUW8yR3hx?=
 =?utf-8?B?VURBcWRVa0pjRm9IbG1XOUR1ZzY5bVFxYVFmVVcvZzVNUUlnaVdPRmtJdkpO?=
 =?utf-8?B?Yy80L0NaeGYvZnJ5VGloWnluaDRkUDRnaHJYNTVxSzhYNFRGeHJsWWpkcHBT?=
 =?utf-8?B?d1JQc3daazA4YmJhRWFlSlVvUXN4aHUrSWxyc1NzNmJObFNVQTkyd2gwNG5D?=
 =?utf-8?B?ZEpQTVVrSm9GdHUwck5KSGVkUytSWGl6VGhXR3pPakhGQnhIWkVrMFErM0Ev?=
 =?utf-8?B?UUVOVW0rcUQ0Rkx5U1AxQ1BORVE2dEY4MmRJc1JRRndVeHlLZW1jZ0lmUGFC?=
 =?utf-8?B?THpMcFV3K3ZSQkdmNVJBdXNIdWVGMmF3Q0NVd3Z2OUJEVU5HU0RVdUtVekVE?=
 =?utf-8?B?bW94SjVhVlNCbFVBTU84aE45MktVQ2R6U0xYM2c2Y1phTFA0OTVxa3ZMMThT?=
 =?utf-8?B?eGsrVDN6aC9DZTlxUGhKeUpuSGpZek5Hb0JTUjcwTG1Zb0NMdTNTbkZTdm5V?=
 =?utf-8?B?RE1MYXNzZ2gxREFyL0xIZFZiN25MekU0Qkx3RXJJWHdHV1p1Qk4rLzF2TDU4?=
 =?utf-8?B?QXZ6YTE0b3gzM0xvQ1NFVUI4dk8xbHVYMktML2NrY0U2Um5pZVk3SC94Mm9O?=
 =?utf-8?B?bGdXWXJ5RWRCYVY4TEhOejgwQzlDeXBqY2VZYzBwMkJuc3RhdFE1bmNHV001?=
 =?utf-8?B?bVV3MHk4NVJDd1NjcHZtYTNrS0Z0Ky9KY1Q1cWxWenovbzU0RGlmVFdTd3RL?=
 =?utf-8?Q?Vw3Q3VspgMAGwN4ZlZF4Ek0PDlws7xN8XRuNDaQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43d220d-efd2-454a-b714-08d8d851d216
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 23:22:00.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuLPPJ0oZl4pZ/gUwDDxEkLXkjdAHlkX5GkILMW+AdHJgUaX3K9Hn+ElI4zrN7sil824IGArVeZbrw4t7vTk6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4322
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230196
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 2:58 PM, Oscar Salvador wrote:
> On 2021-02-23 23:55, Mike Kravetz wrote:
>> Yes, that is the more common case where the once active hugetlb page
>> will be simply added to the free list via enqueue_huge_page().  This
>> path does not go through prep_new_huge_page.
> 
> Right, I see.
> 
> Thanks

You got me thinking ...
When we dynamically allocate gigantic pages via alloc_contig_pages, we
will not use the buddy allocator.  Therefore, the usual 'page prepping'
will not take place.  Specifically, I could not find anything in that
path which clears page->private of the head page.
Am I missing that somewhere?  If not, then we need to clear that as well
in prep_compound_gigantic_page.  Or, just clear it in prep_new_huge_page
to handle any change in assumptions about the buddy allocator.

This is not something introduced with the recent field shuffling, it
looks like something that existed for some time.
-- 
Mike Kravetz
