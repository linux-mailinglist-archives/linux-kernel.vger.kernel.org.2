Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8379330A846
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhBANG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:06:28 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:34346 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231522AbhBANGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:06:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 561BF8384366;
        Mon,  1 Feb 2021 13:05:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2892:2898:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:6737:7652:7875:7903:7904:8603:9036:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12555:12679:12740:12760:12895:12986:13161:13229:13439:14659:14721:21080:21524:21611:21627:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fly99_400121c275c2
X-Filterd-Recvd-Size: 3380
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon,  1 Feb 2021 13:05:33 +0000 (UTC)
Message-ID: <06481a01f551697d42c792506f3538d459ce8bdd.camel@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
From:   Joe Perches <joe@perches.com>
To:     Yafang Shao <laoar.shao@gmail.com>,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 01 Feb 2021 05:05:32 -0800
In-Reply-To: <20210201115610.87808-4-laoar.shao@gmail.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
         <20210201115610.87808-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-01 at 19:56 +0800, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)

While debugfs is not an ABI, this format is exported in debugfs to
userspace via mm/page_owner.c read_page_owner/print_page_owner.

Does changing the output format matter to anyone?

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[] 
> +static
> +char *format_page_flags(char *buf, char *end, unsigned long page_flags)
> +{
> +	unsigned long flags = page_flags & ((1UL << NR_PAGEFLAGS) - 1);
> +	int size = ARRAY_SIZE(pfl);

There's no real value in used-once variables.

> +	bool separator = false;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {

Use ARRAY_SIZE here instead

	for (i = 0; i < ARRAY_SIZE(pfl); i++) {

> +		if (pfl[i].width == 0)
> +			continue;
> +
> +		if (separator) {
> +			if (buf < end)
> +				*buf = ',';
> +			buf++;
> +		}
> +
> +
> +		buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> +
> +		buf = number(buf, end, (page_flags >> pfl[i].shift) & pfl[i].mask,
> +			     *pfl[i].spec);
> +		separator = true;
> +	}

Style question:
Might this array be more intelligible with pointers instead of indexes?
Something like:

	struct page_flags_layout *p;

	for (p = pfl; p < pfl + ARRAY_SIZE(pfl); p++) {
		if (p->width == 0)
			continue;

		if (p > pfl) {
			if (buf < end)
				*buf = ',';
			buf++;
		}

		buf = string(buf, end, p->name, *p->spec);
		buf = number(buf, end, (page_flags >> p->shift) & p->mask, *p->spec);
	}

> +
> +	if (flags) {

Maybe:

	if (page_flags & (BIT(NR_PAGEFLAGS) - 1)) {

> +		if (buf < end)
> +			*buf = ',';
> +		buf++;
> +	}
> +
> +	return buf;
> +}
> +


