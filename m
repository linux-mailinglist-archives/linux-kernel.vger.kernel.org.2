Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D263F8A74
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbhHZOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHZOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:53:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:52:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j12so5588988ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ta1NoD8SNB7CUXQby/YaoqCg3FSl+9VTaHeQNAlA9LY=;
        b=WDaesmr8YGqAtX/adbODz5Pk8xiiTukN++C1ufxRN5MA3x6uFEnYcis1jUihX8RGRQ
         xmoNrKwrXuHa3Lw4a1bVIMK9bb0Owukc43tDKD34qZKbZtRx6/5zcm1Uj4NSxxR+xP/O
         j9cWsV6EzXMiQYlydeEaeiXoeHbtHJ1qh5pfty7thWApPF3rC7NJwhbJPIsi0Xu7+cZF
         vq1AVvBrQpsH47pAnh7tZMqCRqpAmIhSYI0etMzZZoYEsZ6W/irNgayJHMFv1rs04WdS
         86Fxn9R9kU19LjrZvmW8gasgcveiDoEoSpTWQa+vnhVIFMe0zvSPPQ26RS42zeqYG3Is
         YFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ta1NoD8SNB7CUXQby/YaoqCg3FSl+9VTaHeQNAlA9LY=;
        b=N6PPRwWPl7JidzohWyAw9qfAn4euqE3CSU6LdvkjX+AI7gH4unQSjC72SOWKnM7J32
         o///RYQQ/iT0csUZWAXpeeyNAifF7735C8SvM1+EFLPlvfBPM4ympHWs8NCzpauS29fn
         i9M3igeVbSPIL88/FBA+qs8IJQRbAEswGD7cJocNBiJSX7TOXBJzUMepm91uhv2Q1+Ds
         0ZoapBVQUANOHIsT1si80Pd7nzRLUaLEkZ1tIJ7QjiTke11ztsE/dv1Oob+yXPI0SVzp
         GIkyzFiCydmLsEeo55U+0hf993V7+IhJzYfEFJkmcC4sXrmIkqekY9gqitYTpActzueZ
         Z9RA==
X-Gm-Message-State: AOAM532HoTIrd72ce+dngIq/RMaC5b7joZlfQZpNSlPzMtGdMqMyvCzH
        vYiD+aebdA1O8yZZJFmPwYcWyA==
X-Google-Smtp-Source: ABdhPJyg46f3fFaTVnEE0HqAYT1PDyIzFKiZTxUcGQOrN/lyAJweyUYUg4FFP5z1S0gWot74tIIHWg==
X-Received: by 2002:a05:651c:454:: with SMTP id g20mr3509822ljg.142.1629989535748;
        Thu, 26 Aug 2021 07:52:15 -0700 (PDT)
Received: from jade (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id k13sm336704lfg.189.2021.08.26.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:52:15 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:52:13 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 5/5] optee: add FF-A support
Message-ID: <20210826145213.GA1739293@jade>
References: <20210819110655.739318-1-jens.wiklander@linaro.org>
 <20210819110655.739318-6-jens.wiklander@linaro.org>
 <CAFA6WYNHrej1_yMZejLpG5u1WjN5XvpmS-zKWdLVZu=DEWd6xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYNHrej1_yMZejLpG5u1WjN5XvpmS-zKWdLVZu=DEWd6xA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:12:45PM +0530, Sumit Garg wrote:
> On Thu, 19 Aug 2021 at 16:37, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds support for using FF-A [1] as transport to the OP-TEE driver.
> >
> > Introduces struct optee_msg_param_fmem which carries all information
> > needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> > memory reference mapped by the hypervisor in S-EL2. Register usage is
> > also updated to include the information needed.
> >
> > The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> > enabled.
> >
> > [1] https://developer.arm.com/documentation/den0077/latest
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |   3 +-
> >  drivers/tee/optee/call.c          |  13 +-
> >  drivers/tee/optee/core.c          |  16 +-
> >  drivers/tee/optee/ffa_abi.c       | 907 ++++++++++++++++++++++++++++++
> >  drivers/tee/optee/optee_ffa.h     | 153 +++++
> >  drivers/tee/optee/optee_msg.h     |  27 +-
> >  drivers/tee/optee/optee_private.h |  43 +-
> >  7 files changed, 1148 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/tee/optee/ffa_abi.c
> >  create mode 100644 drivers/tee/optee/optee_ffa.h
> >
[snip]
> > --- /dev/null
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -0,0 +1,907 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021, Linaro Limited
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/arm_ffa.h>
> > +#include <linux/errno.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/types.h>
> > +#include "optee_private.h"
> > +#include "optee_ffa.h"
> > +#include "optee_rpc_cmd.h"
> > +
> > +/*
> > + * This file implement the FF-A ABI used when communicating with secure world
> > + * OP-TEE OS via FF-A.
> > + * This file is divided into the follow sections:
> 
> s/follow/following/

Thanks, I'll fix.

[snip]
> > +static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > +                                   const struct ffa_dev_ops *ops,
> > +                                   unsigned int *rpc_arg_count)
> > +{
> > +       struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> > +       int rc;
> > +
> > +       rc = ops->sync_send_receive(ffa_dev, &data);
> > +       if (rc) {
> > +               pr_err("Unexpected error %d", rc);
> > +               return false;
> > +       }
> > +       if (data.data0) {
> > +               pr_err("Unexpected exchange error %lu", data.data0);
> > +               return false;
> > +       }
> > +
> > +       *rpc_arg_count = (u8)data.data1;
> 
> Why is this special capability required in case of FF-A? Is it true
> that RPC arguments count will be fixed for all RPC commands?

It's to allow this driver to preallocate the argument struct used when
doing RPC. That way we can avoid the chicken and egg problem of allocating
an RPC argumet struct just before doing the real RPC.

This is the maximum number of arguments needed by secure world. In case
a larger value ever is needed, secure world will be able to supply the
needed value.

I plan to update the SMC based ABI with this also, but not in the patch
set.

> 
> > +
> > +       return true;
> > +}

[snip]
> > +static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > +{
> > +       const struct ffa_dev_ops *ffa_ops;
> > +       unsigned int rpc_arg_count;
> > +       struct tee_device *teedev;
> > +       struct optee *optee;
> > +       int rc;
> > +
> > +       ffa_ops = ffa_dev_ops_get(ffa_dev);
> > +       if (!ffa_ops) {
> > +               pr_warn("failed \"method\" init: ffa\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > +               return -EINVAL;
> > +
> > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
> > +               return -EINVAL;
> => +
> > +       optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > +       if (!optee) {
> > +               rc = -ENOMEM;
> > +               goto err;
> > +       }
> > +       optee->pool = optee_ffa_config_dyn_shm();
> > +       if (IS_ERR(optee->pool)) {
> > +               rc = PTR_ERR(optee->pool);
> > +               optee->pool = NULL;
> > +               goto err;
> > +       }
> 
> IIUC, with FF-A we will only be supporting dynamic shared memory. So
> CFG_CORE_DYN_SHM=y should be enforced in OP-TEE OS when
> CFG_CORE_FFA=y, but I don't see that currently. Am I missing
> something?

You mean in optee_os.git? With FF-A dynamic shared memory is always
handled, so that flag in irrelevant in that case. However, feel free to
start a discussion on that topic at github.

Thanks,
Jens
