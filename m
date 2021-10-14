Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2245B42D6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhJNKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:04:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CDC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:02:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j21so24876730lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MM0VrYTG69cMYcPYskdHoBtCiOAiSxK8ukGZTBfygvI=;
        b=BwZ1wcvfX6bOADLWwfydgtxRRqrwKBHYjxthrB/MoSGtROgtNdE4L+X06mmLz4aOHK
         EOiGyEV8eSIA2iYno6G7HH6YrPMNZcel8INH7/UOo8aw1Zkcz612711IkisuJnQZBm/m
         DN/aNctyuAy8KmnXS9xO/SCqe2XyI87YzodGkaQ9gYafPFFQ+NKbDpmBJpcYsd/fdnpI
         NDqQXr08mU/fpwk+27IzFayjRAPjGUerKjAy8yo2ZedAt0g4UjHnOcfHF4PJZWKSyQ44
         HRT3mkDBweIXQjUSAXilWu/bge7uF6qhTxbC8hqMCSKd4grK8KGqiDmBdgHmfCl9925Q
         hSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MM0VrYTG69cMYcPYskdHoBtCiOAiSxK8ukGZTBfygvI=;
        b=aEmpbyG5jg3ONsP5QO4gri5Xyy9q4Y97sZenqV5A/d4wKKezV7eTFmZ8sJdqw+qV5d
         KAiVK0UgyDeQU7w3k+GQBu/ZzXIkGw/TsconLOSz8yDfTsCnzLY/+usYjQxgIML0nHov
         owboQR2n6tuK5H1WPPiRFXl7ujDupOPKCd2hclya3S8pyUys8Mf78EbBjyNRMrufPfs0
         5U/nJpwDfxNqPDK3zNEh4UEUyFbCPYZXxHqf8sJiwwZIvoD/yGVMcyYFOxGsM3HUusGa
         Z+5XUQ2AmJoBZUlVg6YkM2dEmkcNAtWQ1bXXfU9u6BhqspduxlFELBzsWN2VakeFOAeO
         dvuA==
X-Gm-Message-State: AOAM532dKpbTSko70+oTWXp92tjkz/cGqkddemPFK3ImLn2JQGW679Br
        d6dl7t75olwW6yqYil8MRlg=
X-Google-Smtp-Source: ABdhPJyFIpvymbjP/cx3Hf/lzyAEnXFIEh9zgIKWQ7MQZ37BAEeBKLPkMD6xJCja74zZgpUa2OiXOg==
X-Received: by 2002:a05:6512:2184:: with SMTP id b4mr4319109lft.288.1634205720218;
        Thu, 14 Oct 2021 03:02:00 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id r10sm219331ljg.10.2021.10.14.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 03:01:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 14 Oct 2021 12:01:57 +0200
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
Message-ID: <20211014100157.GA1844@pc638.lan>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928121040.2547407-1-chenwandun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:10:40PM +0800, Chen Wandun wrote:
> Eric Dumazet reported a strange numa spreading info in [1], and found
> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> this issue [2].
> 
> Dig into the difference before and after this patch, page allocation has
> some difference:
> 
> before:
> alloc_large_system_hash
>     __vmalloc
>         __vmalloc_node(..., NUMA_NO_NODE, ...)
>             __vmalloc_node_range
>                 __vmalloc_area_node
>                     alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
>                         alloc_pages_current
>                             alloc_page_interleave /* can be proved by print policy mode */
> 
> after:
> alloc_large_system_hash
>     __vmalloc
>         __vmalloc_node(..., NUMA_NO_NODE, ...)
>             __vmalloc_node_range
>                 __vmalloc_area_node
>                     alloc_pages_node /* choose nid by nuam_mem_id() */
>                         __alloc_pages_node(nid, ....)
> 
> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> it will allocate memory in current node instead of interleaving allocate
> memory.
> 
> [1]
> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
> 
> [2]
> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
> 
> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f884706c5280..48e717626e94 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int nr_allocated = 0;
> +	struct page *page;
> +	int i;
>  
>  	/*
>  	 * For order-0 pages we make use of bulk allocator, if
> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	if (!order) {
>  		while (nr_allocated < nr_pages) {
>  			unsigned int nr, nr_pages_request;
> +			page = NULL;
>  
>  			/*
>  			 * A maximum allowed request is hard-coded and is 100
> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			 */
>  			nr_pages_request = min(100U, nr_pages - nr_allocated);
>  
> -			nr = alloc_pages_bulk_array_node(gfp, nid,
> -				nr_pages_request, pages + nr_allocated);
> -
> +			if (nid == NUMA_NO_NODE) {
>
<snip>
void *vmalloc(unsigned long size)
{
	return __vmalloc_node(size, 1, GFP_KERNEL, NUMA_NO_NODE,
		__builtin_return_address(0));
}
EXPORT_SYMBOL(vmalloc);
<snip>

vmalloc() uses NUMA_NO_NODE, so all vmalloc calls will be reverted to a single
page allocator for NUMA and non-NUMA systems. Is it intentional to bypass the
optimized bulk allocator for non-NUMA systems? 

Thanks!

--
Vlad Rezki
