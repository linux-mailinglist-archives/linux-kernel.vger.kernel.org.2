Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181B738E85A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhEXOMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhEXOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:12:35 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:07 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id s15so14303327vsi.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8r4bo8gsbRyIPgF8KAG8I7WkdYWQ5gt/261UAryZL4=;
        b=GHi0cPhU9oDBESG9+TM6G/GhZIln+GIfYOIA5QgOdKgxMj+qXbN+tu4hhblS2l7Ahg
         xUEdLSduawNFUyCeAZ6svc02kUjmsQxvtZvNGn0ODrHrf2QctmZcu7s48QD9a1JLY0cS
         eeam6EDEqAy5MWcA2qWqAS+QtUHSc2lDmH20/pmuuiuxa2rar1JFeo2QMXW4lCadDDiQ
         MWYQY8zA98SgyO7NHS87gqlCnkuwjl8Vv5JZsCJzhzLWpIBH5/F4SD5VjnfW+BmsJRRY
         m2hoLVFr2SDWn0lS0bTm1+eCxAz2yfo188dKAVl4CoHsPU6SFbzYqnETPRfLIKKNkYaE
         p6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8r4bo8gsbRyIPgF8KAG8I7WkdYWQ5gt/261UAryZL4=;
        b=X0Sewfvf9bMZHbwJWivL9PXOUeRpMzZW7b7qZEQlrdusktDNiv66HGcUGnFSL87oOD
         vFTEGgLkTgCWxAnzJquKnrERMFQAI9vTaweZFnnuJ3gOf28rXHdgY8688FshMy324d2x
         xWHPxmxemmp56+Di0JXwZKzb7mv/hV5m1MLX5WFHvVqsmK6yjjadVmNNRMYSbfPIB6ad
         eZFk2iWClTJVomcD4L0RuwxQcPj5ajNJfIbW6kpUVUFvLAm3O2bp3xhvmdR4X3wXtqno
         9tUSA3RjICtJFo35RXMj4CBbcwf/bkl+9q6A5W7kE+5cuLW9VAOA5zqOlEEu0aya31Tf
         kRpg==
X-Gm-Message-State: AOAM533jT6BXIpbCvTmXzJG5pDrVVL+ldUrbAITz/iCsZKNPTZ1U87K5
        oWVBn4gtvzUj93zUPGGAGMvaEgKi3bhqBqS12H3Tqw==
X-Google-Smtp-Source: ABdhPJy6WStver9UDbuFr/jJwakaTnngwpeiRYAPELp+UiVB+lu0JsfWTKagpKwQjL4zO3pUEfLg2cGGwN55/mZIlDs=
X-Received: by 2002:a05:6102:7b4:: with SMTP id x20mr22283215vsg.48.1621865466910;
 Mon, 24 May 2021 07:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFrFGo9gmG+EH2hS4oXPn5Jx9v8Pk8jKgvm9KW4Mdk+85A@mail.gmail.com>
 <20210511163944.1233295-1-ztong0001@gmail.com>
In-Reply-To: <20210511163944.1233295-1-ztong0001@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:26 +0200
Message-ID: <CAPDyKFr-_NUpAfZzwrtokRY5+yEw+iYMHoZR5QVd3dbjJV51Tg@mail.gmail.com>
Subject: Re: [PATCH v2] memstick: rtsx_usb_ms: fix UAF
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 18:40, Tong Zhang <ztong0001@gmail.com> wrote:
>
> This patch fixes the following issues:
> 1. memstick_free_host() will free the host, so the use of ms_dev(host) after
> it will be a problem. To fix this, move memstick_free_host() after when we
> are done with ms_dev(host).
> 2. In rtsx_usb_ms_drv_remove(), pm need to be disabled before we remove
> and free host otherwise memstick_check will be called and UAF will
> happen.
>
> [   11.351173] BUG: KASAN: use-after-free in rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
> [   11.357077]  rtsx_usb_ms_drv_remove+0x94/0x140 [rtsx_usb_ms]
> [   11.357376]  platform_remove+0x2a/0x50
> [   11.367531] Freed by task 298:
> [   11.368537]  kfree+0xa4/0x2a0
> [   11.368711]  device_release+0x51/0xe0
> [   11.368905]  kobject_put+0xa2/0x120
> [   11.369090]  rtsx_usb_ms_drv_remove+0x8c/0x140 [rtsx_usb_ms]
> [   11.369386]  platform_remove+0x2a/0x50
>
> [   12.038408] BUG: KASAN: use-after-free in __mutex_lock.isra.0+0x3ec/0x7c0
> [   12.045432]  mutex_lock+0xc9/0xd0
> [   12.046080]  memstick_check+0x6a/0x578 [memstick]
> [   12.046509]  process_one_work+0x46d/0x750
> [   12.052107] Freed by task 297:
> [   12.053115]  kfree+0xa4/0x2a0
> [   12.053272]  device_release+0x51/0xe0
> [   12.053463]  kobject_put+0xa2/0x120
> [   12.053647]  rtsx_usb_ms_drv_remove+0xc4/0x140 [rtsx_usb_ms]
> [   12.053939]  platform_remove+0x2a/0x50
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> Co-Developed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: remove useless code in err_out label
>
>  drivers/memstick/host/rtsx_usb_ms.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 102dbb8080da..29271ad4728a 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -799,9 +799,9 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
>
>         return 0;
>  err_out:
> -       memstick_free_host(msh);
>         pm_runtime_disable(ms_dev(host));
>         pm_runtime_put_noidle(ms_dev(host));
> +       memstick_free_host(msh);
>         return err;
>  }
>
> @@ -828,9 +828,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>         }
>         mutex_unlock(&host->host_mutex);
>
> -       memstick_remove_host(msh);
> -       memstick_free_host(msh);
> -
>         /* Balance possible unbalanced usage count
>          * e.g. unconditional module removal
>          */
> @@ -838,10 +835,11 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>                 pm_runtime_put(ms_dev(host));
>
>         pm_runtime_disable(ms_dev(host));
> -       platform_set_drvdata(pdev, NULL);
> -
> +       memstick_remove_host(msh);
>         dev_dbg(ms_dev(host),
>                 ": Realtek USB Memstick controller has been removed\n");
> +       memstick_free_host(msh);
> +       platform_set_drvdata(pdev, NULL);
>
>         return 0;
>  }
> --
> 2.25.1
>
