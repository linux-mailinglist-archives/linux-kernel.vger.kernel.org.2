Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE093F4921
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhHWK5O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhHWK5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:57:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:56:25 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mI7cu-00036Y-20; Mon, 23 Aug 2021 12:56:24 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mI7ct-0005KP-4l; Mon, 23 Aug 2021 12:56:23 +0200
Message-ID: <8c6674e387615b49bf2aa3304bd49c0e99e37094.camel@pengutronix.de>
Subject: Re: [PATCH] reset: reset-zynqmp: Fixed the argument data type
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 23 Aug 2021 12:56:23 +0200
In-Reply-To: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
References: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
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

Hi Michal,

On Wed, 2021-06-23 at 13:46 +0200, Michal Simek wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> 
> This patch changes the data type of the variable 'val' from
> int to u32.
> 
> Addresses-Coverity: argument of type "int *" is incompatible with parameter of type "u32 *"
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
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
>  
>  	err = zynqmp_pm_reset_get_status(priv->data->reset_id + id, &val);
>  	if (err)

Thank you, applied to reset/fixes.

regards
Philipp
