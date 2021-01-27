Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB7305972
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhA0LTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhA0KmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:42:18 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3714BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:41:38 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id i25so1635871oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHW98jBz5obeVQyvHLsFnkG/U40o7OkkRgzs1XfXLq4=;
        b=NGa9TFyhwu/0tsY14nVroXHv/Lik2dCNomsmMrPsQhCBuxhiJ8ADNEwd7qG/ibuqDj
         NvbOptHDmSg9KNZe7GOh9ZeC8yra2COp0NkBYaOwU29h9Po2uWIRbVSrwnP7ftQS3iXF
         kqn7tWWamFYe0Gjm4sqbsIH6C3Cd9yGVqZchmjI/+gnNTnLrFxgwFUKarQ7ILms6H5cm
         fSvyLixQclDSnRoanIyW/BXFW8DfQuccbZ3ko+0JnBjPXu/Tc4B4zJ/nc8Istdgu0Y8I
         Xx+7LAZFn4LvqM6bIysJ2jma6TejcPSSXYcvivGDvIzZ8p04bzvWnn0hT9MP+aj9EsNZ
         SAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHW98jBz5obeVQyvHLsFnkG/U40o7OkkRgzs1XfXLq4=;
        b=dRcg5bOnnIZJzrOlN2N9jClpxS8gsL61RUkkyMWBrwg//gFyRuN/gg843ox/JAc9C5
         BYh4rkwGzM6Deu2YJahvDWnNrL9qvpvcXLTXaoKzMfyKsMoKiY5L2SMRq8xOE1Xq+wkY
         UPh7VOrUrNoV+gRCqCNuln+vR4dNKE9r9lNKaKvMF7iohRDBxSQvNzCRks7B2u65iM0I
         0QRxXqN+4fKwmmgE38W7llfjnenYQDS3AS73+eZELLwfzBIHPROQur7VMFchl4IorysL
         sFSQjTMbFtYgjwfWBE/FXRaZynDYaXdqkXWFNxUhgS/35GeVOi+1aQjrESXOmHT9L6/o
         PEdg==
X-Gm-Message-State: AOAM533+vqBY4PT8cR1Ehxiqxjkz7I/q7s3cN9ZlhI2Vqts+Xntztg0g
        i5R8vD6zr64du+tJ4crMFwrQE+9m4H+QDU1Dr+Wijw==
X-Google-Smtp-Source: ABdhPJzQWKzftPcKSYQ8bsoIXdPSqAkccHW0BsmWU/8/YgGEKgiRQ/gKGC24QiG2rtEJTH45eKA7j/cuolsJBEZ+fvE=
X-Received: by 2002:aca:6702:: with SMTP id z2mr2635279oix.149.1611744097584;
 Wed, 27 Jan 2021 02:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20210125113758.2430680-1-arnd@kernel.org>
In-Reply-To: <20210125113758.2430680-1-arnd@kernel.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 27 Jan 2021 11:41:26 +0100
Message-ID: <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
Subject: Re: [PATCH] optee: simplify i2c access
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Storing a bogus i2c_client structure on the stack adds overhead and
> causes a compile-time warning:
>
> drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
>
> Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> open-code the i2c_transfer() call, which makes it easier to read
> and avoids the warning.
>
> Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Looks good to me.
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Do you want to take it up directly yourself or do you want a pull
request from me?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 1e3614e4798f..6cbb3643c6c4 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -54,8 +54,9 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>                                              struct optee_msg_arg *arg)
>  {
> -       struct i2c_client client = { 0 };
>         struct tee_param *params;
> +       struct i2c_adapter *adapter;
> +       struct i2c_msg msg = { };
>         size_t i;
>         int ret = -EOPNOTSUPP;
>         u8 attr[] = {
> @@ -85,48 +86,48 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>                         goto bad;
>         }
>
> -       client.adapter = i2c_get_adapter(params[0].u.value.b);
> -       if (!client.adapter)
> +       adapter = i2c_get_adapter(params[0].u.value.b);
> +       if (!adapter)
>                 goto bad;
>
>         if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
> -               if (!i2c_check_functionality(client.adapter,
> +               if (!i2c_check_functionality(adapter,
>                                              I2C_FUNC_10BIT_ADDR)) {
> -                       i2c_put_adapter(client.adapter);
> +                       i2c_put_adapter(adapter);
>                         goto bad;
>                 }
>
> -               client.flags = I2C_CLIENT_TEN;
> +               msg.flags = I2C_M_TEN;
>         }
>
> -       client.addr = params[0].u.value.c;
> -       snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +       msg.addr = params[0].u.value.c;
> +       msg.buf  = params[2].u.memref.shm->kaddr;
> +       msg.len  = params[2].u.memref.size;
>
>         switch (params[0].u.value.a) {
>         case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> -               ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> -                                     params[2].u.memref.size);
> +               msg.flags |= I2C_M_RD;
>                 break;
>         case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> -               ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> -                                     params[2].u.memref.size);
>                 break;
>         default:
> -               i2c_put_adapter(client.adapter);
> +               i2c_put_adapter(adapter);
>                 goto bad;
>         }
>
> +       ret = i2c_transfer(adapter, &msg, 1);
> +
>         if (ret < 0) {
>                 arg->ret = TEEC_ERROR_COMMUNICATION;
>         } else {
> -               params[3].u.value.a = ret;
> +               params[3].u.value.a = msg.len;
>                 if (optee_to_msg_param(arg->params, arg->num_params, params))
>                         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>                 else
>                         arg->ret = TEEC_SUCCESS;
>         }
>
> -       i2c_put_adapter(client.adapter);
> +       i2c_put_adapter(adapter);
>         kfree(params);
>         return;
>  bad:
> --
> 2.29.2
>
