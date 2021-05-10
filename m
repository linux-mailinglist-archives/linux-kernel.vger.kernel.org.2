Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2DF3791F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhEJPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:06:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38697 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232164AbhEJPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:03:15 -0400
Received: (qmail 865031 invoked by uid 1000); 10 May 2021 11:02:03 -0400
Date:   Mon, 10 May 2021 11:02:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] USB: reset-resume the device when PORT_SUSPEND is
 set but timeout
Message-ID: <20210510150203.GD863718@rowland.harvard.edu>
References: <20210510145030.1495-1-chris.chiu@canonical.com>
 <20210510145030.1495-2-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510145030.1495-2-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:50:29PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
> enabled_descendants will sometimes timeout when setting PORT_SUSPEND
> feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> already set. However, the hub will fail to activate because the
> PORT_SUSPEND feature of that port is not cleared during resume. All
> connected devices are lost after resume.
> 
> This commit force reset-resume the device connected to the timeout
> but suspended port so that the hub will have chance to clear the
> PORT_SUSPEND feature during resume.

Are you certain that the reset-resume is needed?  What happens if you 
leave out the line that sets udev->reset_resume?  The rest of the patch 
will cause the kernel to realize that the port really is suspended, so 
maybe the suspend feature will get cleared properly during resume.

It's worthwhile to try the experiement and see what happens.

Alan Stern

> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
> 
> Changelog:
>   v2:
>     - create a new variable to keep the result of hub_port_status
>       when suspend timeout.
> 
>  drivers/usb/core/hub.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b2bc4b7c4289..3c823544e425 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3385,6 +3385,21 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  		status = 0;
>  	}
>  	if (status) {
> +		if (status == -ETIMEDOUT) {
> +			u16 portstatus, portchange;
> +
> +			int ret = hub_port_status(hub, port1, &portstatus,
> +					&portchange);
> +
> +			dev_dbg(&port_dev->dev,
> +				"suspend timeout, status %04x\n", portstatus);
> +
> +			if (ret == 0 && port_is_suspended(hub, portstatus)) {
> +				udev->reset_resume = 1;
> +				goto err_wakeup;
> +			}
> +		}
> +
>  		dev_dbg(&port_dev->dev, "can't suspend, status %d\n", status);
>  
>  		/* Try to enable USB3 LTM again */
> -- 
> 2.20.1
> 
