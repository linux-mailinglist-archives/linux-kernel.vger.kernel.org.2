Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2F42EC69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhJOIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhJOIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:34:25 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:32:19 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbIdP-0001aj-JY; Fri, 15 Oct 2021 10:32:11 +0200
Date:   Fri, 15 Oct 2021 10:32:11 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove MSG_88E calls from
 hal/usb_halinit.c
Message-ID: <20211015083211.ngbgtmhkh3lh5kzj@viti.kaiser.cx>
References: <20211015000233.842-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015000233.842-1-phil@philpotter.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Phillip Potter (phil@philpotter.co.uk):

> Remove both MSG_88E calls from hal/usb_halinit.c, as these calls serve
> no purpose other than to print the name of the function they are in
> (_ReadAdapterInfo8188EU) on entry and on exit, with a timing of the
> function, which is better accomplished by other means. Also remove
> the jiffies assignment at the start of the function, as it is no
> longer used.

> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/hal/usb_halinit.c | 6 ------
>  1 file changed, 6 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index f6db5b05e6e7..abbd107ad3c1 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -1073,15 +1073,9 @@ static void _ReadRFType(struct adapter *Adapter)

>  static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
>  {
> -	u32 start = jiffies;
> -
> -	MSG_88E("====> %s\n", __func__);
> -
>  	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
>  	_ReadPROMContent(Adapter);

> -	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
> -
>  	return _SUCCESS;
>  }

Makes sense to me. We should get rid of the prints that show only the
function name.

Acked-by: Martin Kaiser <martin@kaiser.cx>
