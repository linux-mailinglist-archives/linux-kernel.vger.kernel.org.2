Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BE3690A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbhDWKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhDWKx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AF9860698;
        Fri, 23 Apr 2021 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619175171;
        bh=xQuN3HIeq8N0vDxYvUzfufNjSiG6BHI4rvIYX5Z4mmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJTAbMHblyvskJ+rutYcPiYHh5dCWbnhWaeDLTaCv4WQnZBzALrpT66kBwyVPn64T
         UDReRNFYHv2/HBMB8b/vecMZwro98KHZUN/OkmGsrOR91v/+Wyrt0JVeDiKYpbL1lb
         pxfWUU1n4ZFPp0PnMRp5u7gslRSbxLbGVPllPBnMHiS18jwAd9/GHpA8lV5we2VG8l
         Da4jd//0HehUBctV/o/Tj4p4OIsIwI1VcZd9Pkh/YUsBJ1IeEp9A+CK+0RTVSf4w8i
         Uf9ruzOYiD4yZLqKsvHWudTpzNgJfxeUkgkZxcBwTNngWL8cVEDNJPwTf852nxdoQj
         XgMuKcBekG5ZQ==
Date:   Fri, 23 Apr 2021 18:52:43 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com
Subject: Re: [PATCH v2 2/2] usb: cdnsp: Fix lack of removing request from
 pending list.
Message-ID: <20210423105243.GA6664@nchen>
References: <20210420042813.34917-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420042813.34917-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-20 06:28:13, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch fixes lack of removing request from ep->pending_list on failure
> of the stop endpoint command. Driver even after failing this command
> must remove request from ep->pending_list.
> Without this fix driver can stuck in cdnsp_gadget_ep_disable function
> in loop:
>         while (!list_empty(&pep->pending_list)) {
>                 preq = next_request(&pep->pending_list);
>                 cdnsp_ep_dequeue(pep, preq);
>         }
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Applied, thanks.

Peter
> 
> ---
> Changelog:
> v2:
> - removed blank space
> - added "Fixes" tag
> 
>  drivers/usb/cdns3/cdnsp-gadget.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 56707b6b0f57..c083985e387b 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -422,17 +422,17 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
>  int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
>  {
>  	struct cdnsp_device *pdev = pep->pdev;
> -	int ret;
> +	int ret_stop = 0;
> +	int ret_rem;
>  
>  	trace_cdnsp_request_dequeue(preq);
>  
> -	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_RUNNING) {
> -		ret = cdnsp_cmd_stop_ep(pdev, pep);
> -		if (ret)
> -			return ret;
> -	}
> +	if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_RUNNING)
> +		ret_stop = cdnsp_cmd_stop_ep(pdev, pep);
> +
> +	ret_rem = cdnsp_remove_request(pdev, preq, pep);
>  
> -	return cdnsp_remove_request(pdev, preq, pep);
> +	return ret_rem ? ret_rem : ret_stop;
>  }
>  
>  static void cdnsp_zero_in_ctx(struct cdnsp_device *pdev)
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

