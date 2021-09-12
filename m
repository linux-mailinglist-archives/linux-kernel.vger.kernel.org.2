Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B37407C37
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 09:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhILHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 03:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhILHmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 03:42:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BE9360F9F;
        Sun, 12 Sep 2021 07:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631432471;
        bh=dxvDMpkQ3yQxWCwxYiRfx5jSXslSR/RnQtUPyMHSRqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DisLCNZs/aBW5rj6m47JmQ1xlpByKg8xCbu4Lo92dhwwaiy1Uuoizta8w+Y8CW6x5
         XDATZYfnXkbrHlCxZ6w33I1CO4sJZuaQ7l7DheiRfe8aw39eyGlq43DF3/pkakG0Rh
         fYmqiLGtwEWmksMaFX3x0sjOIulgviEq8Xq9ZcZymh1UmIqS2Kb9h4vKfNrzs6TA3e
         mM42qD5UA5YWqf5mVjADCwrutT9ttYPES6uGSBB+1yobzJCMcbiavJ45PrQbmY2P8k
         uvH99kghj1OiQl1D9omgxtV9iJWyFBY5cQACMrG9GpFdHEMtVcCAwk9TolvhOcqj7r
         o7E871QcS7brA==
Date:   Sun, 12 Sep 2021 15:41:05 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com
Subject: Re: [PATCH] usb: chipidea: udc: make controller hardware endpoint
 primed
Message-ID: <20210912074105.GA4808@Peter>
References: <20210908084321.375662-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908084321.375662-1-piyush.mehta@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-08 14:13:21, Piyush Mehta wrote:
> Root-cause:
> There is an issue like endpoint is not recognized as primed, when bus
> have more pressure and the add dTD tripwire semaphore (ATDTW bit in
> USBCMD register) that can cause the controller to ignore a dTD that is
> added to a primed endpoint.
> This issue observed with the Windows10 host machine.
> 
> Workaround:
> The software must implement a periodic cycle, and check for each dTD,
> if the endpoint is primed. It can do this by reading the corresponding
> bits in the ENDPTPRIME and ENDPTSTAT registers. If these bits are read
> at 0, the software needs to re-prime the endpoint by writing 1 to the
> corresponding bit in the ENDPTPRIME register.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  drivers/usb/chipidea/udc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 8834ca6..d970f45 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -49,6 +49,8 @@ ctrl_endpt_in_desc = {
>  	.wMaxPacketSize  = cpu_to_le16(CTRL_PAYLOAD_MAX),
>  };
>  
> +static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
> +		       struct td_node *node);
>  /**
>   * hw_ep_bit: calculates the bit number
>   * @num: endpoint number
> @@ -599,8 +601,15 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
>  
>  		prevlastnode->ptr->next = cpu_to_le32(next);
>  		wmb();
> +
> +		if (ci->rev == CI_REVISION_22) {
> +			if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
> +				reprime_dtd(ci, hwep, prevlastnode);
> +		}
> +

Only for version 2.2?

>  		if (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
>  			goto done;
> +

No blank line.

>  		do {
>  			hw_write(ci, OP_USBCMD, USBCMD_ATDTW, USBCMD_ATDTW);
>  			tmp_stat = hw_read(ci, OP_ENDPTSTAT, BIT(n));
> -- 
> 2.7.4
> 

-- 

Thanks,
Peter Chen

