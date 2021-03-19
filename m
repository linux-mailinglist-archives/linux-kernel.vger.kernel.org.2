Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AED342666
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCSTo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhCSToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616183044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wBnwTw32U7/edAaMKPgosrHQ6qnsQ7c3qzlNBdLRLwE=;
        b=EVs7VJncYX+HNqB5yAHQaCpI92aH/6wglu2gGMbf96ZSDaXfAd2IayttohEgijinc96d+q
        gvhMsCa15yLB/3KVplDMj5koa63qNEy21Da8ctHQICahJf8TTIdJZZo0RG5KdnSxzDLHnv
        UNQMZpUdYpz+RLftbz5U2+PT+d4zLSI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-PcfcSdoYMOqxYi3ZAfjNzw-1; Fri, 19 Mar 2021 15:44:02 -0400
X-MC-Unique: PcfcSdoYMOqxYi3ZAfjNzw-1
Received: by mail-qv1-f71.google.com with SMTP id bt20so23812965qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBnwTw32U7/edAaMKPgosrHQ6qnsQ7c3qzlNBdLRLwE=;
        b=IrXz8C12yB3JmIG9hG0SLlV98e+7sBHv8DK0K3R7g0eeEx87kbvd1FlS+KbBLX+sre
         OrfyjUUsc+5sBNCM6WrlRgO+tkeV0aGbAIFWHM7cxRPUr/4kBmauw/bgiA03ulAQqmaF
         X5OPse1VFKUMeJl0WYl24SzY8HKrjYfquAqSHAywSonQbxczc7/nfQsn+l+niplvIaDB
         Edv54vtM5nwIJmwZZaifE6/NlFoxPTvzmN90vTNgLXNTGJph6ZbG11w9Bnk2FYZywq/j
         4rrTLnL6bIW6pd6vse6I0plmYJFsXWqnea+bNA2zdFt6a1t9Aq56exXMYwHhbrvyyRsF
         ZZog==
X-Gm-Message-State: AOAM531xeI0edJfkIyEmPI6HjBfDORrR3s0N6Ey/Gy419QhKCrFCb/gB
        rrExT7004VZu9zxrkPlPJGeqwcHDRRA13AXmgWCJYi2w8e+0tujMusz7ETiPMhgEK6o2JIDA1i9
        iRh/NPgdBVxLwFfyvbNrV2gqH
X-Received: by 2002:a37:9c4a:: with SMTP id f71mr270428qke.74.1616183041876;
        Fri, 19 Mar 2021 12:44:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYhpW4rwSqJREyAf9He7tsOoXjxb24BlxLJOXnfqZ+924cmVi+BZtNMt4qvCP7Y8VJUO688Q==
X-Received: by 2002:a37:9c4a:: with SMTP id f71mr270421qke.74.1616183041619;
        Fri, 19 Mar 2021 12:44:01 -0700 (PDT)
Received: from optiplex-lnx (c-98-229-205-110.hsd1.nh.comcast.net. [98.229.205.110])
        by smtp.gmail.com with ESMTPSA id f27sm5083183qkh.118.2021.03.19.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:44:01 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:43:58 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab_common: provide "slab_merge" option for
 !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT) builds
Message-ID: <YFT+/vVot1IIKkgg@optiplex-lnx>
References: <20210319192233.199099-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319192233.199099-1-aquini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 03:22:33PM -0400, Rafael Aquini wrote:
> This is a minor addition to the allocator setup options to provide
> a simple way to on demand enable back cache merging for builds
> that by default run with CONFIG_SLAB_MERGE_DEFAULT not set.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  mm/slab_common.c                                | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..06519eecbfec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4877,6 +4877,10 @@
>  
>  	slram=		[HW,MTD]
>  
> +	slab_merge	[MM]
> +			Enable merging of slabs with similar size when the
> +			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
> +
>  	slab_nomerge	[MM]
>  			Disable merging of slabs with similar size. May be
>  			necessary if there is some reason to distinguish
> @@ -4924,6 +4928,9 @@
>  			lower than slub_max_order.
>  			For more information see Documentation/vm/slub.rst.
>  
> +	slub_merge	[MM, SLUB]
> +			Same with slab_merge.
> +
>  	slub_nomerge	[MM, SLUB]
>  			Same with slab_nomerge. This is supported for legacy.
>  			See slab_nomerge for more information.
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 88e833986332..30db72269036 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -71,11 +71,19 @@ static int __init setup_slab_nomerge(char *str)
>  	return 1;
>  }
>  
> +static int __init setup_slab_merge(char *str)
> +{
> +	slab_nomerge = false;
> +	return 1;
> +}
> +
>  #ifdef CONFIG_SLUB
>  __setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
> +__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
>  #endif
>  
>  __setup("slab_nomerge", setup_slab_nomerge);
> +__setup("slab_merge", setup_slab_nomerge);
DOH! I missed the typo here         ^^   

Sorry.

