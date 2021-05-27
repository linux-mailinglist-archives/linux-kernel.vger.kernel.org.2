Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6070392886
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhE0HaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhE0HaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44EC861059;
        Thu, 27 May 2021 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622100509;
        bh=JaIyM9JOIaX8kTZxhm82AXcUEBSrdnzdxBrRGPKHC7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJJNGPzH150LOjO+txWMxQkpdLCxNFWP44M2DDeOl1Ya/ZpWgEBCANlKDUe6pkcu9
         xr+gdroiMLX5ZWnPW7R24hgjWifhNm66keG2pHYqj0I8ITY2ES+agxLaZEnu7CwvEa
         Sztf9iqOlxqzfxX8SlSQmiOLa63PQID4fJD6/h70=
Date:   Thu, 27 May 2021 09:28:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] usb: common: add helper to get
 role-switch-default-mode
Message-ID: <YK9KG5c96VmdHfF3@kroah.com>
References: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
 <1621933165-9661-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621933165-9661-2-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:59:24PM +0800, Chunfeng Yun wrote:
> Add helper to get "role-switch-default-mode", and convert it
> to the corresponding enum usb_dr_mode
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/common/common.c | 20 ++++++++++++++++++++
>  include/linux/usb/otg.h     |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index fff318597337..78a625a4e526 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -207,6 +207,26 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
>  
> +/**
> + * usb_get_role_switch_default_mode - Get default mode for given device
> + * @dev: Pointer to the given device
> + *
> + * The function gets string from property 'role-switch-default-mode',
> + * and returns the corresponding enum usb_dr_mode.
> + */
> +enum usb_dr_mode usb_get_role_switch_default_mode(struct device *dev)
> +{
> +	const char *str;
> +	int ret;
> +
> +	ret = device_property_read_string(dev, "role-switch-default-mode", &str);
> +	if (ret < 0)
> +		return USB_DR_MODE_UNKNOWN;
> +
> +	return usb_get_dr_mode_from_string(str);
> +}
> +EXPORT_SYMBOL_GPL(usb_get_role_switch_default_mode);
> +
>  /**
>   * usb_decode_interval - Decode bInterval into the time expressed in 1us unit
>   * @epd: The descriptor of the endpoint
> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index a86ee6aad51b..bde313c97fb6 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -121,5 +121,6 @@ enum usb_dr_mode {
>  };
>  
>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
> +extern enum usb_dr_mode usb_get_role_switch_default_mode(struct device *dev);

What other code outside of the dwc3 driver will ever need to call this?

thanks,

greg k-h
