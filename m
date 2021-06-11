Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C353A3E60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFKI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhFKI53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:57:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ECEA611CD;
        Fri, 11 Jun 2021 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401732;
        bh=fXkE15E/OwWp9aeBX5GQ3KSheL8YxUgg0lgOvFqh3jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPu5L0JYrNkoRrtQkyGtwHYCFJLphrErroYcJOQp7XTu0rnmwvUM6+rlXnPMtsO+6
         hccjtE8SlE7UQgw60lJMgfstYe/ZJqA0qYJPkEHl0Bjb1BMl3BG6vMjrnWdJQ7HIOf
         oNVVwHmVS6j4gaJyczas0inqJeOLjreOObM6/VZ0=
Date:   Fri, 11 Jun 2021 10:55:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Zou Wei <zou_wei@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 3/9] nvmem: sc27xx: Add missing MODULE_DEVICE_TABLE
Message-ID: <YMMlAVg9eaNct5Nb@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611083348.20170-4-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:33:42AM +0100, Srinivas Kandagatla wrote:
> From: Zou Wei <zou_wei@huawei.com>
> 
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Fixes: 19c54468f222 ("nvmem: Add Spreadtrum SC27XX efuse support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/sc27xx-efuse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
> index c825fc902d10..7f9bd2195b97 100644
> --- a/drivers/nvmem/sc27xx-efuse.c
> +++ b/drivers/nvmem/sc27xx-efuse.c
> @@ -262,6 +262,7 @@ static const struct of_device_id sc27xx_efuse_of_match[] = {
>  	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, sc27xx_efuse_of_match);
>  
>  static struct platform_driver sc27xx_efuse_driver = {
>  	.probe = sc27xx_efuse_probe,
> -- 
> 2.21.0
> 

Same comment as patch 1/9
