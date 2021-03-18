Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA5340812
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhCROob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCROoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:44:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEB8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:44:21 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lMtsl-0006HQ-CO; Thu, 18 Mar 2021 15:44:15 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1lMtsk-00064n-R6; Thu, 18 Mar 2021 15:44:14 +0100
Date:   Thu, 18 Mar 2021 15:44:14 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] soc: xilinx: vcu: remove deadcode on null divider
 check
Message-ID: <20210318144414.GQ12621@pengutronix.de>
References: <20210210184938.146124-1-colin.king@canonical.com>
 <161301409895.1254594.6980739457487251623@swboyd.mtv.corp.google.com>
 <20210211073906.GC30300@pengutronix.de>
 <161307031421.1254594.40010291545314425@swboyd.mtv.corp.google.com>
 <eef269e5-e16d-90ef-d765-8f50d7e2176a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eef269e5-e16d-90ef-d765-8f50d7e2176a@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:03:16 up 28 days, 17:27, 89 users,  load average: 0.47, 0.29,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 12:48:06 +0000, Colin Ian King wrote:
> On 11/02/2021 19:05, Stephen Boyd wrote:
> > Quoting Michael Tretter (2021-02-10 23:39:06)
> >> On Wed, 10 Feb 2021 19:28:18 -0800, Stephen Boyd wrote:
> >>> Quoting Colin King (2021-02-10 10:49:38)
> >>>> From: Colin Ian King <colin.king@canonical.com>
> >>>>
> >>>> The pointer 'divider' has previously been null checked followed by
> >>>> a return, hence the subsequent null check is redundant deadcode
> >>>> that can be removed.  Clean up the code and remove it.
> >>>>
> >>>> Fixes: 9c789deea206 ("soc: xilinx: vcu: implement clock provider for output clocks")
> >>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >>>> ---
> >>>>  drivers/clk/xilinx/xlnx_vcu.c | 3 ---
> >>>>  1 file changed, 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
> >>>> index d66b1315114e..607936d7a413 100644
> >>>> --- a/drivers/clk/xilinx/xlnx_vcu.c
> >>>> +++ b/drivers/clk/xilinx/xlnx_vcu.c
> >>>> @@ -512,9 +512,6 @@ static void xvcu_clk_hw_unregister_leaf(struct clk_hw *hw)
> >>>>  
> >>>>         mux = clk_hw_get_parent(divider);
> >>>>         clk_hw_unregister_mux(mux);
> >>>> -       if (!divider)
> >>>> -               return;
> >>>> -
> >>>
> >>> This code is pretty confusing. Waiting for m.tretter@pengutronix.de to
> >>> reply
> >>
> >> Can you elaborate what you find confusing about this code. I would gladly try
> >> to clarify and improve the code.
> > 
> > The fact that pointers are being checked and then bailing out of the
> > function early, vs. doing something if the pointer is non-NULL.
> > 
> >>
> >> What happens here is that the driver registers a mux -> divider -> gate chain
> >> for each output clock, but only stores the gate clock. When unregistering the
> >> clocks, the driver starts at the gate and walks up to the mux while
> >> unregistering the clocks.
> >>
> 
> OK, so I think I understand this better, should the order of
> unregisteration be as follows:
> 
> diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
> index d66b1315114e..66bac8421460 100644
> --- a/drivers/clk/xilinx/xlnx_vcu.c
> +++ b/drivers/clk/xilinx/xlnx_vcu.c
> @@ -511,11 +511,11 @@ static void xvcu_clk_hw_unregister_leaf(struct
> clk_hw *hw)
>                 return;
> 
>         mux = clk_hw_get_parent(divider);
> -       clk_hw_unregister_mux(mux);
> -       if (!divider)
> +       clk_hw_unregister_mux(divider);

The order is correct, but this must be:

	clk_hw_unregister_divider(divider);

> +       if (!mux)
>                 return;
> 
> -       clk_hw_unregister_divider(divider);
> +       clk_hw_unregister_divider(mux);
> 

	clk_hw_unregister_mux(mux);

Taking the confusion expressed by Stephen into account, I rewrote the entire
function to clarify what is happening in this function. Please take a look
that patch [0] and tell me, if it is now easier to understand.

[0] 20210318144230.3438009-1-m.tretter@pengutronix.de

Michael
