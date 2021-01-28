Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2300B306B22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA1Cgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:36:42 -0500
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:53276 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229560AbhA1Cgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:36:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EC02F12F0;
        Thu, 28 Jan 2021 02:35:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:6737:7652:10004:10400:10848:11026:11232:11473:11658:11914:12048:12297:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21627:21990:30029:30030:30054:30075:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: toy94_2802c232759c
X-Filterd-Recvd-Size: 2922
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 02:35:54 +0000 (UTC)
Message-ID: <e5ea9e8b1190c2a397a1b84dd55bb9c706dc7058.camel@perches.com>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
From:   Joe Perches <joe@perches.com>
To:     Yafang Shao <laoar.shao@gmail.com>, david@redhat.com,
        vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Jan 2021 18:35:53 -0800
In-Reply-To: <20210128021947.22877-4-laoar.shao@gmail.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
         <20210128021947.22877-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-28 at 10:19 +0800, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
[]
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -1916,6 +1916,46 @@ char *format_flags(char *buf, char *end, unsigned long flags,
>  	return buf;
>  }
> 
> +struct page_flags_layout {
> +	int width;
> +	int shift;
> +	int mask;
> +	char *name;
> +};
> +
> +struct page_flags_layout pfl[] = {

static const struct page_flags_layout pfl[] = {

> +	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK, "Section "},
> +	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK, "Node "},
> +	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK, "Zone "},
> +	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK, "Lastcpupid "},
> +	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK, "Kasantag "},
> +};
> +
> +static
> +char *format_layout(char *buf, char *end, unsigned long flags)

poor name.  perhaps format_page_flags

> +{
> +	int i;
> +
> +	for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {

	for (i = 0; i < ARRAY_SIZE(pfl) && buf < end; i++) {


> @@ -1929,7 +1969,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  	switch (fmt[1]) {
>  	case 'p':
>  		flags = *(unsigned long *)flags_ptr;
> -		/* Remove zone id */
> +		buf = format_layout(buf, end, flags & ~((1UL << NR_PAGEFLAGS) - 1));
>  		flags &= (1UL << NR_PAGEFLAGS) - 1;

Perhaps store the bitshift into a temp and use the temp twice

		foo = BIT(NR_PAGEFLAGS) - 1;

		buf = format_layout(buf, end, flags & ~foo);
		flags &= foo;


