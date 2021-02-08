Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8FC3132A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBHMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhBHMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:42:35 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD607C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:41:53 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f8so7078444ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rubRJOgYmFpM4CNcdGPeXsYiPE2nmydk/BCGJEGbZzU=;
        b=UXWTJe8J6ixYjbsH1Xh9s/4E6xWDP0p1HkdJbr8qNeSSqf0y3OH50/nj+DgXJwqd8G
         91FrxwSkJ0BX+mjYCULhbr0OLkodNuKM3fxt/Cd5C4yiU8skXt//yW4MaIVf+BnsVhdE
         R4ZQgQdfVbKfJu8JhJUXhiiT/CwwZ67Ie0E88KhkZYYT5BynSlbUv1SSQCA+V4/0DxAq
         ESWTzLBJBg5tCWLX39UaNy4Cu71FwOyAPCgNSfPD/L6/tUOJsr5F/AwjeZ5QkviB7WET
         kfElL1NLqAlC83Liflw20PdA4jmi41b209C0fyGZNwo7KQL6MxrrYxHfiu+B1mAoFKN3
         GwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rubRJOgYmFpM4CNcdGPeXsYiPE2nmydk/BCGJEGbZzU=;
        b=JdYCdwoLwP/cDd9XrJUuB4UJbfawTxZevaiMgUXt/7iaMAxACt5f3WRpPRtvbxPlFj
         0o8nGLTPAJ1Jmeato6sxoNL6PivwMmtJ3HCdUsZpcET/gKG6lBsz1vyyXWY2dU0nryHZ
         V16tGt0uR25Qk4m4sSRCL2NHcolUDulyhpcyOwjgdRwPb4Jf7zTq7FjBEsKHQM4Xogop
         lfliPbI8g0GtifbXCr2myOn2Jb89ARZlw+7J7wykK3imEo0KhleQNZR2XOXx/W4yGVg1
         9lJifx7+afopCflClLXgj9/hcd+Q4/l0eviTSW7Erc+duH/YeK6YuFrtZGV6U95K4Cpw
         NLhA==
X-Gm-Message-State: AOAM532PNuy0pwAx5JHblhq5YTRRDtpu5xM3bYjhK/lpEX3GSTI9PBoc
        GiiL/+KsI0JGv31FAVOTCSk=
X-Google-Smtp-Source: ABdhPJz7219bmKgnHQa0SQ6eA1GaiQc8JC4+BUuRM3sHiHkFoEEoMyILFtHPLrD7oe08Hj2TAzJ1mw==
X-Received: by 2002:a2e:884f:: with SMTP id z15mr10831652ljj.110.1612788112190;
        Mon, 08 Feb 2021 04:41:52 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d3sm102956ljg.57.2021.02.08.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 04:41:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 8 Feb 2021 13:41:49 +0100
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/list_lru.c: remove kvfree_rcu_local()
Message-ID: <20210208124149.GA1920@pc638.lan>
References: <20210207152148.1285842-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207152148.1285842-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The list_lru file used to have local kvfree_rcu() which was renamed by
> commit e0feed08ab41 ("mm/list_lru.c: Rename kvfree_rcu() to local
> variant") to introduce the globally visible kvfree_rcu(). Now we have
> global kvfree_rcu(), so remove the local kvfree_rcu_local() and just
> use the global one.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/list_lru.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index fe230081690b..6f067b6b935f 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -373,21 +373,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
>  	struct list_lru_memcg *memcg_lrus;
>  	/*
>  	 * This is called when shrinker has already been unregistered,
> -	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
> +	 * and nobody can use it. So, there is no need to use kvfree_rcu().
>  	 */
>  	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
>  	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
>  	kvfree(memcg_lrus);
>  }
>  
> -static void kvfree_rcu_local(struct rcu_head *head)
> -{
> -	struct list_lru_memcg *mlru;
> -
> -	mlru = container_of(head, struct list_lru_memcg, rcu);
> -	kvfree(mlru);
> -}
> -
>  static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>  				      int old_size, int new_size)
>  {
> @@ -419,7 +411,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>  	rcu_assign_pointer(nlru->memcg_lrus, new);
>  	spin_unlock_irq(&nlru->lock);
>  
> -	call_rcu(&old->rcu, kvfree_rcu_local);
> +	kvfree_rcu(old, rcu);
>  	return 0;
>  }
>  
> -- 
> 2.30.0.478.g8a0d178c01-goog
>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>

--
Vlad Rezki
