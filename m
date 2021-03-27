Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3150334B369
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 01:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC0AsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 20:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhC0Ar7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 20:47:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1D03619F2;
        Sat, 27 Mar 2021 00:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616806079;
        bh=8ooecOatcSAJ+gzaT/9xOpTGALqDjn2dglYYs0Fm+aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMc/1weQ0un9Dec888CHQzkWIDeKSZIWFUyITh+MjnLnrnvUfJ38Vv2ZT1bJ98vyh
         o+ZkgAPlkRJCdribUQyrF4SR24tmYE615kPvySqbLqj+yjUk/awmKjtqAQdvdWUmlq
         TI3BOwIDqDmeFkJeggtpvUtHfWcdYLOUtNm+0QInNu0lIyPd662GVVxEW88iciY5t0
         p/mZmhVUdqozv7w7HLhJwUKb6jU/1fjrhbSzH0cz6mj6hg/hM/u4wrpVXr6kL157h0
         1fm4mirAb+ViIompSOz22BO0+zztgyqNL/vWvrf9X3hJ6TDpU/GVrvBl6OM7Y/BbPI
         y00orFODGKn5w==
Date:   Sat, 27 Mar 2021 08:47:55 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2] usb: cdnsp: Fixes issue with dequeuing requests after
 disabling endpoint
Message-ID: <20210327004754.GA28870@b29397-desktop>
References: <20210322054714.47151-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322054714.47151-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-22 06:47:14, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch fixes the bug:
> BUG: kernel NULL pointer dereference, address: 0000000000000050
> PGD 0 P4D 0
> Oops: 0002 [#1] SMP PTI
> CPU: 0 PID: 4137 Comm: uvc-gadget Tainted: G           OE     5.10.0-next-20201214+ #3
> Hardware name: ASUS All Series/Q87T, BIOS 0908 07/22/2014
> RIP: 0010:cdnsp_remove_request+0xe9/0x530 [cdnsp_udc_pci]
> Code: 01 00 00 31 f6 48 89 df e8 64 d4 ff ff 48 8b 43 08 48 8b 13 45 31 f6 48 89 42 08 48 89 10 b8 98 ff ff ff 48 89 1b 48 89 5b 08 <41> 83 6d 50 01 41 83 af d0 00 00 00 01 41 f6 84 24 78 20 00 00 08
> RSP: 0018:ffffb68d00d07b60 EFLAGS: 00010046
> RAX: 00000000ffffff98 RBX: ffff9d29c57fbf00 RCX: 0000000000001400
> RDX: ffff9d29c57fbf00 RSI: 0000000000000000 RDI: ffff9d29c57fbf00
> RBP: ffffb68d00d07bb0 R08: ffff9d2ad9510a00 R09: ffff9d2ac011c000
> R10: ffff9d2a12b6e760 R11: 0000000000000000 R12: ffff9d29d3fb8000
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff9d29d3fb88c0
> FS:  0000000000000000(0000) GS:ffff9d2adba00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000050 CR3: 0000000102164005 CR4: 00000000001706f0
> Call Trace:
>  cdnsp_ep_dequeue+0x3c/0x90 [cdnsp_udc_pci]
>  cdnsp_gadget_ep_dequeue+0x3f/0x80 [cdnsp_udc_pci]
>  usb_ep_dequeue+0x21/0x70 [udc_core]
>  uvcg_video_enable+0x19d/0x220 [usb_f_uvc]
>  uvc_v4l2_release+0x49/0x90 [usb_f_uvc]
>  v4l2_release+0xa5/0x100 [videodev]
>  __fput+0x99/0x250
>  ____fput+0xe/0x10
>  task_work_run+0x75/0xb0
>  do_exit+0x370/0xb80
>  do_group_exit+0x43/0xa0
>  get_signal+0x12d/0x820
>  arch_do_signal_or_restart+0xb2/0x870
>  ? __switch_to_asm+0x36/0x70
>  ? kern_select+0xc6/0x100
>  exit_to_user_mode_prepare+0xfc/0x170
>  syscall_exit_to_user_mode+0x2a/0x40
>  do_syscall_64+0x43/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fe969cf5dd7
> Code: Unable to access opcode bytes at RIP 0x7fe969cf5dad.
> 
> Problem occurs for UVC class. During disconnecting the UVC class disable
> endpoints and then start dequeuing all requests. This leads to situation
> where requests are removed twice. The first one in
> cdnsp_gadget_ep_disable and the second in cdnsp_gadget_ep_dequeue
> function.
> Patch adds condition in cdnsp_gadget_ep_dequeue function which allows
> dequeue requests only from enabled endpoint.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> 
> ---
> Changelog:
> v2:
> - removed unexpected 'commit' word from fixes tag

Acked-by: Peter Chen <peter.chen@kernel.org>

Greg, would you help queue it to your usb-linus branch?

> 
>  drivers/usb/cdns3/cdnsp-gadget.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index f2ebbacd932e..d7d4bdd57f46 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1128,6 +1128,10 @@ static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
>  		return -ESHUTDOWN;
>  	}
>  
> +	/* Requests has been dequeued during disabling endpoint. */
> +	if (!(pep->ep_state & EP_ENABLED))
> +		return 0;
> +
>  	spin_lock_irqsave(&pdev->lock, flags);
>  	ret = cdnsp_ep_dequeue(pep, to_cdnsp_request(request));
>  	spin_unlock_irqrestore(&pdev->lock, flags);
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

