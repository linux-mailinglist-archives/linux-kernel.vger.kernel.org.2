Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2018C4429BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhKBIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:45:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B735C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:43:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d13so32018089wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+kvSVovXVrVAS4Uy2jdSD8CJu5vplrN/WyYIwJVagw=;
        b=DvbCrmdk5f8KJCQuJwVHF1keKxDIU5EeVJL8Juke/8a2IN1WuuZQVt3fSjiEiwF98A
         XuUMTGxh/QHFifnzY/U/dMjqyrOD6ESfAxOvOZC1I48p3AQl/0iOOPxQRL82alV7LOuL
         Ss41B5LN7RSLpsvQkyECU3DaGY65hx5eJpyosHXeo8sPu88/dBxOXhUuDI9EHaQySo0h
         yDFDiwkpoCi/Ub+dSSpjp14IBpQi0MqFy+MDAgAyRNOlYju1+nawJUmFylVutim4au+x
         JWoWC1kgH4Dp3NeokHgoNHwWjeANSR9Kc7jZETG+ywRgqW58FAkAE5J6a6bfEtE6M/YO
         Td7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+kvSVovXVrVAS4Uy2jdSD8CJu5vplrN/WyYIwJVagw=;
        b=3zNWAR5wOQz6nNH1WdiBldNWZrs1cTa4zbBVMGPyyWdfhnM+aBNDPokKoaU1lknGIT
         KZiGfJ8A8roLEuM1UeQYlqo5V1L0cLVyPmz69uec4Sc5HFNN/BQFs6HpSCv6mFV/tGK8
         ePDV2bN5BSOUWZl7U8ssONxBZpRNEOuNerExS9MiahWqd1sFo75A2g/1ZajdMvBpfL/9
         pEuOvgB3rDJ4qMyIfQwPy3c479Vfwbs39sg5Th09lJPRpGrm6SyHGKdSxEMcVmqAQcGg
         j02FDf+QokDFG2bEKiP79L/Dj3Zjr3YBs43coddsMhC/aHzhuaEtIGcq6/PcjDwhLNc/
         9D0Q==
X-Gm-Message-State: AOAM5316b+BDMu6UhfF9qggit5XecgUmJWaPc+mbdYD6Libd5qxHLJXF
        AHXZn6WMhqS+90ngDuIFRwCkwo+edWHepGWpO5AdVg==
X-Google-Smtp-Source: ABdhPJwpwm1gzPcqp3tFFesNt2ie1dgSUYaPdCr1894PrPhwd3WSqlWz9x6MkLM21APBAsyeTe81Pt9pMDqOKej2DxI=
X-Received: by 2002:adf:ded0:: with SMTP id i16mr40413735wrn.335.1635842600707;
 Tue, 02 Nov 2021 01:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211026083138.1818705-1-jens.wiklander@linaro.org>
 <20211026083138.1818705-7-jens.wiklander@linaro.org> <CAFA6WYPOgmFDj80id9f-ay4_DivS+jTdFaDWsoHoeTn+ipkNEA@mail.gmail.com>
In-Reply-To: <CAFA6WYPOgmFDj80id9f-ay4_DivS+jTdFaDWsoHoeTn+ipkNEA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 2 Nov 2021 09:43:09 +0100
Message-ID: <CAHUa44Hwtt636iPMBBRqMtb2-qTar+sq-wFj8_pnCPcoraerHA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] optee: add asynchronous notifications
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
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, jens.vankeirsbilck@kuleuven.be
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 8:30 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Tue, 26 Oct 2021 at 14:01, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds support for asynchronous notifications from secure world to normal
> > world. This allows a design with a top half and bottom half type of
> > driver where the top half runs in secure interrupt context and a
> > notifications tells normal world to schedule a yielding call to do the
> > bottom half processing.
> >
> > The protocol is defined in optee_msg.h optee_rpc_cmd.h and optee_smc.h.
> >
> > A notification consists of a 32-bit value which normal world can
> > retrieve using a fastcall into secure world. The value
> > OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF (0) has a special meaning.
> > When this value is sent it means that normal world is supposed to make a
> > yielding call OPTEE_MSG_CMD_DO_BOTTOM_HALF.
> >
> > Notification capability is negotiated while the driver is initialized.
> > If both sides supports these notifications then they are enabled.
> >
> > An interrupt is used to notify the driver that there are asynchronous
> > notifications pending. The maximum needed notification value is
> > communicated at this stage. This allows scaling up when needed.
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/optee_msg.h     |   9 ++
> >  drivers/tee/optee/optee_private.h |   2 +
> >  drivers/tee/optee/optee_smc.h     |  75 +++++++++-
> >  drivers/tee/optee/smc_abi.c       | 236 +++++++++++++++++++++++++-----
> >  4 files changed, 287 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index 2422e185d400..70e9cc2ee96b 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -318,6 +318,13 @@ struct optee_msg_arg {
> >   * [in] param[0].u.rmem.shm_ref                holds shared memory reference
> >   * [in] param[0].u.rmem.offs           0
> >   * [in] param[0].u.rmem.size           0
> > + *
> > + * OPTEE_MSG_CMD_DO_BOTTOM_HALF does the scheduled bottom half processing
> > + * of a driver.
> > + *
> > + * OPTEE_MSG_CMD_STOP_ASYNC_NOTIF informs secure world that from now is
> > + * normal world unable to process asynchronous notifications. Typically
> > + * used when the driver is shut down.
> >   */
> >  #define OPTEE_MSG_CMD_OPEN_SESSION     0
> >  #define OPTEE_MSG_CMD_INVOKE_COMMAND   1
> > @@ -325,6 +332,8 @@ struct optee_msg_arg {
> >  #define OPTEE_MSG_CMD_CANCEL           3
> >  #define OPTEE_MSG_CMD_REGISTER_SHM     4
> >  #define OPTEE_MSG_CMD_UNREGISTER_SHM   5
> > +#define OPTEE_MSG_CMD_DO_BOTTOM_HALF   6
> > +#define OPTEE_MSG_CMD_STOP_ASYNC_NOTIF 7
> >  #define OPTEE_MSG_FUNCID_CALL_WITH_ARG 0x0004
> >
> >  #endif /* _OPTEE_MSG_H */
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 68fd28f8c6e9..46f74ab07c7e 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -53,6 +53,7 @@ struct optee_call_queue {
> >
> >  struct optee_notif {
> >         u_int max_key;
> > +       struct tee_context *ctx;
> >         /* Serializes access to the elements below in this struct */
> >         spinlock_t lock;
> >         struct list_head db;
> > @@ -88,6 +89,7 @@ struct optee_smc {
> >         optee_invoke_fn *invoke_fn;
> >         void *memremaped_shm;
> >         u32 sec_caps;
> > +       unsigned int notif_irq;
> >  };
> >
> >  /**
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > index 80eb763a8a80..c14a7cf1f62c 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -107,6 +107,12 @@ struct optee_smc_call_get_os_revision_result {
> >  /*
> >   * Call with struct optee_msg_arg as argument
> >   *
> > + * When calling this function normal world has a few responsibilities:
> > + * 1. It must be able to handle eventual RPCs
> > + * 2. Non-secure interrupts should not be masked
> > + * 3. If asynchronous notifications has been negotiated successfully, then
> > + *    asynchronous notifications should be unmasked during this call.
> > + *
> >   * Call register usage:
> >   * a0  SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
> >   * a1  Upper 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
> > @@ -195,7 +201,8 @@ struct optee_smc_get_shm_config_result {
> >   * Normal return register usage:
> >   * a0  OPTEE_SMC_RETURN_OK
> >   * a1  bitfield of secure world capabilities OPTEE_SMC_SEC_CAP_*
> > - * a2-7        Preserved
> > + * a2  The maximum secure world notification number
> > + * a3-7        Preserved
> >   *
> >   * Error return register usage:
> >   * a0  OPTEE_SMC_RETURN_ENOTAVAIL, can't use the capabilities from normal world
> > @@ -218,6 +225,8 @@ struct optee_smc_get_shm_config_result {
> >  #define OPTEE_SMC_SEC_CAP_VIRTUALIZATION       BIT(3)
> >  /* Secure world supports Shared Memory with a NULL reference */
> >  #define OPTEE_SMC_SEC_CAP_MEMREF_NULL          BIT(4)
> > +/* Secure world supports asynchronous notification of normal world */
> > +#define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
> >
> >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
> >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > @@ -226,8 +235,8 @@ struct optee_smc_get_shm_config_result {
> >  struct optee_smc_exchange_capabilities_result {
> >         unsigned long status;
> >         unsigned long capabilities;
> > +       unsigned long max_notif_value;
> >         unsigned long reserved0;
> > -       unsigned long reserved1;
> >  };
> >
> >  /*
> > @@ -319,6 +328,68 @@ struct optee_smc_disable_shm_cache_result {
> >  #define OPTEE_SMC_GET_THREAD_COUNT \
> >         OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_THREAD_COUNT)
> >
> > +/*
> > + * Inform OP-TEE that normal world is able to receive asynchronous
> > + * notifications.
> > + *
> > + * Call requests usage:
> > + * a0  SMC Function ID, OPTEE_SMC_ENABLE_ASYNC_NOTIF
> > + * a1-6        Not used
> > + * a7  Hypervisor Client ID register
> > + *
> > + * Normal return register usage:
> > + * a0  OPTEE_SMC_RETURN_OK
> > + * a1-7        Preserved
> > + *
> > + * Not supported return register usage:
> > + * a0  OPTEE_SMC_RETURN_ENOTAVAIL
> > + * a1-7        Preserved
> > + */
> > +#define OPTEE_SMC_FUNCID_ENABLE_ASYNC_NOTIF    16
> > +#define OPTEE_SMC_ENABLE_ASYNC_NOTIF \
> > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_ENABLE_ASYNC_NOTIF)
> > +
> > +/*
> > + * Retrieve a value of notifications pending since the last call of this
> > + * function.
> > + *
> > + * OP-TEE keeps a record of all posted values. When an interrupts is
> > + * received which indicates that there are posed values this function
> > + * should be called until all pended values have been retrieved. When a
> > + * value is retrieved, it's cleared from the record in secure world.
> > + *
> > + * Call requests usage:
> > + * a0  SMC Function ID, OPTEE_SMC_GET_ASYNC_NOTIF_VALUE
> > + * a1-6        Not used
> > + * a7  Hypervisor Client ID register
> > + *
> > + * Normal return register usage:
> > + * a0  OPTEE_SMC_RETURN_OK
> > + * a1  value
> > + * a2  Bit[0]: OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID if the value in a1 is
> > + *             valid, else 0 if no values where pending
> > + * a2  Bit[1]: OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING if another value is
> > + *             pending, else 0.
> > + *     Bit[31:2]: MBZ
> > + * a3-7        Preserved
> > + *
> > + * Not supported return register usage:
> > + * a0  OPTEE_SMC_RETURN_ENOTAVAIL
> > + * a1-7        Preserved
> > + */
> > +#define OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID      BIT(0)
> > +#define OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING    BIT(1)
> > +
> > +/*
> > + * Notification that OP-TEE expects a yielding call to do some bottom half
> > + * work in a driver.
> > + */
> > +#define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF     0
> > +
> > +#define OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE 17
> > +#define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
> > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE)
> > +
> >  /*
> >   * Resume from RPC (for example after processing a foreign interrupt)
> >   *
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 00a7ff00a7c0..9fa1bcdcf5e6 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -8,13 +8,16 @@
> >
> >  #include <linux/arm-smccc.h>
> >  #include <linux/errno.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/io.h>
> > -#include <linux/sched.h>
> > +#include <linux/irqdomain.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/tee_drv.h>
> > @@ -34,7 +37,8 @@
> >   * 2. Low level support functions to register shared memory in secure world
> >   * 3. Dynamic shared memory pool based on alloc_pages()
> >   * 4. Do a normal scheduled call into secure world
> > - * 5. Driver initialization.
> > + * 5. Asynchronous notifcation
>
> nit: s/notifcation/notification/
>
> > + * 6. Driver initialization.
> >   */
> >
> >  #define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
> > @@ -875,8 +879,135 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> >         return rc;
> >  }
> >
> > +static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
> > +{
> > +       struct optee_msg_arg *msg_arg;
> > +       struct tee_shm *shm;
> > +
> > +       shm = optee_get_msg_arg(ctx, 0, &msg_arg);
> > +       if (IS_ERR(shm))
> > +               return PTR_ERR(shm);
> > +
> > +       msg_arg->cmd = cmd;
> > +       optee_smc_do_call_with_arg(ctx, shm);
> > +
> > +       tee_shm_free(shm);
> > +       return 0;
> > +}
> > +
> > +static int optee_smc_do_bottom_half(struct tee_context *ctx)
> > +{
> > +       return simple_call_with_arg(ctx, OPTEE_MSG_CMD_DO_BOTTOM_HALF);
> > +}
> > +
> > +static int optee_smc_stop_async_notif(struct tee_context *ctx)
> > +{
> > +       return simple_call_with_arg(ctx, OPTEE_MSG_CMD_STOP_ASYNC_NOTIF);
> > +}
> > +
> >  /*
> > - * 5. Driver initialization
> > + * 5. Asynchronous notifcation
>
> nit: s/notifcation/notification/
>
> > + */
> > +
> > +static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> > +                                bool *value_pending)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_GET_ASYNC_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +       if (res.a0)
> > +               return 0;
> > +       *value_valid = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_VALID);
> > +       *value_pending = (res.a2 & OPTEE_SMC_ASYNC_NOTIF_VALUE_PENDING);
> > +       return res.a1;
> > +}
> > +
> > +static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct optee *optee = dev_id;
> > +       bool do_bottom_half = false;
> > +       bool value_valid;
> > +       bool value_pending;
> > +       u32 value;
> > +
> > +       do {
> > +               value = get_async_notif_value(optee->smc.invoke_fn,
> > +                                             &value_valid, &value_pending);
> > +               if (!value_valid)
> > +                       break;
> > +
> > +               if (value == OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF)
> > +                       do_bottom_half = true;
> > +               else
> > +                       optee_notif_send(optee, value);
> > +       } while (value_pending);
> > +
> > +       if (do_bottom_half)
> > +               return IRQ_WAKE_THREAD;
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
> > +{
> > +       struct optee *optee = dev_id;
> > +
> > +       optee_smc_do_bottom_half(optee->notif.ctx);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> > +{
> > +       struct tee_context *ctx;
> > +       int rc;
> > +
> > +       ctx = teedev_open(optee->teedev);
> > +       if (IS_ERR(ctx))
> > +               return PTR_ERR(ctx);
> > +
> > +       optee->notif.ctx = ctx;
> > +       rc = request_threaded_irq(irq, notif_irq_handler,
> > +                                 notif_irq_thread_fn,
> > +                                 0, "optee_notification", optee);
> > +       if (rc)
> > +               goto err_close_ctx;
> > +
> > +       optee->smc.notif_irq = irq;
> > +
> > +       return 0;
> > +
> > +err_close_ctx:
> > +       teedev_close_context(optee->notif.ctx);
> > +       optee->notif.ctx = NULL;
> > +
> > +       return rc;
> > +}
> > +
> > +static void optee_smc_notif_uninit_irq(struct optee *optee)
> > +{
> > +       if (optee->notif.ctx) {
> > +               optee_smc_stop_async_notif(optee->notif.ctx);
> > +               if (optee->smc.notif_irq) {
> > +                       free_irq(optee->smc.notif_irq, optee);
> > +                       irq_dispose_mapping(optee->smc.notif_irq);
> > +               }
> > +
> > +               /*
> > +                * The thread normally working with optee->notif.ctx was
> > +                * stopped with free_irq() above.
> > +                *
> > +                * Note we're not using teedev_close_context() or
> > +                * tee_client_close_context() since we have already called
> > +                * tee_device_put() while initializing to avoid a circular
> > +                * reference counting.
> > +                */
> > +               teedev_close_context(optee->notif.ctx);
> > +       }
> > +}
> > +
> > +/*
> > + * 6. Driver initialization
> >   *
> >   * During driver inititialization is secure world probed to find out which
>
> nit: s/inititialization/initialization/
>
> >   * features it supports so the driver can be initialized with a matching
> > @@ -950,6 +1081,17 @@ static const struct optee_ops optee_ops = {
> >         .from_msg_param = optee_from_msg_param,
> >  };
> >
> > +static int enable_async_notif(optee_invoke_fn *invoke_fn)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_ENABLE_ASYNC_NOTIF, 0, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +       if (res.a0)
> > +               return -EINVAL;
> > +       return 0;
> > +}
> > +
> >  static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
> >  {
> >         struct arm_smccc_res res;
> > @@ -999,7 +1141,7 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
> >  }
> >
> >  static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> > -                                           u32 *sec_caps)
> > +                                           u32 *sec_caps, u32 *max_notif_value)
> >  {
> >         union {
> >                 struct arm_smccc_res smccc;
> > @@ -1022,6 +1164,11 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> >                 return false;
> >
> >         *sec_caps = res.result.capabilities;
> > +       if (*sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF)
> > +               *max_notif_value = res.result.max_notif_value;
> > +       else
> > +               *max_notif_value = OPTEE_DEFAULT_MAX_NOTIF_VALUE;
> > +
> >         return true;
> >  }
> >
> > @@ -1186,6 +1333,8 @@ static int optee_smc_remove(struct platform_device *pdev)
> >          */
> >         optee_disable_shm_cache(optee);
> >
> > +       optee_smc_notif_uninit_irq(optee);
> > +
> >         optee_remove_common(optee);
> >
> >         if (optee->smc.memremaped_shm)
> > @@ -1215,6 +1364,7 @@ static int optee_probe(struct platform_device *pdev)
> >         struct optee *optee = NULL;
> >         void *memremaped_shm = NULL;
> >         struct tee_device *teedev;
> > +       u32 max_notif_value;
> >         u32 sec_caps;
> >         int rc;
> >
> > @@ -1234,7 +1384,8 @@ static int optee_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >         }
> >
> > -       if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
> > +       if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> > +                                            &max_notif_value)) {
> >                 pr_warn("capabilities mismatch\n");
> >                 return -EINVAL;
> >         }
> > @@ -1257,7 +1408,7 @@ static int optee_probe(struct platform_device *pdev)
> >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> >         if (!optee) {
> >                 rc = -ENOMEM;
> > -               goto err;
> > +               goto err_free_pool;
> >         }
> >
> >         optee->ops = &optee_ops;
> > @@ -1267,24 +1418,24 @@ static int optee_probe(struct platform_device *pdev)
> >         teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
> >         if (IS_ERR(teedev)) {
> >                 rc = PTR_ERR(teedev);
> > -               goto err;
> > +               goto err_free_optee;
> >         }
> >         optee->teedev = teedev;
> >
> >         teedev = tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
> >         if (IS_ERR(teedev)) {
> >                 rc = PTR_ERR(teedev);
> > -               goto err;
> > +               goto err_unreg_teedev;
> >         }
> >         optee->supp_teedev = teedev;
> >
> >         rc = tee_device_register(optee->teedev);
> >         if (rc)
> > -               goto err;
> > +               goto err_unreg_supp_teedev;
> >
> >         rc = tee_device_register(optee->supp_teedev);
> >         if (rc)
> > -               goto err;
> > +               goto err_unreg_supp_teedev;
> >
> >         mutex_init(&optee->call_queue.mutex);
> >         INIT_LIST_HEAD(&optee->call_queue.waiters);
> > @@ -1293,10 +1444,27 @@ static int optee_probe(struct platform_device *pdev)
> >         optee->pool = pool;
> >
> >         platform_set_drvdata(pdev, optee);
> > -       rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
> > -       if (rc) {
> > -               optee_remove(pdev);
> > -               return rc;
> > +       rc = optee_notif_init(optee, max_notif_value);
> > +       if (rc)
> > +               goto err_supp_uninit;
> > +
> > +       if (sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
> > +               unsigned int irq;
> > +
> > +               rc = platform_get_irq(pdev, 0);
> > +               if (rc < 0) {
> > +                       pr_err("platform_get_irq: ret %d\n", rc);
> > +                       goto err_notif_uninit;
> > +               }
> > +               irq = rc;
> > +
> > +               rc = optee_smc_notif_init_irq(optee, irq);
> > +               if (rc) {
> > +                       irq_dispose_mapping(irq);
> > +                       goto err_notif_uninit;
> > +               }
> > +               enable_async_notif(optee->smc.invoke_fn);
> > +               pr_info("Asynchronous notifications enabled\n");
> >         }
> >
> >         /*
> > @@ -1314,28 +1482,30 @@ static int optee_probe(struct platform_device *pdev)
> >                 pr_info("dynamic shared memory is enabled\n");
> >
> >         rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
> > -       if (rc) {
> > -               optee_smc_remove(pdev);
> > -               return rc;
> > -       }
> > +       if (rc)
> > +               goto err_disable_shm_cache;
>
> This error path requires a call to optee_unregister_devices() as well
> as it may be that some optee devices are registered before the error
> happens.

I'll fix this and the nits above.

>
> Other than that it looks good to me. Feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks for the review.

Cheers,
Jens
