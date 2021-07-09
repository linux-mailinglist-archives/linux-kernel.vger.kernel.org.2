Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FE3C2575
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhGIOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhGIOCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:02:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D1661356;
        Fri,  9 Jul 2021 13:59:57 +0000 (UTC)
Date:   Fri, 9 Jul 2021 09:59:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] bitmap: introduce for_each_set_bitrange
Message-ID: <20210709095950.6a451ccb@oasis.local.home>
In-Reply-To: <20210709034519.2859777-3-yury.norov@gmail.com>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
        <20210709034519.2859777-3-yury.norov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Jul 2021 20:45:19 -0700
Yury Norov <yury.norov@gmail.com> wrote:

> bitmap_list_string() is very ineffective when printing bitmaps with long
> ranges of set bits because it calls find_next_bit for each bit. We can do
> better by detecting ranges of set bits.
> 
> This patch introduces a macro for_each_set_bitrange and uses it in
> bitmap_list_string(). In my environment, before/after is 943008/31008 ns.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/find.h |  7 +++++++
>  lib/vsprintf.c       | 40 ++++++++++++++++------------------------
>  2 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/find.h b/include/linux/find.h
> index ae9ed52b52b8..1a5ed45dc81b 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -301,6 +301,13 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>  	     (bit) < (size);					\
>  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
>  
> +#define for_each_set_bitrange(b, e, addr, size)			\

The above needs a kerneldoc header.

> +	for ((b) = find_next_bit((addr), (size), 0),		\
> +	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
> +	     (b) < (size);					\
> +	     (b) = find_next_bit((addr), (size), (e) + 1),	\
> +	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
> +
>  /**
>   * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
>   * @start: bit offset to start search and to store the current iteration offset
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 87acf66f0e4c..1ee54dace71e 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1240,38 +1240,30 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
>  			 struct printf_spec spec, const char *fmt)
>  {
>  	int nr_bits = max_t(int, spec.field_width, 0);
> -	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
> -	int cur, rbot, rtop;
> -	bool first = true;
> +	char *start = buf;
> +	int b, e;
>  
>  	if (check_pointer(&buf, end, bitmap, spec))
>  		return buf;
>  
> -	rbot = cur = find_first_bit(bitmap, nr_bits);
> -	while (cur < nr_bits) {
> -		rtop = cur;
> -		cur = find_next_bit(bitmap, nr_bits, cur + 1);
> -		if (cur < nr_bits && cur <= rtop + 1)
> -			continue;
> +	for_each_set_bitrange(b, e, bitmap, nr_bits) {
> +		buf = number(buf, end, b, default_dec_spec);
> +		if (e == b + 1)
> +			goto put_comma;

Using a goto to skip a few lines instead of just having the reverse
conditional is rather sloppy IMO.

		if (e != b + 1) {
			if (buf < end)
				*buf = '-';
			buf++;
			buf = number(buf, end, e - 1, default_dec_spec);
		}

Is much clearer.
	
>  
> -		if (!first) {
> -			if (buf < end)
> -				*buf = ',';
> -			buf++;
> -		}
> -		first = false;
> +		if (buf < end)
> +			*buf = '-';
>  
> -		buf = number(buf, end, rbot, default_dec_spec);
> -		if (rbot < rtop) {
> -			if (buf < end)
> -				*buf = '-';
> -			buf++;
> +		buf = number(++buf, end, e - 1, default_dec_spec);
> +put_comma:
> +		if (buf < end)
> +			*buf = ',';
> +		buf++;
> +	}
>  
> -			buf = number(buf, end, rtop, default_dec_spec);
> -		}
> +	if (buf > start)
> +		buf--;

If the above is to undo the last comma, please put back the first logic.

-- Steve

>  
> -		rbot = cur;
> -	}
>  	return buf;
>  }
>  

