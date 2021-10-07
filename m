Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3158B424C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhJGEyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 00:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGEyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 00:54:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 693F861039;
        Thu,  7 Oct 2021 04:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633582370;
        bh=FxzDAJVvnO/bGcMiUOiodFDRDx4Ad/gZs6zNI4y/0uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkP9KFX/bXifSSBT0fSzwu8x6XEuDTw3nvs+v7sdVTN4Y03F5jqT+LcA0BmK3JqQl
         UVP3U7EddJ9RqIgdRSNqsXjuQi3+0k1Vb0AqdGsPhm1BXOFeY8vTg80ySp8ceN7btG
         YQc0G7VHYzAV+8x5/A57GxEhHkNMBSgqW81P+Haou72GvD+wJw3617DYSlpWzo31c1
         Gf0eVdh5+cNvUiFn6Mafn1PW33fFeggdqeFReO5Yt6QRX7fgWPRZsFf7aa+EC6CjXZ
         HqDfx/27u/hXn9OGKG/AHm7TTx6ZplSvR7GSFfwU8AQESzJWR7VkJplTblYp4kCyKd
         AHesCptpDuo2g==
Date:   Thu, 7 Oct 2021 12:52:41 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Subject: Re: [PATCH 2/6] usb: chipidea: Use usb2 phy for Zynq platform
Message-ID: <20211007045241.GB4653@Peter>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
 <1629825378-8089-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629825378-8089-3-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 22:46:14, Manish Narani wrote:
> Add usb2 phy to Zynq platform data.

Please change the subject and comments a little. This file is not only
for xilinx platform, it is for generic chipidea driver. If you would
like this change only for your platform, you may use of_device_id.data
for condition.

Peter

> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
> index dc86b12..be58869 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -65,6 +65,10 @@ static int ci_hdrc_usb2_probe(struct platform_device *pdev)
>  	if (match && match->data) {
>  		/* struct copy */
>  		*ci_pdata = *(struct ci_hdrc_platform_data *)match->data;
> +		ci_pdata->usb_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy",
> +								0);
> +		if (IS_ERR(ci_pdata->usb_phy))
> +			return PTR_ERR(ci_pdata->usb_phy);
>  	}
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -- 
> 2.1.1
> 

-- 

Thanks,
Peter Chen

