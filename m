Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBF3198FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBLEKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhBLEKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:10:30 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA3C061574;
        Thu, 11 Feb 2021 20:09:50 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l19so8692119oih.6;
        Thu, 11 Feb 2021 20:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rWqIZH0bGUa/YUPNQ/J6sVSkXiWilyBoUnkVWEmIxIM=;
        b=bxlmlJ1alF0SeIwclc9NVXVGF1Ett7Po3OEUkj/6FojYTrS2gX/5+3ooAKKKFErZed
         mRuauxt0nEICxBUfq9PlM90Z8/L+KDTLLhDgUxtTa8ZPxm+cxVeTt+zgs8vOqxAHdS9i
         OHunen4FwOwBUajkDxE/JHthtYBHymRsUxJTsZzVThir1FXqOL1Rvsv3C+nvTS9DVgX9
         CqaSkV7gYwd0c+gdvsPfD/vJAhpH+nFwSfzpctOJwC1C8Wa/tv5wL7GQ8n1UqhfdHhb/
         5SOTy3HU6jafibP1N8qpXunxdsT9+V048VFBu4wB+U1mL0XybfK93xn2dtU1hvGdf7Ie
         R55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rWqIZH0bGUa/YUPNQ/J6sVSkXiWilyBoUnkVWEmIxIM=;
        b=hVkdruGjL5o9RGW5uOarHvFFT+Q9zod1d6uEeUzfMtr/wfRNAfcrWsvOJJMNp9Qv5i
         S5IjwLGSrMqmvBKLpv1Trf7T6YetLs/aCpIiDUg783juFVRpOBTGjAUao54ktVUtjqWc
         CjJw5v+lqCEQzdiJ1wYY8NawjCzczs1j5t9KBlBZA0zjwPCA2WUKztJWIlGIT+lkTjfd
         cN+EGniWP4ZylgsBbzi3wZBhfnPo0E1gbSxlI4ehtTAwdljyQq+QwAHoiUUo0sPz8OFF
         ukUvCPUl9PPRPgiuFkCWAokKE1pz+/Sxa3NG+DZoTPlCK3UFBpeuTIvrMOcSXlEvWu27
         QfSg==
X-Gm-Message-State: AOAM530tqCPtCZzQwKuCssOj75tRtuurZIstW/tMOiEB837giyHHPwYX
        89cs45ExyNLvitl//+73Nng=
X-Google-Smtp-Source: ABdhPJx3cPOaFHEMEnLoZNQ7I0we1T0iGAutojRvPfyBHvoxjkx5sAgOu+JmpkGZnyvmAeqCsJ+EBA==
X-Received: by 2002:a05:6808:147:: with SMTP id h7mr695733oie.142.1613102989445;
        Thu, 11 Feb 2021 20:09:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y66sm1603976oig.46.2021.02.11.20.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:09:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:09:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/7] usb: pd: Make SVDM Version configurable in VDM
 header
Message-ID: <20210212040947.GB103223@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-3-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:10AM +0800, Kyle Tso wrote:
> PD Rev 3.0 introduces SVDM Version 2.0. This patch makes the field
> configuable in the header in order to be able to be compatible with
> older SVDM version.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v5:
> - no change
> 
>  drivers/usb/typec/altmodes/displayport.c |  2 +-
>  drivers/usb/typec/tcpm/tcpm.c            | 16 ++++++++--------
>  drivers/usb/typec/ucsi/displayport.c     |  6 +++---
>  include/linux/usb/pd_vdo.h               |  7 +++++--
>  4 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index e62e5e3da01e..0abc3121238f 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -15,7 +15,7 @@
>  #include <linux/usb/typec_dp.h>
>  #include "displayport.h"
>  
> -#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, cmd) | \
> +#define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, SVDM_VER_1_0, cmd) | \
>  					 VDO_OPOS(USB_TYPEC_DP_MODE))
>  
>  enum {
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8558ab006885..9aadb1e1bec5 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1544,17 +1544,17 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  		case CMD_DISCOVER_IDENT:
>  			/* 6.4.4.3.1 */
>  			svdm_consume_identity(port, p, cnt);
> -			response[0] = VDO(USB_SID_PD, 1, CMD_DISCOVER_SVID);
> +			response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0, CMD_DISCOVER_SVID);
>  			rlen = 1;
>  			break;
>  		case CMD_DISCOVER_SVID:
>  			/* 6.4.4.3.2 */
>  			if (svdm_consume_svids(port, p, cnt)) {
> -				response[0] = VDO(USB_SID_PD, 1,
> +				response[0] = VDO(USB_SID_PD, 1, SVDM_VER_1_0,
>  						  CMD_DISCOVER_SVID);
>  				rlen = 1;
>  			} else if (modep->nsvids && supports_modal(port)) {
> -				response[0] = VDO(modep->svids[0], 1,
> +				response[0] = VDO(modep->svids[0], 1, SVDM_VER_1_0,
>  						  CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			}
> @@ -1565,7 +1565,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			modep->svid_index++;
>  			if (modep->svid_index < modep->nsvids) {
>  				u16 svid = modep->svids[modep->svid_index];
> -				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
> +				response[0] = VDO(svid, 1, SVDM_VER_1_0, CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			} else {
>  				tcpm_register_partner_altmodes(port);
> @@ -1695,7 +1695,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			break;
>  		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
>  			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> -				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
> +				response[0] = VDO(adev->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
>  				response[0] |= VDO_OPOS(adev->mode);
>  				rlen = 1;
>  			}
> @@ -1729,7 +1729,7 @@ static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
>  
>  	/* set VDM header with VID & CMD */
>  	header = VDO(vid, ((vid & USB_SID_PD) == USB_SID_PD) ?
> -			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), cmd);
> +			1 : (PD_VDO_CMD(cmd) <= CMD_ATTENTION), SVDM_VER_1_0, cmd);
>  	tcpm_queue_vdm(port, header, data, count);
>  }
>  
> @@ -2024,7 +2024,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  	u32 header;
>  
> -	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
> +	header = VDO(altmode->svid, vdo ? 2 : 1, SVDM_VER_1_0, CMD_ENTER_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0);
> @@ -2036,7 +2036,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  	u32 header;
>  
> -	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
> +	header = VDO(altmode->svid, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
>  	tcpm_queue_vdm_unlocked(port, header, NULL, 0);
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 261131c9e37c..1d387bddefb9 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -83,7 +83,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  	 * mode, and letting the alt mode driver continue.
>  	 */
>  
> -	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_ENTER_MODE);
> +	dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, CMD_ENTER_MODE);
>  	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
>  
> @@ -120,7 +120,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	dp->header = VDO(USB_TYPEC_DP_SID, 1, CMD_EXIT_MODE);
> +	dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
>  	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
>  
> @@ -200,7 +200,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
>  
>  	switch (cmd_type) {
>  	case CMDT_INIT:
> -		dp->header = VDO(USB_TYPEC_DP_SID, 1, cmd);
> +		dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, cmd);
>  		dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  
>  		switch (cmd) {
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index 5de7f550f93e..b057250704e8 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -21,22 +21,24 @@
>   * ----------
>   * <31:16>  :: SVID
>   * <15>     :: VDM type ( 1b == structured, 0b == unstructured )
> - * <14:13>  :: Structured VDM version (can only be 00 == 1.0 currently)
> + * <14:13>  :: Structured VDM version
>   * <12:11>  :: reserved
>   * <10:8>   :: object position (1-7 valid ... used for enter/exit mode only)
>   * <7:6>    :: command type (SVDM only?)
>   * <5>      :: reserved (SVDM), command type (UVDM)
>   * <4:0>    :: command
>   */
> -#define VDO(vid, type, custom)				\
> +#define VDO(vid, type, ver, custom)			\
>  	(((vid) << 16) |				\
>  	 ((type) << 15) |				\
> +	 ((ver) << 13) |				\
>  	 ((custom) & 0x7FFF))
>  
>  #define VDO_SVDM_TYPE		(1 << 15)
>  #define VDO_SVDM_VERS(x)	((x) << 13)
>  #define VDO_OPOS(x)		((x) << 8)
>  #define VDO_CMDT(x)		((x) << 6)
> +#define VDO_SVDM_VERS_MASK	VDO_SVDM_VERS(0x3)
>  #define VDO_OPOS_MASK		VDO_OPOS(0x7)
>  #define VDO_CMDT_MASK		VDO_CMDT(0x3)
>  
> @@ -74,6 +76,7 @@
>  
>  #define PD_VDO_VID(vdo)		((vdo) >> 16)
>  #define PD_VDO_SVDM(vdo)	(((vdo) >> 15) & 1)
> +#define PD_VDO_SVDM_VER(vdo)	(((vdo) >> 13) & 0x3)
>  #define PD_VDO_OPOS(vdo)	(((vdo) >> 8) & 0x7)
>  #define PD_VDO_CMD(vdo)		((vdo) & 0x1f)
>  #define PD_VDO_CMDT(vdo)	(((vdo) >> 6) & 0x3)
> -- 
> 2.30.0.365.g02bc693789-goog
> 
