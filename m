Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C03AB44D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhFQNKJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 09:10:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50879 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:10:07 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D504140007;
        Thu, 17 Jun 2021 13:07:57 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu + mvebu/dt64 1/2] firmware: turris-mox-rwtm:
 add marvell,armada-3700-rwtm-firmware compatible string
In-Reply-To: <20210520113844.32319-2-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113844.32319-1-pali@kernel.org>
 <20210520113844.32319-2-pali@kernel.org>
Date:   Thu, 17 Jun 2021 15:07:57 +0200
Message-ID: <87pmwk1vwy.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Add more generic compatible string 'marvell,armada-3700-rwtm-firmware' for
> this driver, since it can also be used on other Armada 3720 devices.
>
> Current compatible string 'cznic,turris-mox-rwtm' is kept for backward
> compatibility.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")


Applied on mvebu/drivers (I removed the Fixes line)

Thanks,

Gregory

> ---
>  drivers/firmware/turris-mox-rwtm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
> index 1cf4f1087492..c2d34dc8ba46 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -569,6 +569,7 @@ static int turris_mox_rwtm_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id turris_mox_rwtm_match[] = {
>  	{ .compatible = "cznic,turris-mox-rwtm", },
> +	{ .compatible = "marvell,armada-3700-rwtm-firmware", },
>  	{ },
>  };
>  
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
