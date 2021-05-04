Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB72372EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhEDRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhEDRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:36:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256CEC061574;
        Tue,  4 May 2021 10:35:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m12so7926129pgr.9;
        Tue, 04 May 2021 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fn8pQbaFZF+te677ue5F1N26vdHe+itVsb7ucfCcoEE=;
        b=nds9drrrvFlzO5ByyKl5dU+fMn6kWpQVp4hNcvKAGPoL4LsS89SWlroEjkuTMO3GYG
         5ikK3puFa11rEdenfMIZ1v9u9zve7M7XLnI8oR1+a/YlV/5hh6k4DPuJv+QRor31bG/R
         qqC2jvSEUfEkR06zDq2cx1EFu0pBhUy//U7fOgkHYsnap7DpY30cZdrKdq0BFi1wYc/l
         a8msoGVnWRXnUQPdOQUwL2LDd5OtCWuveUYNtkxwPBCNYxpcSCKYbUVSXiAtYYa+ThE8
         DJc2P2hz2JK3BL+rpwXwVaFACMhaCjO5PfKQxUgwZTm5KwI7cbWypx0SPEtKvCpBfRDX
         e8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fn8pQbaFZF+te677ue5F1N26vdHe+itVsb7ucfCcoEE=;
        b=PtcGkKT06hHb9R+dyqDaB34fvJ50F7RZM0JjOaw68vm1l/9yYkpjDA+7Dbv9Trm09r
         7ovO5bPhnsLA1K4ZyXqgnFOh1Pwaaa9VHXm2KdC9cWvnOQtvN/kX7FIGSDl9hhMS6WVm
         Tl+IXRN27Wl4TimDStS1t5TpCy3i9HDDHAIYUlNylgft4jIQQIR087ulLRAJLNwtu2vx
         5zw1GaxPK777U8LTKQVBLCYKmzo6fi/nyo1FrbwXdrlFLw2krgmicqyYrKGWhJgQEUGb
         6qL3vk8rcA8lqCJuZ3lKT60UjhSgBtT+al9jmGlyoyGWDqXYRjYuVlsvjlsUEDdZw6BQ
         3Onw==
X-Gm-Message-State: AOAM5329BNOD7MppUO8Ab0WY6Hq+z0hWI9Lx0pnpSLW6nhfggF4MagnS
        RMK44My0UJCbpL9HhB/mwuaPPYibiZzlH3mSSzE=
X-Google-Smtp-Source: ABdhPJzd8oslYjEOevfUkO8fJ+3/MwTSGUu/tMLkIt4d+9m//+M7DbhK1IV45Q0blbPbFMxNkuEYFFgpxNqI4ErJ7DM=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr25396763pff.40.1620149738565; Tue, 04
 May 2021 10:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210504170030.58447-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210504170030.58447-1-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 20:35:22 +0300
Message-ID: <CAHp75VepeO6-A9-xJqjpEDZa0XDyNbat0PBrtrgFEgJ4yxh4kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: samsung-laptop: use octal numbers
 for rwx file permissions
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Andy asked me to do it before working further on the code.

Thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since v1: new patch
>
>  drivers/platform/x86/samsung-laptop.c | 35 +++++++++++----------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index d5cec6e35bb8..763d97cbbe53 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -388,7 +388,7 @@ MODULE_PARM_DESC(force,
>                 "Disable the DMI check and forces the driver to be loaded");
>
>  static bool debug;
> -module_param(debug, bool, S_IRUGO | S_IWUSR);
> +module_param(debug, bool, 0644);
>  MODULE_PARM_DESC(debug, "Debug enabled or not");
>
>  static int sabi_command(struct samsung_laptop *samsung, u16 command,
> @@ -705,7 +705,7 @@ static ssize_t set_performance_level(struct device *dev,
>         return count;
>  }
>
> -static DEVICE_ATTR(performance_level, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(performance_level, 0644,
>                    get_performance_level, set_performance_level);
>
>  static int read_battery_life_extender(struct samsung_laptop *samsung)
> @@ -774,7 +774,7 @@ static ssize_t set_battery_life_extender(struct device *dev,
>         return count;
>  }
>
> -static DEVICE_ATTR(battery_life_extender, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(battery_life_extender, 0644,
>                    get_battery_life_extender, set_battery_life_extender);
>
>  static int read_usb_charge(struct samsung_laptop *samsung)
> @@ -843,7 +843,7 @@ static ssize_t set_usb_charge(struct device *dev,
>         return count;
>  }
>
> -static DEVICE_ATTR(usb_charge, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(usb_charge, 0644,
>                    get_usb_charge, set_usb_charge);
>
>  static int read_lid_handling(struct samsung_laptop *samsung)
> @@ -908,7 +908,7 @@ static ssize_t set_lid_handling(struct device *dev,
>         return count;
>  }
>
> -static DEVICE_ATTR(lid_handling, S_IWUSR | S_IRUGO,
> +static DEVICE_ATTR(lid_handling, 0644,
>                    get_lid_handling, set_lid_handling);
>
>  static struct attribute *platform_attributes[] = {
> @@ -1291,24 +1291,17 @@ static void samsung_debugfs_init(struct samsung_laptop *samsung)
>         samsung->debug.sdiag_wrapper.data = samsung->sdiag;
>         samsung->debug.sdiag_wrapper.size = strlen(samsung->sdiag);
>
> -       debugfs_create_u16("command", S_IRUGO | S_IWUSR, root,
> -                          &samsung->debug.command);
> -       debugfs_create_u32("d0", S_IRUGO | S_IWUSR, root,
> -                          &samsung->debug.data.d0);
> -       debugfs_create_u32("d1", S_IRUGO | S_IWUSR, root,
> -                          &samsung->debug.data.d1);
> -       debugfs_create_u16("d2", S_IRUGO | S_IWUSR, root,
> -                          &samsung->debug.data.d2);
> -       debugfs_create_u8("d3", S_IRUGO | S_IWUSR, root,
> -                         &samsung->debug.data.d3);
> -       debugfs_create_blob("data", S_IRUGO | S_IWUSR, root,
> -                           &samsung->debug.data_wrapper);
> -       debugfs_create_blob("f0000_segment", S_IRUSR | S_IWUSR, root,
> +       debugfs_create_u16("command", 0644, root, &samsung->debug.command);
> +       debugfs_create_u32("d0", 0644, root, &samsung->debug.data.d0);
> +       debugfs_create_u32("d1", 0644, root, &samsung->debug.data.d1);
> +       debugfs_create_u16("d2", 0644, root, &samsung->debug.data.d2);
> +       debugfs_create_u8("d3", 0644, root, &samsung->debug.data.d3);
> +       debugfs_create_blob("data", 0644, root, &samsung->debug.data_wrapper);
> +       debugfs_create_blob("f0000_segment", 0600, root,
>                             &samsung->debug.f0000_wrapper);
> -       debugfs_create_file("call", S_IFREG | S_IRUGO, root, samsung,
> +       debugfs_create_file("call", S_IFREG | 0444, root, samsung,
>                             &samsung_laptop_call_fops);
> -       debugfs_create_blob("sdiag", S_IRUGO | S_IWUSR, root,
> -                           &samsung->debug.sdiag_wrapper);
> +       debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
>  }
>
>  static void samsung_sabi_exit(struct samsung_laptop *samsung)
> --
> 2.30.0
>


-- 
With Best Regards,
Andy Shevchenko
