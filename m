Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24795445FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhKEG4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhKEG4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:56:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18AEB6124F;
        Fri,  5 Nov 2021 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636095250;
        bh=HQhrS1X5t7IMuJtjnHPKK3V+2VJ1abmG4ti9NZ7i0kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2bHre3PZkavP+PA6upnzoyy0LAgcnIlGoJTLFapnyqPTLr4g1UR/eTXGkhpgFsp6
         goBuL+0DMXsBVgLxxeye07zM1J6sSq4gFyz+/QKvm2MbVF6tbdPOQzP+fF5sHAQgTH
         PxC/qS6wWEqXgNHtI+bIK27onjvZcuzdQdsiKANI=
Date:   Fri, 5 Nov 2021 07:54:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: Make use of the helper function
 dev_err_probe()
Message-ID: <YYTVEPVNITE8EEHk@kroah.com>
References: <20211105030959.730-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105030959.730-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:09:59AM +0800, Cai Huoqing wrote:
> When possible using dev_err_probe() helps to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> BTW rename 'dev' to 'pdev'.

"BTW"???

> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/base/platform.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 598acf93a360..5befd3258677 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -253,13 +253,14 @@ EXPORT_SYMBOL_GPL(platform_get_irq_optional);
>   *
>   * Return: non-zero IRQ number on success, negative error number on failure.
>   */
> -int platform_get_irq(struct platform_device *dev, unsigned int num)
> +int platform_get_irq(struct platform_device *pdev, unsigned int num)

Why change the variable name?  It has nothing to do with this change,
please do not do that.

thanks,

greg k-h
