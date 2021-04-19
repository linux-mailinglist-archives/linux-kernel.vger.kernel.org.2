Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE46836409E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhDSLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:36:32 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7ABC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:36:03 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id h2-20020a4ad7420000b02901e5901169a5so7442173oot.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y37dxPGDqWrMMwaZQsfzvIV4iLtksHzvvTYTmv8VKZQ=;
        b=YF/P9rRc8el07+omSgXOAdGcMZ1ae5KTxFlp7NYn8/U9dpcPQKruQTML+xY/JIP7j9
         qdXQC+FT5G+tn4V1N290znESicoSu0YqC4XQ8zhqLvj8lNzLY2/BTA0F99915blACrk5
         I1Pu+AtFL4RQ0dCX0YTDLtislK2/fPPhr6HNMaVaHpl5+YhT4jZGCfl12JLJ3XRst+74
         lWUASJ+UvLqZ3atWGOvVe6v7c4I5o8vkyyFLVUcyIY+K/nELSd+y2SCnldfPG+oKLg7H
         B49qsuqy56oKeWtczVXtV+xspboRkd94GdV7VAdUrFF7w4E0gNskoGY/lcYP+RoJa8Pv
         JJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y37dxPGDqWrMMwaZQsfzvIV4iLtksHzvvTYTmv8VKZQ=;
        b=pzSSMQCzUJ8O/idx5eb0CwwYL1wWUyxONl+6jogFeVqii71MD+dGoIdg71KOoN9mU9
         xDtieZ+ylov0ahtHYSJkiozBl0hH2P5+o1oy9NC1xnEK/Ud0AlgRNkJOXMA3HMoX0jJH
         /XxKV6HoL+/sksxbgDy+NSfAasOzLKfqSfVZRVCwCS0KHPWL09s1CYMze5dq/+vc5Ldx
         BLF4LxJ25COJDEFmoIu+Eep3Z1YqsthqjIpZ1cGL5Lr2kJpyCzaL7sEvLC8N8gVZifJZ
         kimBe/g2bfTR12RDlMW41dZUXDJvAtjXlK8rLRNT7vZfDmup743seol5z6UJIfvMjAJq
         55fA==
X-Gm-Message-State: AOAM531Bjvh6HfXTuPoht3N4anbwaA8mg9EPUkqntWroOEb79mABKSn3
        G1EbPam8rjfE4iEQqt8y/o2WoeS9LcuFtXQrYNWu8H6C+Y7wQw==
X-Google-Smtp-Source: ABdhPJyaoR3yYJ2U4U7X8136f3RVj/q6suxRB0C53uxYhOOcQVO/Iz4EUuasRbsE+ygsh1Yk5eUZ6PM5JMh3k7ZMha0=
X-Received: by 2002:a05:6820:34b:: with SMTP id m11mr13070957ooe.49.1618832162340;
 Mon, 19 Apr 2021 04:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 19 Apr 2021 13:35:51 +0200
Message-ID: <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Dereferencing something to uuid_t value is not good idea strictly speaking.
> Provide a special parameter field for UUID values and drop ugly casting.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tee/optee/call.c      | 2 +-
>  drivers/tee/optee/optee_msg.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 1f0a68381656..d50cff7a9406 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -241,7 +241,7 @@ int optee_open_session(struct tee_context *ctx,
>         memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
>         msg_arg->params[1].u.value.c = arg->clnt_login;
>
> -       rc = tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u.value,
> +       rc = tee_session_calc_client_uuid(&msg_arg->params[1].u.uuid,
>                                           arg->clnt_login, arg->clnt_uuid);
>         if (rc)
>                 goto out;
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 81ff593ac4ec..df095a974f3f 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -144,6 +144,7 @@ struct optee_msg_param_value {
>   * @tmem:      parameter by temporary memory reference
>   * @rmem:      parameter by registered memory reference
>   * @value:     parameter by opaque value
> + * @uuid:      parameter by UUID
>   *
>   * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
>   * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value,
> @@ -157,6 +158,7 @@ struct optee_msg_param {
>                 struct optee_msg_param_tmem tmem;
>                 struct optee_msg_param_rmem rmem;
>                 struct optee_msg_param_value value;
> +               uuid_t uuid;

It's nice to get rid of the cast above, but I'm not that keen on the
change in this struct. This file defines the ABI towards Secure world
and adding dependencies on external complex types is a larger problem
than the cast above in my opinion.

Cheers,
Jens
