Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797342C1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhJMNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhJMNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:45:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC90C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:43:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t2so8565917wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+Y0xyyI1wLmc3f9TlGqhucUogMT+qFqaRbraqD/TSo=;
        b=v0LSbR00mJZeqwHdD2h5ESrF3UnP8I0vyl7OIhpMgahKvzTvI/9e4nVBnrxMCszkKL
         p9luteX+Yn5bWVI8RphvikmshhL3NwKYW+P8QPzUoFwv+k2MxUJkyF7BtMswP+PeJqn0
         7fZHSnwxRQRQZtNbSNSQsXnLd+kYmxgDMo9iMvLRQb33DpntYwM5EJpbcIuzKUTkngda
         SHN6DNmhk8wzdC6i8lb/k3J/I8i8v11EPggq34p1qq+VLL3wNs0ZK3DRomTc9Qq66fa2
         0ElEXF0WwPCs6pHMFfb8V8UNWE9Tp9zCzbHrN2vz2BK3WlI4AFntaLL+/XWeL3e+vCrH
         JxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+Y0xyyI1wLmc3f9TlGqhucUogMT+qFqaRbraqD/TSo=;
        b=H+69zHg8Vr/Mr+hfgPk4se+9nE11dfdIoccVXNGMFtqZ0BqcZDvVrv1pqjNZc0ytpO
         CVywA1KP2/bMUayOcBJftjl/QJNpBBe+a3K79a98JRy6cUvm0NuI3bFN8CyOUgcP5sXl
         ZxtI/Wp8cksqm83q4RVo6pkyASSWxgLFrM7irFCPGoANdkelch8NIee60WRo7VMnvZSF
         ciQP+1B5VzIpb1a83iGc2dWLG44krJviCkc4wQQcRe/TBCoEBGSHWT5ivrgLtDAUzp8S
         AtgA58/Wb5lr9hwzp35qu/9rxYMPSMPOcrR67WHlgk4ua5ihpZa8suLlYfmHRnKimsBX
         Mb2w==
X-Gm-Message-State: AOAM532k0PNNkGiO33/vXcFAdlEAZ2f87xxzuRyzZzWQePpjQgeL+Lx6
        7n4C631JKqRoTJu50gDfKqL79uRTtOgTS3MKefnpYw==
X-Google-Smtp-Source: ABdhPJwJ9HbDf8L1dZ2qzc+MlJeIlkxrfEj/wa5d66jDnrlWwI3mSRO5QpF9ovKMRItVh8P6fqQmQNmpT0lzkOB2t1s=
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr4282849wrs.96.1634132584493;
 Wed, 13 Oct 2021 06:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211006071546.2540920-1-jens.wiklander@linaro.org>
 <20211006071546.2540920-6-jens.wiklander@linaro.org> <CAFA6WYNdebJKoWZdQRPc=OdmaA=_jiguz12gfyHsdozbdx45vQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNdebJKoWZdQRPc=OdmaA=_jiguz12gfyHsdozbdx45vQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 13 Oct 2021 15:42:53 +0200
Message-ID: <CAHUa44E9jLYsMd1LPVJTDXyCkT==EW7s-nHn3rYRx30gyBU8=g@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] optee: separate notification functions
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:15 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 6 Oct 2021 at 12:46, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Renames struct optee_wait_queue to struct optee_notif and all related
> > functions to optee_notif_*().
> >
> > The implementation is changed to allow sending a notification from an
> > atomic state, that is from the top half of an interrupt handler.
> >
> > Waiting for keys is currently only used when secure world is waiting for
> > a mutex or condition variable. The old implementation could handle any
> > 32-bit key while this new implementation is restricted to only 8 bits or
> > the maximum value 255. A upper value is needed since a bitmap is
> > allocated to allow an interrupt handler to only set a bit in case the
> > waiter hasn't had the time yet to allocate and register a completion.
> >
> > The keys are currently only representing secure world threads which
> > number usually are never even close to 255 so it should be safe for now.
> > In future ABI updates the maximum value of the key will be communicated
> > while the driver is initializing.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |   1 +
> >  drivers/tee/optee/core.c          |  12 ++-
> >  drivers/tee/optee/notif.c         | 125 ++++++++++++++++++++++++++++++
> >  drivers/tee/optee/optee_private.h |  19 +++--
> >  drivers/tee/optee/optee_rpc_cmd.h |  31 ++++----
> >  drivers/tee/optee/rpc.c           |  73 ++---------------
> >  6 files changed, 170 insertions(+), 91 deletions(-)
> >  create mode 100644 drivers/tee/optee/notif.c
> >
>
> Apart from minor nit below:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 3aa33ea9e6a6..df55e4ad5370 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_OPTEE) += optee.o
> >  optee-objs += core.o
> >  optee-objs += call.o
> > +optee-objs += notif.o
> >  optee-objs += rpc.o
> >  optee-objs += supp.o
> >  optee-objs += shm_pool.o
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 5ce13b099d7d..8531184f98f4 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -592,6 +592,7 @@ static int optee_remove(struct platform_device *pdev)
> >          */
> >         optee_disable_shm_cache(optee);
> >
> > +       optee_notif_uninit(optee);
> >         /*
> >          * The two devices have to be unregistered before we can free the
> >          * other resources.
> > @@ -602,7 +603,6 @@ static int optee_remove(struct platform_device *pdev)
> >         tee_shm_pool_free(optee->pool);
> >         if (optee->memremaped_shm)
> >                 memunmap(optee->memremaped_shm);
> > -       optee_wait_queue_exit(&optee->wait_queue);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> >
> > @@ -712,11 +712,17 @@ static int optee_probe(struct platform_device *pdev)
> >
> >         mutex_init(&optee->call_queue.mutex);
> >         INIT_LIST_HEAD(&optee->call_queue.waiters);
> > -       optee_wait_queue_init(&optee->wait_queue);
> >         optee_supp_init(&optee->supp);
> >         optee->memremaped_shm = memremaped_shm;
> >         optee->pool = pool;
> >
> > +       platform_set_drvdata(pdev, optee);
> > +       rc = optee_notif_init(optee, 255);
>
> nit: Can you use a macro here instead of a constant with a proper
> comment similar to the one in commit description?

OK, I'll fix.

Thanks,
Jens
