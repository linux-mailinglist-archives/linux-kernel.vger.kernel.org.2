Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6834CCDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhC2JSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:18:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:52099 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhC2JR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:17:59 -0400
IronPort-SDR: 8MX/MkC9shFS5oXmITAaif6xrI76nha+TwQLFVj5WxsYQD7VULc4NezVrAUVSyNDgfpNqdXV3/
 Sn5407NhOHyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190976657"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190976657"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 02:17:56 -0700
IronPort-SDR: 2wxvuMx1l59N3ZARCpy+VZOZia7xxgEOPNrZwKOiLN3ifc2JTOGJgqKNY5vn2hbJMQ+/wgNYCM
 YACMdPUVfTTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="515930898"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 29 Mar 2021 02:17:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Mar 2021 12:17:52 +0300
Date:   Mon, 29 Mar 2021 12:17:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] usb: typec: Link all ports during connector
 registration
Message-ID: <YGGbQA/mIAu2JUWs@kuha.fi.intel.com>
References: <20210329084426.78138-1-heikki.krogerus@linux.intel.com>
 <20210329084426.78138-7-heikki.krogerus@linux.intel.com>
 <YGGUU2z0qHsfgKrV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGGUU2z0qHsfgKrV@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 10:48:19AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Mar 29, 2021 at 11:44:26AM +0300, Heikki Krogerus wrote:
> > +#ifdef CONFIG_USB
> 
> This feels odd in a file under drivers/usb/ is it still relevant?  Will
> this code get built for non-USB systems (i.e. gadget only?)

Yes, later. The typec connector class can not depend on CONFIG_USB for
sure.

> > +static int each_port(struct device *port, void *connector)
> > +{
> > +	struct port_node *node;
> > +	int ret;
> > +
> > +	node = create_port_node(port);
> > +	if (IS_ERR(node))
> > +		return PTR_ERR(node);
> > +
> > +	if (!connector_match(connector, node)) {
> > +		remove_port_node(node);
> > +		return 0;
> > +	}
> > +
> > +	ret = link_port(to_typec_port(connector), node);
> > +	if (ret) {
> > +		remove_port_node(node->pld);
> > +		return ret;
> > +	}
> > +
> > +	get_device(connector);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +int typec_link_ports(struct typec_port *con)
> > +{
> > +	int ret = 0;
> > +
> > +	con->pld = get_pld(&con->dev);
> > +	if (!con->pld)
> > +		return 0;
> > +
> > +#ifdef CONFIG_USB
> > +	ret = usb_for_each_port(&con->dev, each_port);
> > +	if (ret)
> > +		typec_unlink_ports(con);
> 
> If you have proper #ifdef for CONFIG_USB in the .h file, then there's no
> need for the #ifdef in the .c file.

We could do that now, but we will have to move the ifdef back to the
C file the moment we add support for Thunderbolt ports and/or
DisplayPorts.

I could make a stub for the usb_for_each_port() function in case
CONFIG_USB is not enable. Would that work?


thanks,

-- 
heikki
