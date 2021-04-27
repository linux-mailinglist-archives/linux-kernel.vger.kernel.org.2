Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55E236CB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbhD0TUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhD0TUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:20:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D31C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:19:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u20so69482518lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oXvf0Y9xKsBQGdqsEuYClY3Pkmd+9qguv7EcU4aiIo=;
        b=Dx3Y56VbKgFgUrstq1ky2UIXs9PsSpZBJgv1C37e2dncPMk3I5YxdCD3X0FVfDk2/O
         Uctl1yEmo+L8MhpjyksfLV6sCxwlQRO+LeQ49mlmuxoLzzTZm4hc5axPlIuEzB9qKbj/
         MGSh1qXgKiXHRCovvuHs9/vA7TSsnRakCuVJMdHYX0oAXhAjJo5x0ikpGGmXvAdxayc5
         6nN+U0sHspDZBL7FpP5ZJmaQ2C4zh2p8ragm3Jdo06ngrnODmoA+3xCxsHIXrGvDBnpN
         6OR669qVPjj+Wmt+UqhS50JtwTlmDD+PBdommCz9s9lLHJzvMGHIF/cJP0g1DRSuyIrT
         t7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oXvf0Y9xKsBQGdqsEuYClY3Pkmd+9qguv7EcU4aiIo=;
        b=dm0tAZbGG9SuMak+hItUvndYTxApCUd9tgZTCxa68xw8jrr9JniD6pqpCgHZOZ7PaB
         cvclTOAFVsckE5o+jpONE345ECbYLKSZf6yjlog+xsR92JzTxf6Cq+G51cYCWx8rHu35
         r94K8rmoVot/H5kN92zrdVaw3vJiFJ9RpmRT3AMNqCNTLnKPa9+XdlL95u7RrQ7oqQtT
         6KGnHdfmBpkH5DBstXozsPs6DvKEqrt1RbO46SVUUpMM8tX4t7cA3A1Kte57uERA5j0G
         gpZHsBWiZlGChjTOXea6cIHNfOv+oqLudqpYF0pWlNxFN3EK4YuVCmqDKngmXVUnHjYp
         cjbg==
X-Gm-Message-State: AOAM530HFZUdq0YAj1j4fVbZgVEUHd3OE+qMrUBrLUw0Z95farqEKETd
        YOV5NjLsv5hGk2bYc8JxFgCgaY0nZxi3UutoKOzAcg==
X-Google-Smtp-Source: ABdhPJzoVWo2a1QQrSEEIoTA6iMfQHDAjbB4tcdrT7Iw3P4nRvxG1z9n4PxqdaYCSFAlSuCNEwPcufxfjPmIf0ZD/QM=
X-Received: by 2002:a2e:9cc1:: with SMTP id g1mr18263376ljj.0.1619551191581;
 Tue, 27 Apr 2021 12:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210427183624.2790305-1-trix@redhat.com>
In-Reply-To: <20210427183624.2790305-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Apr 2021 12:19:40 -0700
Message-ID: <CAKwvOd=LSs6gdGj-FAuCTrPrH6ik6PVxYX+_tFK9G1OW0vdMAA@mail.gmail.com>
Subject: Re: [PATCH] bus: fsl-mc: fix improper free of mc_dev
To:     Tom Rix <trix@redhat.com>
Cc:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        Nathan Chancellor <nathan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:36 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this error
>
> fsl-mc-bus.c:891:2: warning: Attempt to free released memory
>         kfree(mc_dev);
>         ^~~~~~~~~~~~~
>
> In this block of code
>
> if (strcmp(obj_desc->type, "dprc") == 0) {
> ..
>   mc_bus = kzalloc(..)
>   mc_dev = &mc_bus->mc_dev;

Thanks for the patch.

Aren't the allocations for mc_bus and mc_dev mutually exclusive based
on that conditional? If so...

>
> mc_dev is not alloc-ed, so it should not be freed.
> Old handler triggers a false positive from checkpatch, so add a
> comment and change logic a bit.
>
> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 380ad1fdb745..fb3e1d8a7f63 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -887,8 +887,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>
>  error_cleanup_dev:
>         kfree(mc_dev->regions);
> +       /* mc_dev is only allocated when it is not part of mc_bus */
> +       if (!mc_bus)
> +               kfree(mc_dev);
>         kfree(mc_bus);
> -       kfree(mc_dev);

The error handling here seems quite wrong (regardless of your patch).
mc_dev->regions is allocated by fsl_mc_device_get_mmio_regions() IIUC.
Wouldn't the first `goto error_cleanup_dev;` taken end up passing an
uninitialized pointer to kfree()?

what if `strcmp(obj_desc->type, "dprc") == 0` is false? We allocate
`mc_dev`, but then call kfree on `mc_bus`?

I think it would be safer to locally save the result of
`strcmp(obj_desc->type, "dprc") == 0`, then check that throughout this
function, including the error handling at the end, or use multiple
labels to unwind the allocations correctly.

>
>         return error;
>  }

> --


--
Thanks,
~Nick Desaulniers
