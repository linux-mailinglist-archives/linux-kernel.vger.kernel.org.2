Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB25431711A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBJUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhBJUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:18:06 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D809DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:17:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c11so2015196pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fvc8yFFiXhssCS/8DtOpvEZDrYQpXuFAX3ho/UHrA28=;
        b=ocZZLVpNz8sfpL00VeOLjj4QYmBPgMvR36kniyBJDEiau0zbb+mmw7JH6hte/0Rxvp
         5yYKYAxusgX4xn0VYchNl0ijAsJRCWv4Q8fYbwD88Zfg+/nIWw1tgyssijl0FmCCbvnT
         8B/ouI3YWCsmDFcg4w0vk8HNGxljob7JUPOIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fvc8yFFiXhssCS/8DtOpvEZDrYQpXuFAX3ho/UHrA28=;
        b=oj0LWPUblaL/c5Z5SFFHFHC4yq9rkUipuULLAW2aKWXcDYwDucGuDZIQi2EcBCirqg
         Xk83MnTJaeUbXlxwWStXkaA+fH0iUjPeRcN7b4gFumUOFK2Xnb6291irUDjx3xcX+L6s
         5K74wsdDtLQfZY5zFjLpv4CURXY8XmJdiZvqIouVPZq+/Yxj+loTwBbgWL92o/yxpy4F
         F1YzrdIN9lPpC2Jjt1FVtjLzJvv80+MIn5Bh43r/7LjP5cUXtYW+MzZG1MyG5XklI11j
         KTIQDt9j7JFi9ZxweBua8fqBcXh9UWszAlHlOWTx/I7GUCq+6MoTVd5vXoUlFKb8ylTF
         Pvvw==
X-Gm-Message-State: AOAM530sD+xEfQFsVevzPTfmfYPtRqdReObAP4hgmgaNs6uJjvtSf8W4
        yuG7vOx/vSFrNTqThQyGJuuy6A==
X-Google-Smtp-Source: ABdhPJzW+QD/aMkZVIQhQyght73rvfVEJ/Bqf+1kqTah2uqJ4iGVe/PzZlsJN+1h+tAub1k+E8vfjA==
X-Received: by 2002:a63:686:: with SMTP id 128mr4621480pgg.421.1612988245435;
        Wed, 10 Feb 2021 12:17:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y15sm3077709pju.20.2021.02.10.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:17:24 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:17:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        ccross@android.com, anton@enomsg.org,
        Huang Yiwei <hyiwei@codeaurora.org>
Subject: Re: [PATCH] pstore/ram : Add support for cached pages
Message-ID: <202102101213.D603669D4@keescook>
References: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 08:22:21PM +0530, Mukesh Ojha wrote:
> There could be a sceanario where we define some region
> in normal memory and use them store to logs which is later
> retrieved by bootloader during warm reset.
> 
> In this scenario, we wanted to treat this memory as normal
> cacheable memory instead of default behaviour which
> is an overhead. Making it cacheable could improve
> performance.

Cool; yeah. I like this idea.

> 
> This commit gives control to change mem_type from Device
> tree, and also documents the value for normal memory.

What's the safest default setting?

> 
> Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  Documentation/admin-guide/ramoops.rst |  4 +++-
>  fs/pstore/ram.c                       |  1 +
>  fs/pstore/ram_core.c                  | 10 ++++++++--
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index b0a1ae7..8f107d8 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -3,7 +3,7 @@ Ramoops oops/panic logger
>  
>  Sergiu Iordache <sergiu@chromium.org>
>  
> -Updated: 17 November 2011
> +Updated: 10 Feb 2021
>  
>  Introduction
>  ------------
> @@ -30,6 +30,8 @@ mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
>  depends on atomic operations. At least on ARM, pgprot_noncached causes the
>  memory to be mapped strongly ordered, and atomic operations on strongly ordered
>  memory are implementation defined, and won't work on many ARMs such as omaps.
> +Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
> +which enables full cache on it. This can improve the performance.
>  
>  The memory area is divided into ``record_size`` chunks (also rounded down to
>  power of two) and each kmesg dump writes a ``record_size`` chunk of
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ca6d8a8..b262c57 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  		field = value;						\
>  	}
>  
> +	parse_u32("mem-type", pdata->record_size, pdata->mem_type);

This was handled by "unbuffered" above. Can you find a way to resolve
potential conflicts between these?

>  	parse_u32("record-size", pdata->record_size, 0);
>  	parse_u32("console-size", pdata->console_size, 0);
>  	parse_u32("ftrace-size", pdata->ftrace_size, 0);
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index aa8e0b6..83cd612 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -396,6 +396,10 @@ void persistent_ram_zap(struct persistent_ram_zone *prz)
>  	persistent_ram_update_header_ecc(prz);
>  }
>  
> +#define MEM_TYPE_WCOMBINE	0
> +#define MEM_TYPE_NONCACHED	1
> +#define MEM_TYPE_NORMAL		2

It might be nice for this to have a human-readable name too, but let's
start with numeric. :)

Please update the mem_type MODULE_PARM_DESC to detail the new values too.

> +
>  static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>  		unsigned int memtype)
>  {
> @@ -409,9 +413,11 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>  	page_start = start - offset_in_page(start);
>  	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
>  
> -	if (memtype)
> +	if (memtype == MEM_TYPE_NORMAL)
> +		prot = PAGE_KERNEL;
> +	else if (memtype == MEM_TYPE_NONCACHED)
>  		prot = pgprot_noncached(PAGE_KERNEL);
> -	else
> +	else if (memtype == MEM_TYPE_WCOMBINE)
>  		prot = pgprot_writecombine(PAGE_KERNEL);

Let's make this a switch statement.

>  
>  	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 

-- 
Kees Cook
