Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D932F134
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCERa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:30:27 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43184 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCERaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:30:19 -0500
Received: by mail-ot1-f47.google.com with SMTP id v12so2519436ott.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOauJKMgg2MIheNpatw8gIZjWUnov8KxvweDn05QQmo=;
        b=H2aE8Cadb7mEto1MNFCBdHETtvR4qhk+WUPgq59/WGG0XFNYDAa6UpvSdoL778zu7h
         EYi+5trnxzun5/T+1DbtBh6CAWz3B5YY8Or+7CVFarvLA3H4nZ5OwhKxmP2egOA1dwAU
         Uj1VsDhsPR1JitXzSQphDUSfqab1uP6ESNTKSoAlWKVKb8k/hJxH4fZKaOv/lOdxv3+k
         igcxRMEXy2Wfry/n5IpGwtbuMI4hfHjkokYcFCJ6tmU9l2+aqDAs3et1nvGHbkb6LID5
         HWWr1X6HnWYclT3/rCCTF029WbPsfmp0j0xW4nKsitsm7hDsHg1td+hes7spB88hURkJ
         iUrQ==
X-Gm-Message-State: AOAM53188VBiR2fJ5pYzlI4NyCWuumKGFANf/3CwVkY4RNkieCCgs9xe
        xH1nKXNDpULs/2dHt9C+JADACEDLJkqXe/x9108=
X-Google-Smtp-Source: ABdhPJw7kiCY7ypaPshwF6NqTnAaGu425LVQRtZRQtn8d7w/pnpcFU//vxu0toPT0xhLptUvszCnBZIiDhqXTIYv+ho=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr9243050otp.206.1614965418684;
 Fri, 05 Mar 2021 09:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20210305102405.14940-1-baijiaju1990@gmail.com>
In-Reply-To: <20210305102405.14940-1-baijiaju1990@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 18:30:07 +0100
Message-ID: <CAJZ5v0g5vy4PDVGTso+cV1Zz1LvtUN7OsgWntVAFv9pr0a=6mA@mail.gmail.com>
Subject: Re: [PATCH] base: dd: fix error return code of driver_sysfs_add()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 11:24 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> When device_create_file() fails and returns a non-zero value,
> no error return code of driver_sysfs_add() is assigned.
> To fix this bug, ret is assigned with the return value of
> device_create_file(), and then ret is checked.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/dd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..f94bbef95258 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -413,8 +413,11 @@ static int driver_sysfs_add(struct device *dev)
>         if (ret)
>                 goto rm_dev;
>
> -       if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump ||
> -           !device_create_file(dev, &dev_attr_coredump))
> +       if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump)
> +               return 0;
> +
> +       ret = device_create_file(dev, &dev_attr_coredump);
> +       if (!ret)
>                 return 0;
>
>         sysfs_remove_link(&dev->kobj, "driver");
> --
> 2.17.1
>
