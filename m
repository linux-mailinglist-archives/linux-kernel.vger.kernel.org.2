Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91B939573B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEaImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhEaIlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:41:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30C1B6023E;
        Mon, 31 May 2021 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622450403;
        bh=hIo9igXETrqt8JGupXund+T2mtkuw9aDgnbLO9HhyN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMX+1p1XnD68tYgotvN1s1ACQ+Y/xvPR0Mo27Kdc6p0Ra+3bsuyiEihZzV0Qy/21O
         PBrNdp+BvYan4Tfq4071JGbwLuvxb42hGih5x62SVvzc28BkYC7QHpOqUZEvkNkdS+
         BY9Fa9OvmW5MGQqnwAwSeP1HUjj7XWddbQ4lMeLbYAEedgE4yPBwqludlILxELu4dN
         ZFu4FJ3uJ/Nwi/3BEYOau+jNT3GjlUfOr1Uk8Mc+pEC1FVE+y/RPmiBsk1K0IOxCi3
         0K28aJxa0bNRvZXNqaT5SPcAk44uECTcR29sbfPy5M1EM7tlFzBwuI9iKnkifjcqka
         i5O/v3PLi0g6A==
Date:   Mon, 31 May 2021 14:09:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: Fix an error code in wiz_probe()
Message-ID: <YLSg3z3hYsT/QQ1n@vkoul-mobl.Dlink>
References: <1621939832-65535-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621939832-65535-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-21, 18:50, Yang Li wrote:
> When the code execute this if statement, the value of ret is 0. 
> However, we can see from the dev_err() log that the value of 
> ret should be -EINVAL.
> 
> Clean up smatch warning:
> 
> drivers/phy/ti/phy-j721e-wiz.c:1216 wiz_probe() warn: missing error code
> 'ret'

Single line is fine for this

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit c9f9eba06629 ("phy: ti: j721e-wiz: Manage
> typec-gpio-dir")'

Please dont split to two lines for fixes tag

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I have fixed while applying so Applied, thanks

> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 9eb6d37..126f5b8 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -1212,6 +1212,7 @@ static int wiz_probe(struct platform_device *pdev)
>  
>  		if (wiz->typec_dir_delay < WIZ_TYPEC_DIR_DEBOUNCE_MIN ||
>  		    wiz->typec_dir_delay > WIZ_TYPEC_DIR_DEBOUNCE_MAX) {
> +			ret = -EINVAL;
>  			dev_err(dev, "Invalid typec-dir-debounce property\n");
>  			goto err_addr_to_resource;
>  		}
> -- 
> 1.8.3.1

-- 
~Vinod
