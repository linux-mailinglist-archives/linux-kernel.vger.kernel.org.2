Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6A3A27B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhFJJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFJJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:08:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:06:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r16so3821226ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QlZvmq2qt7sBZ6i/lsSs1+uuiPXKgjE+MOFqdsesJLA=;
        b=YFsPavJKfC42wjrE9OlquvJGz0/n4HMfpd0VQLElz8xzZWsDtyk9LoTI0qVbypsqyG
         95RHdXeSRxx9K4h7ktcW0Wj2BNSZCAFzhUvxBdWSv8qIuD3R/g3OeuDLwYzmk4NBimeQ
         dFXjma+3zW2mdwCFKUCDmPugOlnKa6DIdshrhpEzFEJGUt0SnL/yKilEOoajToZ/erhH
         i8459xG0N87irY0fyTT+/Q3Lj6nIMUBr3DUPgSWNk43J2PjSjCUiSFbwBHyzZAykFtVZ
         UMplQe8edru4E+3xdiiJqGq2wq9IbaTFsOKvYagHgzcBM2CKZH3Ts7pX3DcsxLGXtuiq
         1v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QlZvmq2qt7sBZ6i/lsSs1+uuiPXKgjE+MOFqdsesJLA=;
        b=j1UV1gNg94m4ZsXYa16fElt0TX9WBoIbOeY3FHoFV4fprEmldYcMc1nONrAwycucdJ
         cPYOpK/W1Asdwj//up9eD4HvtrQndbYESPweBAxdo7hL+GAQujHucmVHWTk09JnpZwq2
         lF89wOZCl8KEzasOiDxRG7zflOheDDzKcnyvjLozI1RIZoRN26fX4TLuBt8/ALFTrWTv
         uGCsboc08aHV6s7I5uaSrpsinAJhDSWzhIVi2/lGiXzRn8YCG53fcDrc9BnQywhY//aU
         Vw6u6rymYSEzDXXi/v8AIu8GaE4EtifRLOSC85hZrn+dWENb02NegAsvmKvyWqwF6q6y
         YCtA==
X-Gm-Message-State: AOAM533jRrKdH3tKNa8KzrrUEf5hwaYDiT5SiE/9OQykh88gF8OL2YpC
        BXfSTCzqedK2WdbuKa8vakTJ9w==
X-Google-Smtp-Source: ABdhPJyDjgj256oeRiF0aBgY/0Im7OHNHYnX8h3qtG+OoWa5zWC84GBRpLUC+RMZkgheRm/qEcBDfw==
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr1379327ljo.264.1623315962340;
        Thu, 10 Jun 2021 02:06:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b18sm237862lfb.277.2021.06.10.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:06:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8D88F1027EE; Thu, 10 Jun 2021 12:06:17 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:06:17 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mm: page_vma_mapped_walk(): use pmd_read_atomic()
Message-ID: <20210610090617.e6qutzzj3jxcseyi@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <594c1f0-d396-5346-1f36-606872cddb18@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594c1f0-d396-5346-1f36-606872cddb18@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:38:11PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: use pmd_read_atomic() with barrier()
> instead of READ_ONCE() for pmde: some architectures (e.g. i386 with PAE)
> have a multi-word pmd entry, for which READ_ONCE() is not good enough.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/page_vma_mapped.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 7c0504641fb8..973c3c4e72cc 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -182,13 +182,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	pud = pud_offset(p4d, pvmw->address);
>  	if (!pud_present(*pud))
>  		return false;
> +
>  	pvmw->pmd = pmd_offset(pud, pvmw->address);
>  	/*
>  	 * Make sure the pmd value isn't cached in a register by the
>  	 * compiler and used as a stale value after we've observed a
>  	 * subsequent update.
>  	 */
> -	pmde = READ_ONCE(*pvmw->pmd);
> +	pmde = pmd_read_atomic(pvmw->pmd);
> +	barrier();
> +

Hm. It makes me wounder if barrier() has to be part of pmd_read_atomic().
mm/hmm.c uses the same pattern as you are and I tend to think that the
rest of pmd_read_atomic() users may be broken.

Am I wrong?

-- 
 Kirill A. Shutemov
