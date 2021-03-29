Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF934CCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhC2JF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235017AbhC2IsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8E760C3D;
        Mon, 29 Mar 2021 08:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617007701;
        bh=baL2fwTMgDV75uddWJ1taeRq8hRMlb2FDh7MuIvvNU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXQYbjFnYc4Ioiel0Psot6s3Bh+uLI0MGjd7mnIQQlhFUzJTjTH3dPGKXkH9zyhaP
         UIJCkRtHNdoC73mkku/cwzRclNrWkU8XgK9TvCBnIafFGCVBfaWE6Rg7DkRcmeKRy7
         eosJI5/BfK4hnyMK2PteaYsRXP0Z+PRBQbTRY0sI=
Date:   Mon, 29 Mar 2021 10:48:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] usb: typec: Link all ports during connector
 registration
Message-ID: <YGGUU2z0qHsfgKrV@kroah.com>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
 <20210329084426.78138-7-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329084426.78138-7-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:44:26AM +0300, Heikki Krogerus wrote:
> +#ifdef CONFIG_USB

This feels odd in a file under drivers/usb/ is it still relevant?  Will
this code get built for non-USB systems (i.e. gadget only?)

> +static int each_port(struct device *port, void *connector)
> +{
> +	struct port_node *node;
> +	int ret;
> +
> +	node = create_port_node(port);
> +	if (IS_ERR(node))
> +		return PTR_ERR(node);
> +
> +	if (!connector_match(connector, node)) {
> +		remove_port_node(node);
> +		return 0;
> +	}
> +
> +	ret = link_port(to_typec_port(connector), node);
> +	if (ret) {
> +		remove_port_node(node->pld);
> +		return ret;
> +	}
> +
> +	get_device(connector);
> +
> +	return 0;
> +}
> +#endif
> +
> +int typec_link_ports(struct typec_port *con)
> +{
> +	int ret = 0;
> +
> +	con->pld = get_pld(&con->dev);
> +	if (!con->pld)
> +		return 0;
> +
> +#ifdef CONFIG_USB
> +	ret = usb_for_each_port(&con->dev, each_port);
> +	if (ret)
> +		typec_unlink_ports(con);

If you have proper #ifdef for CONFIG_USB in the .h file, then there's no
need for the #ifdef in the .c file.

thanks,

greg k-h
