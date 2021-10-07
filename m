Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543C9424CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 06:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJGE4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 00:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGE4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 00:56:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09C9661039;
        Thu,  7 Oct 2021 04:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633582471;
        bh=ZeBsLwHowLp6o87e20VsE1pQlOwErVqE47b5Cxr+Xvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FejS89cQX1aC+8RjadcqZBOtQoBOnXKKjDRuS0be2HFYnpDZOyEb/zPubv+r5J8pQ
         DnTEAzZ7fCCHs5CfCmygyYgWfPM7sZjTwpDrVXWgA24dghCXPbu03D9An6wzDzG1nM
         9WKccYL37wfT8voXUkel8IIAZw2YbFmg2bsfgmnaMnCCI+2VBw7fdIG3JrjwZZcBk9
         bpBkVOfL5TmW2QEaORoptRmg8XhwEDieNro6gEckjVt497eoXHn4PYle8Mi7WqAjh5
         YQ3qqGS5kW62B1zYyZ6xSjUg1qwJ/m8syUus3bokCXZoKpTw2LQgJbMZB/yCAdLIIS
         ghYcKzaqBWoIw==
Date:   Thu, 7 Oct 2021 12:54:22 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Subject: Re: [PATCH 3/6] usb: chipidea: Check usb_phy exists before using it
Message-ID: <20211007045422.GC4653@Peter>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
 <1629825378-8089-4-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629825378-8089-4-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 22:46:15, Manish Narani wrote:
> usb_phy and usb_phy->set_vbus may not be present all the times
> based on PHY driver used. So check for it.

Please squash this one with the first one.

Peter
> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/chipidea/otg_fsm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
> index 2f7f94d..5f8f5d2 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -472,7 +472,8 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  			}
>  		}
>  
> -		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
> +		    ci->usb_phy && ci->usb_phy->set_vbus)
>  			ci->usb_phy->set_vbus(ci->usb_phy, 1);
>  
>  		/* Disable data pulse irq */
> @@ -484,7 +485,8 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
>  		if (ci->platdata->reg_vbus)
>  			regulator_disable(ci->platdata->reg_vbus);
>  
> -		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
> +		    ci->usb_phy && ci->usb_phy->set_vbus)
>  			ci->usb_phy->set_vbus(ci->usb_phy, 0);
>  
>  		fsm->a_bus_drop = 1;
> -- 
> 2.1.1
> 

-- 

Thanks,
Peter Chen

