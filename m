Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD5436596
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhJUPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:16:17 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47165 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232249AbhJUPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:15:44 -0400
Received: (qmail 1161564 invoked by uid 1000); 21 Oct 2021 11:13:27 -0400
Date:   Thu, 21 Oct 2021 11:13:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: mass_storage: Make use of the helper macro
 kthread_run()
Message-ID: <20211021151327.GA1161262@rowland.harvard.edu>
References: <20211021084359.2607-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021084359.2607-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:43:58PM +0800, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 3cabf7692ee1..1e3cab5d635c 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2962,7 +2962,7 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>  	if (!common->thread_task) {
>  		common->state = FSG_STATE_NORMAL;
>  		common->thread_task =
> -			kthread_create(fsg_main_thread, common, "file-storage");
> +			kthread_run(fsg_main_thread, common, "file-storage");
>  		if (IS_ERR(common->thread_task)) {
>  			ret = PTR_ERR(common->thread_task);
>  			common->thread_task = NULL;
> @@ -2971,7 +2971,6 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>  		}
>  		DBG(common, "I/O thread pid: %d\n",
>  		    task_pid_nr(common->thread_task));
> -		wake_up_process(common->thread_task);
>  	}

We better not apply this patch for the same reason as the other one: 
It's probably not a good idea for the fsg_main_thread task to start 
running before common->thread_task has been assigned.

Alan Stern
