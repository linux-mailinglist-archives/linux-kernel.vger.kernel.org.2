Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA63204D6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBTJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:49:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:40939 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhBTJt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:49:26 -0500
IronPort-SDR: lFj1AzefuRA5ACqTegbYsNQqx8EwJlr+RDD2JB3lQLLmBF8M/F9/XMqEWqUSjOPh6qzhgSMDbt
 OpKzNW92946g==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="268940687"
X-IronPort-AV: E=Sophos;i="5.81,192,1610438400"; 
   d="scan'208";a="268940687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 01:48:45 -0800
IronPort-SDR: 9adtJopHLObI4Buw1EoCxcKSFXrM6VkDSAQxB4py9rQVCnGk4bB+hKlo2vcqMwfKTEZH4ybIjp
 cRDL7Ap/sFWA==
X-IronPort-AV: E=Sophos;i="5.81,192,1610438400"; 
   d="scan'208";a="387633482"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 01:48:44 -0800
Date:   Sat, 20 Feb 2021 17:48:42 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
Message-ID: <20210220094842.GB30008@shuo-intel.sh.intel.com>
References: <20210219092612.7533-1-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210219092612.7533-1-yejune.deng@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.

On Fri 19.Feb'21 at 17:26:12 +0800, Yejune Deng wrote:
>In acrn_irqfd_assign(), use vfs_poll() is a more advanced function,
>as the same time, modify the definition of events.
>
>Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
>---
> drivers/virt/acrn/irqfd.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
>index a8766d528e29..19890396e174 100644
>--- a/drivers/virt/acrn/irqfd.c
>+++ b/drivers/virt/acrn/irqfd.c
>@@ -112,9 +112,9 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
> {
> 	struct eventfd_ctx *eventfd = NULL;
> 	struct hsm_irqfd *irqfd, *tmp;
>-	unsigned int events;
> 	struct fd f;
> 	int ret = 0;
>+	__poll_t events;

Can you keep variable declarations is reverse fir tree order which this
driver follows?

>
> 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
> 	if (!irqfd)
>@@ -158,7 +158,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
> 	mutex_unlock(&vm->irqfds_lock);
>
> 	/* Check the pending event in this stage */
>-	events = f.file->f_op->poll(f.file, &irqfd->pt);
>+	events = vfs_poll(f.file, &irqfd->pt);
>
> 	if (events & POLLIN)
> 		acrn_irqfd_inject(irqfd);
>-- 
>2.29.0
>
