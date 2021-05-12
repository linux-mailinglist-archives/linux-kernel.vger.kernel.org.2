Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAC37B5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhELGUz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 May 2021 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhELGUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:20:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE63EC061763
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 23:19:27 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lgiDO-0000op-Hm; Wed, 12 May 2021 08:19:26 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lgiDN-0005DX-Sf; Wed, 12 May 2021 08:19:25 +0200
Message-ID: <9094d229c86bd55395ad9b01ae8f5432bb80fd35.camel@pengutronix.de>
Subject: Re: [PATCH] reset: hi6220: Use the correct HiSilicon copyright
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     puck.chen@hisilicon.com, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com
Date:   Wed, 12 May 2021 08:19:25 +0200
In-Reply-To: <1617087044-19572-1-git-send-email-fanghao11@huawei.com>
References: <1617087044-19572-1-git-send-email-fanghao11@huawei.com>
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

On Tue, 2021-03-30 at 14:50 +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/reset/hisilicon/hi6220_reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> index 1992650..5ca145b 100644
> --- a/drivers/reset/hisilicon/hi6220_reset.c
> +++ b/drivers/reset/hisilicon/hi6220_reset.c
> @@ -3,7 +3,7 @@
>   * Hisilicon Hi6220 reset controller driver

Why leave this "Hisilicon" alone?

>   *
>   * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2015-2016 Hisilicon Limited.
> + * Copyright (c) 2015-2016 HiSilicon Limited.
>   *
>   * Author: Feng Chen <puck.chen@hisilicon.com>
>   */

That will be a lot of churn:

  git grep Copyright.*Hisilicon | wc -l
  141

  git grep Hisilicon | wc -l
  371

Could I get an Acked-by from someone at HiSilicon for this?

regards
Philipp
