Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22453C755D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGMQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGMQ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:59:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48206C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:56:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b12so20191832pfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4wCNMjbrOJwbkarM8dk+y5+q+uJgZE6pfRBf9WOnD8=;
        b=eCJ56IKPytZEJQ4suhf8qzrReaw/5yjUFcjGgYCsYI8p7zjCvF169AKnSRMe6dsxw9
         mdV28itw/Q4gFIbvvxJAleTjFexQIN8YahxG8mtr0lXwEvYONoKmXUMIiP0svSNHScyy
         XussLKFw2E8lYNhHQNBlArIET56rSq3XlyppV5dnRTkoOAw2QLN3hyBKphvVm4R7ZEfi
         KNseBzIZL8frNcqYp0sa0qtB4SyDGobFBfsU8thrtHtV9q5lA6fW8awN+wtTQXfJFFWX
         Kim2mfzktHncbNgTV7KR0w8w6biDKLly1FYk8kW1OOjq4hsX5y+5IuEMeB7a0vz7HmRZ
         A4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4wCNMjbrOJwbkarM8dk+y5+q+uJgZE6pfRBf9WOnD8=;
        b=PTc6fr2lP1I3rNFcCzqjvzwi6k4pEIf4DxR/1MfdAH9p84zoZQ1wcQBy8E17PmN1dn
         UT7PQSzu049uoW0EPB/BdMAoPw9JpxzBzDPjyNd4DohwxbrT9WNc+EFt4H94nfZaAxhL
         39JBO/3dL63/h0lkiJKpY2FuGXwSqVi4yQMPnMAFVCS+39ADLVMu3Xnj+aR/vvEKtwLJ
         xGmT8tuLEDTC0sglKtslveq/AvEGXycKmhEO7gx1qnSx5rQPxhq81s3Lnr7NBxCboIzP
         ZxcYYbqiQ+/VOHQRoM2qUtFhdiDp0tM48pNsn/7Ix9L4gPV5hIrLvEQ48A/9BVH6cD7t
         JctQ==
X-Gm-Message-State: AOAM532PRluO517IHGie+MPFvEAIeCBqPUbq97qUBI8dXtrXwxuDy9oh
        BPmcKZLH/GFaUEk4/l2YzcGTFw==
X-Google-Smtp-Source: ABdhPJzh6S6HPRH5PDAKvpAP9XzB/eyG8jBkH8AbSMGK78IS7/FTa+KkDJnfDFjDMuHJpoIqrTUFVg==
X-Received: by 2002:a65:64c4:: with SMTP id t4mr5123236pgv.222.1626195388639;
        Tue, 13 Jul 2021 09:56:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d15sm6928128pfl.82.2021.07.13.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:56:28 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:56:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>
Subject: Re: [RFC PATCH 1/4] x86/sgx: Track phase and type of SGX EPC pages
Message-ID: <YO3FuBupQTKYaKBf@google.com>
References: <20210608214038.1026259-1-tony.luck@intel.com>
 <20210608214038.1026259-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608214038.1026259-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021, Tony Luck wrote:
> Add a type field to struct epc_page for how an in-use page has been
> allocated. Re-use "enum sgx_page_type" for this type, with a couple
> of additions for s/w types.

IMO, taking different actions based on the page type is flawed.  Ditto for adding
a flag to track so called "dirty" pages.

> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 3be203297988..abf6e1a704c0 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -72,7 +72,7 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	struct sgx_epc_page *epc_page;
>  	int ret;
>  
> -	epc_page = sgx_alloc_epc_page(encl_page, false);
> +	epc_page = sgx_alloc_epc_page(encl_page, SGX_PAGE_TYPE_REG, false);

This is wrong when reloading an SECS page.

>  	if (IS_ERR(epc_page))
>  		return epc_page;
>  
> @@ -651,7 +667,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		section->pages[i].section = index;
> -		section->pages[i].flags = 0;
> +		section->pages[i].flags = SGX_EPC_PAGE_DIRTY;

This flag is confusing, "dirty" in paging context almost always refers to the
page having been written.  The existing sgx_dirty_page_list name is not good,
fixing that instead of propagating the bad name would preferable.

But why is the flag needed?  If the flag is set iff the page is on the dirty
list, what's the point of the flag?

Looking forward to patch 3, why does sgx_memory_failure() need to eagerly remove
pages from the list?  Just have the sanitization skip poisoned pages.

> +		section->pages[i].type = SGX_PAGE_TYPE_FREE;
>  		section->pages[i].owner = NULL;
>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
