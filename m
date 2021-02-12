Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72E2319907
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBLESm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhBLESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:18:38 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB202C061756;
        Thu, 11 Feb 2021 20:17:58 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id l23so7299399otn.10;
        Thu, 11 Feb 2021 20:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RXhlW1QBroO29TQjVvdCb0rwXrL5HjSTA/QS/9006aQ=;
        b=PgzhS1ubWxkNvmaKcPzufPysweqAJmSens0Ky61wiePMyonwAa/iVRvFsrIDjlJk35
         cZIONJiSWarFU2xnAzEOSSQ76zW+P3j2a+ta+Ca8vuja976aVGF0tMMiZb7Q3aW6ZM1D
         +u7ypF96LkbWU/FSmNk+lSbK0QRAyNSLBkE1zjSOgLFYpe1r07yyl7EIhVjmWuQqwbib
         gdgbw85GXM+ntwkQ8uM7rO8FwbfplW9wUM8vv6m+h/55kdpJGUzKaC+/GOJ/yqmRfDYK
         Iw+TTFilCEBxeNjL90/nlJPoY2X2scqnTIA7h+c5e02JFKUqG7fhJN0NFS8AwuV1zCOe
         h23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXhlW1QBroO29TQjVvdCb0rwXrL5HjSTA/QS/9006aQ=;
        b=J6tASJACX5sbqsp9Mag+TOMDqUWE6XOAZEW2pPAGev3Fopnq6GErTczPWgFIANZRkt
         9z7zcoz9n4RrRzlYCfixDAizVJen13tX2XRA0wnZWHAO4RUYeJzuQyHDJM9zyY6T2zN+
         2b8ifKPaZLApAsHNh8pF6N4DlTafZcn/M8hEZBFQDL7Piva95BD+fL5fikCKYlXSeOuh
         nuUv+YXh9NYqdIJSHdsqK4x3KM0nrRRKWRtgyChByVxrYClMSYP344LY8TEPOGZgI90v
         JkyAmWdAOh4rfFeg3CB8Sy2YeIVY+Rm46rgcTAUTAxsyo+Xowf7krA3C122y3y55Dcdz
         Nn9A==
X-Gm-Message-State: AOAM530SBiON+P+rNW8AwduJtU46gwcMFSLiBDR5MdPVzV7UgIu1tjP6
        uQNhA1bgFbl2OmA3PLr3XrZ6AXkxwUo=
X-Google-Smtp-Source: ABdhPJws4bJKFAO4WmAoEiOGbMvHrzhKO/gKVQZ7qDpqagcSCu7NdJ/x4eUo/PIhuINn+fVIv96EoA==
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr826811otc.260.1613103478090;
        Thu, 11 Feb 2021 20:17:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm1626564oie.39.2021.02.11.20.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:17:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:17:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/7] usb: typec: tcpm: Determine common SVDM Version
Message-ID: <20210212041756.GC103223@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-4-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-4-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:11AM +0800, Kyle Tso wrote:
> PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
>   6.4.4.2.3 Structured VDM Version
>   "The Structured VDM Version field of the Discover Identity Command
>   sent and received during VDM discovery Shall be used to determine the
>   lowest common Structured VDM Version supported by the Port Partners or
>   Cable Plug and Shall continue to operate using this Specification
>   Revision until they are Detached."
> 
> Also clear the fields newly defined in SVDM version 2.0 if the
> negotiated SVDM version is 1.0.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> Changes since v5:
> - follow the changes of "usb: typec: Manage SVDM version"
> - remove the "reset to default". Now the default SVDM version will be
>   set when calling to typec_register_partner
> 
>  drivers/usb/typec/tcpm/tcpm.c | 71 ++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9aadb1e1bec5..b45cd191a8a4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1475,8 +1475,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			const u32 *p, int cnt, u32 *response,
>  			enum adev_actions *adev_action)
>  {
> +	struct typec_port *typec = port->typec_port;
>  	struct typec_altmode *pdev;
>  	struct pd_mode_data *modep;
> +	int svdm_version;
>  	int rlen = 0;
>  	int cmd_type;
>  	int cmd;
> @@ -1493,6 +1495,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
>  				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
>  
> +	svdm_version = typec_get_negotiated_svdm_version(typec);
> +	if (svdm_version < 0)
> +		return 0;
> +
>  	switch (cmd_type) {
>  	case CMDT_INIT:
>  		switch (cmd) {
> @@ -1500,10 +1506,22 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (PD_VDO_VID(p[0]) != USB_SID_PD)
>  				break;
>  
> +			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
> +				typec_partner_set_svdm_version(port->partner,
> +							       PD_VDO_SVDM_VER(p[0]));
>  			/* 6.4.4.3.1: Only respond as UFP (device) */
>  			if (port->data_role == TYPEC_DEVICE &&
>  			    port->nr_snk_vdo) {
> -				for (i = 0; i <  port->nr_snk_vdo; i++)
> +				/*
> +				 * Product Type DFP and Connector Type are not defined in SVDM
> +				 * version 1.0 and shall be set to zero.
> +				 */
> +				if (typec_get_negotiated_svdm_version(typec) < SVDM_VER_2_0)

Why not
				if (svdm_version)
?

> +					response[1] = port->snk_vdo[0] & ~IDH_DFP_MASK
> +						      & ~IDH_CONN_MASK;
> +				else
> +					response[1] = port->snk_vdo[0];
> +				for (i = 1; i <  port->nr_snk_vdo; i++)
>  					response[i + 1] = port->snk_vdo[i];
>  				rlen = port->nr_snk_vdo + 1;
>  			}
> @@ -1532,6 +1550,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
>  			rlen = 1;
>  		}
> +		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +			      (VDO_SVDM_VERS(typec_get_negotiated_svdm_version(typec)));

Unnecessary ( ) around VDO_SVDM_VERS. Also, why not svdm_version ?

>  		break;
>  	case CMDT_RSP_ACK:
>  		/* silently drop message if we are not connected */
> @@ -1542,19 +1562,22 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  
>  		switch (cmd) {
>  		case CMD_DISCOVER_IDENT:
> +			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
> +				typec_partner_set_svdm_version(port->partner,
> +							       PD_VDO_SVDM_VER(p[0]));
>  			/* 6.4.4.3.1 */
>  			svdm_consume_identity(port, p, cnt);
> -			response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0, CMD_DISCOVER_SVID);
> +			response[0] = VDO(USB_SID_PD, 1, typec_get_negotiated_svdm_version(typec),

Guess I am a bit confused about the use of svdm_version vs.
typec_get_negotiated_svdm_version(typec). Is there some rationale
for using one vs. the other ?

> +					  CMD_DISCOVER_SVID);
>  			rlen = 1;
>  			break;
>  		case CMD_DISCOVER_SVID:
>  			/* 6.4.4.3.2 */
>  			if (svdm_consume_svids(port, p, cnt)) {
> -				response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0,
> -						  CMD_DISCOVER_SVID);
> +				response[0] = VDO(USB_SID_PD, 1, svdm_version, CMD_DISCOVER_SVID);
>  				rlen = 1;
>  			} else if (modep->nsvids && supports_modal(port)) {
> -				response[0] = VDO(modep->svids[0], 1, SVDM_VER_1_0,
> +				response[0] = VDO(modep->svids[0], 1, svdm_version,
>  						  CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			}
> @@ -1565,7 +1588,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			modep->svid_index++;
>  			if (modep->svid_index < modep->nsvids) {
>  				u16 svid = modep->svids[modep->svid_index];
> -				response[0] = VDO(svid, 1, SVDM_VER_1_0, CMD_DISCOVER_MODES);
> +				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			} else {
>  				tcpm_register_partner_altmodes(port);
> @@ -1592,6 +1615,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			/* Unrecognized SVDM */
>  			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
>  			rlen = 1;
> +			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +				      (VDO_SVDM_VERS(svdm_version));
>  			break;
>  		}
>  		break;
> @@ -1611,6 +1636,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			/* Unrecognized SVDM */
>  			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
>  			rlen = 1;
> +			response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +				      (VDO_SVDM_VERS(svdm_version));
>  			break;
>  		}
>  		port->vdm_sm_running = false;
> @@ -1618,6 +1645,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  	default:
>  		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
>  		rlen = 1;
> +		response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> +			      (VDO_SVDM_VERS(svdm_version));
>  		port->vdm_sm_running = false;
>  		break;
>  	}
> @@ -1695,7 +1724,13 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			break;
>  		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
>  			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> -				response[0] = VDO(adev->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
> +				int svdm_version = typec_get_negotiated_svdm_version(
> +									port->typec_port);
> +				if (svdm_version < 0)
> +					break;
> +
> +				response[0] = VDO(adev->svid, 1, svdm_version,
> +						  CMD_EXIT_MODE);
>  				response[0] |= VDO_OPOS(adev->mode);
>  				rlen = 1;
>  			}
> @@ -1722,14 +1757,19 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
>  			  const u32 *data, int count)
>  {
> +	int svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
>  	u32 header;
>  
> +	if (svdm_version < 0)
> +		return;
> +
>  	if (WARN_ON(count > VDO_MAX_SIZE - 1))
>  		count = VDO_MAX_SIZE - 1;
>  
>  	/* set VDM header with VID & CMD */
>  	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
> -			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), SVDM_VER_1_0, cmd);
> +			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION),
> +			svdm_version, cmd);
>  	tcpm_queue_vdm(port, header, data, count);
>  }
>  
> @@ -2022,9 +2062,14 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>  static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  {
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> +	int svdm_version;
>  	u32 header;
>  
> -	header = VDO(altmode->svid, vdo ? 2 : 1, SVDM_VER_1_0, CMD_ENTER_MODE);
> +	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
> @@ -2034,9 +2079,14 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  {
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> +	int svdm_version;
>  	u32 header;
>  
> -	header = VDO(altmode->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
> +	svdm_version = typec_get_negotiated_svdm_version(port->typec_port);
> +	if (svdm_version < 0)
> +		return svdm_version;
> +
> +	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
> @@ -5977,6 +6027,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->typec_caps.fwnode = tcpc->fwnode;
>  	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
>  	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
> +	port->typec_caps.svdm_version = SVDM_VER_2_0;
>  	port->typec_caps.driver_data = port;
>  	port->typec_caps.ops = &tcpm_ops;
>  	port->typec_caps.orientation_aware = 1;
> -- 
> 2.30.0.365.g02bc693789-goog
> 
