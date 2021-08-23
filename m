Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052233F42C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhHWBHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHWBHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:07:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F8C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aspPZtQVW2NXlfWYzMvyvdVJsYawidsXh00ZJfiDIgk=; b=jL04ykE3uh+j5Lc5Hh8LKs7iYO
        PCr18G7o0uas5a+kZ4dfug8ngc+wrVXJtnqozxE5fZ+i+jVreVre66iq475ebwIQkBfVebvW0n8Wp
        xdQglzke+8XqfZnaK1Ci8vLMc8YdkyI/YHgzxV7ZGTW5YhUiEyB4WC5D5iZiSPzqDTq+/4jzVvFhw
        N5WCqNiT2tuWD3RHuECjffZCmhGszhOlW8WjBST6GFuidpcPfOlF31FPRB1nUd96z+S2yDFKxoIhE
        NnqsXM1QS7Tfeq8speOwfrQfYN8X3aC8gIFiFzqRcqWdkpl6wo7SNyzTt+arRHYOPXQVopInewnEw
        jy2+6SmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHyOp-0096T6-1r; Mon, 23 Aug 2021 01:05:29 +0000
Date:   Mon, 23 Aug 2021 02:05:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, zealci@zte.com.cn,
        Changcheng Deng <deng.changcheng@zte.com.cn>
Subject: Re: [PATCH linux-next] mm/folio-compat.c: folio should not be NULL
 when it is referenced
Message-ID: <YSL0S9SKjmt5gGuW@casper.infradead.org>
References: <20210823004735.32013-1-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823004735.32013-1-wang.yi59@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:47:35AM +0800, Yi Wang wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> A bug was found by coccinelle:
> folio is NULL but dereferenced
> Therefore,added a check to make sure 'folio' is not NULL.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Your robot is overzealous.  This does not dereference folio; rather it
takes the address of the page element of the folio structure.

By a strict reading of the C spec, it is not allowed.  However, GCC
(and I assume Clang) does the right thing.

>  	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> -	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
> -		return &folio->page;
> +	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
> +		if (folio != NULL)
> +			return &folio->page;
>  	return folio_file_page(folio, index);

This is definitely wrong.  Did you test it?  I bet you get a NULL
pointer dereference if you try it.

You could potentially make the case for:

	if (!folio)
		return NULL;
	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
		return &folio->page;

but you actually have the same problem with the C spec, that unless
folio is actually a pointer to a folio, then &folio->page is
_technically_ undefined.  So it would have to be something even
more complex to be pedantically correct.

It's just not worth it.  Fix your tool.

