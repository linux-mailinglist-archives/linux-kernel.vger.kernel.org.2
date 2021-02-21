Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292BE320809
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 02:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBUBvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 20:51:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:1080 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhBUBv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 20:51:29 -0500
IronPort-SDR: SW8zDtU7mFWvoGcnKM/xK6RwEjXNiRMBXB9ocrM4M7W8uuMxwL1DT7DPhqKiU1s6Knek4Xs97L
 Ufnv1SAiZxhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="163348949"
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="163348949"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 17:50:48 -0800
IronPort-SDR: zbPehEoTWBgLun78p5az7xp7IZ53u/2CzSm4TQ9Ylm7f+PZGPP9ItOYb1iUstVkpIUHmD9F3Yy
 g8CNPXvYnhAA==
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="401756043"
Received: from jzhao41-mobl1.ccr.corp.intel.com (HELO [10.255.30.119]) ([10.255.30.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 17:50:46 -0800
Subject: Re: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210220145351.14464-1-yejune.deng@gmail.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <714d4648-46d7-bc44-a9a2-5ce3c919897c@intel.com>
Date:   Sun, 21 Feb 2021 09:50:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210220145351.14464-1-yejune.deng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2021 22:53, Yejune Deng wrote:
> Use vfs_poll() is a more advanced function in acrn_irqfd_assign().
> as the same time, modify the definition of events.
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>

Thanks for the update.
Reviewed-by: Shuo Liu <shuo.a.liu@intel.com>

Hi Greg,
Need i do more work on this patch?
Or you will review and apply on your tree directly?

Thanks
shuo

> ---
>  drivers/virt/acrn/irqfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> index a8766d528e29..98d6e9b18f9e 100644
> --- a/drivers/virt/acrn/irqfd.c
> +++ b/drivers/virt/acrn/irqfd.c
> @@ -112,7 +112,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
>  {
>  	struct eventfd_ctx *eventfd = NULL;
>  	struct hsm_irqfd *irqfd, *tmp;
> -	unsigned int events;
> +	__poll_t events;
>  	struct fd f;
>  	int ret = 0;
>  
> @@ -158,7 +158,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
>  	mutex_unlock(&vm->irqfds_lock);
>  
>  	/* Check the pending event in this stage */
> -	events = f.file->f_op->poll(f.file, &irqfd->pt);
> +	events = vfs_poll(f.file, &irqfd->pt);
>  
>  	if (events & POLLIN)
>  		acrn_irqfd_inject(irqfd);
> 
