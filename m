Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6C3639D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhDSDzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhDSDzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:55:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F386160FE9;
        Mon, 19 Apr 2021 03:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618804515;
        bh=SF3Vix1P8gS9jHl8Flhawff8IyM6VZbyNcdAG2OtJKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=se5kpGDcZwvcGN503psMe2/lB+RS+Ce+KAHPuTb1AFvHt5Gve9uFDHWLI0KW9L7nm
         1QpQEYET0Uv1/+gnspr1L15OScJMP+PJkejrAben4U7sx1Z+agIXjMpCFtcE8KivoO
         howpD6fFFw0R/yMy/ibIFisYKA/jSyObrOZbZQjifVE5VbV9kGKmfOnpkIQ/OsNBfg
         XOM1CdOHVo4ZlanY9BcSQGUFKsJE1nRsek8Mcl+jHLiE+uaYXtN4SqgovzglR8CGlO
         eAZDLr/iTT5Ga4PyfiK7UKMGpd3j03StLsgNckE2xQax5UokHqqnYAop6jWhqhqtjK
         zUTXbftlK3ThQ==
Date:   Mon, 19 Apr 2021 11:55:10 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] usb: cdns3: Fix runtime PM imbalance on error
Message-ID: <20210419035510.GA1870@nchen>
References: <20210412054908.7975-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412054908.7975-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-12 13:49:07, Dinghao Liu wrote:
> When cdns3_gadget_start() fails, a pairing PM usage counter
> decrement is needed to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Applied, thanks.

Peter
> ---
> 
> Changelog:
> 
> v2: - Use pm_runtime_put_sync() to decrease refcount.
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 582bfeceedb4..a49fc68ec2ef 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -3255,8 +3255,10 @@ static int __cdns3_gadget_init(struct cdns *cdns)
>  	pm_runtime_get_sync(cdns->dev);
>  
>  	ret = cdns3_gadget_start(cdns);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_put_sync(cdns->dev);
>  		return ret;
> +	}
>  
>  	/*
>  	 * Because interrupt line can be shared with other components in
> -- 
> 2.17.1
> 

-- 

Thanks,
Peter Chen

