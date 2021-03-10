Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3E3336FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhCJIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:09:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:60996 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhCJIIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:08:49 -0500
IronPort-SDR: /vmSsWikJ30b9Qlho0+oFul3cz0/rvrAyrJhegq52DXePX/QLeJq2e1aHuY7Ha7VktfCfhbUxU
 UFcNOp4sEhnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188511327"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188511327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 00:08:49 -0800
IronPort-SDR: ysq/XhbmqGm97GPbL8qQv+xI5MJVVge+K9BWlyR7+S6vVpd6wXIUrV8vK80nM9VHgz/4QddV7B
 rgmyBWzNXspQ==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="410088388"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 00:08:47 -0800
Date:   Wed, 10 Mar 2021 16:08:45 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] virt: acrn: Use EPOLLIN instead of POLLIN
Message-ID: <20210310080845.GA28452@shuo-intel.sh.intel.com>
References: <20210310074901.7486-1-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210310074901.7486-1-yejune.deng@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10.Mar'21 at 15:49:01 +0800, Yejune Deng wrote:
>This fixes the following sparse warning:
>"sparse warnings: (new ones prefixed by >>)"
>>> drivers/virt/acrn/irqfd.c:163:13: sparse: sparse: restricted __poll_t
> degrades to integer
>
>Fixes: 803c1aadecdb("virt: acrn: Use vfs_poll() instead of f_op->poll()")
>Reported-by: kernel test robot <lkp@intel.com>
>Signed-off-by: Yejune Deng <yejune.deng@gmail.com>

Thanks for the patch.
Acked-by: Shuo Liu <shuo.a.liu@intel.com>

>---
> drivers/virt/acrn/irqfd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
>index 98d6e9b18f9e..df5184979b28 100644
>--- a/drivers/virt/acrn/irqfd.c
>+++ b/drivers/virt/acrn/irqfd.c
>@@ -160,7 +160,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
> 	/* Check the pending event in this stage */
> 	events = vfs_poll(f.file, &irqfd->pt);
>
>-	if (events & POLLIN)
>+	if (events & EPOLLIN)
> 		acrn_irqfd_inject(irqfd);
>
> 	fdput(f);
>-- 
>2.29.0
>
