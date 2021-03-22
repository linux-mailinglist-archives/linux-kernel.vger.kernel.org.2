Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99884345277
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCVWgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCVWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:36:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93FDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:36:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r20so23123339ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mpzmIKAPcKhQtzYyIXUYOF1ItUjRTXPYExMYO0CNpAI=;
        b=q59dRq8LPT5NuAXozTLhzFs3UUJSV2/CImjHV8aNWVexC0NDwlOQX/AFa1Qrv36oOI
         QO5eeW/PSFktIY8/B4zFarq8YT0di8kKJq6F1SGRsZ4eM41+zex+MWlUt/tB6XV7aHl0
         Xk/8t34XWyfleOj3DNd8NDx+PWaAL98jqV50rwbMIkS//ZjXdd1ua63JsmLBxAiiqVSB
         2o7kvDEV18WlmSksxl68V/Nw3MqHwKMZjwAM01h5Cpgp6gXC4Vu3gRWemvXJrzT2LPQb
         CLkzw2TZ02kvhAgJ0XNHrVbUj1yx09J9NjU3CBblhKDOkmPkYhO4vmyN/AD4jZch0PwD
         Byng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mpzmIKAPcKhQtzYyIXUYOF1ItUjRTXPYExMYO0CNpAI=;
        b=AcC4hxgDlKVpJBRTLao7WpDKxpLhPMP7RPxTCdsVsHZ4mBziiEOqX/8h86dEoWMXgL
         cjxahzhU67nfs6j92Y9ZJXT5I1eZY9CLyEFSo5OhePaFDkRcaGxLGseFA3phD3UvsAsq
         X0AzGMLmDsbqfCfXe9JmQAR9wmj8wLqYq418+93IFg/tTrvJM12j5Uj5mEzTRZ9kzuNr
         tGNM6WqKHbAGfkCvPGLF6d/nbEzXLdg9fnuocSM6FW0QXSkXTb17PdlVWlR5SdwplYzj
         Izl6BvsUDqcoQ+TOm1FRLkrF81FV0tKAUacpe49puar11YikpNtd1OE9HlhZR9hICBw8
         7hcg==
X-Gm-Message-State: AOAM5338LYLPDzIeJR1THnFM62xIiL4Cm3IEQGq0ANm6WfIhEiieQLTf
        N0EIcFodnxmTKK+w6Zu04ls5C/cNrf4AcA==
X-Google-Smtp-Source: ABdhPJxNI0elgQQ7M2BGp1dyNfIDJPJd/GPCp8n8ASfqTPsAJxhFII+j3AOf6mTTvPEHmq/BdPWcQw==
X-Received: by 2002:a2e:8541:: with SMTP id u1mr983993ljj.446.1616452582040;
        Mon, 22 Mar 2021 15:36:22 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i12sm1199593lfv.220.2021.03.22.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:36:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 22 Mar 2021 23:36:19 +0100
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: Use kvmalloc to allocate the table of
 pages
Message-ID: <20210322223619.GA56503@pc638.lan>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322193820.2140045-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:38:20PM +0000, Matthew Wilcox (Oracle) wrote:
> If we're trying to allocate 4MB of memory, the table will be 8KiB in size
> (1024 pointers * 8 bytes per pointer), which can usually be satisfied
> by a kmalloc (which is significantly faster).  Instead of changing this
> open-coded implementation, just use kvmalloc().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/vmalloc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 96444d64129a..32b640a84250 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2802,13 +2802,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		gfp_mask |= __GFP_HIGHMEM;
>  
>  	/* Please note that the recursion is strictly bounded. */
> -	if (array_size > PAGE_SIZE) {
> -		pages = __vmalloc_node(array_size, 1, nested_gfp, node,
> +	pages = kvmalloc_node_caller(array_size, nested_gfp, node,
>  					area->caller);
> -	} else {
> -		pages = kmalloc_node(array_size, nested_gfp, node);
> -	}
> -
>  	if (!pages) {
>  		free_vm_area(area);
>  		return NULL;
> -- 
> 2.30.2
Makes sense to me. Though i expected a bigger difference:

# patch
single CPU, 4MB allocation, loops: 1000000 avg: 85293854 usec

# default
single CPU, 4MB allocation, loops: 1000000 avg: 89275857 usec

One question. Should we care much about fragmentation? I mean
with the patch, allocations > 2MB will do request to SLAB bigger
then PAGE_SIZE.

Thanks!

--
Vlad Rezki
