Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81237F9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhEMOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:41:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57695 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234530AbhEMOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:41:28 -0400
Received: (qmail 968858 invoked by uid 1000); 13 May 2021 10:40:18 -0400
Date:   Thu, 13 May 2021 10:40:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Revert "USB: Add reset-resume quirk for WD19's
 Realtek Hub"
Message-ID: <20210513144018.GE967812@rowland.harvard.edu>
References: <20210513041446.3082-1-chris.chiu@canonical.com>
 <20210513041446.3082-3-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513041446.3082-3-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:14:46PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> This reverts commit ca91fd8c7643d93bfc18a6fec1a0d3972a46a18a. The

Use the proper format for referring to commits: just the first 12 hex 
digits of the commit ID, followed by the commit's name in parentheses 
and quotation marks.  See other patch submissions in the mailing list 
archives for examples.

> problematic hub should be taken care for each setting PORT_SUSPEND
> feature timeout instead of reset-resume all the time.

The last sentence is not grammatical.  It should say something more 
like:

	The previous patch in this series now handles problematic hubs
	by checking the port status when a PORT_SUSPEND timeout occurs,
	so we don't need to use reset-resume all the time.

Alan Stern

> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  drivers/usb/core/quirks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 21e7522655ac..6114cf83bb44 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -406,7 +406,6 @@ static const struct usb_device_id usb_quirk_list[] = {
>  
>  	/* Realtek hub in Dell WD19 (Type-C) */
>  	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> -	{ USB_DEVICE(0x0bda, 0x5487), .driver_info = USB_QUIRK_RESET_RESUME },
>  
>  	/* Generic RTL8153 based ethernet adapters */
>  	{ USB_DEVICE(0x0bda, 0x8153), .driver_info = USB_QUIRK_NO_LPM },
> -- 
> 2.20.1
> 
