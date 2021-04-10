Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE235A9D5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhDJBMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235215AbhDJBMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:12:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B6646115A;
        Sat, 10 Apr 2021 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618017113;
        bh=1tJDBetcARIQlFJTyBstbrd34YskV6J/Srd47sWRN8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jh4UBFpfkJzjRDgkOGV1Y0/cnW2wIeOLKhsHpTxuzVp7kTtWPkh+E0YtE953yhLPd
         NCwzNx0wQ215vIcwDAyDmEGzPgWWaHflWx6bYyXqruTK9vCphhwq8vxrZyrZr+lxKX
         Tngzckogw36oTR2eF6o8pxRkE20p/KBRE5rI+mTLUM3auaRx7JS9mWS9sIrZ3SM/rM
         4ZUkUfdAJqAo243e9ePkyM5HAMnnk2PqBVb5kjGmHmNHsyDDF3ExdKNmbExSY/aG0M
         aXZyFqFZzRPGnXbuT0xeR/amPjoiUEQIw+tIG9411vik5UVdxlzyM3/qPcgFCHU3PZ
         KDTNCRiftZmBg==
Date:   Sat, 10 Apr 2021 09:11:46 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com
Subject: Re: [PATCH v2] usb: cdnsp: Fixes issue with Configure Endpoint
 command
Message-ID: <20210410011146.GB3862@b29397-desktop>
References: <20210407063629.43685-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407063629.43685-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-07 08:36:29, Pawel Laszczak wrote:
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

Pawel, it is a little later for v5.12. I queue it to v5.13-rc1 if you
don't mind.

Peter
> 
> ---
> Changelog:
> v2:
> - removed useless blank line
> - changed the EP_UNCONFIGURED to limit changes in patch
> 
>  drivers/usb/cdns3/cdnsp-gadget.c | 17 ++++++++++++-----
>  drivers/usb/cdns3/cdnsp-gadget.h |  1 +
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index d7d4bdd57f46..56707b6b0f57 100644
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
> @@ -1043,10 +1048,12 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
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
> index 6bbb26548c04..783ca8ffde00 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -835,6 +835,7 @@ struct cdnsp_ep {
>  #define EP_WEDGE		BIT(4)
>  #define EP0_HALTED_STATUS	BIT(5)
>  #define EP_HAS_STREAMS		BIT(6)
> +#define EP_UNCONFIGURED		BIT(7)
>  
>  	bool skip;
>  };
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

