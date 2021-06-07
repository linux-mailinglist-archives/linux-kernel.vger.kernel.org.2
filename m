Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039C839D8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFGJZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:25:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:45272 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFGJZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:25:40 -0400
IronPort-SDR: qtv97T5fLMlaa/dX6JPQaO3UKVBv2ySlMolfmyhFBBMoZMTtoVoMF0bX19TbHdHdizCrJob3kw
 XCcAIjGwATKA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="191699129"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="191699129"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:23:49 -0700
IronPort-SDR: E/b5jD69XqAgN7vOgsO9bOabpwL61YCNhJxGQ0CuzmFzc5neVxPc2fTSPBk3ImE4Pui9olj04h
 l8N0rblgc/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="551816907"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jun 2021 02:23:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Jun 2021 12:23:46 +0300
Date:   Mon, 7 Jun 2021 12:23:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: intel_pmc_mux: Put fwnode in error
 case during ->probe()
Message-ID: <YL3lomK79iIuE13f@kuha.fi.intel.com>
References: <20210606200911.32076-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606200911.32076-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 11:09:09PM +0300, Andy Shevchenko wrote:
> device_get_next_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 46a25b8db72e..134325444e6a 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -645,6 +645,7 @@ static int pmc_usb_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_remove_ports:
> +	fwnode_handle_put(fwnode);

Wouldn't it be more clear to do that in the condition that jumps to
this lable?

>  	for (i = 0; i < pmc->num_ports; i++) {
>  		typec_switch_unregister(pmc->port[i].typec_sw);
>  		typec_mux_unregister(pmc->port[i].typec_mux);
> -- 
> 2.31.1

-- 
heikki
