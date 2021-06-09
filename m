Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4703A1D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhFIStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:49:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15555 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230199AbhFIStV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:49:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623264446; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=mX4L5IV5eFf/UxLYkJ4BkGaE9xSTvXZJk5GFPql7d5o=; b=wEqFJa5uYRbCF3R6N795Abgntx2NbpBx8gPXWon1hjXp++BryJffhkYNwcJGnBY25VPxNJmU
 i/5qggLjKtQc5kso47h6SRVZHPPXGyY2caTOUz7JE6IS7E9Ve6Ro1hGtB1uxu89nI9FW4HnC
 +blAmUkT/Hwz91aXSAjTTZpgBw0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60c10cbae27c0cc77f017c35 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Jun 2021 18:47:22
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 944C8C4338A; Wed,  9 Jun 2021 18:47:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A5E5CC4338A;
        Wed,  9 Jun 2021 18:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5E5CC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 9 Jun 2021 11:47:15 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Peter Chen <peter.chen@kernel.org>
Subject: Re: [PATCH] USB: dwc3: remove debugfs root dentry storage
Message-ID: <20210609184715.GA28957@jackp-linux.qualcomm.com>
References: <20210609093924.3293230-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609093924.3293230-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:39:24AM +0200, Greg Kroah-Hartman wrote:
> There is no need to keep around the debugfs "root" directory for the
> dwc3 device.  Instead, look it up anytime we need to find it.  This will
> help when callers get out-of-order and we had the potential to have a
> "stale" pointer around for the root dentry, as has happened in the past.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/dwc3/core.h    | 2 --
>  drivers/usb/dwc3/debugfs.c | 8 ++++----
>  drivers/usb/dwc3/gadget.c  | 4 +++-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index c5d5760cdf53..dccdf13b5f9e 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1013,7 +1013,6 @@ struct dwc3_scratchpad_array {
>   * @link_state: link state
>   * @speed: device speed (super, high, full, low)
>   * @hwparams: copy of hwparams registers
> - * @root: debugfs root folder pointer
>   * @regset: debugfs pointer to regdump file
>   * @dbg_lsp_select: current debug lsp mux register selection
>   * @test_mode: true when we're entering a USB test mode
> @@ -1222,7 +1221,6 @@ struct dwc3 {
>  	u8			num_eps;
>  
>  	struct dwc3_hwparams	hwparams;
> -	struct dentry		*root;
>  	struct debugfs_regset32	*regset;
>  
>  	u32			dbg_lsp_select;
> diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> index 5dbbe53269d3..f2b7675c7f62 100644
> --- a/drivers/usb/dwc3/debugfs.c
> +++ b/drivers/usb/dwc3/debugfs.c
> @@ -889,8 +889,10 @@ static void dwc3_debugfs_create_endpoint_files(struct dwc3_ep *dep,
>  void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
>  {
>  	struct dentry		*dir;
> +	struct dentry		*root;
>  
> -	dir = debugfs_create_dir(dep->name, dep->dwc->root);
> +	root = debugfs_lookup(dev_name(dep->dwc->dev), usb_debug_root);
> +	dir = debugfs_create_dir(dep->name, root);
>  	dwc3_debugfs_create_endpoint_files(dep, dir);
>  }
>  
> @@ -909,8 +911,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
>  	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
>  
>  	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
> -	dwc->root = root;
> -
>  	debugfs_create_regset32("regdump", 0444, root, dwc->regset);
>  	debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
>  
> @@ -929,6 +929,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
>  
>  void dwc3_debugfs_exit(struct dwc3 *dwc)
>  {
> -	debugfs_remove_recursive(dwc->root);
> +	debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root));
>  	kfree(dwc->regset);
>  }
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 7cc99b6d0bfe..026a2ad0fc80 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2799,7 +2799,9 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
>  			list_del(&dep->endpoint.ep_list);
>  		}
>  
> -		debugfs_remove_recursive(debugfs_lookup(dep->name, dwc->root));
> +		debugfs_remove_recursive(debugfs_lookup(dep->name,
> +				debugfs_lookup(dev_name(dep->dwc->dev),
> +					       usb_debug_root)));

Nested calls to debugfs_lookup() :). But it does work, and similarly
avoids the out-of-order debugfs removal issue as well even without
Peter's fix.

Tested-by: Jack Pham <jackp@codeaurora.org>

Thanks
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
