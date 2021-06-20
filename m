Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98013ADE8E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFTNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhFTNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 09:34:17 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 06:32:04 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1luxYL-0006ok-96; Sun, 20 Jun 2021 15:31:57 +0200
Date:   Sun, 20 Jun 2021 15:31:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: remove useless comment
Message-ID: <20210620133157.myatkutw2ts26cvj@viti.kaiser.cx>
References: <20210619175055.5122-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619175055.5122-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> Remove block comment about function HwSuspendModeEnable92Cu.
> The comment contains no useful information and there is even
> no HwSuspendModeEnable92Cu function in the driver code.
> 'git grep -n HwSuspendModeEnable92Cu drivers/staging/rtl8188eu'
> returns nothing.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8188eu/hal/usb_halinit.c | 16 ----------------
>  1 file changed, 16 deletions(-)

> diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> index dcdf868b394d..6c88675ae251 100644
> --- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> @@ -601,22 +601,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
>  		haldata->CurAntenna = Antenna_B;
>  }

> -/*-----------------------------------------------------------------------------
> - * Function:	HwSuspendModeEnable92Cu()
> - *
> - * Overview:	HW suspend mode switch.
> - *
> - * Input:		NONE
> - *
> - * Output:	NONE
> - *
> - * Return:	NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	08/23/2010	MHC		HW suspend mode switch test..
> - *---------------------------------------------------------------------------
> - */
>  enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
>  {
>  	u8 val8;
> -- 
> 2.32.0

You're right. The function for this comment is already gone.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
