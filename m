Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA70F3E8ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhHKKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhHKKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:36:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49123C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 03:36:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mDlaw-0007X3-Kn; Wed, 11 Aug 2021 12:36:22 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mDlav-0006UT-HD; Wed, 11 Aug 2021 12:36:21 +0200
Date:   Wed, 11 Aug 2021 12:36:21 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] reset: reset-zynqmp: Fixed the argument data type
Message-ID: <20210811103621.GA23827@pengutronix.de>
References: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:28:45 up 174 days, 13:52, 93 users,  load average: 0.02, 0.09,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 13:46:20 +0200, Michal Simek wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> 
> This patch changes the data type of the variable 'val' from
> int to u32.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Addresses-Coverity: argument of type "int *" is incompatible with parameter of type "u32 *"
> ---
> 
>  drivers/reset/reset-zynqmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index daa425e74c96..59dc0ff9af9e 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -53,7 +53,8 @@ static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
>  			       unsigned long id)
>  {
>  	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> -	int val, err;
> +	int err;
> +	u32 val;

The function returns val as int instead of u32. While this shouldn't be a
problem in this case, maybe there should be an additional check just to be
sure?

Michael

>  
>  	err = zynqmp_pm_reset_get_status(priv->data->reset_id + id, &val);
>  	if (err)
> -- 
> 2.32.0
