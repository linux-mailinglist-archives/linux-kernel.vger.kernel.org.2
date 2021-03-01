Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E12328110
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhCAOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbhCAOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:36:30 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E8C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:35:50 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id k13so16602678otn.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrKyDD+nXhsE7yBfgO1RnI90ZWxZNc5CQ2d/LEfCEVs=;
        b=EvKeF2BSaUOR94etd2XM5SP+27aPZLUGZzs1KGL5ozp3QqIlhP9l7Uev0R/xnRUFLA
         QCqoaDUwAxx2fiB/e3BeaGUpmzf2B2CH64Zogi5aPKi/HCOBOKN7NHV80dJ9+QZvYkBo
         hiS7KCaxm0Ibdy1C5YhQONar+r2gQU4xiBQTDCYf1xQOsRx11a1uZU0h6LahmJfdyvDm
         8tkVOiyNJK3KzZrGiJ/6yZg/6YtkPDmxJ3U/ECBkd5WSuCNBSOiCjweK3b6xoUK9kAWx
         G+dFbejWGnWKFc54JG2G+Y/BQEbPBRoR50nwpCs+Si6MGiFNppqOTX7S0Y6ZQQKExgFv
         RD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrKyDD+nXhsE7yBfgO1RnI90ZWxZNc5CQ2d/LEfCEVs=;
        b=kibgezsXIfIkxLCYE/EFd6OtztUCAiOpDtVy2eJ1AWXEX64cxVxHPvkMceb3ruaCDF
         DqdiWJvFVPfeYugnCE0uw02su79XVBLmk6jp5DnVVvlmY3DATAgy73wnY+sUIFOX+wTa
         xinlQ90fkScFCPyIXlJ9lddTljBiiCX7H7wvRYOwq5F7mrjKQGL4XtOYkIPAVAPyPnw1
         AXDDUBd1GQu5rcvLSY6325r9AXmeutJRDsgx/9jwOwBfEc5rckPq/2ZIORJjwr95q7Xv
         Eu4SFakl9i9G56iDvHSS1m4c+JhYuVQqtJFYYXUmwQYIchYuxI2PhvIbh+u9gezces6F
         mZZg==
X-Gm-Message-State: AOAM531pfIxY4iJM3k61+p+NdcSpSzGCpnIYNdvC7X3u2HE0VhB2joMv
        JQBEWXYWX/9mlkM63YFxivu2kPpAPBxV80HFlD6AZZB6fYM=
X-Google-Smtp-Source: ABdhPJxTUWL8+rtDcjvKoi9N7CkFS4lsnhyMXNledGGmivopGZ1Ru6PuusyIpBfINyoQbWRK2lL6xZGgZPlgMLpFOIc=
X-Received: by 2002:a05:6830:1352:: with SMTP id r18mr14233961otq.283.1614609350048;
 Mon, 01 Mar 2021 06:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20210225090610.242623-1-allen.lkml@gmail.com> <20210225090610.242623-2-allen.lkml@gmail.com>
In-Reply-To: <20210225090610.242623-2-allen.lkml@gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 1 Mar 2021 15:35:36 +0100
Message-ID: <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     zajec5@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:06 AM Allen Pais <allen.lkml@gmail.com> wrote:
>
> From: Allen Pais <apais@linux.microsoft.com>
>
> The following out of memory errors are seen on kexec reboot
> from the optee core.
>
> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>
> tee_shm_release() is not invoked on dma shm buffer.
>
> Implement .shutdown() method to handle the release of the buffers
> correctly.
>
> More info:
> https://github.com/OP-TEE/optee_os/issues/3637
>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> ---
>  drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

This looks good to me. Do you have a practical way of testing this on
QEMU for instance?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index cf4718c6d35d..80e2774b5e2a 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -582,6 +582,13 @@ static optee_invoke_fn *get_invoke_func(struct device *dev)
>         return ERR_PTR(-EINVAL);
>  }
>
> +/* optee_remove - Device Removal Routine
> + * @pdev: platform device information struct
> + *
> + * optee_remove is called by platform subsystem to alter the driver
> + * that it should release the device
> + */
> +
>  static int optee_remove(struct platform_device *pdev)
>  {
>         struct optee *optee = platform_get_drvdata(pdev);
> @@ -612,6 +619,18 @@ static int optee_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +/* optee_shutdown - Device Removal Routine
> + * @pdev: platform device information struct
> + *
> + * platform_shutdown is called by the platform subsystem to alter
> + * the driver that a shutdown/reboot(or kexec) is happening and
> + * device must be disabled.
> + */
> +static void optee_shutdown(struct platform_device *pdev)
> +{
> +       optee_disable_shm_cache(platform_get_drvdata(pdev));
> +}
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>         optee_invoke_fn *invoke_fn;
> @@ -738,6 +757,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
>  static struct platform_driver optee_driver = {
>         .probe  = optee_probe,
>         .remove = optee_remove,
> +       .shutdown = optee_shutdown,
>         .driver = {
>                 .name = "optee",
>                 .of_match_table = optee_dt_match,
> --
> 2.25.1
>
