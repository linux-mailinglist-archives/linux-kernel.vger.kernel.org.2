Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4F427D24
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 21:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhJITiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhJITiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 15:38:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4AC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lM0zRIXeoiENBbttmaqjYixN1trfHDq/iU88uhQzWPg=; b=VY2NW6qMmyw2Zkw+xexPwo8Prw
        /WK/nTozEFsts2fE2oQwjR8JYO5XGnTnp8ZqA5028GAuy4kZoCId0eI1ZcwwWQ93fNP8CXNC26jyV
        giOSPWOvL2BiK6yryNiqs7Am/iZOBj9UPPwyEAGabD1RPrTnCvIkC/RqwCHkyUpf67YDYEFssADCQ
        5A7I4k1FECQGimdJVW6rN7VbAkcYlmD3zq4jwBdaFQh6eOKVHnJ+fiaEIgaQIf0Q0qvlLSO1QDsT1
        DQXSpROEPGcENJcxbT5NBcI7CWmjbVPqFf2RugbsjthtBd42RptaiT2RJnpnpstu5p1VTiBiA7tfA
        AFTJ5fsw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZI8J-004Mbb-4R; Sat, 09 Oct 2021 19:35:53 +0000
Date:   Sat, 9 Oct 2021 20:35:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] mm/folio-compat: fix potential NULL pointer
 access
Message-ID: <YWHvEy5lDD5GnrlQ@casper.infradead.org>
References: <20210913081113.79975-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913081113.79975-1-xu.xin16@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:11:13AM +0000, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> The pointer 'folio' might be NULL, but the structure it points to is accessed.
> Accordingly, we add a check of NULL pointer by 'if (!folio)'.
> Secondly, there is no need to check if folio is pointer or value with 'xa_is_value(folio)' 
> because folio is alwayse pointer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Your robot is garbage.

>  	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> -	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
> +	if (!folio)
> +		return NULL;
> +	if ((fgp_flags & FGP_HEAD))
>  		return &folio->page;

&folio->page *does not access folio*.  It does pointer arithmetic on
folio.  Specifically, it adds zero to folio, because page is the first
element of folio.

Secondly, __filemap_get_folio() absolutely can return an xa_is_value()
result if FGP_ENTRY entry is set.  It's right there in the first few
lines:

        folio = mapping_get_entry(mapping, index);
        if (xa_is_value(folio)) {
                if (fgp_flags & FGP_ENTRY)
                        return folio;

