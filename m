Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79625341B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCSLOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCSLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:14:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251A0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:14:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so5644811pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYTMI3CC9z/CbbFbwvM16oeFN/F/wvINJk1tmHYmUXQ=;
        b=mtiClWoepC5cMwF9tXH/TmfTv6bVOklvncMdW7WnFGZzX+xspoSrp6026TwClOnhPJ
         CWBOS3NuHnMB3vKsz+uv/eC8/bwkfMTeXiGRuieQhRkJ9Be5yE6Mt76bamfbRi3kSjbt
         poPGzw9g6yaCI86eWf9gblRDR9QWDidIOGkA1npKBgs7eGyZUki837YW5AE9YxDKzWRk
         6/NEU2fc7JVMeLEnIu8toQwfNtdzjglovrtum1fIsItzWiK+LpCQywkuXc6sMcEAzGzh
         hCdZu0jBNXzi25IfEKwpvngoGmCzcpGPk5M16Oa3BRO7VtkzG89ftn2yBFVeV8Done79
         reDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYTMI3CC9z/CbbFbwvM16oeFN/F/wvINJk1tmHYmUXQ=;
        b=U79ZzmS4cVkIn06I2kYoyF4kYeT1Cl5jVxfCGO6b4Yk4ATNzx5ROlaOic2O/WeZOpc
         xoEWFMoLa2dEIXhazpCkjWzw9Y/oGBhVC2LAsydlpys2IVChoHCMYzSpglAyZA1TP26/
         NmDp7NGTvLXtT32KyVlYee7pET9zmJlCwMiX/xB0AxhQYKP2bsNUqJFEj4Jfl0CLU9rf
         /IoGu3/Mx8I8K3x91S6j1EcUCGfbTRPJusbr1BRJbPxKKPBbOvbqqJxaXA9lzR1i0cFu
         zpYfrMcxAjISkFhgi/hbgFxqdYNUJ1Kr0g29aethyBKU4AC4HdrqmghVZ+3noO+nZD3n
         Fzug==
X-Gm-Message-State: AOAM530O6CHsZYv8N2umltCdEXMyytzJ2NfFgwsu+mB9xCxeGamFUcko
        8VALcGCa+5RgtQFgS7ziNBuviAqDWShzbM4nUvE=
X-Google-Smtp-Source: ABdhPJw762tA++vKmK+4TPBUdWUiIPIy3iw325T9ff0W7ZGcq5NmbF6K36ChRV/onU3NYVjRLf313hjZ4AQ0B7VMsoM=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr10745725pgq.203.1616152449551;
 Fri, 19 Mar 2021 04:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210319110459.19966-1-a.fatoum@pengutronix.de> <20210319110459.19966-2-a.fatoum@pengutronix.de>
In-Reply-To: <20210319110459.19966-2-a.fatoum@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 13:13:53 +0200
Message-ID: <CAHp75VdjefJHMu2ot7RoZZZis0aNyV097J34wxDSwLgh3bQ8Pg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] driver core: add helper for deferred probe reason setting
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 1:05 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> We now have three places within the same file doing the same operation
> of freeing this pointer and setting it anew. A helper make this

makes

> arguably easier to read, so add one.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Now I'm wondering why deferred_probe_reason is not defined with const.

Can you check and maybe squeeze a patch in the middle (before these
two of this series) to move to const?

> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>  - no change
> ---
>  drivers/base/dd.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e2cf3b29123e..4201baa1cc13 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -69,6 +69,12 @@ static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
>   */
>  static bool defer_all_probes;
>
> +static void __device_set_deferred_probe_reason(const struct device *dev, char *reason)
> +{
> +       kfree(dev->p->deferred_probe_reason);
> +       dev->p->deferred_probe_reason = reason;
> +}
> +
>  /*
>   * deferred_probe_work_func() - Retry probing devices in the active list.
>   */
> @@ -97,8 +103,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>
>                 get_device(dev);
>
> -               kfree(dev->p->deferred_probe_reason);
> -               dev->p->deferred_probe_reason = NULL;
> +               __device_set_deferred_probe_reason(dev, NULL);
>
>                 /*
>                  * Drop the mutex while probing each device; the probe path may
> @@ -140,8 +145,7 @@ void driver_deferred_probe_del(struct device *dev)
>         if (!list_empty(&dev->p->deferred_probe)) {
>                 dev_dbg(dev, "Removed from deferred list\n");
>                 list_del_init(&dev->p->deferred_probe);
> -               kfree(dev->p->deferred_probe_reason);
> -               dev->p->deferred_probe_reason = NULL;
> +               __device_set_deferred_probe_reason(dev, NULL);
>         }
>         mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -220,11 +224,12 @@ void device_unblock_probing(void)
>  void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
>  {
>         const char *drv = dev_driver_string(dev);
> +       char *reason;
>
>         mutex_lock(&deferred_probe_mutex);
>
> -       kfree(dev->p->deferred_probe_reason);
> -       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +       reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +       __device_set_deferred_probe_reason(dev, reason);
>
>         mutex_unlock(&deferred_probe_mutex);
>  }
> --
> 2.29.2
>


-- 
With Best Regards,
Andy Shevchenko
