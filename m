Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103330D309
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBCFZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:25:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhBCFYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:24:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1135IuBv167572;
        Wed, 3 Feb 2021 05:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=r9QTCqHoY3tNYVA5ioO+XAb2rP2zS+yEQgb69bemgv4=;
 b=LVhubk23QVaRdPzpIMLdZWBl54sVeZVxBCMyWTdB7osS/F5aQHLsRBOdep5OO0owJ7zD
 OUN9xZjx3zQHeAXNeAMqWmXhU7vuWnV11hd5W+A4b+OdwJnr+LvR5abTsbZ54i1oeJqN
 FAsxykXQ5zKEtRp6J0VDMaUEvhuXnq0JWk6YGkeMUQeJbGasr2iZBlfbGTE7CTSwYsoU
 f08j0Rn/U9LhpLuqrerfrnTOJfYXH0/SMS1BsCb2Pcaoxb61ou52x2dHVhguW9Q16vdX
 /pBT5gMyY1qIN9g86woNG/vPsigWxgLnURKk50WV5nZawn/K0utwxKnIaLCkREEgCnv/ +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydkx3bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 05:24:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1135JWoD153980;
        Wed, 3 Feb 2021 05:24:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 36dh1q5rk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 05:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrdhkwsX/0r1596xZJVj0F+2Lk/kk4QlfnGGqBbF6KouVTKSN1KtgPydGVYCGUbaQ6lz05XYVG1p9pPt60guOgHDo3uDHZSySHTLKdB30jn2ZJbbabx60KqcEplje89sTBu6xK4FtjPmNNjRgtL9wrgbY1oyT+VTmR+mxpVp+lRnqSJPUcV0Lg8UpPK71tLciazuHtJ6ulQ5qggpIwHZ4IMKdEKSTrLrFmK2SVWqJnBdWkOp8p2+lNqBAZhQSJ5BhCRUybWe1apiS5VjaYuhk9kl8ZcNr9umqslEBFijDUij92gBagPLHPpPHcJWvdJG0epw/AfQAaOE4BQjKFzqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9QTCqHoY3tNYVA5ioO+XAb2rP2zS+yEQgb69bemgv4=;
 b=CWB5gZ+SPqtO7uZMGM/GeIm9aQ0mavh4VvbwMIcrjCrIo3P/2OOfxHHIUK9z3YT7tUQwpW8pig2S70cN4O31qmZ3KZqkrlP4LmyRKcPdkSWagv7f/yuv1hS/n68ix6YoLoUIWQ7WzG7dMrH4lK2CuvScO52/ww7osKK5Tr79hG9TDXdPyWeSCC/lKGcaVMjBlE7+dtNYDpGSO91ye8yhFUwvsJadDTe68iB711zuAI1QyuiW6rjVFspkMS5tupuVrV3K3RSoV0+6s1cQiqgCHzjeX6bOahNMFQpYptztKnBikxhYP0ZpjPAGQTb8utkuytycddwyvUqyM0OrfS3oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9QTCqHoY3tNYVA5ioO+XAb2rP2zS+yEQgb69bemgv4=;
 b=pCuvTzXGGPs8x3a632Ss8v76yWNsc0YtFC3e/Cp/HmgKBD9qv2hMVlBzrwnMBj4+Pmuv8/JkHvNa2N2+ZdBmYSzOsXV8AA9eClOfbfb8CO4AWMK4v8tOlCnRY1Z/dpJqG8ynYI4HsRCPtTe2Aua1vgMylmLxXS2S1m+8S33nCpo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 05:24:05 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Wed, 3 Feb 2021
 05:24:05 +0000
Subject: Re: [PATCH] mm/hugetlb: remove duplicate codes of setting compound_nr
To:     yanfei.xu@windriver.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210203044055.89618-1-yanfei.xu@windriver.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8f0c2bd7-5fc7-6f22-3f68-21bf235ce930@oracle.com>
Date:   Tue, 2 Feb 2021 21:24:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210203044055.89618-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0138.namprd04.prod.outlook.com (2603:10b6:104::16)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0138.namprd04.prod.outlook.com (2603:10b6:104::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 05:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b08a48-d50b-4afd-7297-08d8c803ec72
X-MS-TrafficTypeDiagnostic: CO1PR10MB4609:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46093D1DC12D81FED3E7E2DDE2B49@CO1PR10MB4609.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWOrHtP2G4G7upaU8K8ksSwNXAjHSJL35jX9DSZSWPOH6Hxstnq45+VDQ545s0BT8q85hWlE0TjsVv2OdPBeaXVJwbUsvoFxIP8YpLX4r8MMaVLDN3IDEOKEH//l36gmLdnEz5UIEQCIYMxOQFmUSushBp6N7CNPlxGqCa/7HNIZ3MYMMQhGVK9huZxBe+QbqcqFak9bOYCZ5DeGgdhmL5+2dwAetnxzGFq9oEJrQ4YQTCO8DG0Yq3Rm+5M2OWU9EjL7+aSfQMWfv3Efp9nyMKhSFETSPl7w1HjeyP+RamFpNlUJGbrOrTPhnZlJZA64SM+MIgoa7WQtyQIz2dAUVuG2KgBWmc9BIb08J17qyzCqYDIY20XLTN1kbHAowIGwRfhLckheYeR8y8QLDp2sKnbVb4JM4M20RF0dWmE2NrBuIhaF9GpgjLkyUqyKSXKlZCuUQ1UqMS+VDoMqzHVZStJGrC7MUqJPvxZ19bQAitiKDmFJ3sodXDVpK2XgnHnAlZyxpZwgHGcgILPeoTeSQrKmIIuzq/jng8FUBj3xM/gGlak3LR92enBa6Y/V+f2UO/HXT0rFvU3w/FZX2NQ74Xtkr5a/X9yYWd0hH2Qx5pU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(66946007)(8676002)(66476007)(4744005)(478600001)(83380400001)(36756003)(8936002)(2616005)(316002)(16576012)(66556008)(186003)(2906002)(6486002)(31696002)(16526019)(53546011)(5660300002)(86362001)(956004)(52116002)(31686004)(44832011)(4326008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Um9QSTcvV1k5a3RXVUVVQjRGREh6Ym9keVdpMG9QOEY0VUVYczJweC9HNktS?=
 =?utf-8?B?S3hKUXRpMmVjWWxQY3VHQTJvelg0Zk5FZW1wcGNoMjh0QnVTV3RRcGJCRi9w?=
 =?utf-8?B?L05BbnFuRUpwSFF3ZWpqenFYWHlPYUxGSnRqeVYzRUh5SFJlUHUxVnp0VTBx?=
 =?utf-8?B?UlpjZkZqbE9xcWhtbTV5MlJxaTRTWGNQVTRwb1lYUFhTd0N2MmZiMml4ZFpi?=
 =?utf-8?B?djhPZXBMeCtmbWxDMFAvZnRIMFRjNlF0UmFHSWxKSndrbTZuYTREOTlrdTdT?=
 =?utf-8?B?a3o2dTY3ZU1xVmovWktEVElFNEI1SDRnV2JWUm9XLy9Gc2U3Sms2MjhxNXdl?=
 =?utf-8?B?NTg3K1U4TEFSWTR6L0JObmx2aTZpVUxVYmpObWhIb2lPMDV4VTlRdmZGZmpF?=
 =?utf-8?B?ZkRQc2RXTEd6VnVZUU85b2swSURoZ2NWY0pjOHVhTUVHdm5xQS96bzE4Y21u?=
 =?utf-8?B?d3JYYVhNMm93bXJ6OWF2ZUNWU2RVS3BjRHNqeDFtL2lrM0hDS2dCTFZ5MnNI?=
 =?utf-8?B?WkVhUDhBY2FOV0Z4MzNBUDJoc1BpdWJlaXQ1eDRrZnhUQjBUcDlWNktsL294?=
 =?utf-8?B?aHI0YkNZc09ONFJzTk53TnpaT2xaR3FKZlFiMWpjV3I3b0JSYnBHVHhDbHEw?=
 =?utf-8?B?RmQ0R0lpSDFXamYyMnltcFl5NDBOa28zNC9kNzN6UU1YYk5zdXNkdFh4M1kv?=
 =?utf-8?B?aG0yTFdRU21CcmRhZW5oVXBIY3hkZjBZNFZpdlJSY0Y5bEp0akRDbUg4Mm1v?=
 =?utf-8?B?TnNjdVE4emdPMEVYQlBtS2VtWndWSWxxSnBzQy8rK1VIMXVHQ0xMUjhoTThJ?=
 =?utf-8?B?YlJpYlRaNDBqMHFtbmcyVmZCRFA1Z3NIZDBMdVBublZUQng2SmFEcGR1UXRN?=
 =?utf-8?B?M3lKR2RUOHRCNkc2UTF4a1VQS1JkREpuSkhma1pNZjQxR0d3YUpiYXBtdUpr?=
 =?utf-8?B?K0tYMXVXVk9NQ1VGVlFYZC9KTDVlWm1XeEhJYzZWZGVsVHZBK1BtOTlpZkJB?=
 =?utf-8?B?QXdoWnduYWZwOFdwQ2NTTXRIN0wrVkNsVkJrUmpHYjBxNzNMckRoRDdIaW1S?=
 =?utf-8?B?QXRWTkgrLzlnbHRqdHBpUnV4M0p4dmxQdXR4YVhMY1lWeTRNUnowemtrbnZi?=
 =?utf-8?B?RytjbWJSV28xbUdkSksyRnpOWlhyeE1RQ3ZHQjB5MUx2bGtrQjhlWSt6Q3Y2?=
 =?utf-8?B?cnVISU5kMVFsTUFGcDBWSTRFN1JBckErVkF4VmJwOWJkVjFRdmhSMXpDczZj?=
 =?utf-8?B?K0JWUHRMd1lyVUVxaFdYZjF2ei8xc09IdDErUDBaR1hFMk9UY1lzZ1BJRk9j?=
 =?utf-8?B?ekY2eXNUMFV2c29qcEZER2Nvamt6cGtFeXRmWXFkdElpamhuZXpRWFk2RTd0?=
 =?utf-8?B?UEJHSTdLck1EZXlIdS9SSDFuQ0MvNitpOUE2aUx2TC9md2hFaC9zb2haNFhZ?=
 =?utf-8?B?UmxMUmNoMEZVTEJ5eWl1cDlKT0dvdzd6NytZemNLanJwOHh4VFR5bjN2SG1U?=
 =?utf-8?B?TUFLT1JyYXhvSEVZTGlqbTJtQWN4aUYzYjdhK0ZjQWx2dXlFWDh4TFViaGJ0?=
 =?utf-8?B?ZGJKMENueHhPMS9QaXJISTNwcE5iYlZmempVdWVWQ1VRLzV5dmJpZzdDeXg4?=
 =?utf-8?B?SW5OdCtEdWJDckJBUUxpYUVVbHpWQmZIOWUrNldsRUF4djJPY1dJbVYvT2c4?=
 =?utf-8?B?ZmhKVVJWaW5LempSdTdCWXJxendMbkNVYTZVNlE4S2oxL3VhMXZtSVRhVzMx?=
 =?utf-8?Q?ezZ7iBEbg3rvOTtYF9MdaBgoDmnA0e/mGHtuCHL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b08a48-d50b-4afd-7297-08d8c803ec72
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 05:24:05.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C58x+KzNhKXZCeBvDwUF1fUM8ZMbWneFsVz8PrNVd0KlRWcC74K26hlVSFhpsTHkLz/hbddeyzmnQOIVl93C6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030030
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 8:40 PM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> set_compound_order() set both of page's compound_order and
> compound_nr. It's no need to assign to compound_nr again, so
> remove it.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a3e4fa2c5e94..ac249b1583de 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1228,7 +1228,6 @@ static void destroy_compound_gigantic_page(struct page *page,
>  	}
>  
>  	set_compound_order(page, 0);
> -	page[1].compound_nr = 0;

I may be reading the code wrong, but set_compound_order(page, 0) will
set page[1].compound_nr to the value of 1.  That is different than the
explicit setting to 0 in the existing code.

If that is correct, then you should say why the explicit assignment
is not necessary.
-- 
Mike Kravetz

>  	__ClearPageHead(page);
>  }
>  
> 
