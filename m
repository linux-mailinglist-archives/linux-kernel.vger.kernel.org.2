Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6562B33FB46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhCQWby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhCQWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:31:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E400C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:31:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x126so2105384pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gTd9j8vUp4fOZtUdu4mKTnOETgew12vbkuoEscI8yoA=;
        b=aMf8mWmVPH3gl73lKNX3yTweFWBU1K4kdhXetrKQomBXOp/hM21ByLmwUmZH/AgPcT
         iYw72K2dsO5TUFdV54TXfhEtXIEZbOhqryLv1AyxpuVCIfzkkD81GgELUBQyNe8BFYwZ
         IGvIy2AQt25Bi9B+FdyQnBxdbdA+2tS9vztz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gTd9j8vUp4fOZtUdu4mKTnOETgew12vbkuoEscI8yoA=;
        b=B/IT06A76CJg0kzC4btqHiLKNmmD0qXkJ682GfEKZ8mrxAPcg3aJwFtP973UhUIQbN
         xJ2wM2bkLPta2yonr+wMZF9btUIwBjxjeAFFigkCprfsI4kMxp6FpbnYV8vCwLof3wdK
         xzo1ML9ILvN/h3chDqbmVcfLukGEyoGiPxoXvVIQZKXYxRzYMZ/UzgNiItSmYssDojbd
         WQdC/ktb+7zT5bu9HdGejwkUvOaJpst/22WWhvhtRnykEnu/B1K0sKHoHSv7zBjh8sv0
         1I/194yqV4vdpX4BDRDlqjY7+Qb0eQXNzFKnoenpt3R1eddkl3XLQItCNfAtKVBRXPKX
         QFPw==
X-Gm-Message-State: AOAM530vIXEWGjipbc5G6vD859/vKOLP9G0hfHSBfoBP5Jf78gxwEy//
        UU6ZyRUCtHTRC8fvv5WTRYM6FA==
X-Google-Smtp-Source: ABdhPJzsiqjJ1HzXQzfWqk+eUj3iVbHRNPRlW0WyMWs2qatShJmQunWe3wfF4wx1n7/xkm3VTRyAGA==
X-Received: by 2002:a62:5e02:0:b029:1ed:8bee:6132 with SMTP id s2-20020a625e020000b02901ed8bee6132mr1135915pfb.48.1616020300109;
        Wed, 17 Mar 2021 15:31:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm121803pje.40.2021.03.17.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:31:39 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:31:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [RESEND PATCH v2 1/2] pstore: Add mem_type property DT parsing
 support
Message-ID: <202103171523.23CAFD0E@keescook>
References: <1614268817-7596-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614268817-7596-1-git-send-email-mojha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:30:16PM +0530, Mukesh Ojha wrote:
> There could be a sceanario where we define some region
> in normal memory and use them store to logs which is later
> retrieved by bootloader during warm reset.
> 
> In this scenario, we wanted to treat this memory as normal
> cacheable memory instead of default behaviour which
> is an overhead. Making it cacheable could improve
> performance.
> 
> This commit gives control to change mem_type from Device
> tree, and also documents the value for normal memory.
> 
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
> Changes in v2:
>  - if-else converted to switch case
>  - updated MODULE_PARM_DESC with new memory type.
>  - default setting is still intact.
> 
>  Documentation/admin-guide/ramoops.rst |  4 +++-
>  fs/pstore/ram.c                       |  3 ++-
>  fs/pstore/ram_core.c                  | 18 ++++++++++++++++--
>  3 files changed, 21 insertions(+), 4 deletions(-)
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
> index ca6d8a8..af4ca6a4 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -56,7 +56,7 @@ MODULE_PARM_DESC(mem_size,
>  static unsigned int mem_type;
>  module_param(mem_type, uint, 0400);
>  MODULE_PARM_DESC(mem_type,
> -		"set to 1 to try to use unbuffered memory (default 0)");
> +		"set to 1 to use unbuffered memory, 2 for cached memory (default 0)");

I'd like to be as explicit as possible (0 wasn't listed), so about this:

"memory type: 0=write-combined (default), 1=unbuffered, 2=cached"

>  static int ramoops_max_reason = -1;
>  module_param_named(max_reason, ramoops_max_reason, int, 0400);
> @@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>  		field = value;						\
>  	}
>  
> +	parse_u32("mem-type", pdata->record_size, pdata->mem_type);

Please update the documentation at:
Documentation/devicetree/bindings/reserved-memory/ramoops.txt
(and please move and update the language about "unbuffered" being
deprecated like "no-dump-oops", so that it's clear what happens when
both are specified -- "mem-type" overrides "unbuffered".)

>  	parse_u32("record-size", pdata->record_size, 0);
>  	parse_u32("console-size", pdata->console_size, 0);
>  	parse_u32("ftrace-size", pdata->ftrace_size, 0);
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index aa8e0b6..0da012f 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -396,6 +396,10 @@ void persistent_ram_zap(struct persistent_ram_zone *prz)
>  	persistent_ram_update_header_ecc(prz);
>  }
>  
> +#define MEM_TYPE_WCOMBINE	0
> +#define MEM_TYPE_NONCACHED	1
> +#define MEM_TYPE_NORMAL		2
> +
>  static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>  		unsigned int memtype)
>  {
> @@ -409,10 +413,20 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>  	page_start = start - offset_in_page(start);
>  	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
>  
> -	if (memtype)
> +	switch (memtype) {
> +	case MEM_TYPE_NORMAL:
> +		prot = PAGE_KERNEL;
> +		break;
> +	case MEM_TYPE_NONCACHED:
>  		prot = pgprot_noncached(PAGE_KERNEL);
> -	else
> +		break;
> +	case MEM_TYPE_WCOMBINE:
>  		prot = pgprot_writecombine(PAGE_KERNEL);
> +		break;
> +	default:
> +		pr_err("invalid memory type\n");

This should be more verbose:

		pr_err("invalid mem_type=%d\n", memtype);

> +		return NULL;
> +	}
>  
>  	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
>  	if (!pages) {

With those changes, it looks good to me. Thanks!

-- 
Kees Cook
