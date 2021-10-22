Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996B2437449
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhJVJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232532AbhJVJGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:06:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38078610EA;
        Fri, 22 Oct 2021 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634893427;
        bh=P+ywsJ2Bf8sf28DpGW5jUByITYwueQM+FB+Y2KKGxR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T25fqf7kExb+0NMwyMFXXxoW+vgqg4v2zUzXpgvr7oV3AEtBdXy0JrW4EOp5NfL57
         +OIPMPbtPlL2wdJH5PB7S1ga1aXzaHkK1KUACx9zopTI68lqjlf4yr9CcYEQAuWErb
         lTSfnUs///IRu1TvVOF7ziHNIXe1AkzEmCLPVyUg=
Date:   Fri, 22 Oct 2021 11:03:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: Make use of the helper macro
 kthread_run()
Message-ID: <YXJ+cfWj6NBIuUS5@kroah.com>
References: <20211021084328.2395-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021084328.2395-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:43:27PM +0800, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index a5e33da74726..6130b95aaca3 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1717,15 +1717,12 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
>  	write_unlock_bh(&arm_state->susp_res_lock);
>  	snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
>  		 state->id);
> -	arm_state->ka_thread = kthread_create(&vchiq_keepalive_thread_func,
> -					      (void *)state,
> -					      threadname);
> +	arm_state->ka_thread = kthread_run(&vchiq_keepalive_thread_func,
> +					   (void *)state, threadname);
>  	if (IS_ERR(arm_state->ka_thread)) {
>  		vchiq_log_error(vchiq_susp_log_level,
>  				"vchiq: FATAL: couldn't create thread %s",
>  				threadname);
> -	} else {
> -		wake_up_process(arm_state->ka_thread);
>  	}
>  }
>  

As others have pointed out for other busses where you sent this patch,
this is _VERY_ racy and probably wrong.  Be more careful when sending
changes like this that can modify functionality without testing the
code.

thanks,

greg k-h
