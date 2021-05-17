Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1703824FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhEQHGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:06:03 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:38433 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhEQHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:05:44 -0400
Received: by mail-ua1-f50.google.com with SMTP id k45so1780428uag.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C/REeXdcVCAYpjd6rjo76Xzl3K9167BGJ9+kDZAb2U=;
        b=MBhaO9uxEoQAjBjwKzypRIQ6ctDenaCx7kdUMWjzyxshYdiRKe8YKjHYQvtht7l3Em
         wJi2EPCui+YVx8voCG49a/p+uuLbe9HjKXJhK6mbXLVO5jsu3gf8wWIcIeoymKCcnIE/
         aU+vFhq1H6E+WIxzlJQ6cVvBF3t8iqQC/co+R3V2NQItCTFnQIrak4OtXQe6Lko3fKVY
         PA/FZR9NfRVvp5tXS5YDraA3n0i889VQceH4LCvxDY7FTpqsNvqyJfarBqQ46XBYAHzS
         yPBI8Yqq42GvkhMyj9vxVvcUTb9bfsttSMrmTPWGgs9uZMMx0gTW36e6pJESECt8QLoN
         wEag==
X-Gm-Message-State: AOAM531YsNlycATOqfHSTzMCt4YlzPDoMaAeToKy+DIhpma/nCEaA874
        U/vCvCtrXn9bg0jnhg8jMxRhKFI3qDMJvoEVJrU=
X-Google-Smtp-Source: ABdhPJz2PVXrgSVOWviCZuZPvaBSRA/JmtIT5f0KqhEH9sqGhNAumf4FL1IjHkG5hnZmIkTIzjg4AS9uFXqWndx2MQE=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr28365814uar.4.1621235067214;
 Mon, 17 May 2021 00:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210428063203.691-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210428063203.691-1-thunder.leizhen@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 May 2021 09:04:15 +0200
Message-ID: <CAMuHMdWX7rC2zswHoo6aFf3CYp3NKAfJ7E0x4W2wbVkybGa84g@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: devres: Add error information printing for __devm_ioremap_resource()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On Wed, Apr 28, 2021 at 8:33 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
>
> Fixes: 35bd8c07db2c ("devres: keep both device name and resource name in pretty name")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks for your patch, which is now commit 5c3e241f5246445d ("lib:
devres: Add error information printing for __devm_ioremap_resource()")
in driver-core-next.

> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -157,8 +157,10 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
>                                              dev_name(dev), res->name);
>         else
>                 pretty_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
> -       if (!pretty_name)
> +       if (!pretty_name) {
> +               dev_err(dev, "can't generate pretty name for resource %pR\n", res);

If the above fails, it is due to a memory allocation failure, and the
memory allocation core will have already printed an error message.
So there is no need to print a second message.
Hence IMHO this commit should be reverted.

>                 return IOMEM_ERR_PTR(-ENOMEM);
> +       }
>
>         if (!devm_request_mem_region(dev, res->start, size, pretty_name)) {
>                 dev_err(dev, "can't request region for resource %pR\n", res);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
