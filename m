Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF630D30A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhBCFZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:25:48 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:1249
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229815AbhBCFZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:25:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgEiTuGO8o8ZTW6QdqzEKvLnPtx7XOcJaNUWw8dT3PlsV4HTe9SaAbEvlYZyMHqkcP15/W3MX3xtlmTsS31rQ0/JPf3H2xf8j43MHoWTROH1Ha/IXHIOyJEo/H/37AyIGfXdNOEUYf/I5jIBOmMee6gahRaXLme8+VBHb8HkvfTWblBjbs9w/4NYNMzWFTPpe5faJrWZmZyWdJpeyb21O0uFqv1Lu4IWUV1Mcxyu6f41Rp/4MRJWsJxTT15ESAddrlGhiZ3nFBuuYhbvJShaEsDRzdfbsxKOG+pjO3CyFJZOHGsQLGewsDmofroUdOGojS8nAKxRmLrBV3WE9Iz26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTtupcJ2waTLHfwXHbp8+WDAXrG7QWyXybMPyFfWqS0=;
 b=HLojlNbviaogL1f1Rf2WGNUgSfcngTtgUI+/W3Gdm9puG4GTniEHh/2KPA65z1CBhm3TdraxCJiQxPayxbSuyP2P0PE20pupV0ku4lIt+4OQz8uwOVINUcPEIc6rYBQ/cjXJiXSRrUe2rbJPiw5hquhFM5kBiYsX8+WgUT51TwUJPXhP8i0/M0IJPjFoxH7zRlrJRXJmZdVzkTzjDR9iHPqHmIC+8J4MdLGIKnxOhidK+Y7AjSgwPrkmkTOeHoSYzePymrDVfstQYDGPXXNuQhtGZVPo0cAPx45XyQLZ8YL52MvtdzlCoAOkwgOgE+vxVR4zmTgvYTZpjNy+Qy8L5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTtupcJ2waTLHfwXHbp8+WDAXrG7QWyXybMPyFfWqS0=;
 b=VY1GZUdWIjwUVkuXX+HXbkOrqnMnEyHFqpBtS4VDxivqt9WP6P67MiuLbCFFAfLpk2tCyUzVgBjWMYTDTHx2pk/TSP6Q3oZnIoqejMntTc2gvb68/EVQ6OYQ0sGcljF3xoIZWAXOBNCKH6ax3r1xJkYFchTtlP9GBYbnJB7OO2s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3350.namprd11.prod.outlook.com (2603:10b6:a03:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 05:24:43 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 05:24:43 +0000
Subject: Re: [PATCH] mm/hugetlb: remove duplicate codes of setting compound_nr
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210203044055.89618-1-yanfei.xu@windriver.com>
Message-ID: <ac1da539-a7c6-610b-b1bf-c36989dd2603@windriver.com>
Date:   Wed, 3 Feb 2021 13:24:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210203044055.89618-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.1 via Frontend Transport; Wed, 3 Feb 2021 05:24:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41bd2857-403a-4f81-d202-08d8c804033a
X-MS-TrafficTypeDiagnostic: BYAPR11MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3350DAAF8A63D65F24408FCCE4B49@BYAPR11MB3350.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cS/A+B9rHBWBs2XsO5xoTtZx8zDAD1DD8vwNCWjBso9tAZTmQPt0HRGhNVZ+WVLRwUwUGPFy/QoNiWsqwEDO9+7a1f3K1fqn96KLUhJBjyoPztoBwIfHfNOlZ6X92hyjI0AmnsprNeuiIzEhwfXDKioaoNTAGurA2v1UOS5MRPedb85n5Tv4liiqdmao/XbDpCOTm421BNH9Jgw8C3QN00hg8hzDAGhVyCOvQE/De+IKGAzdsLL269J9N/2aRTycZ8jvLGhTnd70ZtL1b7UI4YsM93qYlCMCTBMqJeAFsDFhH21NtpnuJBTw1TupZWVy9nVG6fmOZ9nAeN+5XCv6/lbZmYPvbNnM4LJ4uGsfQ1hev3rtlDZHRgcdV/Bd6SeUG7kk3PH8vgrHLjKofVS3KGATUEiTPZNLlQWJgfj6/ovt9bkPe3x3QkOKgHhYxv1e2QssDN50ScTO/KMC1KynwfyyFmKhxS8zRjW52N+1x5NJlkoCIR2vclzXc1nFLxe+Jbl7ktEdd4SBxRXhH5NaT/1v/0hvf2lAF+0F2khxqrsp2refw2AU3zqpDrCOO/EDedIlq28rz3SOvJR3fU/tx956BMEB6kQ4CPKvDjjtJiwlcPurh3ehjwRMsFf2KJ46
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(36756003)(66476007)(66556008)(66946007)(478600001)(16576012)(52116002)(53546011)(316002)(6666004)(26005)(16526019)(31686004)(4326008)(186003)(2906002)(8676002)(4744005)(6706004)(83380400001)(8936002)(6486002)(956004)(86362001)(31696002)(2616005)(5660300002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V25QNGxQTGY4TjBzNjg2amRrQWYreUViUFBRY3YzQjM2RnpNS1BEUUxzc2pm?=
 =?utf-8?B?Z2pPRHp1SW00SyttdUVUa0orbnlYS2NvSzZpN1VKS1l6OERDd2VFZnd6SC8y?=
 =?utf-8?B?ZTVEQzZraXhTdm9pR3loYU5qeGNWTWVmbDYxSFpiQWtXRlFPdE5rTWJ2N2li?=
 =?utf-8?B?VzdyMC96dUF3ZUNEbXhtdDk1QlNSbTF4VXNpbEdxcFpnUmFVVVdHUlRzKzBa?=
 =?utf-8?B?d0VydzEyOXJoRHYvcityeWozaEFidmtqNVZ5V1BHRGhPdVdtdTFiTnAvR3Yz?=
 =?utf-8?B?ZnUrQkNCQzRhUVVpY1cxNm5NVDVZYTk5UW1ZUXYvZEpnSU5xYlFvd3NMN3M4?=
 =?utf-8?B?UFprT2hsd0d2R0l0NndTK1R3TzlNbkxEQzdJTXc5eWpKeTNNRVBtWnFNT0NH?=
 =?utf-8?B?b2puQmEyRlg3TkswN0tYb1J1WnFyQi9ocmwyekhGemxTaG9ZVkJlL0VFdG8x?=
 =?utf-8?B?RWZDdVVrOGQyUzJ6dDFjSWNuYkVkM2RiT2xwSGxDTEM0WUxsWU10MWFHWFZG?=
 =?utf-8?B?cXZaMUhEQTFIK2hQNFI4NnRBZ2dkS2J5VmpQTTZZaHdXallRZWc4SnBmVnlB?=
 =?utf-8?B?aCtXclpsbHVTTzNEcm5HT0x3QlFVL3NZUHBOKzdjcDIwbmtJSW9Hb3QxdTRO?=
 =?utf-8?B?Mm41dm1WOHRCNDZJSXBxamQzNUwrV3o1THY3cVdOOXJLLy9MK0V5T3BYMjYr?=
 =?utf-8?B?aVZXelVqRndBOUlReHFGL0E4djZCVEVUbzVFVjhlczI1R09ManEvTFVZc09Q?=
 =?utf-8?B?c011TUc0V3djMmVZaDk5STY3WUJHS0JZTHp5bUxPZVhKQVhRclRjRm1OR1Zw?=
 =?utf-8?B?RDFMV09HWlAxSzdGdk5UWk5TOU9xNElsZ0piOHlBNW5VeEZvMGVnQTd2cjB6?=
 =?utf-8?B?dGZuNE1ENXVxWEdRSHRwckpvajFFaUFzaFVOUDhLYURLZnhqajduZzBKSWk5?=
 =?utf-8?B?MjliSmFveE9rVzNjVHY1MUdBNWRkYU1ZTkRaN0VtYmxhbkJpVmpOeENOcFFY?=
 =?utf-8?B?eGhzMUtXL2o5N0V1VEJnTVpYVStxWndKdlhrRDA3ZEo5d2NJRFQ4MlBVck1u?=
 =?utf-8?B?MW9vb0M1TzFkQ3BCZGhCKzF5TU1sT3NuM2h6MXQ4MG9DMXFXVGRNL2hXcTJz?=
 =?utf-8?B?SUxDUlY3QWM5MFJQOGYyWUEyQ2JyUEJzNzFCU3hKZkkwSUl3ZnlkK2ZjNUJm?=
 =?utf-8?B?UDRsMUJQR2VXVkY4WkxQOUpCdG5ZcDV0bXpLRlQ2NWRjQ3FKQkhwSzYzUUk0?=
 =?utf-8?B?Ky9nOERNWlQ0WlBDdnZGVEJRZzJ1Snhzc0lyOEhoS0wzeVJyVTEzMHY4c1Bj?=
 =?utf-8?B?ckhKQjRtd2RyUXoxTzdOU2pvZWhPa0pNL0k0cUJVRno2VUdsb1F0eEZYZ2dk?=
 =?utf-8?B?UzhkbGxZQTdYTXFtb0xwREFvNjZYZnROcmRNVVFreDhnSjcwYnN0RUFqNGtW?=
 =?utf-8?Q?mXp52KoP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bd2857-403a-4f81-d202-08d8c804033a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 05:24:43.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoYCagSrzUJQhgxL6+cRhlbn6few/yEiKL7BymxXyUEtBlkCGykadbfAknsLTemeu62u6v+VFRQJ8vM6R6Q/Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry. Please ignore this patch, it's incorrect.

Thanks,
Yanfei

On 2/3/21 12:40 PM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> set_compound_order() set both of page's compound_order and
> compound_nr. It's no need to assign to compound_nr again, so
> remove it.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   mm/hugetlb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a3e4fa2c5e94..ac249b1583de 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1228,7 +1228,6 @@ static void destroy_compound_gigantic_page(struct page *page,
>   	}
>   
>   	set_compound_order(page, 0);
> -	page[1].compound_nr = 0;
>   	__ClearPageHead(page);
>   }
>   
> 
