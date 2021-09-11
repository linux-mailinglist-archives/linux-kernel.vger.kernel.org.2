Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE9407AAB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhIKW0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 18:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhIKW0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 18:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993B360FDC;
        Sat, 11 Sep 2021 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631399125;
        bh=5BUD4+/LJTOHGqd73XGo3uzyhbhaAoHyT1tJJkbBUiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i00EjmEZhgu2lmeaQCTk225xlYEmtMR5kW6zLx/y4FG5xG/E5V2n33sO05K55ErDS
         nxMIiIrAS7Ziu9aV33WO7833Oz9Tuw8jx+iTy6wIuzPpzQMEbJbBvlhMn+qqzKmpJI
         ZINWgWOQbGr/j+KJy+eOEtabh+D1ohKsHOs7hWv8=
Date:   Sat, 11 Sep 2021 15:25:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     <tangbin@cmss.chinamobile.com>,
        <zhangshengju@cmss.chinamobile.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <xiaoqian9@huawei.com>
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: count and sort by mem
Message-Id: <20210911152520.45d6e3ed690b652a4d49a1c0@linux-foundation.org>
In-Reply-To: <1631243023-47849-1-git-send-email-weizhenliang@huawei.com>
References: <1631243023-47849-1-git-send-email-weizhenliang@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 11:03:43 +0800 Zhenliang Wei <weizhenliang@huawei.com> wrote:

> When viewing page owner information, we may be more concerned about the
> total memory than the number of stack occurrences. Therefore, the
> following adjustments are made:
> 1. Added the statistics on the total number of pages.
> 2. Added the optional parameter "-m" to configure the program to sort by
>    memory (total pages).
> 

Why does it add regexp matching to add_list()?  Presumably this is some
enhancement to the user interface which I cannot see documented in the
changelog or the code comments,

Can we please add/maintain a full description of the user interface in,
I guess, Documentation/vm/page_owner.rst?

> @@ -59,12 +65,50 @@ static int compare_num(const void *p1, const void *p2)
>  	return l2->num - l1->num;
>  }
>  
> +static int compare_page_num(const void *p1, const void *p2)
> +{
> +	const struct block_list *l1 = p1, *l2 = p2;
> +
> +	return l2->page_num - l1->page_num;
> +}
> +
> +static int get_page_num(char *buf)
> +{
> +	int err, val_len, order_val;
> +	char order_str[4] = {0};
> +	char *endptr;
> +	regmatch_t pmatch[2];
> +
> +	err = regexec(&order_pattern, buf, 2, pmatch, REG_NOTBOL);
> +	if (err != 0 || pmatch[1].rm_so == -1) {
> +		printf("no order pattern in %s\n", buf);

Shouldn't error messages normally be directed to stderr?  We aren't
very consistent about this but it was the accepted thing to do 20-30
years ago, lol.

> +		return 0;
> +	}
> +	val_len = pmatch[1].rm_eo - pmatch[1].rm_so;
> +	if (val_len > 2) /* max_order should not exceed 2 digits */
> +		goto wrong_order;
> +
> +	memcpy(order_str, buf + pmatch[1].rm_so, val_len);
> +
> +	errno = 0;
> +	order_val = strtol(order_str, &endptr, 10);
> +	if (errno != 0 || endptr == order_str || *endptr != '\0')
> +		goto wrong_order;
> +
> +	return 1 << order_val;
> +
> +wrong_order:
> +	printf("wrong order in follow buf:\n%s\n", buf);
> +	return 0;
> +}
> +
>  static void add_list(char *buf, int len)
>  {
>  	if (list_size != 0 &&
>  	    len == list[list_size-1].len &&
>  	    memcmp(buf, list[list_size-1].txt, len) == 0) {
>  		list[list_size-1].num++;
> +		list[list_size-1].page_num += get_page_num(buf);
>  		return;
>  	}
>  	if (list_size == max_size) {
> @@ -74,6 +118,7 @@ static void add_list(char *buf, int len)
>  	list[list_size].txt = malloc(len+1);
>  	list[list_size].len = len;
>  	list[list_size].num = 1;
> +	list[list_size].page_num = get_page_num(buf);
>  	memcpy(list[list_size].txt, buf, len);
>  	list[list_size].txt[len] = 0;
>  	list_size++;
> @@ -85,6 +130,13 @@ static void add_list(char *buf, int len)
>  
>  #define BUF_SIZE	(128 * 1024)
>  
> +static void usage(void)
> +{
> +	printf("Usage: ./page_owner_sort [-m] <input> <output>\n"
> +		"-m	Sort by total memory. If not set this option, sort by times\n"

s/If not set this option/If this option is unset/


