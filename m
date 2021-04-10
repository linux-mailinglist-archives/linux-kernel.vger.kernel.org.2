Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFA35A96E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 02:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhDJAMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhDJAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 20:12:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B4C061765
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 17:11:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k128so3709271wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fA8Z5aUUNElBHQmTl0rVRM8cCmxTfIGvqWZXobJvnWQ=;
        b=CtMvdE66Fm4dWjje6zKsz5kv72mdudXYT7IjWrKjKo1ElzVKNAsIxbE4ZKxunfPt2/
         8ie4/TsZVuhs4+43rmUlu+6M5YlxQlZEbyG1HgCeyhrzubvSiO1oRRhBFP93PkeXTXNQ
         aHTar9XiwUAq8rpKJmYWgPOZbUDWF22pGOe2uku4LffjB5xotLkIyhkxdoq9Mbkt9xnT
         e08O690WOfdvLNwLu8dTOPL9slPOPP4GCBz8q2w/IqHXGhvq71v3FiDWd63lPEpLH88S
         KqfyPamBXXC2iXxWp3jZZJH7Gg2oV2dtcUo55+5gXdpVcjJXcYI02ISu0xYho/CKXJaX
         CL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fA8Z5aUUNElBHQmTl0rVRM8cCmxTfIGvqWZXobJvnWQ=;
        b=q2LHkzmtMFMwEfTMoIpniAG7UKb881BRAvCoXVDLjIxROcS9GLxt8GlISDYVKsyRiA
         T5KO6vPYi5EP7mDO2RmNBQA/RjATLtJ50aMqsSx6cgFZWPZ+mdnzKBo/2/nUQZKOrpEi
         EhHCPU5Jajq43awh4UJ1U/vXlYk9Ifd4CX9/t/VJ5MHYtb2/NQMWBhHcwSn3E/cM+OPu
         FFll9XaLj7Weih7VzM+NXxAhDKkDJZCJ7LOzxtnhO4373BBw4H7vAd8DBbr7AOt5+sVZ
         7ughKVt4bOXdB4xO2vVF+V4Z/QgkLghLJxj6qoD3KMMN9TIXSz7bRCv6+RLK3J8aOEZE
         01EA==
X-Gm-Message-State: AOAM533wbAL0IF4PQu8np7tJlsqi3VG6OOYJgbyPRcnOyphmSzzhgrUT
        NKjKA0msKJ/iiQJwSAfx6Rop7Q==
X-Google-Smtp-Source: ABdhPJzAaP35Kiw87xpUTi5qQTsrRoBKS6TFnZdpjti+HlUXGZNQDuwqZCfg9FEauKEV6I1dmHPq2w==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr15914875wmj.147.1618013510497;
        Fri, 09 Apr 2021 17:11:50 -0700 (PDT)
Received: from apalos.home (ppp-94-65-225-75.home.otenet.gr. [94.65.225.75])
        by smtp.gmail.com with ESMTPSA id p10sm6815210wmi.0.2021.04.09.17.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 17:11:50 -0700 (PDT)
Date:   Sat, 10 Apr 2021 03:11:45 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     netdev@vger.kernel.org, linux-mm@kvack.org,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>,
        Kevin Hao <haokexin@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 3/5] page_pool: Allow drivers to hint on SKB
 recycling
Message-ID: <YHDtQWyzFmrjuQWr@apalos.home>
References: <20210409223801.104657-1-mcroce@linux.microsoft.com>
 <20210409223801.104657-4-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409223801.104657-4-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo, 

[...]
> +bool page_pool_return_skb_page(void *data);
> +
>  struct page_pool *page_pool_create(const struct page_pool_params *params);
>  
>  #ifdef CONFIG_PAGE_POOL
> @@ -243,4 +247,13 @@ static inline void page_pool_ring_unlock(struct page_pool *pool)
>  		spin_unlock_bh(&pool->ring.producer_lock);
>  }
>  
> +/* Store mem_info on struct page and use it while recycling skb frags */
> +static inline
> +void page_pool_store_mem_info(struct page *page, struct xdp_mem_info *mem)
> +{
> +	u32 *xmi = (u32 *)mem;
> +

I just noticed this changed from the original patchset I was carrying. 
On the original, I had a union containing a u32 member to explicitly avoid
this casting. Let's wait for comments on the rest of the series, but i'd like 
to change that back in a v4. Aplogies, I completely missed this on the
previous postings ...

Thanks
/Ilias
