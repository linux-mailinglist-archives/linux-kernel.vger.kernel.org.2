Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1337D35A1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhDIPJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:09:29 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40409 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233878AbhDIPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:09:25 -0400
Received: (qmail 1334363 invoked by uid 1000); 9 Apr 2021 11:09:11 -0400
Date:   Fri, 9 Apr 2021 11:09:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [RFC PATCH] usb: core: reduce power-on-good delay time of root
 hub
Message-ID: <20210409150911.GC1333284@rowland.harvard.edu>
References: <1617935947-24045-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617935947-24045-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:39:07AM +0800, Chunfeng Yun wrote:
> Return the exactly delay time given by root hub descriptor,
> this helps to reduce resume time etc.
> 
> Due to the root hub descriptor is usually provided by the host
> controller driver, if there is compatibility for a root hub,
> we can fix it easily without affect other root hub
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/core/hub.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 73f4482d833a..22ea1f4f2d66 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -148,8 +148,10 @@ static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
>  {
>  	unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
>  
> -	/* Wait at least 100 msec for power to become stable */
> -	return max(delay, 100U);
> +	if (!hub->hdev->parent)	/* root hub */
> +		return delay;
> +	else /* Wait at least 100 msec for power to become stable */
> +		return max(delay, 100U);
>  }
>  
>  static inline int hub_port_debounce_be_connected(struct usb_hub *hub,
> -- 
> 2.18.0
> 
