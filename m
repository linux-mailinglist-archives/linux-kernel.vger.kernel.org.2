Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F03F9408
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbhH0F2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhH0F2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:28:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31ACC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:27:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq28so11897934lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 22:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCNGlXY6361ZigaIW6incXr5mbnDjyMCYDuUlz3Yj5o=;
        b=oqzvMaeIs4iTOzMP6wvTn2+1nJhI0RmOfTsl15fEzOJgN4u+b4TXv02mvvwjb78HtJ
         K04ToZZHp3fgqTptx3kNY+aUf2oQPYWcWPBp6tddPPiFq+xNvQNnpH/5oP2ls3J0a/u0
         XXPl5CDSP5u4li6Nu74m5jLGmmJxw6FvQbXUQWBtDAZz5L79Evx3oHyv3BLhcmViZjHt
         uBecX5sD7TDTog+pxuazs6325QK7eFb40ERjNgOgFYr1TXRCrWqdtuEKqQq1Kg8AeHMv
         KsINC8AnwVjpkX9JCfnosFfxAW+Z9h+nXz1Vdtvgx7EHmaP+LVG8yISs3+xu9Yx1LzQ5
         4OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCNGlXY6361ZigaIW6incXr5mbnDjyMCYDuUlz3Yj5o=;
        b=Kl7vmdh7L1+3SmL9a1ZpV9OgFxGcjFswSMIGQQ7c4L92GLBovWbi1t5RddW+oO/Qhf
         UzRTW0EWbjUYbBOGKxcCg2B/CTIgnD0YPEcrpdS4afQNA+yoSlN4KV7NwYUDheIooF3g
         J8u6V54SlggoTb2GkANGkO24Q4hljrCwhS2tp+JiwH3+Q879syC4sjLj9tx/byRB9tJL
         hlWU2ykJWwDgO/p0dIQeAk8vwA5/gBWyi91Y1ged/fAL1thXAxAF/k05fOvaw9NIMdL7
         bg26LqiKN6X1ETrscBNt3F2Hphx62Wx6slayVOUB2wMmaZ9/7EjDd4Om3dcYJTMFCVeU
         D74w==
X-Gm-Message-State: AOAM531k1F7nDt+a5IEauMlK/itgOuM5xqoOgiz4vNxfq0RuEJN2O8fq
        LjCXakxW9ktZJDqCbjZ/wHSPMYc9eMv+8jVmrrLmBw==
X-Google-Smtp-Source: ABdhPJw5tu9U0plf944UOLkB6b80+Y1ywSWOvicN6FaE8XCULyPXDzRXt/73+pxFc6FebCmNjRws2R0LO6hcfB36Sd8=
X-Received: by 2002:ac2:5c4c:: with SMTP id s12mr5211187lfp.108.1630042031913;
 Thu, 26 Aug 2021 22:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210819110655.739318-1-jens.wiklander@linaro.org>
 <20210819110655.739318-6-jens.wiklander@linaro.org> <CAFA6WYNHrej1_yMZejLpG5u1WjN5XvpmS-zKWdLVZu=DEWd6xA@mail.gmail.com>
 <20210826145213.GA1739293@jade>
In-Reply-To: <20210826145213.GA1739293@jade>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 27 Aug 2021 10:57:00 +0530
Message-ID: <CAFA6WYMuAgL0D7oQYoK_zaJ+2hjtyeeVHOgA4tfkurzGuQi6=g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] optee: add FF-A support
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, 26 Aug 2021 at 20:22, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Wed, Aug 25, 2021 at 05:12:45PM +0530, Sumit Garg wrote:
> > On Thu, 19 Aug 2021 at 16:37, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Adds support for using FF-A [1] as transport to the OP-TEE driver.
> > >
> > > Introduces struct optee_msg_param_fmem which carries all information
> > > needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> > > memory reference mapped by the hypervisor in S-EL2. Register usage is
> > > also updated to include the information needed.
> > >
> > > The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> > > enabled.
> > >
> > > [1] https://developer.arm.com/documentation/den0077/latest
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/Makefile        |   3 +-
> > >  drivers/tee/optee/call.c          |  13 +-
> > >  drivers/tee/optee/core.c          |  16 +-
> > >  drivers/tee/optee/ffa_abi.c       | 907 ++++++++++++++++++++++++++++++
> > >  drivers/tee/optee/optee_ffa.h     | 153 +++++
> > >  drivers/tee/optee/optee_msg.h     |  27 +-
> > >  drivers/tee/optee/optee_private.h |  43 +-
> > >  7 files changed, 1148 insertions(+), 14 deletions(-)
> > >  create mode 100644 drivers/tee/optee/ffa_abi.c
> > >  create mode 100644 drivers/tee/optee/optee_ffa.h
> > >
> [snip]
> > > --- /dev/null
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -0,0 +1,907 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2021, Linaro Limited
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/arm_ffa.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/scatterlist.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/tee_drv.h>
> > > +#include <linux/types.h>
> > > +#include "optee_private.h"
> > > +#include "optee_ffa.h"
> > > +#include "optee_rpc_cmd.h"
> > > +
> > > +/*
> > > + * This file implement the FF-A ABI used when communicating with secure world
> > > + * OP-TEE OS via FF-A.
> > > + * This file is divided into the follow sections:
> >
> > s/follow/following/
>
> Thanks, I'll fix.
>
> [snip]
> > > +static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > +                                   const struct ffa_dev_ops *ops,
> > > +                                   unsigned int *rpc_arg_count)
> > > +{
> > > +       struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> > > +       int rc;
> > > +
> > > +       rc = ops->sync_send_receive(ffa_dev, &data);
> > > +       if (rc) {
> > > +               pr_err("Unexpected error %d", rc);
> > > +               return false;
> > > +       }
> > > +       if (data.data0) {
> > > +               pr_err("Unexpected exchange error %lu", data.data0);
> > > +               return false;
> > > +       }
> > > +
> > > +       *rpc_arg_count = (u8)data.data1;
> >
> > Why is this special capability required in case of FF-A? Is it true
> > that RPC arguments count will be fixed for all RPC commands?
>
> It's to allow this driver to preallocate the argument struct used when
> doing RPC. That way we can avoid the chicken and egg problem of allocating
> an RPC argumet struct just before doing the real RPC.
>
> This is the maximum number of arguments needed by secure world. In case
> a larger value ever is needed, secure world will be able to supply the
> needed value.
>
> I plan to update the SMC based ABI with this also, but not in the patch
> set.
>

Okay, I see the requirement with FF-A ABI that we need to pass memory
reference to "struct thread_rpc_arg" while in case of SMC ABI we
directly pass the RPC commands in registers which allows it to work
without pre-allocation.

So I am fine with this approach as well given that the pre-allocated
memory for RPC arguments may be left unused in some cases but that's
fine when compared with the overhead of extra RPC calls with SMC ABI.

> >
> > > +
> > > +       return true;
> > > +}
>
> [snip]
> > > +static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > +{
> > > +       const struct ffa_dev_ops *ffa_ops;
> > > +       unsigned int rpc_arg_count;
> > > +       struct tee_device *teedev;
> > > +       struct optee *optee;
> > > +       int rc;
> > > +
> > > +       ffa_ops = ffa_dev_ops_get(ffa_dev);
> > > +       if (!ffa_ops) {
> > > +               pr_warn("failed \"method\" init: ffa\n");
> > > +               return -ENOENT;
> > > +       }
> > > +
> > > +       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > > +               return -EINVAL;
> > > +
> > > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
> > > +               return -EINVAL;
> > => +
> > > +       optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > > +       if (!optee) {
> > > +               rc = -ENOMEM;
> > > +               goto err;
> > > +       }
> > > +       optee->pool = optee_ffa_config_dyn_shm();
> > > +       if (IS_ERR(optee->pool)) {
> > > +               rc = PTR_ERR(optee->pool);
> > > +               optee->pool = NULL;
> > > +               goto err;
> > > +       }
> >
> > IIUC, with FF-A we will only be supporting dynamic shared memory. So
> > CFG_CORE_DYN_SHM=y should be enforced in OP-TEE OS when
> > CFG_CORE_FFA=y, but I don't see that currently. Am I missing
> > something?
>
> You mean in optee_os.git? With FF-A dynamic shared memory is always
> handled, so that flag in irrelevant in that case. However, feel free to
> start a discussion on that topic at github.

Ah, I see. You are correct that FF-A enables dynamic shared memory by default.

FWIW, feel free to add:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Thanks,
> Jens
