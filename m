Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585E1357E08
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhDHI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:28:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:55274 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhDHI2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:28:23 -0400
IronPort-SDR: +tgpD1L8WZdhec3W44xIKeMcix3GvUvbyTkY/R+L98xJnP9KxiGD73VmZn9yExNhCoga68iU2b
 GgVigh/gH0Vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="191332665"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="191332665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 01:28:12 -0700
IronPort-SDR: GlAvcAPZuSIMQFgeRhWj7Qtb64brTKGxSvkBexW2plL6uEXg5UVBfWA08kDWZK+rpsPp9N+/t5
 aMfR0cR21EUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519766809"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2021 01:28:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 11:28:09 +0300
Date:   Thu, 8 Apr 2021 11:28:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: remove unused static variable
 'tcpm_altmode_ops'
Message-ID: <YG6+mfqIc15rc9H1@kuha.fi.intel.com>
References: <20210407091540.2815-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407091540.2815-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:15:40PM +0800, Zhen Lei wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
> 
> The reference to the variable 'tcpm_altmode_ops' is deleted by the
> commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration
> mechanism").
> 
> By the way, the static functions referenced only by the variable
> 'tcpm_altmode_ops' are deleted accordingly.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Oh, I thought this was already fixed. Should this go into the stable
trees as well?

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 60 -------------------------------------------
>  1 file changed, 60 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ce7af398c7c1c1f..2f89bae29c0c297 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1365,14 +1365,6 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  	mod_vdm_delayed_work(port, 0);
>  }
>  
> -static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
> -				    const u32 *data, int cnt)
> -{
> -	mutex_lock(&port->lock);
> -	tcpm_queue_vdm(port, header, data, cnt);
> -	mutex_unlock(&port->lock);
> -}
> -
>  static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>  {
>  	u32 vdo = p[VDO_INDEX_IDH];
> @@ -1705,8 +1697,6 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  	 *
>  	 * And we also have this ordering:
>  	 * 1. alt-mode driver takes the alt-mode's lock
> -	 * 2. alt-mode driver calls tcpm_altmode_enter which takes the
> -	 *    tcpm port lock
>  	 *
>  	 * Dropping our lock here avoids this.
>  	 */
> @@ -2060,56 +2050,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>  	return 0;
>  }
>  
> -static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -	int svdm_version;
> -	u32 header;
> -
> -	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
> -	if (svdm_version < 0)
> -		return svdm_version;
> -
> -	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
> -	header |= VDO_OPOS(altmode->mode);
> -
> -	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
> -	return 0;
> -}
> -
> -static int tcpm_altmode_exit(struct typec_altmode *altmode)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -	int svdm_version;
> -	u32 header;
> -
> -	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
> -	if (svdm_version < 0)
> -		return svdm_version;
> -
> -	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
> -	header |= VDO_OPOS(altmode->mode);
> -
> -	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
> -	return 0;
> -}
> -
> -static int tcpm_altmode_vdm(struct typec_altmode *altmode,
> -			    u32 header, const u32 *data, int count)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -
> -	tcpm_queue_vdm_unlocked(port, header, data, count - 1);
> -
> -	return 0;
> -}
> -
> -static const struct typec_altmode_ops tcpm_altmode_ops = {
> -	.enter = tcpm_altmode_enter,
> -	.exit = tcpm_altmode_exit,
> -	.vdm = tcpm_altmode_vdm,
> -};
> -
>  /*
>   * PD (data, control) command handling functions
>   */
> -- 
> 1.8.3
> 

-- 
heikki
