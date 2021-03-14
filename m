Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04C33A263
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 03:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhCNC3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 21:29:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhCNC3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 21:29:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A28A64E62;
        Sun, 14 Mar 2021 02:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615688960;
        bh=mt760bIfNdFduP4gxeD2h1k3Vjred890jDgDdCPGWbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCyT1ewNJq3FoqH4CWB/FKvn0cDgTHXq9uoU8QZhJ0d1vBvvvHei6gcYpwYR4wDfp
         eMsDtVerSGEseO7wQwXhrYZahe7SC83ved2Mi9vZ6k51/WLGptCaWVxS27qxrOFvBE
         0O37DDYHhH8XwwjmGgKkWVXNX8b9We1i7fzNuqdxclHWSsIccn+MDdc4adMWoN/WWN
         hCvD+6eKJpeLYQ0PRkMj8EP82SH7EHj8DxsFE9NKoShc1jzFw8H5Na5fA8y7l6fEP/
         3zP6o39MOMPI7cJHPKJdV2ZSlUF+rxAQJqJz8Swbp2/vfAefjLob/9JmOeaWA7YJcj
         YDnlxkhAfceCQ==
Date:   Sun, 14 Mar 2021 10:29:14 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com
Subject: Re: [PATCH v2] usb: gadget: uvc: add bInterval checking for HS mode
Message-ID: <20210314022914.GC17526@b29397-desktop>
References: <20210308125338.4824-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308125338.4824-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-08 13:53:38, Pawel Laszczak wrote:
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
> 
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
> -- 
> 2.25.1
> 

Reviewed-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen

