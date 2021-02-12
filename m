Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF04531A19B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhBLPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhBLPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:21:20 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F94AC061756;
        Fri, 12 Feb 2021 07:20:38 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id f3so6577661oiw.13;
        Fri, 12 Feb 2021 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d6+Ix5tUom3YtchCT4frjDNqXEU/t20Qrz9V7ksshi8=;
        b=ERjWd8b5tJOeaTYpxnQnMlmHHS7m6ODMMAkNH7SUi4phx2Ts3KthOLqNrFaCY13ryL
         KOyFRinSHj8b3SZrmzujEgKTMEEbO8JPexhpHSSS9B08vwhTiij5a5yQtYBgqsOPxg2z
         QAOImywdMUfb746g3UvPotXiXwcf4InOaojEJCEHLErReCVJMMCQ6xqFWDg6d/c2ZBgJ
         qhBi5HJiHxBHNflVmvvDVF+pQmB++y0TrPSOiDpxSbGSK/a0Us+5gVdctxcgn71/7fGl
         7rfIUXT9SAP9ZpMn3g76UPG2VgQLu95uEaqMDpmsOGc1+0TWOedqroLofzGRle4KsCg3
         Lw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d6+Ix5tUom3YtchCT4frjDNqXEU/t20Qrz9V7ksshi8=;
        b=POPfoyX48gugZ0LvPBrUrnf4vdMskABbZzqZZQBg4p5waN6AS93WtU6//qb/RE4EfS
         dzwGodFa8iyQS39ACY5rXqKyABUhj33N1KUBwMxHq8h7T2FYVW0SAkOW7LSXfEyzsuT+
         NiLaIp899Js0GDntXYMaoBokWZ+Cw1hvZwPWOTLq73gmJ1l5FMW1/dM0qBnWukmoksJu
         /RAr2W/+okIBn+iiumN8bcrcuhZRzYVl/QR/1IBUiszLdeZcrA/B6ptX8oOWk7+Z+waI
         xO70pG/K0fIrm01dhsHiakTgM+ome5xfqxLCCorSLuPzo5aFMYhSH+2NnUiYGkX80ad1
         8qag==
X-Gm-Message-State: AOAM532E3KZ5CFb68RzO/DmvXQPwFL+RNMo93qthbBubioH2Dm52LDFF
        OeDlOxb4H5IE06Yg8/9weyM/vUVjV1E=
X-Google-Smtp-Source: ABdhPJxNrG2DtEHsDTgCGqU89VIuYQFY9eQ845gx86Rh8r1llXgWeqFduLARnmfj2x+cV8oVSJsPCA==
X-Received: by 2002:a05:6808:30e:: with SMTP id i14mr2185942oie.50.1613143237355;
        Fri, 12 Feb 2021 07:20:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f1sm792120otq.10.2021.02.12.07.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 07:20:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6 3/7] usb: typec: tcpm: Determine common SVDM Version
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-4-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <23ab2b79-bb2b-eb36-795e-1bfcb83a6cf5@roeck-us.net>
Date:   Fri, 12 Feb 2021 07:20:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205033415.3320439-4-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 7:34 PM, Kyle Tso wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
> 

