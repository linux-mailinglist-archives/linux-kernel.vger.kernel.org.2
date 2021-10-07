Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10789424CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhJGF1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGF1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:27:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B6B06120D;
        Thu,  7 Oct 2021 05:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633584312;
        bh=bD5PfoEo/tEYlEn8Ehu6qpmPGIYWbDXQp6oPPjygNFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsPZWJifT+sYj6zmxfKZ+ZGfxMjSLlehEpmcTQMgv0X6MXKP2f8YGlVr53D17c9z2
         xNUU/PQbBTBXWbvQ6fIlQZRj1y0G5/sB0iBM7/Xd9IaOEBV6sAh6z44QqNG3R5FwOp
         wdcesGlLyp3Dyofm01Q+TAcv1J9NFoxcb1oilmro=
Date:   Thu, 7 Oct 2021 07:25:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] of: add self parameter to
 __of_sysfs_remove_bin_file()
Message-ID: <YV6EtWyHZNbc3InD@kroah.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-5-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007000954.30621-5-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:09:49PM -0700, Zev Weiss wrote:
> This allows using the function to remove a bin_attribute from that
> attribute's own methods (by calling sysfs_remove_bin_file_self()
> instead of sysfs_remove_bin_file()).
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/of/kobj.c       | 13 ++++++++-----
>  drivers/of/of_private.h |  2 +-
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
> index 6675b5e56960..06d6c90f7aa1 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -84,12 +84,15 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
>  	return rc;
>  }
>  
> -void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop)
> +void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop, bool self)
>  {
>  	if (!IS_ENABLED(CONFIG_SYSFS))
>  		return;
>  
> -	sysfs_remove_bin_file(&np->kobj, &prop->attr);
> +	if (self)
> +		sysfs_remove_bin_file_self(&np->kobj, &prop->attr);
> +	else
> +		sysfs_remove_bin_file(&np->kobj, &prop->attr);
>  	kfree(prop->attr.attr.name);
>  }
>  
> @@ -97,7 +100,7 @@ void __of_remove_property_sysfs(struct device_node *np, struct property *prop)
>  {
>  	/* at early boot, bail here and defer setup to of_init() */
>  	if (of_kset && of_node_is_attached(np))
> -		__of_sysfs_remove_bin_file(np, prop);
> +		__of_sysfs_remove_bin_file(np, prop, false);
>  }
>  
>  void __of_update_property_sysfs(struct device_node *np, struct property *newprop,
> @@ -108,7 +111,7 @@ void __of_update_property_sysfs(struct device_node *np, struct property *newprop
>  		return;
>  
>  	if (oldprop)
> -		__of_sysfs_remove_bin_file(np, oldprop);
> +		__of_sysfs_remove_bin_file(np, oldprop, false);
>  	__of_add_property_sysfs(np, newprop);
>  }
>  
> @@ -157,7 +160,7 @@ void __of_detach_node_sysfs(struct device_node *np)
>  	/* only remove properties if on sysfs */
>  	if (of_node_is_attached(np)) {
>  		for_each_property_of_node(np, pp)
> -			__of_sysfs_remove_bin_file(np, pp);
> +			__of_sysfs_remove_bin_file(np, pp, false);
>  		kobject_del(&np->kobj);
>  	}
>  
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 75e67b8bb826..fff157c63907 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -134,7 +134,7 @@ extern int __of_update_property(struct device_node *np,
>  extern void __of_detach_node(struct device_node *np);
>  
>  extern void __of_sysfs_remove_bin_file(struct device_node *np,
> -				       struct property *prop);
> +                                       struct property *prop, bool selfremove);

Ick, no, now you have to go and find the function declaration every time
you see this called.  Adding random boolean flags to functions is not
how to make an api that works well, sorry.

greg k-h
