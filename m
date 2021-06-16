Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18393AA3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFPTEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhFPTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:04:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D53C061574;
        Wed, 16 Jun 2021 12:02:33 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x196so3592574oif.10;
        Wed, 16 Jun 2021 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOqLQQmsoCxqiYwODGOxvwScag2+ijPfJja63uXJkvM=;
        b=QKlM7nFUoB6J9K6LCVtW4wLxrfvSkz/9/nDxNyxDziZoJE7UBptRchMsuVPPsv/Hh6
         0hoMsU+kE/siiKIoEARnj+zwFE8PmjgdODBmhLSDyKIQnUHb5mT7rlhid2dRz4RZKI/1
         vm4AD/ORdZWtQjEHXa03hMC9KsTCZM+Vu+kDID2Vzbbo1Zy1tCzn9xoJLK9bGpIWQ0M3
         X/Hvi9oD4cMfRkNHQ7PZvIQb4wcnbP5lJsan/SoaGrXV6dn7us3t/odsNRmWZL50gXrH
         tXos9ISMyX0/UUW/opRzLItk0oDWUNvFsoT4dfNaFMLJ19g29AeyElaIe2MR1hrrlcVG
         VX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=UOqLQQmsoCxqiYwODGOxvwScag2+ijPfJja63uXJkvM=;
        b=YjQa/OCv5374ugRtSavGSg4napRZ+R8w1mZCMf1GlOKAX1HqqGmKzaGgAP6yuaQZ84
         NLc4/HNkE7lcI4qFBnu2CHCYKyCDRuFG/3s3b1mc5QM2qPj1KeOrA0RK28XSEr8kpEhR
         uJh4MuKQMWSiAaEdhpBtJ+0xudJwL7b274TxG+vFTJ+3+t63n3hEd65t582NWX/FRsRg
         n89gIhHedEG1lKIEvmcIcNNZ13BBovkluzy+zLG5VOi322HIETfiga/XUt1Vv4nJDTkz
         qxL9gGE5N2hRywsxm1STMzpLik7VIrzFoQLjJAz6ebKqgmJEtb1UhS+Clgaat9vZHStM
         fXGA==
X-Gm-Message-State: AOAM532GWQGENa4VIQL0ajb7t0MT5/Q/H+RaKo7TeCdiPpJWewSNaSbK
        faNajjUkyFhR/zCdGYXDBg==
X-Google-Smtp-Source: ABdhPJzogjBWC3Po3+HvkfTYzT7IZOBBIi2tfx6vpj5GURwwDUR39OAgLN+pokD5M0qf1LT+kBQ+bQ==
X-Received: by 2002:aca:281a:: with SMTP id 26mr8138043oix.142.1623870152808;
        Wed, 16 Jun 2021 12:02:32 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id p9sm694118otl.64.2021.06.16.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:02:31 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:742a:6ad4:30ea:e332])
        by serve.minyard.net (Postfix) with ESMTPSA id B2FF61800E7;
        Wed, 16 Jun 2021 19:02:30 +0000 (UTC)
Date:   Wed, 16 Jun 2021 14:02:29 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ipmi: kcs_bmc_aspeed: Fix less than zero
 comparison of a unsigned int
Message-ID: <20210616190229.GG2921206@minyard.net>
Reply-To: minyard@acm.org
References: <20210616162913.15259-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616162913.15259-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:29:13PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The comparisons of the unsigned int hw_type to less than zero always
> false because it is unsigned. Fix this by using an int for the
> assignment and less than zero check.

Thanks, I added this to my tree.

-corey

> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 9d2df9a0ad80 ("ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 0401089f8895..92a37b33494c 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -301,13 +301,15 @@ static inline int aspeed_kcs_map_serirq_type(u32 dt_type)
>  static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u32 dt_type)
>  {
>  	unsigned int mask, val, hw_type;
> +	int ret;
>  
>  	if (id > 15)
>  		return -EINVAL;
>  
> -	hw_type = aspeed_kcs_map_serirq_type(dt_type);
> -	if (hw_type < 0)
> -		return hw_type;
> +	ret = aspeed_kcs_map_serirq_type(dt_type);
> +	if (ret < 0)
> +		return ret;
> +	hw_type = ret;
>  
>  	priv->upstream_irq.mode = aspeed_kcs_irq_serirq;
>  	priv->upstream_irq.id = id;
> -- 
> 2.31.1
> 
