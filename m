Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050F03521A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhDAV2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhDAV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:27:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE73A610F8;
        Thu,  1 Apr 2021 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617312479;
        bh=3Y8IHyeyNgtYWxflsGZGyDyumCRblrORTkW7c6t9Id4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCNlrFTBsd2t6T4pRn0wAlwhHcX8cosB5MR7xPMMYP3FmAnty7fnBzx3CU6pAmzxM
         EWumOw76rN2SSz+ZJGkRJkqaHx1+XkpEpmlqk04Dc7rCa9Fr2GR4qyu0dZEZZm3kDI
         DlKnbOQTosVX4o4mLTasmdGDsSMor3kXJUl6tQYywrcPLLOoNfpeIjNYT/dm6DZRXj
         DtX6KftCwieFNYHcEco7U3Pzr/ARdmENMKDT6PElJhTvzqT09OAI9Xi2n6lbuHgH76
         PKG1ZB8tvKHMV0IZO05YarK3XXf6JDzsvnVkkTkMlqP/tq8jWz1zGrmfAXqX4j+xme
         iAeC6R5syoEhA==
Date:   Fri, 2 Apr 2021 06:27:53 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [bug report] node: Add memory-side caching attributes
Message-ID: <20210401212753.GB31698@redsun51.ssa.fujisawa.hgst.com>
References: <YGWLtzMLqSW4cxma@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGWLtzMLqSW4cxma@mwanda>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:00:39PM +0300, Dan Carpenter wrote:
> Hi Keith,
> 
> I've been trying to figure out ways Smatch can check for device managed
> resources.  Like adding rules that if we call dev_set_name(&foo->bar)
> then it's device managaged and if there is a kfree(foo) without calling
> device_put(&foo->bar) then that's a resource leak.
> 
> Of course one of the rules is that if you call device_register(dev) then
> you can't kfree(dev), it has to released with device_put(dev) and that's
> true even if the register fails.  But this code here feels very
> intentional so maybe there is an exception to the rule?

Thanks for the notice. There was no intentional use of this, so I
think it was a mistake. The proposal in the follow on replies looks much
better.
 
> The patch acc02a109b04: "node: Add memory-side caching attributes"
> from Mar 11, 2019, leads to the following static checker warning:
> 
> 	drivers/base/node.c:285 node_init_cache_dev()
> 	error: kfree after device_register(): 'dev'
> 
> drivers/base/node.c
>    263  static void node_init_cache_dev(struct node *node)
>    264  {
>    265          struct device *dev;
>    266  
>    267          dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>    268          if (!dev)
>    269                  return;
>    270  
>    271          dev->parent = &node->dev;
>    272          dev->release = node_cache_release;
>    273          if (dev_set_name(dev, "memory_side_cache"))
>    274                  goto free_dev;
>    275  
>    276          if (device_register(dev))
>                     ^^^^^^^^^^^^^^^^^^^
>    277                  goto free_name;
>    278  
>    279          pm_runtime_no_callbacks(dev);
>    280          node->cache_dev = dev;
>    281          return;
>    282  free_name:
>    283          kfree_const(dev->kobj.name);
>    284  free_dev:
>    285          kfree(dev);
>                 ^^^^^^^^^^
>    286  }
> 
> regards,
> dan carpenter
