Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC82D43CC12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbhJ0O06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:26:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41575 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S238277AbhJ0O0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:26:50 -0400
Received: (qmail 1320616 invoked by uid 1000); 27 Oct 2021 10:24:22 -0400
Date:   Wed, 27 Oct 2021 10:24:22 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v2 1/2] usb: gadget: udc: core: Revise comments for
 usb_ep_disable()
Message-ID: <20211027142422.GA1319606@rowland.harvard.edu>
References: <1635303025-772-1-git-send-email-quic_wcheng@quicinc.com>
 <1635303025-772-2-git-send-email-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635303025-772-2-git-send-email-quic_wcheng@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 07:50:24PM -0700, Wesley Cheng wrote:
> The usb_ep_disable() routine is being widely used directly in the
> disconnect callback path by function drivers.  Hence, the statement
> about it being able to only run in process context may not be true.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/gadget/udc/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index d626511..e1f90d8 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -136,8 +136,6 @@ EXPORT_SYMBOL_GPL(usb_ep_enable);
>   * gadget drivers must call usb_ep_enable() again before queueing
>   * requests to the endpoint.
>   *
> - * This routine must be called in process context.
> - *
>   * returns zero, or a negative error code.
>   */
>  int usb_ep_disable(struct usb_ep *ep)

You should also change the kerneldoc for usb_ep_enable.  Neither routine 
needs to be called in process context.

In fact, it might be good to change both comments to:

 * This routine may be called in an atomic (interrupt) context.

just to be totally explicit.

Alan Stern
