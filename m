Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBC426C86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhJHOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:12:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39372 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242532AbhJHOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:12:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFAA322304;
        Fri,  8 Oct 2021 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633702216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbOqtnTDCJEewuTVp7hVAJPXdVhDLcSCoGXQKCOWG+I=;
        b=DfF0JRwcVjPIuDNF7x5Qia4uC4GS7PTWys8Y0zwJjBujB6kEPT2yN9qNrSLdEOZGVEYscp
        zlbyvBVvWYtmBqQo881jy3CZrwcwRIaTfAla5zmW+YukVCnFMsgM9fxeWvNGCuFXpMthTD
        G8pjHqoXvhkni5NFQw7TLhipRRdJtXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633702216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbOqtnTDCJEewuTVp7hVAJPXdVhDLcSCoGXQKCOWG+I=;
        b=YHfZQ+N3x7ZxBZ+V+8afL67f1C+/6bnb4ShnC+us5YMMCjQca7kmT93m/mqSMv1trWbb9y
        jrg7yUT7dRNfPzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCD5D13EC3;
        Fri,  8 Oct 2021 14:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dwspMUhRYGHFfgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 08 Oct 2021 14:10:16 +0000
Message-ID: <2f54d5c5-213a-fdb4-aa54-eacd81a93a5c@suse.cz>
Date:   Fri, 8 Oct 2021 16:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: fix a comment
Content-Language: en-US
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211008140312.6492-1-zhangyinan2019@email.szu.edu.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211008140312.6492-1-zhangyinan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 16:03, Yinan Zhang wrote:
> I have noticed that the previous macro is #ifndef CONFIG_SPARSEMEM.
> I think the comment of #else should be CONFIG_SPARSEMEM.

Right.

> Signed-off-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index dfb91653d..106079e67 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -201,7 +201,7 @@ void __init page_ext_init_flatmem(void)
>  	panic("Out of memory");
>  }
>  
> -#else /* CONFIG_FLATMEM */
> +#else /* CONFIG_SPARSEMEM */
>  
>  struct page_ext *lookup_page_ext(const struct page *page)
>  {
> 

