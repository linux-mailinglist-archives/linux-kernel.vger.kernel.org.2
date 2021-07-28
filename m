Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35553D8B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhG1J7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhG1J7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:59:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:59:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so1515205otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ba4rx7hrGA75oCWkKBjPtODYyHU6y4P5ZpCMaKRA1R4=;
        b=bHm/3xLbjdaqJbg67BjmrN/8X2ZhWaU8O9nDNGBeAwnuC01cUVKMzYpZN2TW2ch0oz
         dUq8068WtEKxZlwC7iMvJvT4vbmaUSiM6TX0rQSP6UUmpihLtIwZGZgsPxxwcJG0X5ZG
         jiOrxtPCTRud1ETE2kKGmEALM/rs9v7n5XdOqjVbwjg3mxXYqCzoEngyHPOkq4jPBALM
         qgqwZyvOxRO3cw1/ozdWVJo7IXmTgywAI4kzTg3LottxOkuPogN4wbZahY3VJSJdpvIY
         PfBMTfIPBgbtvPv0R2AmCDosj6MrDWfCOVBu8sKqZ6eD7b9Z0C2/lJCwzdgljMAIpLBi
         6tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ba4rx7hrGA75oCWkKBjPtODYyHU6y4P5ZpCMaKRA1R4=;
        b=bmV94NxzOSw5iRydm4ccMGSTJyH3Ku8MXDXF9EgZ8gUWqsedif9CWc15kbbSHwertA
         TMu9tHStG1Eg37/UHGz1Qpbylh+rpkIAMYEalwulyBUrYztXmYx0K8fH2ItQDOwkC80j
         aThU8F5Zy3/lTxdEjwTxaJUsu/ARwLgyrdIFf5yn/lLhJ5H5ztve8fhdTqcUnE8ZBF/8
         ACAE2cXLlbPumcYFL77OOWlsVGC4pSMEvsQM9eEDyyisyS5fnw6j0cCmQJZnRYT1LrZG
         7cpJPMTZDVYG7nSF15NDSRZ6tu+JuhqmEMwbXpqPAFqKqvQzXuJ2ug3s0GTQ91uq1Fld
         p9UA==
X-Gm-Message-State: AOAM532TM8/bsexATKR/XPI+89V75JUu/NPzmNMvLSBhmaht+itBjZXa
        bjiSk5dFdf7tGRPM1G2V7GSfmjCPyj6IT75iEEMoeg==
X-Google-Smtp-Source: ABdhPJwM88u3SYynWBbVstraHcpnTBC9z6jbukcptLzeBlIEGkl7qjfxPb/7ABFkZf9zRv1qEThExFAAXVyjXQPSj/M=
X-Received: by 2002:a05:6830:913:: with SMTP id v19mr18203370ott.156.1627466384758;
 Wed, 28 Jul 2021 02:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org> <20210722121757.1944658-4-jens.wiklander@linaro.org>
In-Reply-To: <20210722121757.1944658-4-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 28 Jul 2021 15:29:33 +0530
Message-ID: <CAFA6WYMbOO6N2OSieeWitvti0bvOndLDWyc=yPrrC7cm4GLpPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] optee: refactor driver with internal callbacks
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

On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> The OP-TEE driver is refactored with three internal callbacks replacing
> direct calls to optee_from_msg_param(), optee_to_msg_param() and
> optee_do_call_with_arg().
>
> These functions a central to communicating with OP-TEE in secure world
> by using the SMC Calling Convention directly.
>
> This refactoring makes room for using other primitives to communicate
> with OP-TEE in secure world while being able to reuse as much as
> possible from the present driver.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c          |  86 +++++++++--------
>  drivers/tee/optee/core.c          | 148 ++++++++++++++++++++----------
>  drivers/tee/optee/optee_private.h |  35 +++++--
>  drivers/tee/optee/rpc.c           |  19 ++--
>  4 files changed, 182 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 9d8f5a95e42f..00ecd794e59a 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015, Linaro Limited
> + * Copyright (c) 2015-2021, Linaro Limited
>   */
>  #include <linux/arm-smccc.h>
>  #include <linux/device.h>
> @@ -118,20 +118,25 @@ static struct optee_session *find_session(struct optee_context_data *ctxdata,
>  /**
>   * optee_do_call_with_arg() - Do an SMC to OP-TEE in secure world
>   * @ctx:       calling context
> - * @parg:      physical address of message to pass to secure world
> + * @arg:       shared memory holding the message to pass to secure world
>   *
>   * Does and SMC to OP-TEE in secure world and handles eventual resulting
>   * Remote Procedure Calls (RPC) from OP-TEE.
>   *
>   * Returns return code from secure world, 0 is OK
>   */
> -u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
> +int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_call_waiter w;
>         struct optee_rpc_param param = { };
>         struct optee_call_ctx call_ctx = { };
> -       u32 ret;
> +       phys_addr_t parg;
> +       int rc;
> +
> +       rc = tee_shm_get_pa(arg, 0, &parg);
> +       if (rc)
> +               return rc;
>
>         param.a0 = OPTEE_SMC_CALL_WITH_ARG;
>         reg_pair_from_64(&param.a1, &param.a2, parg);
> @@ -160,7 +165,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>                         param.a3 = res.a3;
>                         optee_handle_rpc(ctx, &param, &call_ctx);
>                 } else {
> -                       ret = res.a0;
> +                       rc = res.a0;
>                         break;
>                 }
>         }
> @@ -172,14 +177,12 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>          */
>         optee_cq_wait_final(&optee->call_queue, &w);
>
> -       return ret;
> +       return rc;
>  }
>
>  static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
> -                                  struct optee_msg_arg **msg_arg,
> -                                  phys_addr_t *msg_parg)
> +                                  struct optee_msg_arg **msg_arg)
>  {
> -       int rc;
>         struct tee_shm *shm;
>         struct optee_msg_arg *ma;
>
> @@ -190,22 +193,13 @@ static struct tee_shm *get_msg_arg(struct tee_context *ctx, size_t num_params,
>
>         ma = tee_shm_get_va(shm, 0);
>         if (IS_ERR(ma)) {
> -               rc = PTR_ERR(ma);
> -               goto out;
> +               tee_shm_free(shm);
> +               return (void *)ma;
>         }
>
> -       rc = tee_shm_get_pa(shm, 0, msg_parg);
> -       if (rc)
> -               goto out;
> -
>         memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
>         ma->num_params = num_params;
>         *msg_arg = ma;
> -out:
> -       if (rc) {
> -               tee_shm_free(shm);
> -               return ERR_PTR(rc);
> -       }
>
>         return shm;
>  }
> @@ -214,16 +208,16 @@ int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param)
>  {
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_context_data *ctxdata = ctx->data;
>         int rc;
>         struct tee_shm *shm;
>         struct optee_msg_arg *msg_arg;
> -       phys_addr_t msg_parg;
>         struct optee_session *sess = NULL;
>         uuid_t client_uuid;
>
>         /* +2 for the meta parameters added below */
> -       shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg, &msg_parg);
> +       shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
> @@ -247,7 +241,8 @@ int optee_open_session(struct tee_context *ctx,
>                 goto out;
>         export_uuid(msg_arg->params[1].u.octets, &client_uuid);
>
> -       rc = optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
> +       rc = optee->ops->to_msg_param(optee, msg_arg->params + 2,
> +                                     arg->num_params, param);
>         if (rc)
>                 goto out;
>
> @@ -257,7 +252,7 @@ int optee_open_session(struct tee_context *ctx,
>                 goto out;
>         }
>
> -       if (optee_do_call_with_arg(ctx, msg_parg)) {
> +       if (optee->ops->do_call_with_arg(ctx, shm)) {
>                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
>                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
>         }
> @@ -272,7 +267,8 @@ int optee_open_session(struct tee_context *ctx,
>                 kfree(sess);
>         }
>
> -       if (optee_from_msg_param(param, arg->num_params, msg_arg->params + 2)) {
> +       if (optee->ops->from_msg_param(optee, param, arg->num_params,
> +                                      msg_arg->params + 2)) {
>                 arg->ret = TEEC_ERROR_COMMUNICATION;
>                 arg->ret_origin = TEEC_ORIGIN_COMMS;
>                 /* Close session again to avoid leakage */
> @@ -291,16 +287,16 @@ int optee_open_session(struct tee_context *ctx,
>  int optee_close_session_helper(struct tee_context *ctx, u32 session)
>  {
>         struct tee_shm *shm;
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_msg_arg *msg_arg;
> -       phys_addr_t msg_parg;
>
> -       shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
> +       shm = get_msg_arg(ctx, 0, &msg_arg);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
>         msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
>         msg_arg->session = session;
> -       optee_do_call_with_arg(ctx, msg_parg);
> +       optee->ops->do_call_with_arg(ctx, shm);
>
>         tee_shm_free(shm);
>
> @@ -328,10 +324,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
>  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>                       struct tee_param *param)
>  {
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_context_data *ctxdata = ctx->data;
>         struct tee_shm *shm;
>         struct optee_msg_arg *msg_arg;
> -       phys_addr_t msg_parg;
>         struct optee_session *sess;
>         int rc;
>
> @@ -342,7 +338,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>         if (!sess)
>                 return -EINVAL;
>
> -       shm = get_msg_arg(ctx, arg->num_params, &msg_arg, &msg_parg);
> +       shm = get_msg_arg(ctx, arg->num_params, &msg_arg);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>         msg_arg->cmd = OPTEE_MSG_CMD_INVOKE_COMMAND;
> @@ -350,16 +346,18 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>         msg_arg->session = arg->session;
>         msg_arg->cancel_id = arg->cancel_id;
>
> -       rc = optee_to_msg_param(msg_arg->params, arg->num_params, param);
> +       rc = optee->ops->to_msg_param(optee, msg_arg->params, arg->num_params,
> +                                     param);
>         if (rc)
>                 goto out;
>
> -       if (optee_do_call_with_arg(ctx, msg_parg)) {
> +       if (optee->ops->do_call_with_arg(ctx, shm)) {
>                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
>                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
>         }
>
> -       if (optee_from_msg_param(param, arg->num_params, msg_arg->params)) {
> +       if (optee->ops->from_msg_param(optee, param, arg->num_params,
> +                                      msg_arg->params)) {
>                 msg_arg->ret = TEEC_ERROR_COMMUNICATION;
>                 msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
>         }
> @@ -373,10 +371,10 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>
>  int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
>  {
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_context_data *ctxdata = ctx->data;
>         struct tee_shm *shm;
>         struct optee_msg_arg *msg_arg;
> -       phys_addr_t msg_parg;
>         struct optee_session *sess;
>
>         /* Check that the session is valid */
> @@ -386,14 +384,14 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
>         if (!sess)
>                 return -EINVAL;
>
> -       shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
> +       shm = get_msg_arg(ctx, 0, &msg_arg);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
>         msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
>         msg_arg->session = session;
>         msg_arg->cancel_id = cancel_id;
> -       optee_do_call_with_arg(ctx, msg_parg);
> +       optee->ops->do_call_with_arg(ctx, shm);
>
>         tee_shm_free(shm);
>         return 0;
> @@ -592,10 +590,10 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>                        struct page **pages, size_t num_pages,
>                        unsigned long start)
>  {
> -       struct tee_shm *shm_arg = NULL;
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_msg_arg *msg_arg;
> +       struct tee_shm *shm_arg;
>         u64 *pages_list;
> -       phys_addr_t msg_parg;
>         int rc;
>
>         if (!num_pages)
> @@ -609,7 +607,7 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>         if (!pages_list)
>                 return -ENOMEM;
>
> -       shm_arg = get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
> +       shm_arg = get_msg_arg(ctx, 1, &msg_arg);
>         if (IS_ERR(shm_arg)) {
>                 rc = PTR_ERR(shm_arg);
>                 goto out;
> @@ -630,7 +628,7 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>         msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
>           (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
>
> -       if (optee_do_call_with_arg(ctx, msg_parg) ||
> +       if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
>             msg_arg->ret != TEEC_SUCCESS)
>                 rc = -EINVAL;
>
> @@ -642,12 +640,12 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>
>  int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
>  {
> -       struct tee_shm *shm_arg;
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_msg_arg *msg_arg;
> -       phys_addr_t msg_parg;
> +       struct tee_shm *shm_arg;
>         int rc = 0;
>
> -       shm_arg = get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
> +       shm_arg = get_msg_arg(ctx, 1, &msg_arg);
>         if (IS_ERR(shm_arg))
>                 return PTR_ERR(shm_arg);
>
> @@ -656,7 +654,7 @@ int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
>         msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
>         msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
>
> -       if (optee_do_call_with_arg(ctx, msg_parg) ||
> +       if (optee->ops->do_call_with_arg(ctx, shm_arg) ||
>             msg_arg->ret != TEEC_SUCCESS)
>                 rc = -EINVAL;
>         tee_shm_free(shm_arg);
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 949223b214c3..f689f171a794 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015, Linaro Limited
> + * Copyright (c) 2015-2021, Linaro Limited
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -26,21 +26,87 @@
>
>  #define OPTEE_SHM_NUM_PRIV_PAGES       CONFIG_OPTEE_SHM_NUM_PRIV_PAGES
>
> +static void from_msg_param_value(struct tee_param *p, u32 attr,
> +                                const struct optee_msg_param *mp)
> +{
> +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
> +                 attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> +       p->u.value.a = mp->u.value.a;
> +       p->u.value.b = mp->u.value.b;
> +       p->u.value.c = mp->u.value.c;
> +}
> +
> +static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
> +                                 const struct optee_msg_param *mp)
> +{
> +       struct tee_shm *shm;
> +       phys_addr_t pa;
> +       int rc;
> +
> +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> +                 attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> +       p->u.memref.size = mp->u.tmem.size;
> +       shm = (struct tee_shm *)(unsigned long)mp->u.tmem.shm_ref;
> +       if (!shm) {
> +               p->u.memref.shm_offs = 0;
> +               p->u.memref.shm = NULL;
> +               return 0;
> +       }
> +
> +       rc = tee_shm_get_pa(shm, 0, &pa);
> +       if (rc)
> +               return rc;
> +
> +       p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
> +       p->u.memref.shm = shm;
> +
> +       /* Check that the memref is covered by the shm object */
> +       if (p->u.memref.size) {
> +               size_t o = p->u.memref.shm_offs +
> +                          p->u.memref.size - 1;
> +
> +               rc = tee_shm_get_pa(shm, o, NULL);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +
> +static void from_msg_param_reg_mem(struct tee_param *p, u32 attr,
> +                                  const struct optee_msg_param *mp)
> +{
> +       struct tee_shm *shm;
> +
> +       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> +                 attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> +       p->u.memref.size = mp->u.rmem.size;
> +       shm = (struct tee_shm *)(unsigned long)mp->u.rmem.shm_ref;
> +
> +       if (shm) {
> +               p->u.memref.shm_offs = mp->u.rmem.offs;
> +               p->u.memref.shm = shm;
> +       } else {
> +               p->u.memref.shm_offs = 0;
> +               p->u.memref.shm = NULL;
> +       }
> +}
> +
>  /**
>   * optee_from_msg_param() - convert from OPTEE_MSG parameters to
>   *                         struct tee_param
> + * @optee:     main service struct

I don't see this new argument being used. Can you throw some light on
the use-case for this additional argument?

>   * @params:    subsystem internal parameter representation
>   * @num_params:        number of elements in the parameter arrays
>   * @msg_params:        OPTEE_MSG parameters
>   * Returns 0 on success or <0 on failure
>   */
> -int optee_from_msg_param(struct tee_param *params, size_t num_params,
> -                        const struct optee_msg_param *msg_params)
> +static int optee_from_msg_param(struct optee *optee, struct tee_param *params,
> +                               size_t num_params,
> +                               const struct optee_msg_param *msg_params)
>  {
>         int rc;
>         size_t n;
> -       struct tee_shm *shm;
> -       phys_addr_t pa;
>
>         for (n = 0; n < num_params; n++) {
>                 struct tee_param *p = params + n;
> @@ -55,48 +121,19 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
>                 case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
>                 case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
>                 case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
> -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT +
> -                                 attr - OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
> -                       p->u.value.a = mp->u.value.a;
> -                       p->u.value.b = mp->u.value.b;
> -                       p->u.value.c = mp->u.value.c;
> +                       from_msg_param_value(p, attr, mp);
>                         break;
>                 case OPTEE_MSG_ATTR_TYPE_TMEM_INPUT:
>                 case OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT:
>                 case OPTEE_MSG_ATTR_TYPE_TMEM_INOUT:
> -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> -                                 attr - OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
> -                       p->u.memref.size = mp->u.tmem.size;
> -                       shm = (struct tee_shm *)(unsigned long)
> -                               mp->u.tmem.shm_ref;
> -                       if (!shm) {
> -                               p->u.memref.shm_offs = 0;
> -                               p->u.memref.shm = NULL;
> -                               break;
> -                       }
> -                       rc = tee_shm_get_pa(shm, 0, &pa);
> +                       rc = from_msg_param_tmp_mem(p, attr, mp);
>                         if (rc)
>                                 return rc;
> -                       p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
> -                       p->u.memref.shm = shm;
>                         break;
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
> -                       p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> -                                 attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
> -                       p->u.memref.size = mp->u.rmem.size;
> -                       shm = (struct tee_shm *)(unsigned long)
> -                               mp->u.rmem.shm_ref;
> -
> -                       if (!shm) {
> -                               p->u.memref.shm_offs = 0;
> -                               p->u.memref.shm = NULL;
> -                               break;
> -                       }
> -                       p->u.memref.shm_offs = mp->u.rmem.offs;
> -                       p->u.memref.shm = shm;
> -
> +                       from_msg_param_reg_mem(p, attr, mp);
>                         break;
>
>                 default:
> @@ -106,6 +143,16 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
>         return 0;
>  }
>
> +static void to_msg_param_value(struct optee_msg_param *mp,
> +                              const struct tee_param *p)
> +{
> +       mp->attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
> +                  TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +       mp->u.value.a = p->u.value.a;
> +       mp->u.value.b = p->u.value.b;
> +       mp->u.value.c = p->u.value.c;
> +}
> +
>  static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
>                                 const struct tee_param *p)
>  {
> @@ -148,13 +195,15 @@ static int to_msg_param_reg_mem(struct optee_msg_param *mp,
>
>  /**
>   * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parameters
> + * @optee:     main service struct

Same here.

-Sumit

>   * @msg_params:        OPTEE_MSG parameters
>   * @num_params:        number of elements in the parameter arrays
>   * @params:    subsystem itnernal parameter representation
>   * Returns 0 on success or <0 on failure
>   */
> -int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
> -                      const struct tee_param *params)
> +static int optee_to_msg_param(struct optee *optee,
> +                             struct optee_msg_param *msg_params,
> +                             size_t num_params, const struct tee_param *params)
>  {
>         int rc;
>         size_t n;
> @@ -171,11 +220,7 @@ int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
> -                       mp->attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT + p->attr -
> -                                  TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> -                       mp->u.value.a = p->u.value.a;
> -                       mp->u.value.b = p->u.value.b;
> -                       mp->u.value.c = p->u.value.c;
> +                       to_msg_param_value(mp, p);
>                         break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
> @@ -301,7 +346,7 @@ static void optee_release_supp(struct tee_context *ctx)
>         optee_supp_release(&optee->supp);
>  }
>
> -static const struct tee_driver_ops optee_ops = {
> +static const struct tee_driver_ops optee_clnt_ops = {
>         .get_version = optee_get_version,
>         .open = optee_open,
>         .release = optee_release,
> @@ -313,9 +358,9 @@ static const struct tee_driver_ops optee_ops = {
>         .shm_unregister = optee_shm_unregister,
>  };
>
> -static const struct tee_desc optee_desc = {
> +static const struct tee_desc optee_clnt_desc = {
>         .name = DRIVER_NAME "-clnt",
> -       .ops = &optee_ops,
> +       .ops = &optee_clnt_ops,
>         .owner = THIS_MODULE,
>  };
>
> @@ -336,6 +381,12 @@ static const struct tee_desc optee_supp_desc = {
>         .flags = TEE_DESC_PRIVILEGED,
>  };
>
> +static const struct optee_ops optee_ops = {
> +       .do_call_with_arg = optee_do_call_with_arg,
> +       .to_msg_param = optee_to_msg_param,
> +       .from_msg_param = optee_from_msg_param,
> +};
> +
>  static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
>  {
>         struct arm_smccc_res res;
> @@ -637,10 +688,11 @@ static int optee_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> +       optee->ops = &optee_ops;
>         optee->invoke_fn = invoke_fn;
>         optee->sec_caps = sec_caps;
>
> -       teedev = tee_device_alloc(&optee_desc, NULL, pool, optee);
> +       teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
>         if (IS_ERR(teedev)) {
>                 rc = PTR_ERR(teedev);
>                 goto err;
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 2b63b796645e..c5741e96e967 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2015, Linaro Limited
> + * Copyright (c) 2015-2021, Linaro Limited
>   */
>
>  #ifndef OPTEE_PRIVATE_H
> @@ -66,9 +66,34 @@ struct optee_supp {
>         struct completion reqs_c;
>  };
>
> +struct optee;
> +
> +/**
> + * struct optee_ops - OP-TEE driver internal operations
> + * @do_call_with_arg:  enters OP-TEE in secure world
> + * @to_msg_param:      converts from struct tee_param to OPTEE_MSG parameters
> + * @from_msg_param:    converts from OPTEE_MSG parameters to struct tee_param
> + *
> + * These OPs are only supposed to be used internally in the OP-TEE driver
> + * as a way of abstracting the different methogs of entering OP-TEE in
> + * secure world.
> + */
> +struct optee_ops {
> +       int (*do_call_with_arg)(struct tee_context *ctx,
> +                               struct tee_shm *shm_arg);
> +       int (*to_msg_param)(struct optee *optee,
> +                           struct optee_msg_param *msg_params,
> +                           size_t num_params, const struct tee_param *params);
> +       int (*from_msg_param)(struct optee *optee, struct tee_param *params,
> +                             size_t num_params,
> +                             const struct optee_msg_param *msg_params);
> +};
> +
>  /**
>   * struct optee - main service struct
>   * @supp_teedev:       supplicant device
> + * @ops:               internal callbacks for different ways to reach secure
> + *                     world
>   * @teedev:            client device
>   * @invoke_fn:         function to issue smc or hvc
>   * @call_queue:                queue of threads waiting to call @invoke_fn
> @@ -86,6 +111,7 @@ struct optee_supp {
>  struct optee {
>         struct tee_device *supp_teedev;
>         struct tee_device *teedev;
> +       const struct optee_ops *ops;
>         optee_invoke_fn *invoke_fn;
>         struct optee_call_queue call_queue;
>         struct optee_wait_queue wait_queue;
> @@ -148,7 +174,7 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
>  int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
>                     struct tee_param *param);
>
> -u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg);
> +int optee_do_call_with_arg(struct tee_context *ctx, struct tee_shm *arg);
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> @@ -171,11 +197,6 @@ int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
>                             unsigned long start);
>  int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm);
>
> -int optee_from_msg_param(struct tee_param *params, size_t num_params,
> -                        const struct optee_msg_param *msg_params);
> -int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
> -                      const struct tee_param *params);
> -
>  u64 *optee_allocate_pages_list(size_t num_entries);
>  void optee_free_pages_list(void *array, size_t num_entries);
>  void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 1849180b0278..39562fb6841e 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015-2016, Linaro Limited
> + * Copyright (c) 2015-2021, Linaro Limited
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -55,6 +55,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>                                              struct optee_msg_arg *arg)
>  {
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct tee_param *params;
>         struct i2c_adapter *adapter;
>         struct i2c_msg msg = { };
> @@ -79,7 +80,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>                 return;
>         }
>
> -       if (optee_from_msg_param(params, arg->num_params, arg->params))
> +       if (optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params))
>                 goto bad;
>
>         for (i = 0; i < arg->num_params; i++) {
> @@ -122,7 +124,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>                 arg->ret = TEEC_ERROR_COMMUNICATION;
>         } else {
>                 params[3].u.value.a = msg.len;
> -               if (optee_to_msg_param(arg->params, arg->num_params, params))
> +               if (optee->ops->to_msg_param(optee, arg->params,
> +                                            arg->num_params, params))
>                         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>                 else
>                         arg->ret = TEEC_SUCCESS;
> @@ -234,7 +237,7 @@ static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
>         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
>
> -static void handle_rpc_supp_cmd(struct tee_context *ctx,
> +static void handle_rpc_supp_cmd(struct tee_context *ctx, struct optee *optee,
>                                 struct optee_msg_arg *arg)
>  {
>         struct tee_param *params;
> @@ -248,14 +251,16 @@ static void handle_rpc_supp_cmd(struct tee_context *ctx,
>                 return;
>         }
>
> -       if (optee_from_msg_param(params, arg->num_params, arg->params)) {
> +       if (optee->ops->from_msg_param(optee, params, arg->num_params,
> +                                      arg->params)) {
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>                 goto out;
>         }
>
>         arg->ret = optee_supp_thrd_req(ctx, arg->cmd, arg->num_params, params);
>
> -       if (optee_to_msg_param(arg->params, arg->num_params, params))
> +       if (optee->ops->to_msg_param(optee, arg->params, arg->num_params,
> +                                    params))
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  out:
>         kfree(params);
> @@ -480,7 +485,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>                 handle_rpc_func_cmd_i2c_transfer(ctx, arg);
>                 break;
>         default:
> -               handle_rpc_supp_cmd(ctx, arg);
> +               handle_rpc_supp_cmd(ctx, optee, arg);
>         }
>  }
>
> --
> 2.31.1
>
