Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2ED376860
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhEGQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:00:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59983 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231130AbhEGQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:00:08 -0400
Received: (qmail 780607 invoked by uid 1000); 7 May 2021 11:59:08 -0400
Date:   Fri, 7 May 2021 11:59:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] USB: reset-resume the device when PORT_SUSPEND is
 set but timeout
Message-ID: <20210507155908.GB776548@rowland.harvard.edu>
References: <20210507093329.895-1-chris.chiu@canonical.com>
 <20210507093329.895-2-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507093329.895-2-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 05:33:28PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> On the Realtek hub of Dell Dock WD19, the port which has wakeup
> enabled descendants will sometimes timeout when setting PORT_SUSPEND
> feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
> already set. However, the hub will fail to activate because the
> PORT_SUSPEND feature of that port is not cleared during resume. All
> devices connecting via the port are lost after resume.
> 
> This commit force reset-resume the device connected to the timeout
> but suspended port so that the hub will have chance to clear the
> PORT_SUSPEND feature during resume.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  drivers/usb/core/hub.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b2bc4b7c4289..18603949a8de 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3385,6 +3385,21 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  		status = 0;
>  	}
>  	if (status) {
> +		if (status == -ETIMEDOUT) {
> +			u16 portstatus, portchange;
> +
> +			status = hub_port_status(hub, port1, &portstatus,
> +					&portchange);

Don't reuse status like this.  There will be a problem if this line sets 
status to 0 but the port isn't actually suspended.  Use a different 
variable instead.

Alan Stern

> +
> +			dev_dbg(&port_dev->dev,
> +				"suspend timeout, status %04x\n", portstatus);
> +
> +			if (status == 0 && port_is_suspended(hub, portstatus)) {
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
