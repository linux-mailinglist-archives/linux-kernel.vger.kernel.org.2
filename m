Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D64140D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 06:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhIVEuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 00:50:44 -0400
Received: from mail-sn1anam02on2046.outbound.protection.outlook.com ([40.107.96.46]:14407
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231526AbhIVEuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 00:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQklw2SDVZ0Li1Dk9GoOQboa+JbzBgysnh6JM7yVZWA4r37Y4ekuGcJ25nhBmZgZYubPsotiqbDrigHVwAyjq2/NeH+Mqz6vocS7t+zfnE4/QkxRHVBTRt1h29zzQyINZUTyhvzea77Tjkgo5nNgNJzYGBFgN8JE6LdmqojyvtUmS4SognlGRfDNuF1/bL+KdJnmNvM2z0gQUkRk32GQccxAxPdZsXhyupyecZDlrROh/2alnIBfmHZdQ/C+gfEF1yuRwo/FxTf03ky5oMYecC4xqm3GxowiQLy0BKm+tfgo4flh5Y28ROivqWB4nhf+vA/ruudfqMemd9jaed01aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WKpjESRKlEut09q7+apd0aXcfwc2p9fMX50TNPlY5M4=;
 b=R7uQqOgxti20LqOCZIfxzRC/jRQGsDplhX/llT89uaSKwl5z3SHX1TsYNEsn6kUQg3iT2ACoPo1bryzYgojYojyNT66Z9KjC6W1hkABlN5Ams5uZq6mibXqIh3YcP91PQqWZ4toABi1lRUsrJJcxGU/KYyagIUF715Vw02q3quW7iFnOJY6dz+gzPNYd/qTDS8GBHbVM9LPYek7QBx8bNk1qH0/2a5sIrgA8PIq8k8Nm6Sju3OAQ3eMIfOZTHisTdH70yCnbU0ge3L9EP9nGtTa4V5jbuAoBRpbPfb3Xg+IXWjumxPDimhDLSNSRe/T8hBqnG0iYHyyqlZUvVF5LLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKpjESRKlEut09q7+apd0aXcfwc2p9fMX50TNPlY5M4=;
 b=qn82Ma+mriwZy2B+7VWECUdVwmYR3lYypNPVcGW+jcn72zMcIxJlfmnditpnnUlcH5ifnYgND6dB3BeTHWO4cP52SjPOZSbWzf4x/6CU8fM65Y26KObK27sANDg1C/VIcOHoWV551BUF1yTebadehepr/lFLpFUd+PfQPHdm5DAlXBr9AnnqHUxOH/b5cyY3C0kNTwEyR5hoET5bpyK3+NTjuzO3f968+ehVS2XzBqwU2fmy6tHtM8WBJhi3LTbqdQCLQ3htYqnupWNR+NvYUDc3Rk1EwUPNRVSVAFYIJJnNJnD/7rTxUQAgAB3Ag5K9qXwD4Ns5ZIh7xcnEMxRhjQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 04:49:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 04:49:06 +0000
Message-ID: <35ba1b41-507a-a178-b81f-9d7305726b9f@nvidia.com>
Date:   Tue, 21 Sep 2021 21:49:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 2/2] mm/debug: sync up latest migrate_reason to
 migrate_reason_names
Content-Language: en-US
To:     Weizhao Ouyang <o451686892@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
References: <20210921064553.293905-1-o451686892@gmail.com>
 <20210921064553.293905-3-o451686892@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20210921064553.293905-3-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.92.177] (216.228.112.22) by BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 04:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99d782ba-e560-4011-eb55-08d97d844f1b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB319256CC749A1EC9ACEBA37CA8A29@BYAPR12MB3192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:210;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKnQtuvPtxzvmPlAxO1Bo+himz8T34whsrNk3EZf4clxt9NasrF50XLd7Gh5O1cbfnJ4zlF3mZIjW8DTI9SjmyueqkJWLHIWRz04UNt11RAgAURa5vZ2ILJt58hnvUnVHVD3KbvYDMJ1DcAX1k+4cgjyeaYiLDqoP2m2K0S/Dt26J46xqFSYBlG1Q8S9QfA2YNZq6mM+ltvaVtP4c5JvV2GYjpcfsGQkZDchiIiHzXRYc0xf+c8CVC32+vBXH/KL01cGNWh7KBgXt18Vw2Ycx0L9kehLUQ/Cf2snfdOQNOImS0D8oyuat3tVOFqXVe1fDlmdrjwh4sBvWbf/DIhnaUbN9VWAXwvE8N7LhtPXqiKKVJ6c0//9/aYD4BMXRlBxYy8D4QNyrlUl0fi0lVWid5hWYyyNxUg3Mbnp8h5cRa/Wj8LmBt4P+1wvbihA8kiWQLUjlJixPvwUwnTtHZ91XeM608Ob5qUS8iiQG/Nomg3Yco5t7Gf0FXMgkqe7Ydod83u7BZkK6dsomquyo5EZnTDatcX3A15uXJvZvlpGwsGM3QPoS92zNIPkCQFzupuvyjBUxJb9S0/D1MbMKdayQ5YW3uUlBvcMLErSxOeCuoqZ3h6E8r8yasTDbfVVtRR69nIYoW1B7mjyHYlF4t76XPrsQhfyEgazgKOgEmxGfu+LqGoHLD9DVQTapjolQ7YWpYyjepp0DEHge5Y/YrOo1Pao1cOsDAwQrBPpvIBH+rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(2616005)(956004)(16576012)(83380400001)(66946007)(6486002)(53546011)(508600001)(66556008)(36756003)(31696002)(110136005)(2906002)(8676002)(7416002)(38100700002)(54906003)(86362001)(8936002)(186003)(316002)(5660300002)(4326008)(31686004)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhHZVgyTWNNV2FOejVPYm55V2dHaThtUUdjTURVYjFXSXNUbks5VjVSSUVL?=
 =?utf-8?B?ZmkrcHhJUFVjM2Jpd3ZHbDJTdTdiSDh6a0JWQ2tmVGJxZTAvRGN6bVVpZW9B?=
 =?utf-8?B?VWtKRzVqQW1XWWNPVGJrRFdIMy9XS2Jvc0QvVWxWVnhKQ0FWWXNtaWVDeW1K?=
 =?utf-8?B?bC9WTVJweXpvRzcram5yZkltUE1rc2lNVEtIRkxGU0xCdWZCdmIyMVB3ZzlE?=
 =?utf-8?B?TWJaUWFJY25ta0RFc2l0K2JFeHhmb05IMm4yc0JFZVdheG4xUkd4d1F5dGVv?=
 =?utf-8?B?a2oxeElsYzR2UkVoaTl1OEtSSUdlWUhIM2FvU0ZENjR2VWRXVVkwZE9MRnZK?=
 =?utf-8?B?bGFtQm5OdHZnZERubHNqVVNaR2VKVEdOWHU4TUlSRWh3aVhvKzZGdXNpVVFQ?=
 =?utf-8?B?dlRJSEo3OTc5RHZVVU8vY09SeUpHZ3lwVWsyc3FJVm95ZU5yK3ZoaGF2czBZ?=
 =?utf-8?B?Y0pzQ0RWM2J3am84U0lwMHp3aVVCclU2akhna3I1U0xlZFVwUWROTUJxczFj?=
 =?utf-8?B?T0t0UjY2NEtTczNJTjI4aUFWTjBldFNlUllEQXljblh5ZkdZcjBLY1JLcGxy?=
 =?utf-8?B?SVFsSCtteFNJL1gzNVB3Z05TdVdIaFNMZEJOUGUvYldkWEhDMWVySmNxSEtx?=
 =?utf-8?B?dHJZaHphQ05FeHdnSkZrcENXOGoxUE5NMDg0ZHZSSmNzV2RvbEJ4VmlwMXZX?=
 =?utf-8?B?eXVSMHo0UEMvWkhiU2xlMHB1UVdTdFpmTnFZSGdDY3FzS2p1OEdZK3dzTjk3?=
 =?utf-8?B?WTNXUlBTZE5YNFA1dHZuTGxXWDF6VmJFREg0VjR5Ukwya1E5ZTc5ZVZlNjRX?=
 =?utf-8?B?QU9kTXlqRk0yZGZSV3RrbnQxZ0kva3BqaW52YjhKUjRCMEZxTVdsMml3Y3Rj?=
 =?utf-8?B?ekJ0MWlHTEJjY2lBd1hxdEYvd1BGbjlac0VDelFaM09TMDhVNWxCc3Y4RlEy?=
 =?utf-8?B?T0ZySGNuTHFhbGNNRXR3alVuSGRYMVFZTkd0ZE96OEozRFgvZSt4UWpmL2Uy?=
 =?utf-8?B?SDk2eXhWVkh6NUpnWms0MVd3ZDJXTXpJUDZucE4yTWtOaTdNY2Z6OHdFZDBC?=
 =?utf-8?B?bmlTakpaVkwzK2twdDBLak5iS2orcW1DRUFOS0tIdjE3UVpTdllSVHdIdE1o?=
 =?utf-8?B?Z0VDaENvd0JIUE8vd2taVDF2eFoyZitSRDUvSFM1QmZESEwzR0xrN09MY1JS?=
 =?utf-8?B?VUZ6ZHgyL3JOeDBjODhkYlJUaXRWVG90cDZjcHFWRjBBTHgrOXNYMEs1UjNZ?=
 =?utf-8?B?Y0Y2cHg1cDEvMEhJVFEvZUJmMGNSdGZwaGhGbnFOdloxYUFaZU9BT1RkZExy?=
 =?utf-8?B?WGo3KzhoQ1ZGVUVyUHlpaE84M0piK1VjYUovMjJwcHN4UjJrM2VjVFlvdXQ0?=
 =?utf-8?B?STZUYm1JZlZzMCtRc1lSa3Qzd0lsdzJ5dWFDS0d4MHFXcVAvVEJ4cVBFeVU4?=
 =?utf-8?B?MWpKNnErT2VQYTVFeVEzYzBlYTU1V3UrbUhZYjhaUTgrN05nZVBsRWtJd2FU?=
 =?utf-8?B?RnRkRzRHc21Wck54MzJGMTg1a1VJUFpDeTQxMnRBK3kxZG9saEp1eVdrdFNS?=
 =?utf-8?B?cFRFcmRmNFlXNnQ4QVQwSGJzUjR6QVpMRXUwby9ZTERCNXZGYXRoUlNJeC8y?=
 =?utf-8?B?ZDVnVlkwc3A0Q091UzNjMzFoS3RvQmVQVHZoK1dTUzQ0SmxmZFlyRzJXb3lM?=
 =?utf-8?B?VWlRRVdJem5ycDFqT0crR0srWjhnK2pZc0R1OVN0Tzd4N2tySFNUdXAzUnlO?=
 =?utf-8?Q?oHLr2eeA8KR55LoqC/HEXnlBFkgoeWeXMeidAbV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d782ba-e560-4011-eb55-08d97d844f1b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 04:49:06.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q77PhCoSBKupBHEKm5xSzHaAAeU0Hz2rvnGdAqVnXdUcB3YoRb0FL+k1TSNNoS+s0i7ctbwHCXd28iPJpGbYYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 23:45, Weizhao Ouyang wrote:
> Sync up MR_DEMOTION to migrate_reason_names and add a synch prompt.
> 
> Fixes: 26aa2d199d6f ("mm/migrate: demote pages during reclaim")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>   include/linux/migrate.h | 6 +++++-
>   mm/debug.c              | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 326250996b4e..c8077e936691 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -19,6 +19,11 @@ struct migration_target_control;
>    */
>   #define MIGRATEPAGE_SUCCESS		0
>   
> +/*
> + * Keep sync with:
> + * - macro MIGRATE_REASON in include/trace/events/migrate.h
> + * - migrate_reason_names[MR_TYPES] in mm/debug.c
> + */
>   enum migrate_reason {
>   	MR_COMPACTION,
>   	MR_MEMORY_FAILURE,
> @@ -32,7 +37,6 @@ enum migrate_reason {
>   	MR_TYPES
>   };
>   
> -/* In mm/debug.c; also keep sync with include/trace/events/migrate.h */
>   extern const char *migrate_reason_names[MR_TYPES];
>   
>   #ifdef CONFIG_MIGRATION
> diff --git a/mm/debug.c b/mm/debug.c
> index e61037cded98..fae0f81ad831 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -26,6 +26,7 @@ const char *migrate_reason_names[MR_TYPES] = {
>   	"numa_misplaced",
>   	"contig_range",
>   	"longterm_pin",
> +	"demotion",
>   };
>   
>   const struct trace_print_flags pageflag_names[] = {
> 

Looks good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
