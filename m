Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69A43CB581
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhGPJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:59:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:16010 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234095AbhGPJ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:59:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210519879"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="210519879"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 02:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="573620581"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Jul 2021 02:56:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 16 Jul 2021 12:56:31 +0300
Date:   Fri, 16 Jul 2021 12:56:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     saravanak@google.com, grandmaster@al2klimov.de,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tipd: Don't block probing of consumer of
 "connector" nodes
Message-ID: <YPFXz2yqDsGA1xK5@kuha.fi.intel.com>
References: <20210714061807.5737-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714061807.5737-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 14, 2021 at 08:18:07AM +0200, Martin Kepplinger kirjoitti:
> Similar as with tcpm this patch lets fw_devlink know not to wait on the
> fwnode to be populated as a struct device.
> 
> Without this patch, USB functionality can be broken on some previously
> supported boards.
> 
> Fixes: 28ec344bb891 ("usb: typec: tcpm: Don't block probing of consumers of "connector" nodes")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> revision history
> ----------------
> v2: (thank you Saravana)
> * add a code-comment why the call is needed.
> 
> v1:
> https://lore.kernel.org/linux-usb/20210713073946.102501-1-martin.kepplinger@puri.sm/
> 
> 
> 
>  drivers/usb/typec/tipd/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 938219bc1b4b..21b3ae25c76d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -629,6 +629,15 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (!fwnode)
>  		return -ENODEV;
>  
> +	/*
> +	 * This fwnode has a "compatible" property, but is never populated as a
> +	 * struct device. Instead we simply parse it to read the properties.
> +	 * This breaks fw_devlink=on. To maintain backward compatibility
> +	 * with existing DT files, we work around this by deleting any
> +	 * fwnode_links to/from this fwnode.
> +	 */
> +	fw_devlink_purge_absent_suppliers(fwnode);
> +
>  	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
>  	if (IS_ERR(tps->role_sw)) {
>  		ret = PTR_ERR(tps->role_sw);
> -- 
> 2.30.2

-- 
heikki
