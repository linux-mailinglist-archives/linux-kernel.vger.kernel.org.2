Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0373185B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhBKHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:32:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAF6C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 23:32:14 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lA6SF-0001oW-CK; Thu, 11 Feb 2021 08:31:59 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lA6SC-0006Wh-3t; Thu, 11 Feb 2021 08:31:56 +0100
Date:   Thu, 11 Feb 2021 08:31:56 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] soc: xilinx: vcu: remove deadcode on null divider
 check
Message-ID: <20210211073156.GB30300@pengutronix.de>
References: <20210210184938.146124-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210184938.146124-1-colin.king@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:21:46 up 70 days, 19:48, 76 users,  load average: 0.32, 0.16,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 18:49:38 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer 'divider' has previously been null checked followed by
> a return, hence the subsequent null check is redundant deadcode
> that can be removed.  Clean up the code and remove it.
> 
> Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for output clocks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/xilinx/xlnx_vcu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
> index d66b1315114e..607936d7a413 100644
> --- a/drivers/clk/xilinx/xlnx_vcu.c
> +++ b/drivers/clk/xilinx/xlnx_vcu.c
> @@ -512,9 +512,6 @@ static void xvcu_clk_hw_unregister_leaf(struct clk_hw *hw)
>  
>  	mux = clk_hw_get_parent(divider);
>  	clk_hw_unregister_mux(mux);
> -	if (!divider)
> -		return;
> -
>  	clk_hw_unregister_divider(divider);

Thanks for pointing this out. There is actually a different bug there.

There should have been a check for !mux before unregistering the mux:

	mux = clk_hw_get_parent(divider);
	clk_hw_unregister_divider(divider);
	if (!mux)
		return;

	clk_hw_unregister_mux(mux);

Michael

>  }
>  
> -- 
> 2.30.0
> 
> 
