Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C62377D70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEJHvy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 May 2021 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEJHvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:51:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFD4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:50:47 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lg0gf-00029n-J1; Mon, 10 May 2021 09:50:45 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lg0gU-0005w4-E9; Mon, 10 May 2021 09:50:34 +0200
Message-ID: <f42e5936139f75968520cf76c359e079b49b1dcb.camel@pengutronix.de>
Subject: Re: [PATCH] reset: a10sr: add missing of_match_table reference
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Date:   Mon, 10 May 2021 09:50:34 +0200
In-Reply-To: <20210507112803.20012-1-krzysztof.kozlowski@canonical.com>
References: <20210507112803.20012-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-07 at 07:28 -0400, Krzysztof Kozlowski wrote:
> The driver defined of_device_id table but did not use it with
> of_match_table.  This prevents usual matching via devicetree and causes
> a W=1 warning:
> 
>   drivers/reset/reset-a10sr.c:111:34: warning:
>     ‘a10sr_reset_of_match’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 627006820268 ("reset: Add Altera Arria10 SR Reset Controller")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/reset/reset-a10sr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-a10sr.c b/drivers/reset/reset-a10sr.c
> index 7eacc89382f8..99b3bc8382f3 100644
> --- a/drivers/reset/reset-a10sr.c
> +++ b/drivers/reset/reset-a10sr.c
> @@ -118,6 +118,7 @@ static struct platform_driver a10sr_reset_driver = {
>  	.probe	= a10sr_reset_probe,
>  	.driver = {
>  		.name		= "altr_a10sr_reset",
> +		.of_match_table	= a10sr_reset_of_match,
>  	},
>  };
>  module_platform_driver(a10sr_reset_driver);

Thank you, applied to reset/next.

regards
Philipp
