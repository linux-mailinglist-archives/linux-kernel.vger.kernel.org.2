Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509963493E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhCYOTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhCYOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:18:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05156C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:18:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 184so3307550ljf.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpLGFAuP0zRhD8ECDASmtUCCqZyWadUjjPsdXLkzDqI=;
        b=GcElBKS7rrZsXIzL8iL2fQTZM8mDFRhoxCQqgNhE2t3ljVlmcmNMBY7kAMMAzBbihx
         gqzHnHfFAj9ZXx3DZXOZqh0LtqVKx1J5v7fsuJaDFCCVAai5EN4IqNAOW/tjGW/brPQD
         0EV1aJmpGsFksorq1eaSc1o5KkTawtb3FbnNqHkkDIuWR8DUBbawVg80hW4ePgfKvnmi
         GMvcRzBY7svPva0XAfjZ6XkJbWtFKxMNM0+PtvG0J1knJnlLYGtWgYpqBwwnkZCF4EXA
         YA92oWT5fMP+946UT/jpXl2+uJn8y7TgZIZj/DEgEhjK2lcS6DsSBTyyB6N0+9HCKrgD
         j8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpLGFAuP0zRhD8ECDASmtUCCqZyWadUjjPsdXLkzDqI=;
        b=rxl4Fs1YDk7isaBzCNXG6ibq9DQZ6WnNXQTR7N5T5TJrmtwGKmNIVM7e4k29whIs00
         +Gt/EtpSeV0hgQk5siUi9N/i5PRtfy0NCmxXgfvWPOewv5SpR564R7EKkTFYuaGY1IrO
         gb1j0IUbYGj77bkV9UgaveevMA/ycFV9rOEUriPs2CKHMilOIWQEXlrSbrJ1iGilj91f
         XDO7yCeuekHOUuvooKDynkZTrVTngnvzcdWMtIHV1JVqtxa7lPGEl3rLCx7WcCDessl6
         Niu825xn2Ovc3SUNo6Clms7J8SpcDl+7JdvsmnbzDBuU1Pswg71Ev0oe14x3/ckQzHGL
         uP0g==
X-Gm-Message-State: AOAM531rOH45YrZSQVFAWR+AZ6d7qs3ev4gnY0f4+M6dlE+M3UVwhJnR
        RblzUnEwQu4HlmCa85XLP0ZmHbLCV7x1Aw6/XE31fNQv5fF0A3Gl
X-Google-Smtp-Source: ABdhPJzqBnu7s32WbSm2YB1vrx+f2AwqOgTvQHwo6CsZ23JU6Gjcrr6cxc4ueNfjn2fOB4L827PYnnDupurtTvx0o8c=
X-Received: by 2002:a2e:868a:: with SMTP id l10mr5626263lji.343.1616681912438;
 Thu, 25 Mar 2021 07:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616409291.git.jerome@forissier.org> <010001785986e9be-63aa88ce-3cf8-425f-87da-b2e3f84f6ef5-000000@email.amazonses.com>
In-Reply-To: <010001785986e9be-63aa88ce-3cf8-425f-87da-b2e3f84f6ef5-000000@email.amazonses.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 25 Mar 2021 19:48:21 +0530
Message-ID: <CAFA6WYPryB+9W6EGXvea07=JH8_cfHKF8a4BDEyPeqPVkzvutw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: optee: do not check memref size on return from
 Secure World
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 at 16:11, Jerome Forissier via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> When Secure World returns, it may have changed the size attribute of the
> memory references passed as [in/out] parameters. The GlobalPlatform TEE
> Internal Core API specification does not restrict the values that this
> size can take. In particular, Secure World may increase the value to be
> larger than the size of the input buffer to indicate that it needs more.
>
> Therefore, the size check in optee_from_msg_param() is incorrect and
> needs to be removed. This fixes a number of failed test cases in the
> GlobalPlatform TEE Initial Configuratiom Test Suite v2_0_0_0-2017_06_09
> when OP-TEE is compiled without dynamic shared memory support
> (CFG_CORE_DYN_SHM=n).
>
> Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  drivers/tee/optee/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
>

Looks good to me.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 319a1e701163..ddb8f9ecf307 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -79,16 +79,6 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
>                                 return rc;
>                         p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
>                         p->u.memref.shm = shm;
> -
> -                       /* Check that the memref is covered by the shm object */
> -                       if (p->u.memref.size) {
> -                               size_t o = p->u.memref.shm_offs +
> -                                          p->u.memref.size - 1;
> -
> -                               rc = tee_shm_get_pa(shm, o, NULL);
> -                               if (rc)
> -                                       return rc;
> -                       }
>                         break;
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
>                 case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
> --
> 2.25.1
>
