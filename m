Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077793C6CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhGMJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:01:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:52516 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234121AbhGMJBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:01:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="209942193"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="209942193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 01:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="570222387"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Jul 2021 01:58:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Jul 2021 11:58:11 +0300
Date:   Tue, 13 Jul 2021 11:58:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>
Cc:     gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        kernel@puri.sm, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: Don't block probing of consumer of
 "connector" nodes
Message-ID: <YO1VowaJ1Impm1U7@kuha.fi.intel.com>
References: <20210713073946.102501-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713073946.102501-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rafael, Saravana

On Tue, Jul 13, 2021 at 09:39:46AM +0200, Martin Kepplinger wrote:
> Similar as with tcpm this patch lets fw_devlink know not to wait on the
> fwnode to be populated as a struct device.
> 
> Without this patch, USB functionality can be broken on some previously
> supported boards.
> 
> Fixes: 28ec344bb891 ("usb: typec: tcpm: Don't block probing of consumers of "connector" nodes")

That patch has gone under my radar.

> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> hi,
> 
> at least the boards based on imx8mq-librem5.dtsi suffer from this, possibly
> more.
> 
> thanks,
>                            martin
> 
> 
>  drivers/usb/typec/tipd/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 938219bc1b4b..b31aaf57eb3b 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -629,6 +629,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (!fwnode)
>  		return -ENODEV;
>  
> +	fw_devlink_purge_absent_suppliers(fwnode);

Why do we have to care about this kind of stuff in the drivers? It
sounds like something that only affects DT platforms, so why isn't
this being fixed in the DT core code?

I didn't have time to study this fw_deflink thing yet, it is
completely new to me and unfortunately I'm going on vacation now, but
it looks like something that has been added to the driver core in a
haste without enough thinking, and which is now causing problems. Not
cool.


thanks,

-- 
heikki
