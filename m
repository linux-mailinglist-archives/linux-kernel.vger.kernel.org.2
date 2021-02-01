Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8B30A8BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhBANaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:30:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:18741 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhBAN33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:29:29 -0500
IronPort-SDR: az79XuYDN54CR4SFI5U1khB/RN7vBYuPFAXYFo19jC73FKDFZ6vFCNeBVRo2jmWTe8gYEnmziW
 11iQ8zcRNX1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="160448388"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="160448388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:27:40 -0800
IronPort-SDR: NFfJUo0fRHuqD7yUs1A6erkBL7AjmwTAUEbZgtP2Cunlf56nxROWnaMVa6i1cwUN/hwEVDi/pH
 Il6+b4hO5GWg==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="405692679"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:27:37 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6ZEr-0018kN-CS; Mon, 01 Feb 2021 15:27:33 +0200
Date:   Mon, 1 Feb 2021 15:27:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@redhat.com, vbabka@suse.cz, linmiaohe@huawei.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YBgBxaFSy8P/nrcH@smile.fi.intel.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201115610.87808-4-laoar.shao@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
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
> 
> The Documentation and test cases are also updated.

Thanks for an update, my comments below.

...

> -	%pGp	referenced|uptodate|lru|active|private
> +	%pGp	Node 0,Zone 2,referenced|uptodate|lru|active|private

Since of the nature of printf() buffer, I wonder if these should be at the end.
I.o.w. the question is is the added material more important to user to see than
the existed one?

...

> +static void __init
> +page_flags_test(int section, int node, int zone, int last_cpupid,
> +		int kasan_tag, int flags, const char *name, char *cmp_buf)
> +{
> +	unsigned long page_flags = 0;
> +	unsigned long size = 0;
> +
> +#ifdef SECTION_IN_PAGE_FLAGS
> +	page_flags |= (sec & SECTIONS_MASK) << SECTIONS_PGSHIFT;
> +	snprintf(cmp_buf, BUF_SIZE, "Section %#x,", sec);

I would keep it in the same form as latter ones, i.e.

	snprintf(cmp_buf + size, BUF_SIZE - size, "Section %#x,", sec);

In this case it will be easier if at some point we might need to reshuffle.

> +	size = strlen(cmp_buf);
> +#endif
> +
> +	page_flags |= (node & NODES_MASK) << NODES_PGSHIFT;
> +	snprintf(cmp_buf + size, BUF_SIZE - size, "Node %d", node);
> +	size = strlen(cmp_buf);
> +
> +	page_flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
> +	snprintf(cmp_buf + size, BUF_SIZE - size, ",Zone %d", zone);
> +	size = strlen(cmp_buf);
> +
> +#ifndef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> +	page_flags |= (last_cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
> +	snprintf(cmp_buf + size, BUF_SIZE - size, ",Lastcpupid %#x", last_cpupid);
> +	size = strlen(cmp_buf);
> +#endif
> +
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +	page_flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +	snprintf(cmp_buf + size, BUF_SIZE - size, ",Kasantag %#x", tag);
> +	size = strlen(cmp_buf);
> +#endif
> +
> +	test(cmp_buf, "%pGp", &page_flags);
> +
> +	if (flags) {

If below will be always for flags set, I would rewrite this condition as

	if (!flags)
		return;

but it's up to you.

> +		page_flags |= flags;
> +		snprintf(cmp_buf + size, BUF_SIZE - size, ",%s", name);
> +		test(cmp_buf, "%pGp", &page_flags);
> +	}
> +}

...

> -	flags = 0;

> -	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
> -		| 1UL << PG_active | 1UL << PG_swapbacked;

I would leave this untouched and reuse below...

> +	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
> +	if (!cmp_buffer)
> +		return;

...as

> +	page_flags_test(0, 0, 0, 0, 0, 0, NULL, cmp_buffer);

	flags = 0;
	page_flags_test(0, 0, 0, 0, 0, flags, NULL, cmp_buffer);

> +	page_flags_test(1, 1, 1, 0x1ffff, 1,
> +			(1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
> +			 | 1UL << PG_active | 1UL << PG_swapbacked),
> +			"uptodate|dirty|lru|active|swapbacked",
> +			cmp_buffer);

	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
		| 1UL << PG_active | 1UL << PG_swapbacked;
	page_flags_test(1, 1, 1, 0x1ffff, 1, flags,
			"uptodate|dirty|lru|active|swapbacked",
			cmp_buffer);

...

> +static const struct page_flags_layout pfl[] = {
> +	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
> +	 &default_dec_spec, "Section "},
> +	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
> +	 &default_dec_spec, "Node "},
> +	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
> +	 &default_dec_spec, "Zone "},
> +	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
> +	 &default_flag_spec, "Lastcpupid "},
> +	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
> +	 &default_flag_spec, "Kasantag "},
> +};

Please add trailing space only once where it's needed (below in the code).

...

> +static
> +char *format_page_flags(char *buf, char *end, unsigned long page_flags)
> +{
> +	unsigned long flags = page_flags & ((1UL << NR_PAGEFLAGS) - 1);
> +	int size = ARRAY_SIZE(pfl);
> +	bool separator = false;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
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

One blank line is enough.

> +		buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> +
> +		buf = number(buf, end, (page_flags >> pfl[i].shift) & pfl[i].mask,
> +			     *pfl[i].spec);
> +		separator = true;
> +	}
> +
> +	if (flags) {
> +		if (buf < end)
> +			*buf = ',';
> +		buf++;
> +	}

I think you may optimize above to avoid using the separator variable.

	DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
	unsigned long flags;
	unsigned long last;

	for (i = 0; i < ARRAY_SIZE(pfl); i++)
		__assign_bit(mask, pfl[i].width);

	last = find_last_bit(mask, ARRAY_SIZE(pfl));

	for_each_set_bit(i, mask, ARRAY_SIZE(pfl)) {
		flags = (page_flags >> pfl[i].shift) & pfl[i].mask;

		/* Format: Flag Name + ' ' (space) + Number + ',' (separator) */
		buf = string(buf, end, pfl[i].name, *pfl[i].spec);

		if (buf < end)
			*buf = ' ';
		buf++;

		buf = number(buf, end, flags, *pfl[i].spec);

		/* No separator for the last entry */
		if ((page_flags & (BIT(NR_PAGEFLAGS) - 1)) || (i != last)) {
			if (buf < end)
				*buf = ',';
			buf++;
		}
	}

> +	return buf;
> +}

-- 
With Best Regards,
Andy Shevchenko


