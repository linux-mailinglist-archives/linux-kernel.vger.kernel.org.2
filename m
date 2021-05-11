Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70D337AC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEKQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:40:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35313 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230435AbhEKQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:40:14 -0400
Received: (qmail 903532 invoked by uid 1000); 11 May 2021 12:39:07 -0400
Date:   Tue, 11 May 2021 12:39:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: Re: [PATCH] usb: core: hub: fix race condition about TRSMRCY of
 resume
Message-ID: <20210511163907.GB901897@rowland.harvard.edu>
References: <20210511101522.34193-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511101522.34193-1-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:15:22PM +0800, Chunfeng Yun wrote:
> This may happen if the port becomes resume status exactly
> when usb_port_resume() gets port status, it still need provide
> a TRSMCRY time before access the device.
> 
> Reported-by: Tianping Fang <tianping.fang@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

This should also say:

CC: <stable@vger.kernel.org>

> ---
>  drivers/usb/core/hub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index b2bc4b7c4289..fc7d6cdacf16 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3642,9 +3642,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  		 * sequence.
>  		 */
>  		status = hub_port_status(hub, port1, &portstatus, &portchange);
> -
> -		/* TRSMRCY = 10 msec */
> -		msleep(10);
>  	}
>  
>   SuspendCleared:
> @@ -3659,6 +3656,9 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  				usb_clear_port_feature(hub->hdev, port1,
>  						USB_PORT_FEAT_C_SUSPEND);
>  		}
> +
> +		/* TRSMRCY = 10 msec */
> +		msleep(10);
>  	}
>  
>  	if (udev->persist_enabled)

Acked-by: Alan Stern <stern@rowland.harvard.edu>
