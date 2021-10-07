Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB4424C89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 06:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhJGE3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 00:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhJGE3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 00:29:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D2FF610EA;
        Thu,  7 Oct 2021 04:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633580859;
        bh=jxXvN5afASHFFmVBHrpmjuDtB6YdKWx/IRGUIEVcW3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWDQkvWuf7OBqY7PsFKnNwrlNXL3nnZclaSOrXqrmG2rv6BRKLM7ragRQnd3Q/1to
         TWWBv2YQgqo+7IkJg8wreP1I7o9XEpmWH4Ok19P2BL1FYyK/buhqxjj8ux2OBwqD2/
         8Fb3Xm1dd2ARKthAEWZjHxyaOtDnBBRuqz8/yAFWMbilzQkbPcVhQlSGJznAVQibGY
         4So2rkHv7EKJvB95dqij3ZfQxwlYujFCNFjpC77K52D8efWmrNU/dkmCk/ySYRW7VX
         31jsIfLQzlWv+2XqxmrT6bVMk42ACFYKEeiLAToN9kGGqXcNtD5Mjh59n1qhy5MEMF
         oKMC8Ey8vnHpg==
Date:   Thu, 7 Oct 2021 12:27:30 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Piyush Mehta <piyushm@xilinx.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [PATCH V2] usb: chipidea: udc: make controller hardware endpoint
 primed
Message-ID: <20211007042730.GA3786@Peter>
References: <20210913140005.955699-1-piyush.mehta@xilinx.com>
 <SJ0PR02MB864445907305B66580FFE1D8D4B09@SJ0PR02MB8644.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR02MB864445907305B66580FFE1D8D4B09@SJ0PR02MB8644.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-06 04:36:59, Piyush Mehta wrote:
> 
> Root-cause:
> There is an issue like endpoint is not recognized as primed, when bus have more pressure and the add dTD tripwire semaphore (ATDTW bit in USBCMD register) that can cause the controller to ignore a dTD that is added to a primed endpoint.
> This issue observed with the Windows10 host machine.
> 
> Workaround:
> The software must implement a periodic cycle, and check for each dTD, if the endpoint is primed. It can do this by reading the corresponding bits in the ENDPTPRIME and ENDPTSTAT registers. If these bits are read at 0, the software needs to re-prime the endpoint by writing 1 to the corresponding bit in the ENDPTPRIME register.
> 
> Added conditional revision check of 2.20[CI_REVISION_22].
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Addressed Peter review comments - Remove unrelated new-line
> - Updated commit message
> 
> Link: https://lore.kernel.org/linux-usb/SJ0PR02MB8644CBBA848A0F68323F1AA5D4D99@SJ0PR02MB8644.namprd02.prod.outlook.com/
> ---
>  drivers/usb/chipidea/udc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c index 8834ca6..f9ca501 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -49,6 +49,8 @@ ctrl_endpt_in_desc = {
>  	.wMaxPacketSize  = cpu_to_le16(CTRL_PAYLOAD_MAX),  };
>  
> +static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
> +		       struct td_node *node);
>  /**
>   * hw_ep_bit: calculates the bit number
>   * @num: endpoint number
> @@ -599,6 +601,12 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
>  
>  		prevlastnode->ptr->next = cpu_to_le32(next);
>  		wmb();
> +
> +		if (ci->rev == CI_REVISION_22) {
> +			if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
> +				reprime_dtd(ci, hwep, prevlastnode);
> +		}
> +
>  		if (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
>  			goto done;
>  		do {
> --

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen

