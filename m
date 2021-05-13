Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C937F9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhEMOg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:36:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51319 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234496AbhEMOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:36:40 -0400
Received: (qmail 968704 invoked by uid 1000); 13 May 2021 10:35:29 -0400
Date:   Thu, 13 May 2021 10:35:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] USB: Verify the port status when timeout happens
 during port suspend
Message-ID: <20210513143529.GD967812@rowland.harvard.edu>
References: <20210513041446.3082-1-chris.chiu@canonical.com>
 <20210513041446.3082-2-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513041446.3082-2-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:14:45PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
> enabled_descendants will sometimes timeout when setting PORT_SUSPEND
> feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> already set. However, the hub will fail to activate because the
> PORT_SUSPEND feature of that port is not cleared during resume. All
> connected devices are lost after resume.

The last two sentences of this paragraph are now inaccurate.  Please fix 
them up to match the current patch version.

> Check the port status to verify whether it's really suspended when
> timeout happpens. If yes, mark it as suspended so the device can
> be resumed correctly.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
> 
> Changelog:
>   v3:
>     - create a new goto target for the timeout case instead of
>       reset_resume
>     - Revise the commit title/message because reset_resume is not
>       required.
>   v2:
>     - create a new variable to keep the result of hub_port_status
>       when suspend timeout.
> 
>  drivers/usb/core/hub.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b2bc4b7c4289..c5d64175eaa9 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3385,6 +3385,21 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  		status = 0;
>  	}
>  	if (status) {
> +		if (status == -ETIMEDOUT) {
> +			u16 portstatus, portchange;
> +

Extra blank line.

> +			int ret = hub_port_status(hub, port1, &portstatus,
> +					&portchange);
> +
> +			dev_dbg(&port_dev->dev,
> +				"suspend timeout, status %04x\n", portstatus);

The portstatus value shouldn't be printed if ret < 0, because it won't 
be initialized.  If you want, initialize portstatus to 0 in the 
declaration.

Also, there should be a comment here explaining why this code is needed.  
It should say pretty the same thing as the patch description, but more 
briefly (two sentences should be sufficient).

Alan Stern

> +
> +			if (ret == 0 && port_is_suspended(hub, portstatus)) {
> +				status = 0;
> +				goto suspend_done;
> +			}
> +		}
> +
>  		dev_dbg(&port_dev->dev, "can't suspend, status %d\n", status);
>  
>  		/* Try to enable USB3 LTM again */
> @@ -3401,6 +3416,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  		if (!PMSG_IS_AUTO(msg))
>  			status = 0;
>  	} else {
> + suspend_done:
>  		dev_dbg(&udev->dev, "usb %ssuspend, wakeup %d\n",
>  				(PMSG_IS_AUTO(msg) ? "auto-" : ""),
>  				udev->do_remote_wakeup);
> -- 
> 2.20.1
> 
