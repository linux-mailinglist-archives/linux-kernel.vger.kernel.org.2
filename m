Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654F333A26B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 03:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhCNClL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 21:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCNClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 21:41:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE7BC061574;
        Sat, 13 Mar 2021 18:41:09 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4099455C;
        Sun, 14 Mar 2021 03:41:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615689668;
        bh=WwUFKLT2ILP5xEgeIIFfNCe2ECsETBynuMHcIOfQuDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oY86x0apFBG+KREZaYavKIMz7BjKbaMm2G2EhL3oQnkiVdIaVNLt2CKqhhMHxngra
         3tQFcMJ14YaIzXyFUcmnfd3pN8ksx1RgMId+HNq2KELF2ZgblYhPN1Pk7HR+538Psw
         Tvxhr/hL6ho9s8Q0m+8JFbrInZUJgFTFHoOJd+kY=
Date:   Sun, 14 Mar 2021 04:40:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.chen@kernel.org, kurahul@cadence.com
Subject: Re: [PATCH v2] usb: gadget: uvc: add bInterval checking for HS mode
Message-ID: <YE13oOd2aWHSCYR8@pendragon.ideasonboard.com>
References: <20210308125338.4824-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308125338.4824-1-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

Thank you for the patch.

On Mon, Mar 08, 2021 at 01:53:38PM +0100, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch adds extra checking for bInterval passed by configfs.
> The 5.6.4 chapter of USB Specification (rev. 2.0) say:
> "A high-bandwidth endpoint must specify a period of 1x125 µs
> (i.e., a bInterval value of 1)."
> 
> The issue was observed during testing UVC class on CV.
> I treat this change as improvement because we can control
> bInterval by configfs.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Felipe, could you take this patch in your tree ?

> ---
> Changlog:
> v2:
> - removed duplicated assignment
> 
>  drivers/usb/gadget/function/f_uvc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 44b4352a2676..ed77a126a74f 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -633,7 +633,12 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	uvc_hs_streaming_ep.wMaxPacketSize =
>  		cpu_to_le16(max_packet_size | ((max_packet_mult - 1) << 11));
> -	uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
> +
> +	/* A high-bandwidth endpoint must specify a bInterval value of 1 */
> +	if (max_packet_mult > 1)
> +		uvc_hs_streaming_ep.bInterval = 1;
> +	else
> +		uvc_hs_streaming_ep.bInterval = opts->streaming_interval;
>  
>  	uvc_ss_streaming_ep.wMaxPacketSize = cpu_to_le16(max_packet_size);
>  	uvc_ss_streaming_ep.bInterval = opts->streaming_interval;

-- 
Regards,

Laurent Pinchart
