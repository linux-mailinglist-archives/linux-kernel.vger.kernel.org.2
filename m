Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C473CCDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhGSGYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbhGSGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:24:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E345C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 23:21:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g4-20020a17090ace84b029017554809f35so13381268pju.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Q9X6x+e06UI3F0nFfey9N+d4GzFycyXwhSyw0wNHAoM=;
        b=RVVEon+ao3twNDIZID/4EIi2113ly0TlofiQD8z11HgiL33AHoxhj9n85p9IK6CkYk
         7RAbm0JKFQM6bMbwExvB5nod62KcbZ9xsZb3i2sHB1VqQl+9rr2PjMnOV4Sn4V64zJ/V
         x9CaPtdFVnireEebgNFnSx4qAQPZXB/NMKmu7c5m5KarYQ7XFOG0OAR2YNyLUizlziWI
         iE3SzUYslbhG3HeGXZu/i22zGUMh2/O7bjcCf0pPJVLGj2PuuXjIlBvW82PW3BQVpgAr
         IcFC9/21h5Ef425HK9+uTYHk4B71aeu/oSna3WhNtRo4KFPI8jvOmo0JO6GvaWARaDBX
         3KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Q9X6x+e06UI3F0nFfey9N+d4GzFycyXwhSyw0wNHAoM=;
        b=jB+ec2ddaADFlD2u7sg0KTTHxLMTwd/MSSC7dE+hmX1bdyy4MhO0Dvu+RPQQ7jatBy
         9wxi7pGIMihN/71iPHmo5ZKZB7iseqLnvT5NRkLaqRS1syaDnwEFXgEp8FbHGu4hnnuF
         a/Kr52jdNXmbJHP2YeQFybIBkwPSMyb+itCrpbnLiMa1r1FYiYcw6DSf6Aupzs8IW0nE
         vS+nsHq/Ho/0wsQZluOiN2btrKJp4a5lOisf6m/4GsHhw4cWfnNm+olVJYAilEN9YEAV
         CrERkFP7cNHtWHXiFsZKLsb1rJy10G0V3R+CH41cwK4lEtur3AiSAEwOl9omqfmCtSJo
         mm9g==
X-Gm-Message-State: AOAM5321XmtmH+b9moK/YpUDZqhiJYeg+NpZhMoJnuiYwgZLQ5xFmyJo
        gTvtu4sAsB7OEuKIjUva8tatrw==
X-Google-Smtp-Source: ABdhPJy1mPFZdTV6u7yu9rPEj0wQhy04nRt7CBu3R3Zq1iXrJI7Z/fTfPEVeZiAvIN62K8ckeD9iYA==
X-Received: by 2002:a17:90a:28a5:: with SMTP id f34mr23217865pjd.107.1626675702870;
        Sun, 18 Jul 2021 23:21:42 -0700 (PDT)
Received: from [2620:15c:17:3:2c04:af17:8ee7:e439] ([2620:15c:17:3:2c04:af17:8ee7:e439])
        by smtp.gmail.com with ESMTPSA id g8sm17319817pfu.30.2021.07.18.23.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 23:21:42 -0700 (PDT)
Date:   Sun, 18 Jul 2021 23:21:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     vjitta@codeaurora.org
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: slub: Fix slub_debug disablement for list of slabs
In-Reply-To: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org>
Message-ID: <dfcaaf6b-9a23-41f8-7baf-187e7c83e20@google.com>
References: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021, vjitta@codeaurora.org wrote:

> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> Consider the scenario where CONFIG_SLUB_DEBUG_ON is set
> and we would want to disable slub_debug for few slabs.
> Using boot parameter with slub_debug=-,slab_name syntax
> doesn't work as expected i.e; only disabling debugging for
> the specified list of slabs, instead it disables debugging
> for all slabs. Fix this.
> 
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>  mm/slub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index dc863c1..5a88418 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1429,6 +1429,7 @@ static int __init setup_slub_debug(char *str)
>  	char *slab_list;
>  	bool global_slub_debug_changed = false;
>  	bool slab_list_specified = false;
> +	bool slab_list_debug_disable = true;
>  
>  	slub_debug = DEBUG_DEFAULT_FLAGS;
>  	if (*str++ != '=' || !*str)
> @@ -1436,7 +1437,6 @@ static int __init setup_slub_debug(char *str)
>  		 * No options specified. Switch on full debugging.
>  		 */
>  		goto out;
> -
>  	saved_str = str;
>  	while (str) {
>  		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
> @@ -1445,6 +1445,8 @@ static int __init setup_slub_debug(char *str)
>  			slub_debug = flags;
>  			global_slub_debug_changed = true;
>  		} else {
> +			if (flags || !IS_ENABLED(CONFIG_SLUB_DEBUG_ON))

Could you explain the check for CONFIG_SLUB_DEBUG_ON here?

I don't believe that using `-' for slub_debug is *only* useful when 
CONFIG_SLUB_DEBUG_ON is enabled.

> +				slab_list_debug_disable = false;
>  			slab_list_specified = true;
>  		}
>  	}
> @@ -1456,7 +1458,7 @@ static int __init setup_slub_debug(char *str)
>  	 * long as there is no option specifying flags without a slab list.
>  	 */
>  	if (slab_list_specified) {
> -		if (!global_slub_debug_changed)
> +		if (!global_slub_debug_changed && !slab_list_debug_disable)
>  			slub_debug = 0;
>  		slub_debug_string = saved_str;
>  	}
