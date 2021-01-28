Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD179306B46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhA1Cw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:52:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11209 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhA1Cwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:52:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DR4hw2sMNzlBqG;
        Thu, 28 Jan 2021 10:50:40 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 10:52:11 +0800
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, <vbabka@suse.cz>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
 <20210128021947.22877-4-laoar.shao@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <27e53062-7b0e-42e8-6f44-4eba44832805@huawei.com>
Date:   Thu, 28 Jan 2021 10:52:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210128021947.22877-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/28 10:19, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> - Before the patch,
> [ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)
> 

Thanks. This really helps!

> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  lib/vsprintf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..bd809f4f1b82 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1916,6 +1916,46 @@ char *format_flags(char *buf, char *end, unsigned long flags,
>  	return buf;
>  }
>  
> +struct page_flags_layout {
> +	int width;
> +	int shift;
> +	int mask;
> +	char *name;

Should we add const for name ?

> +};
> +
> +struct page_flags_layout pfl[] = {

Should we add static const for pfl[] as we won't change its value and use it outside this file ?

> +	{SECTIONS_WIDTH, SECTIONS_PGSHIFT, SECTIONS_MASK, "Section "},
> +	{NODES_WIDTH, NODES_PGSHIFT, NODES_MASK, "Node "},
> +	{ZONES_WIDTH, ZONES_PGSHIFT, ZONES_MASK, "Zone "},
> +	{LAST_CPUPID_WIDTH, LAST_CPUPID_PGSHIFT, LAST_CPUPID_MASK, "Lastcpupid "},
> +	{KASAN_TAG_WIDTH, KASAN_TAG_PGSHIFT, KASAN_TAG_MASK, "Kasantag "},
> +};
> +
> +static
> +char *format_layout(char *buf, char *end, unsigned long flags)
> +{
> +	int i;
> +
> +	for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {

I think we can use ARRAY_SIZE here.

> +		if (pfl[i].width == 0)
> +			continue;
> +
> +		buf = string(buf, end, pfl[i].name, default_str_spec);
> +
> +		if (buf >= end)
> +			break;
> +		buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> +			     default_flag_spec);
> +
> +		if (buf >= end)
> +			break;
> +		*buf = ',';
> +		buf++;
> +	}
> +
> +	return buf;
> +}
> +
>  static noinline_for_stack
>  char *flags_string(char *buf, char *end, void *flags_ptr,
>  		   struct printf_spec spec, const char *fmt)
> @@ -1929,7 +1969,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
>  	switch (fmt[1]) {
>  	case 'p':
>  		flags = *(unsigned long *)flags_ptr;
> -		/* Remove zone id */
> +		buf = format_layout(buf, end, flags & ~((1UL << NR_PAGEFLAGS) - 1));
>  		flags &= (1UL << NR_PAGEFLAGS) - 1;
>  		names = pageflag_names;
>  		break;
>
Many thanks.
