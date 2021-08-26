Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E513F863F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhHZLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhHZLSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A3E3610A4;
        Thu, 26 Aug 2021 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629976654;
        bh=rj+1dxJfAFKdj8Dhrnrr16eUI58mr8w3p7l4glHVvx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaMxParJDyi+yixAw+EbULYF6f5FIuXp59gnMDB9xGPA4AqozC6ZkuNhfV1DshSYD
         ANt4pSy4OgJaw1Pn5ktDc+378vF0A9NGubMsZMolPilYHc0YIQdmNTTw2x20NN4jYG
         e/N++lLUB5pXl63NzhSON1rfDsLDQnr2VWaPduFw=
Date:   Thu, 26 Aug 2021 13:17:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, team-linux@rtst.co.kr,
        mkbyeon@lselectric.co.kr, khchoib@lselectric.co.kr
Subject: Re: [PATCH v2] usb: chipidea: add loop timeout for hw_ep_set_halt()
Message-ID: <YSd4Sp25RtT1b+rm@kroah.com>
References: <20210817064353.GA669425@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817064353.GA669425@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 03:43:53PM +0900, Jeaho Hwang wrote:
> If ctrl EP priming is failed (very rare case in standard linux),
> hw_ep_set_halt goes infinite loop. waiting 100 times was enough
> for zynq7000.
> 
> Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 8834ca613721..d73fadb18f32 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -209,6 +209,9 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>  	return 0;
>  }
>  
> +/* enough for zynq7000 evaluation board */
> +#define HW_EP_SET_HALT_COUNT_MAX 100
> +
>  /**
>   * hw_ep_set_halt: configures ep halt & resets data toggle after clear (execute
>   *                 without interruption)
> @@ -221,6 +224,7 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>   */
>  static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
>  {
> +	int count = HW_EP_SET_HALT_COUNT_MAX;
>  	if (value != 0 && value != 1)

You need a blank line after "int count..."


>  		return -EINVAL;
>  
> @@ -232,9 +236,9 @@ static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
>  		/* data toggle - reserved for EP0 but it's in ESS */
>  		hw_write(ci, reg, mask_xs|mask_xr,
>  			  value ? mask_xs : mask_xr);
> -	} while (value != hw_ep_get_halt(ci, num, dir));
> +	} while (value != hw_ep_get_halt(ci, num, dir) && --count > 0);
>  
> -	return 0;
> +	return count ? 0 : -EAGAIN;

Please spell this out:
	if (count)
		return 0;
	return -EAGAIN;

And will the caller properly handle this?

thanks,

greg k-h
