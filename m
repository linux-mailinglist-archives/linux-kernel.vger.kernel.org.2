Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56EB30B99B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBBIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:25:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:51121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232523AbhBBIYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:24:41 -0500
IronPort-SDR: 1QlUrpF0fd4A/GWXDjMR1Bz8RVSrnG4C2JTUWUA7MuEaHqRx318GLby5J/UD6SO0s5PlEOJnPV
 pCFyDuSnP0pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="178257683"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="178257683"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:22:52 -0800
IronPort-SDR: gwp8W19RtNF1YXGS7OUro+/XLRGEhfV2dOwxMUDfgV8wvVwqvM/74C9TBxYgTHBFDBGXRQ3uht
 9qRkaWLFcB4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479481915"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 00:22:48 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:22:48 +0200
Date:   Tue, 2 Feb 2021 10:22:48 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: typec: tcpm: Get Sink VDO from fwnode
Message-ID: <20210202082248.GC1433721@kuha.fi.intel.com>
References: <20210201133421.408508-1-kyletso@google.com>
 <20210201133421.408508-4-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201133421.408508-4-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:34:21PM +0800, Kyle Tso wrote:
> Commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config
> configuration mechanism") removed the tcpc_config which includes the
> Sink VDO and it is not yet added back with fwnode. Add it now.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v2:
> - use fwnode_property_count_u32 instead to get the count
> - revise the error handling
> 
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 979b7ee6473c..9b13e19118f0 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5677,6 +5677,20 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  			port->new_source_frs_current = frs_current;
>  	}
>  
> +	/* sink-vdos is optional */
> +	ret = fwnode_property_count_u32(fwnode, "sink-vdos");
> +	if (ret < 0)
> +		ret = 0;
> +
> +	port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
> +	if (port->nr_snk_vdo) {
> +		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos",
> +						     port->snk_vdo,
> +						     port->nr_snk_vdo);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
