Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A7424C91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhJGEqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 00:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGEqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 00:46:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C39560F48;
        Thu,  7 Oct 2021 04:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633581882;
        bh=H28sqCTxVFgWzx4PqYa+P+xRN1M8iIwlJpVoBVb9t2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2TUYJmmdwAKFjxPHEfI1HeYw7lT7e1O81r6+Ri544xrHvvMdbEVSgm4ASdhznd3k
         kC0pvKyHNUnDcmtn3kwMrXm8Xy2B+SQUEDNf4n6S7nQ0iBDtJHR1P2BeMQEkPaKcd+
         OxJDTz3Uv3d01VXAX5E8+bVp0PzuNviVGuzmkUMqcJKOp6/7OIpgsg54Tdlf5m7f8w
         EtChNx4IuynzL+WpuxWmznE8px0NpWFOUbeluYLkLAMrnsU4klDTSThIa+yQFM4dIG
         BBuA3wqNiwojEBD5GOOSfeg7JW/0/tL3lTNAbJyQrYQr4v1xkQQl7Yb0TXiQyWM7rR
         dIXJSEzdXVnMA==
Date:   Thu, 7 Oct 2021 12:44:32 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Subject: Re: [PATCH 1/6] usb: chipidea: Add support for VBUS control with PHY
Message-ID: <20211007044432.GA4653@Peter>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
 <1629825378-8089-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629825378-8089-2-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 22:46:13, Manish Narani wrote:
> Some platforms make use of VBUS control over PHY which
> means controller driver has to access PHY registers to
> turn on/off VBUS line.This patch adds support for
> such platforms in chipidea.
> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
>  drivers/usb/chipidea/host.c         | 9 +++++++++
>  drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
>  include/linux/usb/chipidea.h        | 1 +
>  4 files changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
> index 89e1d82..dc86b12 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data ci_default_pdata = {
>  
>  static const struct ci_hdrc_platform_data ci_zynq_pdata = {
>  	.capoffset	= DEF_CAPOFFSET,
> +	.flags          = CI_HDRC_PHY_VBUS_CONTROL,
>  };
>  
>  static const struct ci_hdrc_platform_data ci_zevio_pdata = {
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index e86d13c..578968d 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -63,6 +63,14 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
>  		priv->enabled = enable;
>  	}
>  
> +	if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
> +	    ci->usb_phy && ci->usb_phy->set_vbus) {

Indent is needed. Otherwise:

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

> +		if (enable)
> +			ci->usb_phy->set_vbus(ci->usb_phy, 1);
> +		else
> +			ci->usb_phy->set_vbus(ci->usb_phy, 0);
> +	}
> +
>  	if (enable && (ci->platdata->phy_mode == USBPHY_INTERFACE_MODE_HSIC)) {
>  		/*
>  		 * Marvell 28nm HSIC PHY requires forcing the port to HS mode.
> @@ -71,6 +79,7 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
>  		hw_port_test_set(ci, 5);
>  		hw_port_test_set(ci, 0);
>  	}
> +
>  	return 0;
>  };
>  
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index 6ed4b00..2f7f94d 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  				return;
>  			}
>  		}
> +
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +			ci->usb_phy->set_vbus(ci->usb_phy, 1);
> +
>  		/* Disable data pulse irq */
>  		hw_write_otgsc(ci, OTGSC_DPIE, 0);
>  
> @@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  		if (ci->platdata->reg_vbus)
>  			regulator_disable(ci->platdata->reg_vbus);
>  
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +			ci->usb_phy->set_vbus(ci->usb_phy, 0);
> +
>  		fsm->a_bus_drop = 1;
>  		fsm->a_bus_req = 0;
>  	}
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index edf3342..ee38835 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_REQUIRES_ALIGNED_DMA	BIT(13)
>  #define CI_HDRC_IMX_IS_HSIC		BIT(14)
>  #define CI_HDRC_PMQOS			BIT(15)
> +#define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> -- 
> 2.1.1
> 

-- 

Thanks,
Peter Chen

