Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1235A9D2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbhDJBGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235215AbhDJBGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F020F61108;
        Sat, 10 Apr 2021 01:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618016799;
        bh=s8osdEXEHWK0uXbZb3OoiNNhqDzjRjCPWvJu8aGIU10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSnWl81LkF8fs/Vl1jFFifVH75VDgdKPn6NuNMaMkoXN9M70hzU1+n3gVLMRO/ZNt
         E6uOo3tOQen8ZOc6+4Rma9m0cPXTsAuAQIJ6oy96mbP+woCoqWvxbcHafCOsMwt3aF
         pvCC/8mvGuFJ/JdX9KNgsoFk2va4B+eYhQX5TbAt2/PtNknDKknX05aTmm2/J67Y1O
         b1WgSwfwYtdJ/H9/OM6anR59uE4nXRS9Mkdfz6PAqoegzRQJFMguWulOS24xw22uPj
         iFAT+tGFWNqodSeD4rghJaEt/Qplv9jSg7VC78mRE9bNaoDbuaYeNxu5aYZWK1B3HG
         E7DRCjdrYy3FA==
Date:   Sat, 10 Apr 2021 09:06:31 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: Fix rumtime PM imbalance on error
Message-ID: <20210410010631.GA3862@b29397-desktop>
References: <20210407052226.1056-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407052226.1056-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-07 13:22:26, Dinghao Liu wrote:
> When cdns3_gadget_start() fails, a pairing PM usage counter
> decrement is needed to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 582bfeceedb4..ad891a108aed 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -3255,8 +3255,11 @@ static int __cdns3_gadget_init(struct cdns *cdns)
>  	pm_runtime_get_sync(cdns->dev);
>  
>  	ret = cdns3_gadget_start(cdns);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_mark_last_busy(cdns->dev);
> +		pm_runtime_put_autosuspend(cdns->dev);
>  		return ret;

It doesn't need to delay entering runtime suspend, I prefer using pm_runtime_put_sync directly.

-- 

Thanks,
Peter Chen

