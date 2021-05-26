Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E42391088
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhEZGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:25:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:10813 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhEZGZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:25:30 -0400
IronPort-SDR: b3NIAJCBPwgcVNYbRbHtxcoQMbthhmRXroUuPm4KabHSrSsBWNKGZhH9YtDk0i+CCr7MgSkzu7
 FVDFzxQPXR5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202429592"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="202429592"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 23:23:53 -0700
IronPort-SDR: Alg9KqsTcpoSRzM/E8tLIcHNb6nERYxEFXuQLjGzB9t9p+ccBkkhbL42zY/bpZgh+SdP7voRWy
 m2ZLhLQSZhPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="547074285"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 May 2021 23:23:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 May 2021 09:23:49 +0300
Date:   Wed, 26 May 2021 09:23:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Update IOM port status offset
 for AlderLake
Message-ID: <YK3pdXzYKdSy8d31@kuha.fi.intel.com>
References: <20210525020401.6738-1-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525020401.6738-1-azhar.shaikh@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:04:01PM -0700, Azhar Shaikh wrote:
> Intel AlderLake(ADL) IOM has a different IOM port status offset than
> Intel TigerLake.
> Add a new ACPI ID for ADL and use the IOM port status offset as per
> the platform.
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 28 ++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 46a25b8db72e..5ef41cfa8213 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -83,8 +83,6 @@ enum {
>  /*
>   * Input Output Manager (IOM) PORT STATUS
>   */
> -#define IOM_PORT_STATUS_OFFSET				0x560
> -
>  #define IOM_PORT_STATUS_ACTIVITY_TYPE_MASK		GENMASK(9, 6)
>  #define IOM_PORT_STATUS_ACTIVITY_TYPE_SHIFT		6
>  #define IOM_PORT_STATUS_ACTIVITY_TYPE_USB		0x03
> @@ -144,6 +142,7 @@ struct pmc_usb {
>  	struct pmc_usb_port *port;
>  	struct acpi_device *iom_adev;
>  	void __iomem *iom_base;
> +	u32 iom_port_status_offset;
>  };
>  
>  static void update_port_status(struct pmc_usb_port *port)
> @@ -153,7 +152,8 @@ static void update_port_status(struct pmc_usb_port *port)
>  	/* SoC expects the USB Type-C port numbers to start with 0 */
>  	port_num = port->usb3_port - 1;
>  
> -	port->iom_status = readl(port->pmc->iom_base + IOM_PORT_STATUS_OFFSET +
> +	port->iom_status = readl(port->pmc->iom_base +
> +				 port->pmc->iom_port_status_offset +
>  				 port_num * sizeof(u32));
>  }
>  
> @@ -559,14 +559,32 @@ static int is_memory(struct acpi_resource *res, void *data)
>  	return !acpi_dev_resource_memory(res, &r);
>  }
>  
> +/* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
> +static const struct acpi_device_id iom_acpi_ids[] = {
> +	/* TigerLake */
> +	{ "INTC1072", 0x560, },
> +
> +	/* AlderLake */
> +	{ "INTC1079", 0x160, },
> +	{}
> +};
> +
>  static int pmc_usb_probe_iom(struct pmc_usb *pmc)
>  {
>  	struct list_head resource_list;
>  	struct resource_entry *rentry;
> -	struct acpi_device *adev;
> +	static const struct acpi_device_id *id;
> +	struct acpi_device *adev = NULL;
>  	int ret;
>  
> -	adev = acpi_dev_get_first_match_dev("INTC1072", NULL, -1);
> +	for (id = &iom_acpi_ids[0]; id->id[0]; id++) {
> +		if (acpi_dev_present((const char *)id, NULL, -1)) {
> +			pmc->iom_port_status_offset = (u32)id->driver_data;
> +			adev = acpi_dev_get_first_match_dev((const char *)id, NULL, -1);

This one I think you still need to change:

                        adev = acpi_dev_get_first_match_dev(id->id, NULL, -1)

> +			break;
> +		}
> +	}
> +
>  	if (!adev)
>  		return -ENODEV;
>  

thanks,

-- 
heikki
