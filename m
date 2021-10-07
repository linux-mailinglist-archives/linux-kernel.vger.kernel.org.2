Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE552424CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbhJGF15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGF14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:27:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 114C9611AE;
        Thu,  7 Oct 2021 05:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633584363;
        bh=x2wFVdUzumwx8hHL6zp2elbESyJKKZzYQG0HU/tZB1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/pkgEaTeWzw2a8Cu+KPDGJAkOrrQrygbcIN4qtbPTxnrBn4FHdvUDlfAjur/Z4mO
         Yolqun6+sbUA+RIUGzDdfMWuibYw+5MTJoHSO/ilUb57a5vBM8iAc3Op7Plm/mt0cO
         p2Ts9mdZAgiQh4PVkvEkIpHzibzZD3YT7xmLYYSE=
Date:   Thu, 7 Oct 2021 07:26:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] of: add self parameter to of_update_property()
Message-ID: <YV6E6UcMEOyNCXqW@kroah.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-6-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007000954.30621-6-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:09:50PM -0700, Zev Weiss wrote:
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -64,7 +64,7 @@ int of_node_is_attached(struct device_node *node);
>  int __of_add_property_sysfs(struct device_node *np, struct property *pp);
>  void __of_remove_property_sysfs(struct device_node *np, struct property *prop);
>  void __of_update_property_sysfs(struct device_node *np, struct property *newprop,
> -		struct property *oldprop);
> +		struct property *oldprop, bool self);

Again, not a good api decision at all

thanks,

greg k-h
