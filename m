Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCD3F94F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbhH0HTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbhH0HTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:19:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC689C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:18:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l2so4333693lfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+IaJSyNL4XREuBWuDPEiRbo2KPBBJ5fT6qyNyePHaw=;
        b=y+G6iIlpHNWO2KVAhN69bnLiEzDWsnLPF0tng6P0p3Jzp1kYmtwEpe0v8ZuGQP7R6N
         phMOcrdKEy7VCt5iVD5loFIab0ibDThJDNC5WiF20xXZN2lF6j/g4/Ws/S2lQLK1Q2VT
         wlWcYJej1ERzvjW12sX2oEjyZ6chuW35AMXy9rUZOVGoRiQl7jZFPKSA1GDcWKH32haM
         taWCNJnx1tc+204U7v0aLlPZ1A/nU7bEwFD1SnjsAKp9FhCwh4ESgBTIjZQLRFRgmhY+
         TB2VtWiyVL/gWYUqx2ZCeQdsVk8UpkICZ+ebdvHlr9Sr9kjZe2K7h6yCLelKLP+OV6Ge
         baLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+IaJSyNL4XREuBWuDPEiRbo2KPBBJ5fT6qyNyePHaw=;
        b=B9Y59wTbNq7mfIfupcz0ieIVVNzsm599zf1Bjur2Ul+2M8b6utO3k8NOck4iibLbFl
         WjcW+F+sMdtFumc2UjFaxQOxKUoVTg0O6ENpahm/1thMt6O91TlMMXYBBR7mXXbRnRT8
         11lZh8YlNTU3rBcOvppoLqww4jeccnMpgzVSdpd9Sy2wx9Msyw++adL5gCDpEqNUmXet
         4hWg7Ahu6h8macx5K9wv7m6KWGU9C3xwBy1M2flYoAI0ASBxsr5+A3/RwXqqE4TRqMpU
         W3h+xX5tWKXIBKypiFMO7c6aYM4RLa4GPlo+p4SjmXAwhSSgNZyY9L569pncYOoi2KLs
         DCpA==
X-Gm-Message-State: AOAM5325JILDFWSP0qwk9hqfkojJDZsKcH8j5YuGAKwaMa/B/UBg6QfT
        AZjzzC3pPHEvQ4hMX0ZE9NyZMQ==
X-Google-Smtp-Source: ABdhPJznjOCdiL0auSRnxZt0ZMAfi6ahqS92zMenjcjhZt+Q5aOpZtlUL2Oi4LINid49S57KHQYWdw==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr5535335lfm.343.1630048704725;
        Fri, 27 Aug 2021 00:18:24 -0700 (PDT)
Received: from jade (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id a23sm588234ljb.95.2021.08.27.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 00:18:24 -0700 (PDT)
Date:   Fri, 27 Aug 2021 09:18:22 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 4/5] optee: isolate smc abi
Message-ID: <20210827071822.GA1748471@jade>
References: <20210819110655.739318-1-jens.wiklander@linaro.org>
 <20210819110655.739318-5-jens.wiklander@linaro.org>
 <CAFA6WYOZsZKfG0ZO8LGMcvQG8-pV0Z=hGF2nDFg7OW2DQO0esw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYOZsZKfG0ZO8LGMcvQG8-pV0Z=hGF2nDFg7OW2DQO0esw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:11:00PM +0530, Sumit Garg wrote:
> On Thu, 19 Aug 2021 at 16:37, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Isolate the ABI based on raw SMCs. Code specific to the raw SMC ABI is
> > moved into smc_abi.c. This makes room for other ABIs with a clear
> > separation.
> >
> > The driver changes to use module_init()/module_exit() instead of
> > module_platform_driver(). The platform_driver_register() and
> > platform_driver_unregister() functions called directly to keep the same
> > behavior. This is needed because module_platform_driver() is based on
> > module_driver() which can only be used once in a module.
> >
> > A function optee_rpc_cmd() is factored out from the function
> > handle_rpc_func_cmd() to handle the ABI independent part of RPC
> > processing.
> >
> > This patch is not supposed to change the driver behavior, it's only a
> > matter of reorganizing the code.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |    6 +-
> >  drivers/tee/optee/call.c          |  339 +-------
> >  drivers/tee/optee/core.c          |  688 +--------------
> >  drivers/tee/optee/optee_private.h |  103 ++-
> >  drivers/tee/optee/rpc.c           |  217 +----
> >  drivers/tee/optee/shm_pool.c      |   89 --
> >  drivers/tee/optee/shm_pool.h      |   14 -
> >  drivers/tee/optee/smc_abi.c       | 1299 +++++++++++++++++++++++++++++
> >  8 files changed, 1439 insertions(+), 1316 deletions(-)
> >  delete mode 100644 drivers/tee/optee/shm_pool.c
> >  delete mode 100644 drivers/tee/optee/shm_pool.h
> >  create mode 100644 drivers/tee/optee/smc_abi.c
> >
> 
> Apart from minor comments below including one related to rebase, this
> looks good to me. So feel free to add:
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> 
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 3aa33ea9e6a6..e92f77462f40 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -4,8 +4,10 @@ optee-objs += core.o
> >  optee-objs += call.o
> >  optee-objs += rpc.o
> >  optee-objs += supp.o
> > -optee-objs += shm_pool.o
> >  optee-objs += device.o
> >
> > +optee-smc-abi-y = smc_abi.o
> > +optee-objs += $(optee-ffa-abi-y)
> 
> Did you mean optee-smc-abi-y here?

Yes, I'll fix, thanks.

[snip]
> > index d767eebf30bd..000000000000
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ /dev/null
> > @@ -1,89 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -/*
> > - * Copyright (c) 2015, Linaro Limited
> > - * Copyright (c) 2017, EPAM Systems
> > - */
> > -#include <linux/device.h>
> > -#include <linux/dma-buf.h>
> > -#include <linux/genalloc.h>
> > -#include <linux/slab.h>
> > -#include <linux/tee_drv.h>
> > -#include "optee_private.h"
> > -#include "optee_smc.h"
> > -#include "shm_pool.h"
> > -
> > -static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> > -                        struct tee_shm *shm, size_t size)
> > -{
> > -       unsigned int order = get_order(size);
> > -       struct page *page;
> > -       int rc = 0;
> > -
> > -       page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > -       if (!page)
> > -               return -ENOMEM;
> > -
> > -       shm->kaddr = page_address(page);
> > -       shm->paddr = page_to_phys(page);
> > -       shm->size = PAGE_SIZE << order;
> > -
> > -       if (shm->flags & TEE_SHM_DMA_BUF) {
> 
> I guess this series needs to be rebased on top of mainline, since now
> we have TEE_SHM_PRIV flag here [1]?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tee/optee/shm_pool.c

Right, I'll take care of that in the next patchset.

[snip]
> > --- /dev/null
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -0,0 +1,1299 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2015-2021, Linaro Limited
> > + * Copyright (c) 2016, EPAM Systems
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/errno.h>
> > +#include <linux/io.h>
> > +#include <linux/sched.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/types.h>
> > +#include <linux/workqueue.h>
> > +#include "optee_private.h"
> > +#include "optee_smc.h"
> > +#include "optee_rpc_cmd.h"
> > +#define CREATE_TRACE_POINTS
> > +#include "optee_trace.h"
> > +
> > +/*
> > + * This file implement the SMC ABI used when communicating with secure world
> > + * OP-TEE OS via raw SMCs.
> > + * This file is divided into the follow sections:
> 
> s/follow/following/

I'll fix.

Thanks,
Jens
