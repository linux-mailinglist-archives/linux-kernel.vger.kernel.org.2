Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F753946FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhE1S2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:28:11 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:62560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhE1S2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVAESmF9VVFDL2utxKcdTHzr2mJ/ls/krMRDNByR9zS7I/6HhzZHtfXpD9PcyaOzN6p5zFbTc/2gMxnu2RDti7mBmRWJCIVcF5wyrhGLIUe4Cw+jx2/QJauma5+FNiu3NlfosucevLYgQLksOqwZNGDPESLTqnna6T0uDYHUHk0upR8DEPJjRoRtmLN9Bn8ogwBVJ3AK76MPyYu9BzgOFY0/df7D/K02Q39OJQ7UXRGRMhkZlPccIUOLerrSJq548aHcYQCJT7MpxmzDLD1uyVtWQkLdqF0IdzRy/ycvWsRSsFCEqQTruaj/Ce734TzOkYRDw0hC2KGkHk/jef+gPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hshBOYGwqU0cXfsKmFcg+uJKym9kl4HfOAgg4BR6z9c=;
 b=V/2BW+68iLgyoG40rq8R9PetbsJkYcVrpFbkc6BIRnDSAGoBxN47gnP4zR1QVO5yLkUHiKmMKQ3h+GT7Igm2bn9fmaPdO843QcD6EpEiE/KikDvuhFCelXlvyhPkFv85+31sdaQFQs/HHKw5Wquw7i5syoGIHAV28qH7ctEQ/DUu7EdQDS0Qskibt6ddWSs8eycEOMS8RWTBh+Dvz/OB7/qaATHH90aRRNjjwMEtHFNRTNG1DbwnvctoijsTUyupAnl3fRa6aA+HLDZVtkXQi2aP17tJQzCoo3QgN9+mmH+ung5SKO8MQzwS+e5x8eQ4Bpm+kW1pCva9OWrlW4rcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hshBOYGwqU0cXfsKmFcg+uJKym9kl4HfOAgg4BR6z9c=;
 b=P4Wk1lwt2yhKBiTErkuwxHw7uCfKPuXj7wRsvyJASrFgC6UQqExzhhpNKTRkTU47+Roim2EQhPaBWVGwVKNIUfs7Qb26VMx2Tn4QDtl3eSLb+SvRi1dGW5/nWJ/LiwsNGBhE99gORD2Ur88PIYQ63Pc0W4fsqnpGZ0y2JCsSYbtV/yeXHb5yMt1DIs8foAFBnZOu9KCithv3suCHLn41cwRiQYV+5NvaihcZ00XWrei4tpROt538szM6vZA1fd6bGTLPGYrPoU5vBrFr4XBbqG2hzaNSHo1ik+6/lkuYnDmHzry8mB3u6qG+XfIAHWS2kCDVUhzNOKTCesD4Hb2Ztw==
Received: from BN6PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:404:b4::13) by MN2PR12MB4061.namprd12.prod.outlook.com
 (2603:10b6:208:19a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 18:26:34 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::ee) by BN6PR2001CA0003.outlook.office365.com
 (2603:10b6:404:b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 18:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 18:26:34 +0000
Received: from [10.2.60.247] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 18:26:33 +0000
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound page
To:     Yang Shi <shy828301@gmail.com>, <hughd@google.com>,
        <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
        <vbabka@suse.cz>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210528175403.4506-1-shy828301@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ffc5612f-9403-9bc9-316f-fa50199769b2@nvidia.com>
Date:   Fri, 28 May 2021 11:26:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528175403.4506-1-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ccdb17e-7e84-4278-aabc-08d922061f6a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4061064B86324968F6DC1EAAA8229@MN2PR12MB4061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+mywgGz84jLyLuze40ItjsBSRL736T/AgmOd8wOh+/SPwVgHbd1Nq5b84CiG08G9EPQC9leioP+9JnudrDPnbgU2Cyvx2xS0x+0p7Eoy7b3RS2IVY/53rl1NiJHWRJ00sXl2S1n3tfnSRYYM/FKMpcyQpCThgVvVU/1+Zn1DijOcRvmxdUl0NXV7GXy4RUVGBettWbXP8BcQxQ3kGait6H7P8XgAdauodgce99NAbcNnoeXREZAF9rSr1okAst7DjrhslQCHQ4DsoJe+wnVEnKZqlA/oB7lv6uA4bTpruivjCu6GeUmo9YhGJgtxY/X0Z/WgMPk5ATG3igAF93heoNknHz2iC1uUAqUREdDYrTiPPtEf23+EkUqKaPzex9/TpsZwOM66eqkqAVfH9Sj9MtLUgXEQtTOsZuNi6AvQArQUaXKAPAktjXrC/obfUFiHReqjK4VyZNlQsScX0sBxf8xOgH3WoQlKXpeebXHwp9WNV130bSPejuCc0ZlSMomr254DmaOOXZtO54AJ4Hf3x4Ztq3Y28IhtWgBqwH72idSfw17MquTKUkPO0zssjwqZvdcTtHy7jpyg2hwRkGcbJWBSg+fy6+BYRD7jtcu8df1og8v0uA33Qi1+bpZ6nxz6gvM17wiaLPjJwKW1EzWt/ynPjDtBKUFkieNyIgTa8Xb0GOAMSDvNMlyLRsi+Aq20hliDPObbRJNIhR7crqD2d1VHPMK9mVOm6tiGEkJrH92dtY0nlB+AMvF6huMmUhy2KPz2Kx44r+pT38X3lE6gHjcVYC1bvo7xeztbnFFyQtdPzk5ic847XECLCWnoZ09
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(8936002)(31696002)(2616005)(36860700001)(2906002)(54906003)(356005)(8676002)(31686004)(70586007)(47076005)(86362001)(83380400001)(5660300002)(82740400003)(7636003)(70206006)(36906005)(336012)(82310400003)(16576012)(16526019)(478600001)(426003)(186003)(53546011)(4326008)(110136005)(966005)(316002)(36756003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 18:26:34.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccdb17e-7e84-4278-aabc-08d922061f6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 10:54 AM, Yang Shi wrote:
> The total mapcount is a useful information for debugging, but we can't
> call total_mapcount() directly since it calls some assertions which may
> be triggered as commit 6dc5ea16c86f ("mm,
> dump_page: do not crash with bad compound_mapcount()") met.
> 
> We could implement yet another implementation for dump_page() but
> it has the limitation when individual mapcount of subpages is corrupted.
> 
> Actually the total mapcount could be decoded from refcount, pincount and
> compound mapcount although it may be not very precise due to some
> transient references.

If the mapcount calculation were in a separate routine, *and* if something
else in addition to dump_page() used it, then I'd be interested in
calling it from dump_page().

But, just adding a calculation glob like this is not a good idea. If
the reader really needs the calculation, then that person can, as you
say, work it out from the other information.

Debug and dump routines are actually supposed to remain fairly simple,
so that they themselves do not end up with bugs, or stale assumptions
(which this calculation is very much susceptible to). This goes in the
wrong direction.

So best to just not do this, IMHO.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> I think we are on the same page that the total mapcount is useful
> information and it would be ideal to print this information when dumpping
> page if possible.  But how to implement it safely seems controversial.
> Some ideas and potential problems have been discussed by
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2105261733110.16920@eggly.anvils/.
> 
> So I prepared this patch to show a possible approach to get some
> feedback.  The same thing could be decoded by the reader of page dump
> as well by using the same formula used by this patch.  However it sounds
> more convenient to have kernel do the math.
>   
>   mm/debug.c | 35 +++++++++++++++++++++++++++++------
>   1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index e73fe0a8ec3d..129efcfcaf79 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -54,8 +54,13 @@ static void __dump_page(struct page *page)
>   	 * inaccuracy here due to racing.
>   	 */
>   	bool page_cma = is_migrate_cma_page(page);
> -	int mapcount;
> +	int mapcount, total_mapcount;
> +	int nr;
> +	int refcount;
> +	int pincount = 0;
> +	int comp_mapcnt;
>   	char *type = "";
> +	bool is_slab = PageSlab(head);
>   
>   	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
>   		/*
> @@ -82,22 +87,40 @@ static void __dump_page(struct page *page)
>   	 * page->_mapcount space in struct page is used by sl[aou]b pages to
>   	 * encode own info.
>   	 */
> -	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
> +	mapcount = is_slab ? 0 : page_mapcount(page);
> +
> +	refcount = page_ref_count(head);
>   
>   	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
> -			page, page_ref_count(head), mapcount, mapping,
> +			page, refcount, mapcount, mapping,
>   			page_to_pgoff(page), page_to_pfn(page));
>   	if (compound) {
> +		comp_mapcnt = head_compound_mapcount(head);
>   		if (hpage_pincount_available(page)) {
> +			pincount = head_compound_pincount(head);
>   			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
>   					head, compound_order(head),
> -					head_compound_mapcount(head),
> -					head_compound_pincount(head));
> +					comp_mapcnt, pincount);
>   		} else {
>   			pr_warn("head:%p order:%u compound_mapcount:%d\n",
>   					head, compound_order(head),
> -					head_compound_mapcount(head));
> +					comp_mapcnt);
> +		}
> +
> +		nr = compound_nr(head);
> +		if (is_slab)
> +			total_mapcount = 0;
> +		else if (PageHuge(head))
> +			total_mapcount = comp_mapcnt;
> +		else {
> +			if (mapping) {
> +				if (!PageAnon(head))
> +					nr = nr * (comp_mapcnt + 1) - comp_mapcnt;
> +			} else
> +				nr = 0;
> +			total_mapcount = refcount - pincount - nr;
>   		}
> +		pr_warn("total_mapcount(estimated):%d\n", total_mapcount);
>   	}
>   
>   #ifdef CONFIG_MEMCG
> 

