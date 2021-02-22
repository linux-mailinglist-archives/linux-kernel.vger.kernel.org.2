Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D210E321830
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 14:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBVNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 08:12:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:59322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhBVMjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:39:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613997499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gs7qei1LjxxGt8o7TsGXkD1pF4Wvb6ryeWApuTDRZU=;
        b=NUEf0Dr1i+sQwilBf0DBdSEBzWMb68dKIInfyq+tZgg4UWMYR3bK7jVII4F1gC/03VljdQ
        pLOH96CGNx4A9RHLexu1yW0se6vUsPtXf9vGtc492wkhvWwL+N0/hB2GX/QBtlke/5VPqo
        7UnIaz5/LGQnFaMi8F9t4PJSmCKP72M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7C0AAD2B;
        Mon, 22 Feb 2021 12:38:18 +0000 (UTC)
Date:   Mon, 22 Feb 2021 13:38:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <YDOluaRK2CHtQyQD@alley>
References: <20210215155141.47432-1-laoar.shao@gmail.com>
 <20210215155141.47432-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215155141.47432-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first, I am sorry for the late reply. I have marked the thread as
proceed by mistake last week...


On Mon 2021-02-15 23:51:41, Yafang Shao wrote:
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
> One example of the output in mm/slub.c as follows,
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 8448.272530] Slab 0x0000000090797883 objects=33 used=3 fp=0x00000000790f1c26 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> The documentation and test cases are also updated. The output of the
> test cases as follows,
> [11585.830272] test_printf: loaded.
> [11585.830454] test_printf: all 388 tests passed
> [11585.831401] test_printf: unloaded.
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> +static
> +char *format_page_flags(char *buf, char *end, unsigned long flags)
> +{
> +	unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
> +	bool append = false;
> +	int i;
> +
> +	/* Page flags from the main area. */
> +	if (main_flags) {
> +		buf = format_flags(buf, end, main_flags, pageflag_names);
> +		append = true;
> +	}
> +
> +	/* Page flags from the fields area */
> +	for (i = 0; i < ARRAY_SIZE(pff); i++) {
> +		/* Skip undefined fields. */
> +		if (!pff[i].width)
> +			continue;
> +
> +		/* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
> +		if (append) {
> +			if (buf < end)
> +				*buf = '|';
> +			buf++;
> +		}
> +
> +		buf = string(buf, end, pff[i].name, *pff[i].spec);

I have found one more small issue.

The purpose of the flag-specific printk_spec is to define the format
how the value is printed. The name of the flag should be printed
using default_str_spec.

It works because the string is printed as-is with both
default_dec_spec and default_flag_spec. But it would be better
to use the string format.

> +		if (buf < end)
> +			*buf = '=';
> +		buf++;
> +		buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
> +			     *pff[i].spec);
> +
> +		append = true;
> +	}
> +
> +	return buf;
> +}

Otherwise, the patch looks to me. The issue is cosmetic and might be
fixed either by re-spinning just this patch or by a followup patch.
Either way, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Another question where to push this change. It is pity the we
finalized it in the middle of the merge window. It has to spend
at least few days in linux-next.

I would like to hear from Andy before I push it into linux-next.
There is still theoretical chance to get it into 5.12 when Linus
prolongs the merge window by one week. it has been delayed by
a long lasting power outage.

Best Regards,
Petr
