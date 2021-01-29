Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D320308BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhA2Rkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhA2RiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:38:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41541C061786
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:37:38 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j11so3002562plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L9O0JPeY7UlN+8wzL0U3ZAyM5VkRrCUmtyowZR23Ugg=;
        b=v35jOnn9EJUcAl+Zswnuk/Nd3C3Oei8/6vqjt50pyEs8c2Px9frn2mKU2x6xZ+pclV
         CwhQlED07+rLudhWeEpJqw/k8zdXubn7SHMIDZJIF7mWytxbrEbuwz3TLDv4grynsmab
         3iYVQCq7TuikznG98dQMza8OBw0FMnKTezZ84bKknNE82RNdYjVd02B/wBMvQe2BcnV7
         +TlvtmR+JiZO1COjHkBUrJmQKgyLj6xVx4INzYfR8iCSDCiUI87CWMrChI+3DWqWuM39
         B4Bm9ELbkvIkL1YJHOWOxYl0oxUUglaqpYV4VN5FBw5mWw2tdjpD1S4eJBiOpCwG1RHo
         qHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L9O0JPeY7UlN+8wzL0U3ZAyM5VkRrCUmtyowZR23Ugg=;
        b=YjtkZl50+c0eh00HFlq1vtqzQfgjnVnx8C8OkBRQh+ghguMuzY4HDDNshPYac/qQS4
         qHFRYCWXRs7+mSnIBd8kxQ4SF2zmRzkR6QmIkXPGKfBuCEBqqfM3HmXcz8knzsEFnbXy
         TtKHy/N/vWH/35AQM023VGMi9/t42wCkXaVso+MpK1brkng0xs2fSTquV464vaTmF4/o
         PFzI4OaDDWfiub7aYiYUWHaAg/zi+A124gUuZSS6old3a7GmnCpj1EJ3ekR6Cj2ernCO
         s+u6fjCoc8DMdw6UkelUjvlvuXEs2kqb/Bye1nXc2UcyFEGCOHBFl81WxsCLhEun7j9C
         gh+w==
X-Gm-Message-State: AOAM532Do/8BV0Ssucy2PMivN6UG4+YAOJ5i/NZt6A8Lu2d1+hvOYMSU
        86UfEAUS9KEC7rSAa60Y/wshf0P1Jl/uzw==
X-Google-Smtp-Source: ABdhPJyoyD1AHHA8RpZ+dnlzK+bDvdHJURn8iz/zhdJHYvWkUGV3M4ebXLTRUfRYUyQ3gqZliP0s2w==
X-Received: by 2002:a17:902:7783:b029:df:fa69:3a34 with SMTP id o3-20020a1709027783b02900dffa693a34mr5317324pll.21.1611941857706;
        Fri, 29 Jan 2021 09:37:37 -0800 (PST)
Received: from google.com ([2620:15c:f:10:91fd:c415:8a8b:ccc4])
        by smtp.gmail.com with ESMTPSA id r21sm10181610pgg.34.2021.01.29.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:37:36 -0800 (PST)
Date:   Fri, 29 Jan 2021 09:37:30 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     ira.weiny@intel.com
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86: Remove unnecessary kmap() from
 sgx_ioc_enclave_init()
Message-ID: <YBRH2jfPKS8ZofMZ@google.com>
References: <20210129001459.1538805-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129001459.1538805-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> There is no reason to alloc a page and kmap it to store this temporary
> data from the user. 

Actually, there is, it's just poorly documented.  The sigstruct needs to be
page aligned, and the token needs to be 512-byte aligned.  kmcalloc doesn't
guarantee alignment.  IIRC things will work until slub_debug is enabled, at
which point the natural alignment behavior goes out the window.

> This is especially true when we are trying to
> remove kmap usages.  Also placing the token pointer 1/2 way into the
> page is fragile.
> 
> Replace this allocation with two kzalloc()'s which also removes the need
> for the memset().
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 90a5caf76939..9c9019760585 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -604,7 +604,6 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
>  {
>  	struct sgx_sigstruct *sigstruct;
>  	struct sgx_enclave_init init_arg;
> -	struct page *initp_page;
>  	void *token;
>  	int ret;
>  
> @@ -615,13 +614,15 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
>  	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
>  		return -EFAULT;
>  
> -	initp_page = alloc_page(GFP_KERNEL);
> -	if (!initp_page)
> +	sigstruct = kzalloc(sizeof(*sigstruct), GFP_KERNEL);
> +	if (!sigstruct)
>  		return -ENOMEM;
>  
> -	sigstruct = kmap(initp_page);
> -	token = (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
> -	memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
> +	token = kzalloc(SGX_LAUNCH_TOKEN_SIZE, GFP_KERNEL);
> +	if (!token) {
> +		ret = -ENOMEM;
> +		goto free_sigstruct;
> +	}
>  
>  	if (copy_from_user(sigstruct, (void __user *)init_arg.sigstruct,
>  			   sizeof(*sigstruct))) {
> @@ -645,8 +646,9 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
>  	ret = sgx_encl_init(encl, sigstruct, token);
>  
>  out:
> -	kunmap(initp_page);
> -	__free_page(initp_page);
> +	kfree(token);
> +free_sigstruct:
> +	kfree(sigstruct);
>  	return ret;
>  }
>  
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
