Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4953D3D9DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhG2G4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhG2G4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:56:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:56:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a7so6173867ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mPbbmz69rxjjCQbPeBIBpKWXObvZ/eGvCXrp6SPEv/w=;
        b=kCw8nyCeHRzuMZUN1X0kOtYa6LT2UKrwmYAQER0+fpGuNzZ7ikJ+9VeRSuK0GUhAAN
         AMILwtS5et8kLjggyR2YZWyvuMTvgRiel7w49g0GHxS6ogA3IjZEu267VOz1aJ+dIAjQ
         tz/WA6I05WNE/2r67iiRSo/sMHNOaYZ69JxjKRjJDMWAW5kmsKFf4rMCLtclJGI2tpXv
         0AejQta9BFXJ952YX048icNIQfQtUFHkr+XgHb4hwtPvvlor0bnuSTusX2doVbTLW+pt
         Z3x/xHM9i48KJmnYmpgI/3/6hl0KOGBasPWJn2Gug4OWFyUncdHllZDe2keBr46nS1tU
         T8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPbbmz69rxjjCQbPeBIBpKWXObvZ/eGvCXrp6SPEv/w=;
        b=iKaLmmq5vIhJQzsfE9VS0F5mlx9fOWC+kingA6kkCJkURqQyHEiunCqprygso5rqtz
         4YXqCnR6eRr3neE9bhxsrkQRkNCLg9s7HJevGldmweZn8pOErsHg87GPXOXgyjLPWBd1
         92+DU1yv/nX6JOj5m33eMHF6xDmTqYGpkS4Wv4f/pgISayvarW0oihqiFKZocMrrbOBV
         OKdX7C5+7VHGE3Qr+EyvjfF3dl/j5K0qw696PWtlkUCpjdZcx7CXNYOv9bhtt5kGXwjx
         4g2sNGpF1njZfnOcWNA9qRr3/Xk6hgPDFY9GwE1MwCHteetvM9WGDp/aDWj+G6ywdw6a
         6cXg==
X-Gm-Message-State: AOAM5329VFr9aG7Pis2/4sP5NrGsKHvEIysR8aE+ogEcR9R4O8lnmrTu
        7gEVCyQwp0Bdt6BncIghgV06Vg==
X-Google-Smtp-Source: ABdhPJy9GLyUYBVIArTkBfQzS5UXDMITyjxnHTfahCnrDouX5UcmOgNW0o/F2P3yOhhlmvhWsZzCIQ==
X-Received: by 2002:a05:651c:902:: with SMTP id e2mr2044836ljq.93.1627541784951;
        Wed, 28 Jul 2021 23:56:24 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id b6sm213813lfe.173.2021.07.28.23.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 23:56:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 08:56:23 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 3/5] optee: refactor driver with internal callbacks
Message-ID: <20210729065623.GB3316601@jade>
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <20210722121757.1944658-4-jens.wiklander@linaro.org>
 <CAFA6WYMbOO6N2OSieeWitvti0bvOndLDWyc=yPrrC7cm4GLpPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYMbOO6N2OSieeWitvti0bvOndLDWyc=yPrrC7cm4GLpPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:29:33PM +0530, Sumit Garg wrote:
> On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > The OP-TEE driver is refactored with three internal callbacks replacing
> > direct calls to optee_from_msg_param(), optee_to_msg_param() and
> > optee_do_call_with_arg().
> >
> > These functions a central to communicating with OP-TEE in secure world
> > by using the SMC Calling Convention directly.
> >
> > This refactoring makes room for using other primitives to communicate
> > with OP-TEE in secure world while being able to reuse as much as
> > possible from the present driver.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/call.c          |  86 +++++++++--------
> >  drivers/tee/optee/core.c          | 148 ++++++++++++++++++++----------
> >  drivers/tee/optee/optee_private.h |  35 +++++--
> >  drivers/tee/optee/rpc.c           |  19 ++--
> >  4 files changed, 182 insertions(+), 106 deletions(-)
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 9d8f5a95e42f..00ecd794e59a 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2015, Linaro Limited
> > + * Copyright (c) 2015-2021, Linaro Limited
> >   */
> >  #include <linux/arm-smccc.h>
> >  #include <linux/device.h>
> > @@ -118,20 +118,25 @@ static struct optee_session *find_session(struct optee_context_data *ctxdata,
> >  /**
> >   * optee_do_call_with_arg() - Do an SMC to OP-TEE in secure world
> >   * @ctx:       calling context
> > - * @parg:      physical address of message to pass to secure world
> > + * @arg:       shared memory holding the message to pass to secure world
> >   *
> >   * Does and SMC to OP-TEE in secure world and handles eventual resulting
> >   * Remote Procedure Calls (RPC) from OP-TEE.
> >   *
> >   * Returns return code from secure world, 0 is OK
> >   */
> > -u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
> > +int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg)
> >  {
> >         struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_call_waiter w;
> >         struct optee_rpc_param param = { };
> >         struct optee_call_ctx call_ctx = { };
> > -       u32 ret;
> > +       phys_addr_t parg;
> > +       int rc;
> > +
> > +       rc = tee_shm_get_pa(arg, 0, &parg);
> > +       if (rc)
> > +               return rc;
> >
> >         param.a0 = OPTEE_SMC_CALL_WITH_ARG;
> >         reg_pair_from_64(&param.a1, &param.a2, parg);
> > @@ -160,7 +165,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
> >                         param.a3 = res.a3;
> >                         optee_handle_rpc(ctx, &param, &call_ctx);
> >                 } else {
> > -                       ret = res.a0;
> > +                       rc = res.a0;
> >                         break;
> >                 }
> >         }
> > @@ -172,14 +177,12 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
> >          */
> >         optee_cq_wait_final(&optee->call_queue, &w);
> >
> > -       return ret;
> > +       return rc;
> >  }
> >
> >  static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
> > -                                  struct optee_msg_arg **msg_arg,
> > -                                  phys_addr_t *msg_parg)
> > +                                  struct optee_msg_arg **msg_arg)
> >  {
> > -       int rc;
> >         struct tee_shm *shm;
> >         struct optee_msg_arg *ma;
> >
> > @@ -190,22 +193,13 @@ static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
> >
> >         ma = tee_shm_get_va(shm, 0);
> >         if (IS_ERR(ma)) {
> > -               rc = PTR_ERR(ma);
> > -               goto out;
> > +               tee_shm_free(shm);
> > +               return (void *)ma;
> >         }
> >
> > -       rc = tee_shm_get_pa(shm, 0, msg_parg);
> > -       if (rc)
> > -               goto out;
> > -
> >         memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
> >         ma->num_params = num_params;
> >         *msg_arg = ma;
> > -out:
> > -       if (rc) {
> > -               tee_shm_free(shm);
> > -               return ERR_PTR(rc);
> > -       }
> >
> >         return shm;
> >  }
> > @@ -214,16 +208,16 @@ int optee_open_session(struct tee_context *ctx,
> >                        struct tee_ioctl_open_session_arg *arg,
> >                        struct tee_param *param)
> >  {
> > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_context_data *ctxdata = ctx->data;
> >         int rc;
> >         struct tee_shm *shm;
> >         struct optee_msg_arg *msg_arg;
> > -       phys_addr_t msg_parg;
> >         struct optee_session *sess = NULL;
> >         uuid_t client_uuid;
> >
> >         /* +2 for the meta parameters added below */
> > -       shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg, &msg_parg);
> > +       shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> > @@ -247,7 +241,8 @@ int optee_open_session(struct tee_context *ctx,
> >                 goto out;
> >         export_uuid(msg_arg->params[1].u.octets, &client_uuid);
> >
> > -       rc = optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
> > +       rc = optee->ops->to_msg_param(optee, msg_arg->params + 2,
> > +                                     arg->num_params, param);
> >         if (rc)
> >                 goto out;
> >
> > @@ -257,7 +252,7 @@ int optee_open_session(struct tee_context *ctx,
> >                 goto out;
> >         }
> >
> > -       if (optee_do_call_with_arg(ctx, msg_parg)) {
> > +       if (optee->ops->do_call_with_arg(ctx, shm)) {
> >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> >         }
> > @@ -272,7 +267,8 @@ int optee_open_session(struct tee_context *ctx,
> >                 kfree(sess);
> >         }
> >
> > -       if (optee_from_msg_param(param, arg->num_params, msg_arg->params + 2)) {
> > +       if (optee->ops->from_msg_param(optee, param, arg->num_params,
> > +                                      msg_arg->params + 2)) {
> >                 arg->ret = TEEC_ERROR_COMMUNICATION;
> >                 arg->ret_origin = TEEC_ORIGIN_COMMS;
> >                 /* Close session again to avoid leakage */
> > @@ -291,16 +287,16 @@ int optee_open_session(struct tee_context *ctx,
> >  int optee_close_session_helper(struct tee_context *ctx, u32 session)
> >  {
> >         struct tee_shm *shm;
> > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_msg_arg *msg_arg;
> > -       phys_addr_t msg_parg;
> >
> > -       shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
> > +       shm = get_msg_arg(ctx, 0, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> >         msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> >         msg_arg->session = session;
> > -       optee_do_call_with_arg(ctx, msg_parg);
> > +       optee->ops->do_call_with_arg(ctx, shm);
> >
> >         tee_shm_free(shm);
> >
> > @@ -328,10 +324,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
> >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >                       struct tee_param *param)
> >  {
> > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_context_data *ctxdata = ctx->data;
> >         struct tee_shm *shm;
> >         struct optee_msg_arg *msg_arg;
> > -       phys_addr_t msg_parg;
> >         struct optee_session *sess;
> >         int rc;
> >
> > @@ -342,7 +338,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >         if (!sess)
> >                 return -EINVAL;
> >
> > -       shm = get_msg_arg(ctx, arg->num_params, &msg_arg, &msg_parg);
> > +       shm = get_msg_arg(ctx, arg->num_params, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >         msg_arg->cmd = OPTEE_MSG_CMD_INVOKE_COMMAND;
> > @@ -350,16 +346,18 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >         msg_arg->session = arg->session;
> >         msg_arg->cancel_id = arg->cancel_id;
> >
> > -       rc = optee_to_msg_param(msg_arg->params, arg->num_params, param);
> > +       rc = optee->ops->to_msg_param(optee, msg_arg->params, arg->num_params,
> > +                                     param);
> >         if (rc)
> >                 goto out;
> >
> > -       if (optee_do_call_with_arg(ctx, msg_parg)) {
> > +       if (optee->ops->do_call_with_arg(ctx, shm)) {
> >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> >         }
> >
> > -       if (optee_from_msg_param(param, arg->num_params, msg_arg->params)) {
> > +       if (optee->ops->from_msg_param(optee, param, arg->num_params,
> > +                                      msg_arg->params)) {
> >                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
> >                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
> >         }
> > @@ -373,10 +371,10 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> >
> >  int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >  {
> > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_context_data *ctxdata = ctx->data;
> >         struct tee_shm *shm;
> >         struct optee_msg_arg *msg_arg;
> > -       phys_addr_t msg_parg;
> >         struct optee_session *sess;
> >
> >         /* Check that the session is valid */
> > @@ -386,14 +384,14 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
> >         if (!sess)
> >                 return -EINVAL;
> >
> > -       shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
> > +       shm = get_msg_arg(ctx, 0, &msg_arg);
> >         if (IS_ERR(shm))
> >                 return PTR_ERR(shm);
> >
> >         msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
> >         msg_arg->session = session;
> >         msg_arg->cancel_id = cancel_id;
> > -       optee_do_call_with_arg(ctx, msg_parg);
> > +       optee->ops->do_call_with_arg(ctx, shm);
> >
> >         tee_shm_free(shm);
> >         return 0;
> > @@ -592,10 +590,10 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >                        struct page **pages, size_t num_pages,
> >                        unsigned long start)
> >  {
> > -       struct tee_shm *shm_arg = NULL;
> > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_msg_arg *msg_arg;
> > +       struct tee_shm *shm_arg;
> >         u64 *pages_list;
> > -       phys_addr_t msg_parg;
> >         int rc;
> >
> >         if (!num_pages)
> > @@ -609,7 +607,7 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >         if (!pages_list)
> >                 return -ENOMEM;
> >
> > -       shm_arg = get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
> > +       shm_arg = get_msg_arg(ctx, 1, &msg_arg);
> >         if (IS_ERR(shm_arg)) {
> >                 rc = PTR_ERR(shm_arg);
> >                 goto out;
> > @@ -630,7 +628,7 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >         msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
> >           (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
> >
> > -       if (optee_do_call_with_arg(ctx, msg_parg) ||
> > +       if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
> >             msg_arg->ret != TEEC_SUCCESS)
> >                 rc = -EINVAL;
> >
> > @@ -642,12 +640,12 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >
> >  int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> >  {
> > -       struct tee_shm *shm_arg;
> > +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >         struct optee_msg_arg *msg_arg;
> > -       phys_addr_t msg_parg;
> > +       struct tee_shm *shm_arg;
> >         int rc = 0;
> >
> > -       shm_arg = get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
> > +       shm_arg = get_msg_arg(ctx, 1, &msg_arg);
> >         if (IS_ERR(shm_arg))
> >                 return PTR_ERR(shm_arg);
> >
> > @@ -656,7 +654,7 @@ int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
> >         msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> >         msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
> >
> > -       if (optee_do_call_with_arg(ctx, msg_parg) ||
> > +       if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
> >             msg_arg->ret != TEEC_SUCCESS)
> >                 rc = -EINVAL;
> >         tee_shm_free(shm_arg);
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 949223b214c3..f689f171a794 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2015, Linaro Limited
> > + * Copyright (c) 2015-2021, Linaro Limited
> >   */
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > @@ -26,21 +26,87 @@
> >
> >  #define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
> >
> > +static void from_msg_param_value(struct tee_param *p, u32 attr,
> > +                                const struct optee_msg_param *mp)
> > +{
> > +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
> > +                 attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> > +       p->u.value.a = mp->u.value.a;
> > +       p->u.value.b = mp->u.value.b;
> > +       p->u.value.c = mp->u.value.c;
> > +}
> > +
> > +static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
> > +                                 const struct optee_msg_param *mp)
> > +{
> > +       struct tee_shm *shm;
> > +       phys_addr_t pa;
> > +       int rc;
> > +
> > +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > +                 attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> > +       p->u.memref.size = mp->u.tmem.size;
> > +       shm = (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
> > +       if (!shm) {
> > +               p->u.memref.shm_offs = 0;
> > +               p->u.memref.shm = NULL;
> > +               return 0;
> > +       }
> > +
> > +       rc = tee_shm_get_pa(shm, 0, &pa);
> > +       if (rc)
> > +               return rc;
> > +
> > +       p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
> > +       p->u.memref.shm = shm;
> > +
> > +       /* Check that the memref is covered by the shm object */
> > +       if (p->u.memref.size) {
> > +               size_t o = p->u.memref.shm_offs +
> > +                          p->u.memref.size - 1;
> > +
> > +               rc = tee_shm_get_pa(shm, o, NULL);
> > +               if (rc)
> > +                       return rc;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
> > +                                  const struct optee_msg_param *mp)
> > +{
> > +       struct tee_shm *shm;
> > +
> > +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > +                 attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> > +       p->u.memref.size = mp->u.rmem.size;
> > +       shm = (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
> > +
> > +       if (shm) {
> > +               p->u.memref.shm_offs = mp->u.rmem.offs;
> > +               p->u.memref.shm = shm;
> > +       } else {
> > +               p->u.memref.shm_offs = 0;
> > +               p->u.memref.shm = NULL;
> > +       }
> > +}
> > +
> >  /**
> >   * optee_from_msg_param() - convert from OPTEE_MSG parameters to
> >   *                         struct tee_param
> > + * @optee:     main service struct
> 
> I don't see this new argument being used. Can you throw some light on
> the use-case for this additional argument?

This function is registered as a callback and the counter part in the
FF-A ABI (optee_ffa_from_msg_param()) will need this parameter. So it's
needed to have the same signature.

> 
> >   * @params:    subsystem internal parameter representation
> >   * @num_params:        number of elements in the parameter arrays
> >   * @msg_params:        OPTEE_MSG parameters
> >   * Returns 0 on success or <0 on failure
> >   */
> > -int optee_from_msg_param(struct tee_param *params, size_t num_params,
> > -                        const struct optee_msg_param *msg_params)
> > +static int optee_from_msg_param(struct optee *optee, struct tee_param *params,
> > +                               size_t num_params,
> > +                               const struct optee_msg_param *msg_params)
> >  {
> >         int rc;
> >         size_t n;
> > -       struct tee_shm *shm;
> > -       phys_addr_t pa;
> >
> >         for (n = 0; n < num_params; n++) {
> >                 struct tee_param *p = params + n;
> > @@ -55,48 +121,19 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
> >                 case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
> >                 case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
> >                 case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
> > -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
> > -                                 attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> > -                       p->u.value.a = mp->u.value.a;
> > -                       p->u.value.b = mp->u.value.b;
> > -                       p->u.value.c = mp->u.value.c;
> > +                       from_msg_param_value(p, attr, mp);
> >                         break;
> >                 case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
> >                 case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
> >                 case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
> > -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > -                                 attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> > -                       p->u.memref.size = mp->u.tmem.size;
> > -                       shm = (struct tee_shm *)(unsigned long)
> > -                               mp->u.tmem.shm_ref;
> > -                       if (!shm) {
> > -                               p->u.memref.shm_offs = 0;
> > -                               p->u.memref.shm = NULL;
> > -                               break;
> > -                       }
> > -                       rc = tee_shm_get_pa(shm, 0, &pa);
> > +                       rc = from_msg_param_tmp_mem(p, attr, mp);
> >                         if (rc)
> >                                 return rc;
> > -                       p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
> > -                       p->u.memref.shm = shm;
> >                         break;
> >                 case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
> >                 case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
> >                 case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
> > -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > -                                 attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> > -                       p->u.memref.size = mp->u.rmem.size;
> > -                       shm = (struct tee_shm *)(unsigned long)
> > -                               mp->u.rmem.shm_ref;
> > -
> > -                       if (!shm) {
> > -                               p->u.memref.shm_offs = 0;
> > -                               p->u.memref.shm = NULL;
> > -                               break;
> > -                       }
> > -                       p->u.memref.shm_offs = mp->u.rmem.offs;
> > -                       p->u.memref.shm = shm;
> > -
> > +                       from_msg_param_reg_mem(p, attr, mp);
> >                         break;
> >
> >                 default:
> > @@ -106,6 +143,16 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
> >         return 0;
> >  }
> >
> > +static void to_msg_param_value(struct optee_msg_param *mp,
> > +                              const struct tee_param *p)
> > +{
> > +       mp->attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
> > +                  TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> > +       mp->u.value.a = p->u.value.a;
> > +       mp->u.value.b = p->u.value.b;
> > +       mp->u.value.c = p->u.value.c;
> > +}
> > +
> >  static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
> >                                 const struct tee_param *p)
> >  {
> > @@ -148,13 +195,15 @@ static int to_msg_param_reg_mem(struct optee_msg_param *mp,
> >
> >  /**
> >   * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parameters
> > + * @optee:     main service struct
> 
> Same here.

This function is also registered as a callback.  Here it's questionable
though, but I added it to let optee->ops->to_msg_param() and
optee->ops->from_msg_param() have better symmetry.

Thanks,
Jens
