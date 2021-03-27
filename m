Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8948234B98B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 22:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhC0ViB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 17:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0ViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:38:00 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA1C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 14:38:00 -0700 (PDT)
Date:   Sat, 27 Mar 2021 21:37:48 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add page_owner_stack=off to make stack collection
 optional
Message-ID: <20210327213748.2f7a5692@sf>
In-Reply-To: <20210321212501.2504947-1-slyfox@gentoo.org>
References: <20210321212501.2504947-1-slyfox@gentoo.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 21:25:01 +0000
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> On some architectures (like ia64) stack walking is slow
> and currently requires memory allocation. This causes stack
> collection for page_owner=on to fall into recursion.
> 
> This patch implements a page_owner_stack=off to allow page stats
> collection.

More user friendly alternative would be to have a GFP_ flag similar
to __GFP_NOLOCKDEP which would allow us to skip the recursion.
I'll prepare alternative patch.

> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>  mm/Kconfig.debug                              |  3 ++-
>  mm/page_owner.c                               | 23 +++++++++++++------
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..3e710c4ab4df 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3518,6 +3518,12 @@
>  			we can turn it on.
>  			on: enable the feature
>  
> +	page_owner_stack= [KNL] Boot-time parameter option disabling stack
> +			collection of page allocation. Has effect only if
> +			"page_owner=on" is set. Useful for cases when stack
> +			collection is too slow or not feasible.
> +			off: disable the feature
> +
>  	page_poison=	[KNL] Boot-time parameter changing the state of
>  			poisoning on the buddy allocator, available with
>  			CONFIG_PAGE_POISONING=y.
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 1e73717802f8..c1ecaf066c93 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -57,7 +57,8 @@ config PAGE_OWNER
>  	  help to find bare alloc_page(s) leaks. Even if you include this
>  	  feature on your build, it is disabled in default. You should pass
>  	  "page_owner=on" to boot parameter in order to enable it. Eats
> -	  a fair amount of memory if enabled. See tools/vm/page_owner_sort.c
> +	  a fair amount of memory if enabled. Call chain tracking can be
> +	  disabled with "page_owner_stack=off". See tools/vm/page_owner_sort.c
>  	  for user-space helper.
>  
>  	  If unsure, say N.
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index d15c7c4994f5..2cc1113fa28d 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -31,6 +31,7 @@ struct page_owner {
>  };
>  
>  static bool page_owner_enabled = false;
> +static bool page_owner_stack_enabled = true;
>  DEFINE_STATIC_KEY_FALSE(page_owner_inited);
>  
>  static depot_stack_handle_t dummy_handle;
> @@ -41,21 +42,26 @@ static void init_early_allocated_pages(void);
>  
>  static int __init early_page_owner_param(char *buf)
>  {
> -	if (!buf)
> -		return -EINVAL;
> -
> -	if (strcmp(buf, "on") == 0)
> -		page_owner_enabled = true;
> -
> -	return 0;
> +	return kstrtobool(buf, &page_owner_enabled);
>  }
>  early_param("page_owner", early_page_owner_param);
>  
> +static int __init early_page_owner_stack_param(char *buf)
> +{
> +	return kstrtobool(buf, &page_owner_stack_enabled);
> +}
> +early_param("page_owner_stack", early_page_owner_stack_param);
> +
>  static bool need_page_owner(void)
>  {
>  	return page_owner_enabled;
>  }
>  
> +static bool need_page_owner_stack(void)
> +{
> +	return page_owner_stack_enabled;
> +}
> +
>  static __always_inline depot_stack_handle_t create_dummy_stack(void)
>  {
>  	unsigned long entries[4];
> @@ -122,6 +128,9 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
>  	depot_stack_handle_t handle;
>  	unsigned int nr_entries;
>  
> +	if (!need_page_owner_stack())
> +		return failure_handle;
> +
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
>  
>  	/*
> -- 
> 2.31.0
> 


-- 

  Sergei
