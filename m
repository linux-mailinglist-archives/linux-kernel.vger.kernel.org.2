Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23E9406720
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhIJGRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJGRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:17:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA69A611B0;
        Fri, 10 Sep 2021 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631254559;
        bh=I9jfoZPzgk5wgindVIV+Rty1kIvDXNjltpXvOCUC4LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smqJnTAIi6gpQGZmfdJk4Xa0pEas3D5h9xKu3DiAwL2kziBEwvDN+rPnEE7nouI+j
         YTRMBLod9zPsjBLvj7TUdnvYNaTOs4uCUoRqo1qr6p+YF2r+3i27F5HSgcJAmV5GES
         lgk6Lz2gSN6yk51PdD8TwQ0J4HNla6DmEfviK49s=
Date:   Fri, 10 Sep 2021 08:15:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andre Muller <andre.muller@web.de>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: Disable fw_devlink DT support for X86
Message-ID: <YTr4CZW+rOXAjNq9@kroah.com>
References: <20210910011446.3208894-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910011446.3208894-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 06:14:45PM -0700, Saravana Kannan wrote:
> Andre reported fw_devlink=on breaking OLPC XO-1.5 [1].
> 
> OLPC XO-1.5 is an X86 system that uses a mix of ACPI and OF to populate
> devices. The root cause seems to be ISA devices not setting their fwnode
> field. But trying to figure out how to fix that doesn't seem worth the
> trouble because the OLPC devicetree is very sparse/limited and fw_devlink
> only adds the links causing this issue. Considering that there aren't many
> users of OF in an X86 system, simply fw_devlink DT support for X86.
> 
> [1] - https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/
> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Andre Muller <andre.muller@web.de>
> ---
>  drivers/of/property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 0c0dc2e369c0..3fd74bb34819 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1444,6 +1444,9 @@ static int of_fwnode_add_links(struct fwnode_handle *fwnode)
>  	struct property *p;
>  	struct device_node *con_np = to_of_node(fwnode);
>  
> +	if (IS_ENABLED(CONFIG_X86))
> +		return 0;

I love it :)

Anyway, getting a "Tested-by:" would be great to have here.  Andre, can
you verify this solves your issue?

thanks,

greg k-h
