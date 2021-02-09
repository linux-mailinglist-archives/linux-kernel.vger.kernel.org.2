Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D163150FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhBINzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:55:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:47740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhBINyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:54:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612878835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u3beVktBJeU3nR/gpabKScPIlmh909dbtHxbNDm9Ea0=;
        b=T6QnCOdL4g5WMz19dLeQVPa8TZ9tGPXT6pUtzsZ7xJ8jrLz1TxGqQ06g30XJJPU5ccmOx0
        78J5lnv6tM53NfuhLWoamDfC8nW+Y7XcnlDncfVjV4ktklgPJM04eDeyHfZkaq02DDJekq
        dmTD+YLbsUlaA/dY01FiUMBAt+Ij4VE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4582AD5C;
        Tue,  9 Feb 2021 13:53:54 +0000 (UTC)
Date:   Tue, 9 Feb 2021 14:53:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YCKT8WCPGU+HBY91@alley>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
 <20210209105613.42747-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209105613.42747-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-09 18:56:13, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new information is
> tracked onto the end of the existed one.
> 
> On example of the output in mm/slub.c as follows,
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> The documentation and test cases are also updated. The output of the
> test cases as follows,
> [  501.485081] test_printf: loaded.
> [  501.485768] test_printf: all 388 tests passed
> [  501.488762] test_printf: unloaded.
> 

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 14c9a6af1b23..3f26611adb34 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1916,6 +1916,66 @@ char *format_flags(char *buf, char *end, unsigned long flags,
>  	return buf;
>  }
>  
> +struct page_flags_layout {
> +	int width;
> +	int shift;
> +	int mask;
> +	const struct printf_spec *spec;
> +	const char *name;
> +};
> +
> +static const struct page_flags_layout pfl[] = {
> +	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
> +	 &default_dec_spec, "section"},
> +	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
> +	 &default_dec_spec, "node"},
> +	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
> +	 &default_dec_spec, "zone"},
> +	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
> +	 &default_flag_spec, "lastcpupid"},
> +	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
> +	 &default_flag_spec, "kasantag"},
> +};
> +
> +static
> +char *format_page_flags(char *buf, char *end, unsigned long flags)
> +{
> +	DECLARE_BITMAP(mask, ARRAY_SIZE(pfl));
> +	unsigned long last;
> +	int i;
> +
> +	if (flags & (BIT(NR_PAGEFLAGS) - 1)) {
> +		if (buf < end)
> +			*buf = '|';
> +		buf++;
> +	}

This is far from obvious. You print '|' here because you printed
something somewhere else. See below.

> +
> +	for (i = 0; i < ARRAY_SIZE(pfl); i++)
> +		__assign_bit(i, mask, pfl[i].width);

The bitmap looks like an overkill. If I get it correctly, it is a
tricky way to handle only flags defined by the used build
configuration. See below.

> +	last = find_last_bit(mask, ARRAY_SIZE(pfl));
> +
> +	for_each_set_bit(i, mask, ARRAY_SIZE(pfl)) {
> +		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
> +		buf = string(buf, end, pfl[i].name, *pfl[i].spec);
> +
> +		if (buf < end)
> +			*buf = '=';
> +		buf++;
> +		buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> +			     *pfl[i].spec);
> +
> +		/* No separator for the last entry */
> +		if (i != last) {
> +			if (buf < end)
> +				*buf = '|';
> +			buf++;
> +		}
> +	}
> +
> +	return buf;
> +}
> +
>  static noinline_for_stack
>  char *flags_string(char *buf, char *end, void *flags_ptr,
>  		   struct printf_spec spec, const char *fmt)
> @@ -1929,10 +1989,10 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  	switch (fmt[1]) {
>  	case 'p':
>  		flags = *(unsigned long *)flags_ptr;
> -		/* Remove zone id */
> -		flags &= (1UL << NR_PAGEFLAGS) - 1;
>  		names = pageflag_names;

The "names" variable is needed only with "break;" when using the final
format_flags(buf, end, flags, names);

> -		break;
> +		buf = format_flags(buf, end, flags & (BIT(NR_PAGEFLAGS) - 1), names);
> +		buf = format_page_flags(buf, end, flags);

I am sorry for my ignorance. I am not familiar with MM.
But it is pretty hard to understand what call does what.

I have found the following comment in include/linux/page_flags.h:

 * The page flags field is split into two parts, the main flags area
 * which extends from the low bits upwards, and the fields area which
 * extends from the high bits downwards.

Sigh, I know that you already reworked this several times because
people "nitpicked" about the code style. But it seems that it
rather diverged instead of converged.

What about the following?

Note: It is inpired by the names "main area" and "fields area"
      mentioned in the above comment from page_flags.h.
      I have later realized that "page_flags_layout" actually made
      sense as well. Feel free to rename page_flags_fileds
      back to page_flags_layout.

Anyway, this is my proposal:

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..cf67b39d72ae 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1916,6 +1916,67 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 	return buf;
 }
 
+/* Meta information for page flags in the fields area */
+struct page_flags_fields {
+	int width;
+	int shift;
+	int mask;
+	const struct printf_spec *spec;
+	const char *name;
+};
+
+static const struct page_flags_fields pff[] = {
+	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK,
+	 &default_dec_spec, "section"},
+	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK,
+	 &default_dec_spec, "node"},
+	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK,
+	 &default_dec_spec, "zone"},
+	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK,
+	 &default_flag_spec, "lastcpupid"},
+	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK,
+	 &default_flag_spec, "kasantag"},
+};
+
+static
+char *format_page_flags(char *buf, char *end, unsigned long flags)
+{
+	unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
+	bool append = false;
+	int i;
+
+	/* Page flags from the main area. */
+	if (main_flags) {
+		buf = format_flags(buf, end, main_flags, pageflag_names);
+		append = true;
+	}
+
+	/* Page flags from the fields area */
+	for (i = 0; i < ARRAY_SIZE(pff); i++) {
+		/* Skip undefined fields. */
+		if (!pff[i].width)
+			continue;
+
+		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
+		if (append) {
+			if (buf < end)
+				*buf = '|';
+			buf++;
+		}
+
+		buf = string(buf, end, pff[i].name, *pff[i].spec);
+		if (buf < end)
+			*buf = '=';
+		buf++;
+		buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
+			     *pff[i].spec);
+
+		append = true;
+	}
+
+	return buf;
+}
+
 static noinline_for_stack
 char *flags_string(char *buf, char *end, void *flags_ptr,
 		   struct printf_spec spec, const char *fmt)
@@ -1929,10 +1990,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
 	switch (fmt[1]) {
 	case 'p':
 		flags = *(unsigned long *)flags_ptr;
-		/* Remove zone id */
-		flags &= (1UL << NR_PAGEFLAGS) - 1;
-		names = pageflag_names;
-		break;
+		return format_page_flags(buf, end, flags);
 	case 'v':
 		flags = *(unsigned long *)flags_ptr;
 		names = vmaflag_names;
-- 
2.26.2

