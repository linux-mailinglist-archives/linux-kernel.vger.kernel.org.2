Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED943AEC03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFUPKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFUPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oeYSpEhZE6AmPfNM4+w2zYj9of/Mlvcohb59Uj+RS6k=; b=udr+eniEeQRB22JbVElibG//cJ
        jzbNGAnVUOEydkIjCnfG6UGKxmHS1FCLO+SG6Nqk/MRjZAsp6OTxGdLZ0/NTJ8gylehMPZumiy9bD
        okUbzqXaVAsuZNXwekXBiY87c4qmHinOcPEd+G/XQkA+MBGWZDGr+VMRCYEeLnk+hmFFKkCWOtFLd
        DFKCIUEYgJ0Nkp7dxCAbfsfR6ELNt2yzZ70YVG9a2ujinF/R4xcpGw9pjRQ4cmmWVrids6gdUebz9
        xASPeX1lOUQIHo6XN+wdWzZhl4epihE+TQdpMy+eDRuOTU+c/0ZfodNchXxRooJgsDcGssghKkuKR
        5eFIdWXQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLW8-00DDQH-Lf; Mon, 21 Jun 2021 15:07:21 +0000
Date:   Mon, 21 Jun 2021 16:07:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] riscv: Map the kernel with correct permissions
 the first time
Message-ID: <YNCrJMb7aO16XHg3@infradead.org>
References: <20210617131734.1923932-1-alex@ghiti.fr>
 <20210617131734.1923932-3-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617131734.1923932-3-alex@ghiti.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 03:17:34PM +0200, Alexandre Ghiti wrote:
>  
>  void free_initmem(void)
>  {
>  	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
> +		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
> +				  IS_ENABLED(CONFIG_64BIT) ? set_memory_rw : set_memory_rw_nx);

Breaking the second line up woul help a lot with readability:

		set_kernel_memory(lm_alias(__init_begin), lm_alias(__init_end),
				  IS_ENABLED(CONFIG_64BIT) ?
				  	set_memory_rw : set_memory_rw_nx);

> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +static __init pgprot_t pgprot_from_va(uintptr_t va)
> +{
> +	if (is_va_kernel_text(va))
> +		return PAGE_KERNEL_READ_EXEC;
> +
> +	/*
> +	 * In 64b kernel, the kernel mapping is outside the linear mapping so we

Spelling out 64-bit would be nice.

> +	 * must protect its linear mapping alias from being executed and written.

And please never spill comments over 80 characters, as that makes them
completely unreadable.

Besides a few more overly long lines this looks great.
