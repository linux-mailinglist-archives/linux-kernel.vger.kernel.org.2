Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AB235EEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349854AbhDNICi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:02:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:23227 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349802AbhDNIC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:02:26 -0400
IronPort-SDR: myK2LQvL6bzKV5diamIQlQHnkcKwmW2OLWwMeCTp2TMOP6UxAD7yD9UrbCAQzj/eDK5WVuxhnB
 UIuz9zQriN/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="181712120"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="181712120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 01:02:03 -0700
IronPort-SDR: nN1X+UEKOplLFKzfT759Vd3nykvmMnaZu7r3/pxh0eZk+y5mEBfkdcMwviSGdrx09SRT5f+zmT
 /ocFhmwQeIfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="521907223"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2021 01:02:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Apr 2021 11:01:59 +0300
Date:   Wed, 14 Apr 2021 11:01:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: silence a static checker warning
Message-ID: <YHahdwkU9A4AVv5T@kuha.fi.intel.com>
References: <YHadaACH8Mq/10F7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHadaACH8Mq/10F7@mwanda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:44:40AM +0300, Dan Carpenter wrote:
> Smatch complains about a potential missing error code:
> 
>     drivers/usb/typec/port-mapper.c:168 typec_link_port()
>     warn: missing error code 'ret'
> 
> This is a false positive and returning zero is intentional.  Let's
> re-arrange the code to silence the warning and make the intent more
> clear.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/port-mapper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
> index fae736eb0601..9b0991bdf391 100644
> --- a/drivers/usb/typec/port-mapper.c
> +++ b/drivers/usb/typec/port-mapper.c
> @@ -157,15 +157,17 @@ int typec_link_port(struct device *port)
>  {
>  	struct device *connector;
>  	struct port_node *node;
> -	int ret = 0;
> +	int ret;
>  
>  	node = create_port_node(port);
>  	if (IS_ERR(node))
>  		return PTR_ERR(node);
>  
>  	connector = find_connector(node);
> -	if (!connector)
> +	if (!connector) {
> +		ret = 0;
>  		goto remove_node;
> +	}
>  
>  	ret = link_port(to_typec_port(connector), node);
>  	if (ret)
> -- 
> 2.30.2

thanks,

-- 
heikki
