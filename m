Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C833C7592
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhGMRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGMRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:17:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF8C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:14:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t9so22204516pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JC3QAw3ODxgigAZdf9CWnBsyAGr9slowWBImV3c+X8w=;
        b=nXWgLBqyaKiPa3oCYMYtJMk/uq67FYXv6tGVC/+GHPK1fejwcQZYFyAgC8QNQyw0m5
         42vBBthoBl5UPdCvo0R+sggOpO1Tc8rGx7nsormGmF/zTSQT7YNQTbIxn38kK607bpy8
         8QKUtp5z3G0M9TBPK9EXtxd6/ezKadFU6YdCJBAvdkqEKhmUHbY7Y1Z7oB+oV77pm8Ff
         JJx7I49KHQrWSbVViBmsrrdzafE8NWeYL+hxnmBG+OzHM6QszVbGMKuhXOkCLnAFr6PD
         EzW5DpgNM//zG/qg71s7Wc3vC/RzpPT5YcQgixCuFGln/bZnBFSKNOvy2Ba1ubixPhjD
         O/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JC3QAw3ODxgigAZdf9CWnBsyAGr9slowWBImV3c+X8w=;
        b=EZTmJT1LxDS8Ytl2TZp2JAD17WxHNyCA6yCbz0zkwq75sQp0P4Rt0iF242GeSrgwno
         mCBmC465nJSlEMmliOPfCi26JOWrhU67ffle3G513DZE0WVedXTPgBQLAf0dKOhyOTJF
         3r6U5/G3r1vAfXmj5h59EABASUcEvQelxwiGWF4R1dsDuGSJaIDEWQ9r2EeQBzVA188D
         voRhuYqoyaFwFblZyXeuUqoNUQQo55Ad0/JytXbV/Tjqgqg+eWmUpOe9SgfAd63tr7a7
         j81WwfDdntLu4W9kF5c5q/WFjdRBrT0viLfjafiyEf33Gz8R8EB/cUWYDjEzFK4jZdL3
         qd3g==
X-Gm-Message-State: AOAM531ORGq5t7D+Zrij4dzgrNZvVrcp6pAcD65u7J5799b8GFK5t71S
        fFC9oLClFDQC+ZXrLd6E4BwYyw==
X-Google-Smtp-Source: ABdhPJwSSisbcFPAsTVvUOOtCw3W4NieNJSmxk4Q7oHIpHwS8SznTp9S+h68vMn5xVhwsWNfng9nDA==
X-Received: by 2002:a63:655:: with SMTP id 82mr5184524pgg.133.1626196449648;
        Tue, 13 Jul 2021 10:14:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e18sm20181214pfc.85.2021.07.13.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:14:09 -0700 (PDT)
Date:   Tue, 13 Jul 2021 17:14:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>
Subject: Re: [RFC PATCH 2/4] x86/sgx: Add basic infrastructure to recover
 from errors in SGX memory
Message-ID: <YO3J3fGh8Zx39QH0@google.com>
References: <20210608214038.1026259-1-tony.luck@intel.com>
 <20210608214038.1026259-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608214038.1026259-3-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021, Tony Luck wrote:
> +	/*
> +	 * Poison was synchronously consumed by an enclave in the current
> +	 * task. Send a SIGBUS here. Hardware should prevent this enclave
> +	 * from being re-entered, so no concern that the poisoned page
> +	 * will be touched a second time. The poisoned EPC page will be
> +	 * dropped as pages are freed during task exit.
> +	 */
> +	if (flags & MF_ACTION_REQUIRED) {
> +		if (epc_page->type == SGX_PAGE_TYPE_REG) {

Why only for REG pages?  I don't see the value added by assuming that SECS, TCS,
and VA pages will result in uncorrectable #MC.

> +			encl_page = epc_page->owner;
> +			addr = encl_page->desc & PAGE_MASK;
> +			force_sig_mceerr(BUS_MCEERR_AR, (void *)addr, PAGE_SHIFT);
> +		} else {
> +			force_sig(SIGBUS);
> +		}
> +		goto unlock;
> +	}
> +
> +	section = &sgx_epc_sections[epc_page->section];
> +	node = section->node;
> +
> +	if (page_flags & SGX_EPC_PAGE_POISON)
> +		goto unlock;
> +
> +	if (page_flags & SGX_EPC_PAGE_DIRTY) {
> +		list_del(&epc_page->list);

As suggested in the prior patch, why not let the sanitizer handle poisoned pages?

> +	} else if (page_flags & SGX_EPC_PAGE_FREE) {
> +		spin_lock(&node->lock);
> +		epc_page->owner = NULL;
> +		list_del(&epc_page->list);
> +		sgx_nr_free_pages--;
> +		spin_unlock(&node->lock);
> +		goto unlock;
> +	}
> +
> +	switch (epc_page->type) {
> +	case SGX_PAGE_TYPE_REG:
> +		encl_page = epc_page->owner;
> +		/* Unmap the page, unless it was already in progress to be freed */
> +		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
> +			spin_unlock(&sgx_reclaimer_lock);
> +			sgx_reclaimer_block(epc_page);
> +			kref_put(&encl_page->encl->refcount, sgx_encl_release);
> +			goto done;
> +		}
> +		break;
> +
> +	case SGX_PAGE_TYPE_KVM:
> +		spin_unlock(&sgx_reclaimer_lock);
> +		sgx_memory_failure_vepc(epc_page);

...

> @@ -217,6 +218,13 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +void sgx_memory_failure_vepc(struct sgx_epc_page *epc_page)
> +{
> +	struct sgx_vepc *vepc = epc_page->owner;
> +
> +	send_sig(SIGBUS, vepc->task, false);

...

> +}
> +
>  static int sgx_vepc_open(struct inode *inode, struct file *file)
>  {
>  	struct sgx_vepc *vepc;
> @@ -226,6 +234,7 @@ static int sgx_vepc_open(struct inode *inode, struct file *file)
>  		return -ENOMEM;
>  	mutex_init(&vepc->lock);
>  	xa_init(&vepc->page_array);
> +	vepc->task = current;

This is broken, there is no guarantee whatsoever that the task that opened the
vEPC is the task that is actively using vEPC.  Since Dave successfully lobbied
to allow multiple mm_structs per vEPC, it might not even be the correct process.

>  	file->private_data = vepc;
>  
> -- 
> 2.29.2
> 
