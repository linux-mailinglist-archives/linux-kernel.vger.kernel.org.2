Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D32364FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDTBPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhDTBPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:15:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6ADB6127C;
        Tue, 20 Apr 2021 01:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618881320;
        bh=dMVy7r9kbwGa9NRpxTnJsulneVn6ZpTFbmTT2nBL6dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmHJmRZhHoHa0lYeCv8ImdRwIMDmVTYyLv/k25x2801hM/RsHKvN5uJYH/IrMaOex
         BussN01c8+/DUplPZA/DvoJ/UHo1fA+NHmo8Vb4MD9l91VA9Cmj4ZZnhjmdiizTLwE
         QJ6UotXioAPvCVlpSFIHxnM/eP3MxKCzO5DHmQt51WZJguqHL9dFdlUWz/HIx+KHXA
         KIp6EMNluDR10Mw0yxhxITbQgdf1KY2NNfyVi2oYIOZq1mywjVRImAy2MpGIOp+kcu
         ayHg/6YNDcEvT2Vr8hiqEossVfPyEf0Jf+IihHHSFdYaO9mKxDdoOANBDIzadu/kym
         197Zlfvld9NVA==
Date:   Tue, 20 Apr 2021 09:15:14 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com
Subject: Re: [PATCH 2/2] usb: cdnsp: Fix lack of removing request from
 pending list.
Message-ID: <20210420011514.GA6443@nchen>
References: <20210419075311.34430-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419075311.34430-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-19 09:53:11, Pawel Laszczak wrote:
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
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 6182c9bc65de..1ca8c1777a5c 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -424,17 +424,17 @@ int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
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
> +	ret_rem =  cdnsp_remove_request(pdev, preq, pep);

One more blank space above, and add Fixed-by tag.

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

