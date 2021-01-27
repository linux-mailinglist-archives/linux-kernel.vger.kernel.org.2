Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196B1305F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhA0PVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235534AbhA0PPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:15:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9588C2076E;
        Wed, 27 Jan 2021 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611760491;
        bh=dhQVerM0dJxW7QcpoyXF81wXi+UcsALJRxGRjatx37c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YufKGc/5FJwdePpvyUGT/njPl4oMe7RZLGSEtJzJCIIp3FytvvuV6aPURqURV5KWB
         2y1AOWyH5l4aQQcmNlQ8dqxRfjAdi6s8NF69klfJnEIAhZX35CzfOYd/zh8wsj+dJJ
         mXT2Z7cLWFONgy1f6Qmyds9uVbzMZ/o/zgmscIqgJb5Mm6g9DPZ2iYDAJH9QiuLeoI
         Fk0hx/vFmsRofPvfp/fHNb6KH2HuVEjQAF9VPxYmkwpRJ4bJtISdpLhJj4xWJonOz0
         +7OySH5lH+9PCUSzYSfvcUIaoGsXmkWP296nUfaizDsWGtP0xCvqdkv5l9quhHBcpW
         iWbuI86m5Ax5w==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4mX9-000212-2Q; Wed, 27 Jan 2021 16:15:03 +0100
Date:   Wed, 27 Jan 2021 16:15:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Evgeny Novikov <novikov@ispras.ru>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/12] usb: misc: lvstest: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <YBGDdyfVNKOvZPJr@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183943.914631-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183943.914631-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:09:43AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_{recv|send}() and the return value checking conditions have
> also been modified appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/lvstest.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)

> @@ -336,10 +330,10 @@ static void lvs_rh_work(struct work_struct *work)
>  
>  	/* Examine each root port */
>  	for (i = 1; i <= descriptor->bNbrPorts; i++) {
> -		ret = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
> +		ret = usb_control_msg_recv(hdev, 0,
>  			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, i,
> -			port_status, sizeof(*port_status), 1000);
> -		if (ret < 4)
> +			port_status, sizeof(*port_status), 1000, GFP_KERNEL);
> +		if (ret < 0)
>  			continue;

I'm afraid this may introduce a regression as well since the
sizeof(*port_status) is 8 for some devices and the driver only cares
about the first 4 that all devices use (i.e. it is written to handle
short reads).

>  		portchange = le16_to_cpu(port_status->wPortChange);
> @@ -420,13 +414,13 @@ static int lvs_rh_probe(struct usb_interface *intf,
>  	usb_set_intfdata(intf, lvs);
>  
>  	/* how many number of ports this root hub has */
> -	ret = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
> +	ret = usb_control_msg_recv(hdev, 0,
>  			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN | USB_RT_HUB,
>  			USB_DT_SS_HUB << 8, 0, &lvs->descriptor,
> -			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
> -	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
> +			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
> +	if (ret < 0) {
>  		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
> -		return ret < 0 ? ret : -EINVAL;
> +		return ret;
>  	}

This looks like it may break for similar reasons.

Johan
