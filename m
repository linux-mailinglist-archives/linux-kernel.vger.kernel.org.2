Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFC317073
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhBJTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhBJTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:41:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01DCC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=O38fp6/+Gh5qfp0NnuP4fazgNZgMCvigrKOFpzxeVV0=; b=nMJujJtVj1IEyjpP9OA43IIdGm
        Iy4o6Wxk+VJ6QOVGUtmCdXzqbdcAXE3Q9EJvkxO/IdfY+NYTDfEkrtCt+AbPqeFjens1Va3ze0cda
        /9OJywnvibVV9HgJwjaNlTg4u5W+9RwFvEROHU1ReuB4Ufa1TE2VJphzd55HXzSoAPxO6sFOus0ik
        OgGNoR2ihc70SwT66nTWNodKiqhddZRZymeGhOuiz2Z1Pfp9LHcZ6zyCFEK1Oyd3kbFN2Jpt8HNsS
        S7C7URvKQHPe5ixCOydErLWaW1cg9SmfC4wMbxXiXxbA7Op5CCMtv24biMAiKg+4esQ7/0AAUsP1U
        iUJof6FA==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9vM0-0007Dq-NG; Wed, 10 Feb 2021 19:40:49 +0000
Subject: Re: [PATCH] pstore/ram : Add support for cached pages
To:     Mukesh Ojha <mojha@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, ccross@android.com, anton@enomsg.org,
        keescook@chromium.org, Huang Yiwei <hyiwei@codeaurora.org>
References: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d59687d7-1ca3-c822-f41d-169a9e388abb@infradead.org>
Date:   Wed, 10 Feb 2021 11:40:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/10/21 6:52 AM, Mukesh Ojha wrote:
> There could be a sceanario where we define some region

                   scenario

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

Does "mem_type=" work?  or does it need to be "mem-type=", as below?
I.e., do both of them work?


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

              here^^^^^^^^^^


thanks.
-- 
~Randy

