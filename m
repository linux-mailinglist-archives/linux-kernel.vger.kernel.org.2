Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A3424CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhJGFFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGFF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:05:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D84861075;
        Thu,  7 Oct 2021 05:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633583015;
        bh=itI7gxLN9MnGJa45AohsuUrnIkIDmK2mxwLx4U+UAi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSOF8FXV3oM+Mlq8Wk0dgFTmdplTHATk7mC4Pwl4sVarNskuubgIh2qcLZ4cTbI0A
         RtW5A0I2hSdRLj0w4O/N0UTcwwRiOtzKYwJPBZpsWeD+c+MNXH8CxfhD1H+J18fOMx
         NDCbvFiWg2ty8nBqRHjg2kucGtd660gKKdOP8cWGgno7sDzL2K+Ap4NBWAXqflYvGf
         g1xT5Op/7C7TD2nEr8Y0cLh6NIjCYcQquyFwwRu9CZH2Oelx8nbiWEwUHCBTGiK3Bs
         b3t1cG2l6ZlLSWN3m7DvohW0RNR0OHi6Mn15WQ5Hw7VwtoRC7lEDeMlB0eXR5bzmjd
         sadrr0dum9k0g==
Date:   Thu, 7 Oct 2021 13:03:22 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: Re: [PATCH 6/6] usb: chipidea: udc: Add xilinx revision support
Message-ID: <20211007050322.GF4653@Peter>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
 <1629825378-8089-7-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629825378-8089-7-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 22:46:18, Manish Narani wrote:
> From: Piyush Mehta <piyush.mehta@xilinx.com>
> 
> Issue: Adding a dTD to a Primed Endpoint May Not Get Recognized with
> revision 2.20a.
> 
> There is an issue with the add dTD tripwire semaphore (ATDTW bit in
> USBCMD register) that can cause the controller to ignore a dTD that is
> added to a primed endpoint. When this happens, the software can read
> the tripwire bit and the status bit at '1' even though the endpoint is
> unprimed.
> This issue observed with the Windows host machine.
> 
> Workaround:
> The software must implement a periodic cycle, and check for each dTD
> pending on execution (Active = 1), if the endpoint is primed. It can do
> this by reading the corresponding bits in the ENDPTPRIME and ENDPTSTAT
> registers. If these bits are read at 0, the software needs to re-prime
> the endpoint by writing 1 to the corresponding bit in the ENDPTPRIME
> register.
> 
> Added conditional revision check of 2.20[CI_REVISION_22] along with 2.40.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/chipidea/udc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 8834ca6..b440205 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -680,7 +680,8 @@ static int _hardware_dequeue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
>  		if ((TD_STATUS_ACTIVE & tmptoken) != 0) {
>  			int n = hw_ep_bit(hwep->num, hwep->dir);
>  
> -			if (ci->rev == CI_REVISION_24)
> +			if (ci->rev == CI_REVISION_24 ||
> +			    ci->rev == CI_REVISION_22)

Besides, please change subject a little, it is for specific IP version,
but not related to SoC platforms.

>  				if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
>  					reprime_dtd(ci, hwep, node);
>  			hwreq->req.status = -EALREADY;
> -- 
> 2.1.1
> 

-- 

Thanks,
Peter Chen

