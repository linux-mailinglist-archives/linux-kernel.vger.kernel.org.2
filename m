Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850A74480CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhKHOIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:08:40 -0500
Received: from netrider.rowland.org ([192.131.102.5]:37655 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236375AbhKHOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:08:39 -0500
Received: (qmail 1666786 invoked by uid 1000); 8 Nov 2021 09:05:53 -0500
Date:   Mon, 8 Nov 2021 09:05:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v0 16/42] USB: Check notifier registration return value
Message-ID: <20211108140553.GA1666297@rowland.harvard.edu>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-17-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108101157.15189-17-bp@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:11:31AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.

This is a rather misleading description.  The patch does exactly the 
opposite: It _adds_ a homegrown notifier registration check.  (Homegrown 
in the sense that the check is made by the individual caller rather than 
being centralized in the routine being called.)

Alan Stern

> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/core/notify.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/notify.c b/drivers/usb/core/notify.c
> index e6143663778f..80d1bfa61887 100644
> --- a/drivers/usb/core/notify.c
> +++ b/drivers/usb/core/notify.c
> @@ -28,7 +28,8 @@ static BLOCKING_NOTIFIER_HEAD(usb_notifier_list);
>   */
>  void usb_register_notify(struct notifier_block *nb)
>  {
> -	blocking_notifier_chain_register(&usb_notifier_list, nb);
> +	if (blocking_notifier_chain_register(&usb_notifier_list, nb))
> +		pr_warn("USB change notifier already registered\n");
>  }
>  EXPORT_SYMBOL_GPL(usb_register_notify);
>  
> -- 
> 2.29.2
> 
