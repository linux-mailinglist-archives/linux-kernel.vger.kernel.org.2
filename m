Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9323930DA39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBCMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:52:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:6781 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhBCMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:49:29 -0500
IronPort-SDR: 0d7ReD5eExWadCwu53KROZUQAp+lG2k7bYaIzs0LCa7MEldycJXTrgG7AmIEXmpnc4CCQoTCqV
 c0VLDqM8KF7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181108280"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="181108280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 04:47:28 -0800
IronPort-SDR: a54BKyw3jkn5IqYOxiw5m9UsxbrGNtRp3DjPR9LTJp2KZJ0p+4FY8FhKPE09XwUlF5FTXGV0Z5
 VAs449fpzUsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480338665"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 03 Feb 2021 04:47:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 03 Feb 2021 14:47:24 +0200
Date:   Wed, 3 Feb 2021 14:47:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/8] usb: typec: Manage SVDM version
Message-ID: <20210203124724.GD1687065@kuha.fi.intel.com>
References: <20210202161733.932215-1-kyletso@google.com>
 <20210202161733.932215-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202161733.932215-2-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On Wed, Feb 03, 2021 at 12:17:26AM +0800, Kyle Tso wrote:
> PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
>   6.4.4.2.3 Structured VDM Version
>   "The Structured VDM Version field of the Discover Identity Command
>   sent and received during VDM discovery Shall be used to determine the
>   lowest common Structured VDM Version supported by the Port Partners or
>   Cable Plug and Shall continue to operate using this Specification
>   Revision until they are Detached."
> 
> Add a variable in typec_capability to specify the highest SVDM version
> supported by the port and another variable in typec_port to cache the
> negotiated SVDM version between the port partners.
> 
> Also add setter/getter functions for the negotiated SVDM version.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/typec/class.c | 13 +++++++++++++
>  include/linux/usb/typec.h | 10 ++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b6ceab3dc16b..42d1be1eece9 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -51,6 +51,7 @@ struct typec_port {
>  	enum typec_role			vconn_role;
>  	enum typec_pwr_opmode		pwr_opmode;
>  	enum typec_port_type		port_type;
> +	enum usb_pd_svdm_ver		svdm_version;
>  	struct mutex			port_type_lock;

I just realized that you are storing that in the port object. I guess
we don't have to change this right now, but it would have been more
clear to store that in the partner object IMO.

>  	enum typec_orientation		orientation;
> @@ -1841,6 +1842,18 @@ int typec_find_port_data_role(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(typec_find_port_data_role);
>  
> +void typec_set_svdm_version(struct typec_port *port, enum usb_pd_svdm_ver ver)
> +{
> +	port->svdm_version = ver;
> +}
> +EXPORT_SYMBOL_GPL(typec_set_svdm_version);
> +
> +enum usb_pd_svdm_ver typec_get_svdm_version(struct typec_port *port)
> +{
> +	return port->svdm_version;
> +}
> +EXPORT_SYMBOL_GPL(typec_get_svdm_version);

You need to document those exported functions! You need to do that in
any case, but in this case it's very important, because the purpose of
these functions is not clear from the ctx.

I'm sorry for noticing that so late. Since you do need to fix that,
please see if you can also store that detail in the partner device
object instead of the port object.

thanks,

-- 
heikki
