Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D2730B3AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBAXpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBAXpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:45:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:44:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e12so1926104pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwm6mluZA5z9j5m60X7bcq1KDPR0kK7jE0BbvE8y0SA=;
        b=zPvtRhY8I6xZhECNQRtxMIuGfx13gF4xR1FwvDj3y/r4s6hy2esITYebzwYaiNPkMF
         3Mqr3aNVKTd6mMRWz6CagJxYOVTWq4vXsnKQwl4mv531lgd1bm4OOGYkfHxj1II3Sgs6
         kgkN3T5V1B1tXq+1qUhwmtNcEYE7GXbkZC5N4nYz2s2pI269IK9Dy/NGtCL5Tu7/uQf4
         VJhA3fK31DPiS1Jq38zUlaS7KeYvaUg4jjlQ8rS6IDBUmVl6Mc1J5g6hEVcGyX0SxXDz
         8ehmHsDyK0sFzcjgJLlDgZZtDiCEVyjNyOKXtxPjqC17RHLTTYo4bTyqLlb6+ODuAdOO
         L8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwm6mluZA5z9j5m60X7bcq1KDPR0kK7jE0BbvE8y0SA=;
        b=EPBDLlbpCIXpUFxooDXns1jAHIHD2YX7CCH4k6tVUHRrdY4zcAIuyFa2gcuh4MKl0q
         pjX45cNHDRjAxENbAg6di1rygSx9PMwoz7wm7n7KZL63Kky9kFkSXOIyeCQieysjIgdG
         AYwlM25760LqIJzKBLdiCHUGCdxYnwKCg7RW+r1CN0L878xkVBEIgDg86NwoC88UsQy9
         XWpWK19D929f7ThmYjH1bj2IOMnChefDJtjRVtMhVjYU7/iP1RLxpSxEHHBchZbxRzdk
         l17US0vZ65AQ93QJEouMZoaq4hvBFZHAmUSxiu191v9y/yiNKp4RpPN3AEh5pr3W1Rna
         o2vg==
X-Gm-Message-State: AOAM531F1K7jDj35BVW/SuetImaUTquts1rQKLqEX6lhLoKiYecAbyK9
        Pozr+BqcoMNusGToQP7Bk3Fttg==
X-Google-Smtp-Source: ABdhPJxBU043CZGZI8fRbH2HsQrhXMmtUPQ7rnAVcDNrNRrS3Q/L54u4bE8a6bj3tFWn/tEbHg4f7Q==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr1279309pjb.18.1612223074311;
        Mon, 01 Feb 2021 15:44:34 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c23sm20513453pgc.72.2021.02.01.15.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:44:33 -0800 (PST)
Date:   Mon, 1 Feb 2021 16:44:31 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/14] coresight: Do not scan for graph if none is
 present
Message-ID: <20210201234431.GC1475392@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-3-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:26PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> If a graph node is not found for a given node, of_get_next_endpoint()
> will emit the following error message :
> 
>  OF: graph: no port node found in /<node_name>
> 
> If the given component doesn't have any explicit connections (e.g,
> ETE) we could simply ignore the graph parsing.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3629b78..c594f45 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -90,6 +90,12 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
>  	struct of_endpoint endpoint;
>  	int in = 0, out = 0;
>  
> +	/*
> +	 * Avoid warnings in of_graph_get_next_endpoint()
> +	 * if the device doesn't have any graph connections
> +	 */
> +	if (!of_graph_is_present(node))
> +		return;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	do {
>  		ep = of_graph_get_next_endpoint(node, ep);
>  		if (!ep)
> -- 
> 2.7.4
> 
