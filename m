Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5183A42D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhFKNPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhFKNPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87BAE613E3;
        Fri, 11 Jun 2021 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623417192;
        bh=GlR3ucjcwaQR6yiH4I8Q2YRRt5O0WomVF9cBXnMH6FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpXZseUFxwK/YzhdgZWO92HqluV2xAj0W+ODnbk9ZpY6ckEysYk8OD9gHm+0oIXCH
         Xd78Lkwml2tqxB3qjQ6P34oiw7qM4c1fRdZDDgVeLyR6cIPeR/Ql5rHnjFp5pV+hfY
         6IxSD688fKnc/1lV4ETaXsMJJeuRGOAiKTFbcaRY=
Date:   Fri, 11 Jun 2021 15:13:09 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
Cc:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xuetao (kirin)" <xuetao09@huawei.com>,
        "chenyu (U)" <chenyu56@huawei.com>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
Subject: Re: [PATCH v2] xhci: solve a double free problem while doing s4
Message-ID: <YMNhZdRN/qsySpSp@kroah.com>
References: <1623403104-121391-1-git-send-email-xuetao09@huawei.com>
 <3f5f7a1a46a847ca8bb793050cf30b98@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f5f7a1a46a847ca8bb793050cf30b98@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:08:30AM +0000, Zhangjiantao (Kirin, nanjing) wrote:
> when system is doing s4, the process of xhci_resume may be as below:
> 1、xhci_mem_cleanup
> 2、xhci_init->xhci_mem_init->xhci_mem_cleanup(when memory is not enough).
> xhci_mem_cleanup will be executed twice when system is out of memory.
> xhci->port_caps is freed in xhci_mem_cleanup,but it isn't set to NULL.
> It will be freed twice when xhci_mem_cleanup is called the second time.
> 
> We got following bug when system resumes from s4:
> 
> kernel BUG at mm/slub.c:309!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> CPU: 0 PID: 5929 Tainted: G S   W   5.4.96-arm64-desktop #1
> pc : __slab_free+0x5c/0x424
> lr : kfree+0x30c/0x32c
> 
> Call trace:
>  __slab_free+0x5c/0x424
>  kfree+0x30c/0x32c
>  xhci_mem_cleanup+0x394/0x3cc
>  xhci_mem_init+0x9ac/0x1070
>  xhci_init+0x8c/0x1d0
>  xhci_resume+0x1cc/0x5fc
>  xhci_plat_resume+0x64/0x70
>  platform_pm_thaw+0x28/0x60
>  dpm_run_callback+0x54/0x24c
>  device_resume+0xd0/0x200
>  async_resume+0x24/0x60
>  async_run_entry_fn+0x44/0x110
>  process_one_work+0x1f0/0x490
>  worker_thread+0x5c/0x450
>  kthread+0x158/0x160
>  ret_from_fork+0x10/0x24
> 
> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> Signed-off-by: Tao Xue <xuetao09@huawei.com>
> ---
>  drivers/usb/host/xhci-mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c index f66815f..e4b0c04 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1924,6 +1924,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>  	xhci->hw_ports = NULL;
>  	xhci->rh_bw = NULL;
>  	xhci->ext_caps = NULL;
> +	xhci->port_caps = NULL;
>  
>  	xhci->page_size = 0;
>  	xhci->page_shift = 0;
> --
> 2.7.4
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
