Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBB534B36D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 01:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhC0Ay6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 20:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhC0AyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 20:54:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09962619F2;
        Sat, 27 Mar 2021 00:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616806465;
        bh=4do6G+gJZlBTQPYH4m2JO5OQCmo46Wr09haIuKn0Gms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMWb9lpTF8ZgKeel11M524/WLq3cEWqo3Vf2AuLF+QnypPuOZvL5fbbrUMcSWP/NH
         1MVL7ewFDzP36cAXI60UfHb9rwtuq9gOLFxnYVOHd9pWZK2S5fJSaKxGfcfCXf8Dgd
         T6ALmk3RI3BPE+I5Wij3ETpQqzksnh6cve/NUp3S91OnqnKh/AExkXIo+mlDD0rWoM
         RaDLXWkX9wUBXQZYww5x/rmOs0rdRdgPBojlrlsuEpDAbaSUdJ9CP43/9Iwdg4+9xq
         oYr5MBTgULbv8qZ6jXxIC44QS4yr+rgXjM8d3KIxa8Cn6lVXm3U4Q+3hREOawtRXuR
         6EaVZpAYGbqYg==
Date:   Sat, 27 Mar 2021 08:54:17 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com
Subject: Re: [PATCH] usb: cdnsp: Fixes issue with Configure Endpoint command
Message-ID: <20210327005417.GB28870@b29397-desktop>
References: <20210322060902.11197-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322060902.11197-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-22 07:09:02, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch adds flag EP_UNCONFIGURED to detect whether endpoint was
> unconfigured. This flag is set in cdnsp_reset_device after Reset Device
> command. Among others this command disables all non control endpoints.
> Flag is used in cdnsp_gadget_ep_disable to protect controller against
> invoking Configure Endpoint command on disabled endpoint. Lack of this
> protection in some cases caused that Configure Endpoint command completed
> with Context State Error code completion.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++-----
>  drivers/usb/cdns3/cdnsp-gadget.h | 11 ++++++-----
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index d7d4bdd57f46..de17cc4ad91a 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -727,7 +727,7 @@ int cdnsp_reset_device(struct cdnsp_device *pdev)
>  	 * are in Disabled state.
>  	 */
>  	for (i = 1; i < CDNSP_ENDPOINTS_NUM; ++i)
> -		pdev->eps[i].ep_state |= EP_STOPPED;
> +		pdev->eps[i].ep_state |= EP_STOPPED | EP_UNCONFIGURED;
>  
>  	trace_cdnsp_handle_cmd_reset_dev(slot_ctx);
>  
> @@ -942,6 +942,7 @@ static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
>  
>  	pep = to_cdnsp_ep(ep);
>  	pdev = pep->pdev;
> +	pep->ep_state &= ~EP_UNCONFIGURED;
>  
>  	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
>  			  "%s is already enabled\n", pep->name))
> @@ -1023,9 +1024,13 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
>  		goto finish;
>  	}
>  
> -	cdnsp_cmd_stop_ep(pdev, pep);
>  	pep->ep_state |= EP_DIS_IN_RROGRESS;
> -	cdnsp_cmd_flush_ep(pdev, pep);
> +
> +	/* Endpoint was unconfigured by Reset Device command. */
> +	if (!(pep->ep_state & EP_UNCONFIGURED)) {
> +		cdnsp_cmd_stop_ep(pdev, pep);
> +		cdnsp_cmd_flush_ep(pdev, pep);
> +	}
>  
>  	/* Remove all queued USB requests. */
>  	while (!list_empty(&pep->pending_list)) {
> @@ -1036,6 +1041,7 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
>  	cdnsp_invalidate_ep_events(pdev, pep);
>  
>  	pep->ep_state &= ~EP_DIS_IN_RROGRESS;
> +

Useless blank line

>  	drop_flag = cdnsp_get_endpoint_flag(pep->endpoint.desc);
>  	ctrl_ctx = cdnsp_get_input_control_ctx(&pdev->in_ctx);
>  	ctrl_ctx->drop_flags = cpu_to_le32(drop_flag);
> @@ -1043,10 +1049,12 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
>  
>  	cdnsp_endpoint_zero(pdev, pep);
>  
> -	ret = cdnsp_update_eps_configuration(pdev, pep);
> +	if (!(pep->ep_state & EP_UNCONFIGURED))
> +		ret = cdnsp_update_eps_configuration(pdev, pep);
> +
>  	cdnsp_free_endpoint_rings(pdev, pep);
>  
> -	pep->ep_state &= ~EP_ENABLED;
> +	pep->ep_state &= ~(EP_ENABLED | EP_UNCONFIGURED);
>  	pep->ep_state |= EP_STOPPED;
>  
>  finish:
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 6bbb26548c04..e628bd539e23 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -830,11 +830,12 @@ struct cdnsp_ep {
>  	unsigned int ep_state;
>  #define EP_ENABLED		BIT(0)
>  #define EP_DIS_IN_RROGRESS	BIT(1)
> -#define EP_HALTED		BIT(2)
> -#define EP_STOPPED		BIT(3)
> -#define EP_WEDGE		BIT(4)
> -#define EP0_HALTED_STATUS	BIT(5)
> -#define EP_HAS_STREAMS		BIT(6)
> +#define EP_UNCONFIGURED		BIT(2)

Why add new flag as BIT(2), it causes many changes in this patch?

> +#define EP_HALTED		BIT(3)
> +#define EP_STOPPED		BIT(4)
> +#define EP_WEDGE		BIT(5)
> +#define EP0_HALTED_STATUS	BIT(6)
> +#define EP_HAS_STREAMS		BIT(7)
>  
>  	bool skip;
>  };
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

