Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89C3D89F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhG1IqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhG1IqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:46:00 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:45:59 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so480057ooo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXW54YHoGb6p0OaECaGxMSQDhEroyRfhDhDE+SWU4WI=;
        b=JJU3bTVzGtzupFIeJadpKdYzv2Y689RhD0w6lzyW5+OhTqgY+xjF4qzOV/Cm/w5NZB
         dtcIbmjsMHwpHRSAUjq72AJs5MVnjSAWi04YoezMo3Wk+LyWCK+lOSXTfLiYhkvJky2c
         9eKs42p35o81bO1pBH74tZuB7HoqG3ijAvA62MVU0LuGYwC1DSYItH1rx0GX26Lfxqn+
         5lEOuJLKwXIaRTGWj2YkJD24C/IfxOgqDzgEWRGySo+C8W/GbmqtWsc/APCpKB75VZXU
         McwmI2KIvr0bvIgJ2lYYkVrTf/6ALpPGr1yupN+3dz7GmC1AKjuGDPZA3otp2rCmYGhc
         dT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXW54YHoGb6p0OaECaGxMSQDhEroyRfhDhDE+SWU4WI=;
        b=ByQ/iPvyHzJA2vaRmEcCl9Xn+WO3OZka2YZB3eiKGP1zm2hkVvXe38qFpj7VNDH85b
         VX19gAnMDEFZIAkeEHARxW+pokNqZ0rCHvMHt26/DYoFUDlXk/AJ7W9Ev4C3VptAh2Kq
         a+qT4EDANAk3k6Zu5WrGGU1DyPzPdSXAqZmaKEQA4t0mqZptMnm2TniTH+W3WXxVf//c
         gsnEknfqIvCGEf11b1CF7L0DjGYpZOe8az5szSWd6k5hvTmCAWovxSUQXQ4WOhcnvgxd
         1oBIXq31jDTw+bBBzy5pNYlGWWERs8vWWynyv3rXgM0dXU+7LAWBNlIQVTNAy3Fevysr
         H9iA==
X-Gm-Message-State: AOAM530CjWFZa6uqAy8pYpuo5ZAnexbNf66z3xaQ2gokQ+scGpRqxT+P
        AFQ4nl/M08jJ0BgSeLlTAxnNMqYBEJLFJzLbOv0gLQ==
X-Google-Smtp-Source: ABdhPJzQfWM7W7ygyyjy8S5CT8wjjXdnLP2tNHyOQ7OSu38X6cL93er//YDhShGyd2FT/sNShLzhrDv/4aaBBOm9Aqk=
X-Received: by 2002:a4a:e60b:: with SMTP id f11mr16524375oot.8.1627461958720;
 Wed, 28 Jul 2021 01:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org> <20210722121757.1944658-3-jens.wiklander@linaro.org>
In-Reply-To: <20210722121757.1944658-3-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 28 Jul 2021 14:15:47 +0530
Message-ID: <CAFA6WYOJ6At7p21UuWNp8k4=Qwcb_2VFuV78Z9hksyW76p-fKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] optee: simplify optee_release()
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
> Simplifies optee_release() with a new helper function,
> optee_close_session_helper() which has been factored out from
> optee_close_session().
>

Simplification looks good to me.

> A separate optee_release_supp() is added for the supplicant device.
>

On similar terms, can we have separate optee_open_supp() for better
understanding?

-Sumit

> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c          | 31 ++++++++++-------
>  drivers/tee/optee/core.c          | 55 +++++++++++--------------------
>  drivers/tee/optee/optee_private.h |  1 +
>  3 files changed, 39 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 6e6eb836e9b6..9d8f5a95e42f 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -288,12 +288,28 @@ int optee_open_session(struct tee_context *ctx,
>         return rc;
>  }
>
> -int optee_close_session(struct tee_context *ctx, u32 session)
> +int optee_close_session_helper(struct tee_context *ctx, u32 session)
>  {
> -       struct optee_context_data *ctxdata = ctx->data;
>         struct tee_shm *shm;
>         struct optee_msg_arg *msg_arg;
>         phys_addr_t msg_parg;
> +
> +       shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
> +       if (IS_ERR(shm))
> +               return PTR_ERR(shm);
> +
> +       msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> +       msg_arg->session = session;
> +       optee_do_call_with_arg(ctx, msg_parg);
> +
> +       tee_shm_free(shm);
> +
> +       return 0;
> +}
> +
> +int optee_close_session(struct tee_context *ctx, u32 session)
> +{
> +       struct optee_context_data *ctxdata = ctx->data;
>         struct optee_session *sess;
>
>         /* Check that the session is valid and remove it from the list */
> @@ -306,16 +322,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
>                 return -EINVAL;
>         kfree(sess);
>
> -       shm = get_msg_arg(ctx, 0, &msg_arg, &msg_parg);
> -       if (IS_ERR(shm))
> -               return PTR_ERR(shm);
> -
> -       msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> -       msg_arg->session = session;
> -       optee_do_call_with_arg(ctx, msg_parg);
> -
> -       tee_shm_free(shm);
> -       return 0;
> +       return optee_close_session_helper(ctx, session);
>  }
>
>  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ddb8f9ecf307..949223b214c3 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -263,59 +263,42 @@ static int optee_open(struct tee_context *ctx)
>         return 0;
>  }
>
> -static void optee_release(struct tee_context *ctx)
> +static void optee_release_helper(struct tee_context *ctx,
> +                                int (*close_session)(struct tee_context *ctx,
> +                                                     u32 session))
>  {
>         struct optee_context_data *ctxdata = ctx->data;
> -       struct tee_device *teedev = ctx->teedev;
> -       struct optee *optee = tee_get_drvdata(teedev);
> -       struct tee_shm *shm;
> -       struct optee_msg_arg *arg = NULL;
> -       phys_addr_t parg;
>         struct optee_session *sess;
>         struct optee_session *sess_tmp;
>
>         if (!ctxdata)
>                 return;
>
> -       shm = tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_MAPPED);
> -       if (!IS_ERR(shm)) {
> -               arg = tee_shm_get_va(shm, 0);
> -               /*
> -                * If va2pa fails for some reason, we can't call into
> -                * secure world, only free the memory. Secure OS will leak
> -                * sessions and finally refuse more sessions, but we will
> -                * at least let normal world reclaim its memory.
> -                */
> -               if (!IS_ERR(arg))
> -                       if (tee_shm_va2pa(shm, arg, &parg))
> -                               arg = NULL; /* prevent usage of parg below */
> -       }
> -
>         list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
>                                  list_node) {
>                 list_del(&sess->list_node);
> -               if (!IS_ERR_OR_NULL(arg)) {
> -                       memset(arg, 0, sizeof(*arg));
> -                       arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
> -                       arg->session = sess->session_id;
> -                       optee_do_call_with_arg(ctx, parg);
> -               }
> +               close_session(ctx, sess->session_id);
>                 kfree(sess);
>         }
>         kfree(ctxdata);
> +       ctx->data = NULL;
> +}
>
> -       if (!IS_ERR(shm))
> -               tee_shm_free(shm);
> +static void optee_release(struct tee_context *ctx)
> +{
> +       optee_release_helper(ctx, optee_close_session_helper);
> +}
>
> -       ctx->data = NULL;
> +static void optee_release_supp(struct tee_context *ctx)
> +{
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
>
> -       if (teedev == optee->supp_teedev) {
> -               if (optee->scan_bus_wq) {
> -                       destroy_workqueue(optee->scan_bus_wq);
> -                       optee->scan_bus_wq = NULL;
> -               }
> -               optee_supp_release(&optee->supp);
> +       optee_release_helper(ctx, optee_close_session_helper);
> +       if (optee->scan_bus_wq) {
> +               destroy_workqueue(optee->scan_bus_wq);
> +               optee->scan_bus_wq = NULL;
>         }
> +       optee_supp_release(&optee->supp);
>  }
>
>  static const struct tee_driver_ops optee_ops = {
> @@ -339,7 +322,7 @@ static const struct tee_desc optee_desc = {
>  static const struct tee_driver_ops optee_supp_ops = {
>         .get_version = optee_get_version,
>         .open = optee_open,
> -       .release = optee_release,
> +       .release = optee_release_supp,
>         .supp_recv = optee_supp_recv,
>         .supp_send = optee_supp_send,
>         .shm_register = optee_shm_register_supp,
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index e25b216a14ef..2b63b796645e 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -152,6 +152,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg);
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> +int optee_close_session_helper(struct tee_context *ctx, u32 session);
>  int optee_close_session(struct tee_context *ctx, u32 session);
>  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>                       struct tee_param *param);
> --
> 2.31.1
>
