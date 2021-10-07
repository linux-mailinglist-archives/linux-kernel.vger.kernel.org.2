Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F6424CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhJGFCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGFCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:02:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D914A61074;
        Thu,  7 Oct 2021 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633582827;
        bh=EmOgN58xQNYpXS7Z2g5SK5S8ZjnjUg2XXkF+jhptwns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoDqw7MMzyWGIynpdX93cxcLtNFc4kuwTz6Qx0bhpn47GfWo5oTbQznN+AOe8vdt9
         TOV44L8AueMJXewWXwoB1WKcLLYWz2faYWli2KJw+8KB9NRLVm3CHDzNUCpdwCX1k7
         UvJFFHCVi0dntCkgEAFQjdX8WW21SoZa2a9jptcnX0nM74hIzuiCAYNliak922QK65
         IHRUkBhS2wb+1Ww3RP5koDU1c34Dj/qU9Zb9jiyfapM9e/S2igU3lFMzIcWrTmAq1G
         sYWfRiPP7DOvKorRcbkGaa3hpi13ULm00fa0IEpnlZfv0Nhd+Qt1RH4zxDggDz63ff
         afqMSZBlriLuw==
Date:   Thu, 7 Oct 2021 13:00:18 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: Re: [PATCH 5/6] usb: chipidea: core: Add return value function check
Message-ID: <20211007050018.GD4653@Peter>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
 <1629825378-8089-6-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629825378-8089-6-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 22:46:17, Manish Narani wrote:
> From: Piyush Mehta <piyush.mehta@xilinx.com>
> 
> Add return value validation for function phy exit and phy power off.
> 
> Addresses-Coverity: "USELESS_CALL"
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/chipidea/core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 676346f..37f619e 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -324,7 +324,8 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
>  
>  		ret = phy_power_on(ci->phy);
>  		if (ret) {
> -			phy_exit(ci->phy);
> +			if (phy_exit(ci->phy) < 0)
> +				dev_dbg(ci->dev, "phy exit failed\r\n");

You may not need to debug message, the phy_exit shows error message.
You may return 'ret' for phy_exit for error.

>  			return ret;
>  		}
>  	} else {
> @@ -341,12 +342,20 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
>   */
>  static void ci_usb_phy_exit(struct ci_hdrc *ci)
>  {
> +	int ret;
> +
>  	if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
>  		return;
>  
>  	if (ci->phy) {
> -		phy_power_off(ci->phy);
> -		phy_exit(ci->phy);
> +		ret = phy_power_off(ci->phy);
> +		if (ret < 0)
> +			dev_dbg(ci->dev, "phy poweroff failed\r\n");
> +
> +		ret = phy_exit(ci->phy);
> +		if (ret < 0)
> +			dev_dbg(ci->dev, "phy exit failed\r\n");
> +

Ditto

>  	} else {
>  		usb_phy_shutdown(ci->usb_phy);
>  	}
> -- 
> 2.1.1
> 

-- 

Thanks,
Peter Chen

