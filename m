Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86DE372F02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhEDRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhEDRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:38:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C5C061574;
        Tue,  4 May 2021 10:37:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e2so5504653plh.8;
        Tue, 04 May 2021 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/6eeoI5X+LeyB37oNBPlfmG8MjpAgf0R2+j6Z3VeyU=;
        b=PNxBie1T/RNnHKz4KnUrWBWpwMrq4gPD8aA6fqZYWM5a8+nBLVl8UbnYAyomELtejc
         XfHUlT3mixaZN68H5iXcLDSyJ42jvE0nkEAlaLP5mBlrVOrqwhhXw7DtR+ZBN99+nExX
         PxPTutcM6CFa/rLxmL9r9Jr3CwyLpbtWwS6ifyMdngbSYxqQjQLZTwEc5kzeNaF2Z9dK
         /WTiL8T5dKXn5zJMdELDqwEJYnFSkyRC6bUJXTof7clIKsrKtxuzcfk64rrh7+DAbZZr
         p2bICnpyBSmdrSi0hkYfNSZFGF+oRmmElx3/3aZd//JjtS3AZvgzzCvIMa7EgALtXC5c
         BpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/6eeoI5X+LeyB37oNBPlfmG8MjpAgf0R2+j6Z3VeyU=;
        b=ka8HqSvHBpeRFGuCNFNKW69jZ3VmA81cnwUKb0Ee59FgDoC5NlwCvT1pIdsqGFdyK4
         GcCSHB9PlNkxE2jrverZyRkXfwueHck6w60+if5BlDluOYlsOPKzJ5Pd5VaB0YyPNTLa
         YoG1OKewHbEWuvzljJRktJe4A1CQhWf+SFGMawqKmZhcZTXSV5kI3+ryy2Dl8FLExcOA
         KbIwvpxT+C6+uXpm4LLT7KQUy33ebubdkDZEIN3FeNuqXKIFvSOHmVKkrZ9V/NgnJgal
         OpCAZXIAogZQZBfG1VEh/BwE+CXL3bIpwax2DvmTWhDxHjVqJXjdcYqO174udK3x/4mf
         NT7w==
X-Gm-Message-State: AOAM530AuV1NOihs6n/5p+cvhKUbTrYxE4AVmdVwHVaqTGoFLNRwwJ3t
        Ncw+BJUHSKWSiKQqrxvk5byIL76wxb4oZXtbpKxnc/wpwlE=
X-Google-Smtp-Source: ABdhPJyT6P5Pkz4E9spw4WMgmGRGtfwg3XL/HAy8JkuYJ3Hn9tDec+kFuDcRR0v26cDgeLS6jkTFG/xoyfxa3Fny0I8=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr26843031plq.17.1620149852894; Tue, 04
 May 2021 10:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210504170030.58447-1-wsa+renesas@sang-engineering.com> <CAHp75VepeO6-A9-xJqjpEDZa0XDyNbat0PBrtrgFEgJ4yxh4kA@mail.gmail.com>
In-Reply-To: <CAHp75VepeO6-A9-xJqjpEDZa0XDyNbat0PBrtrgFEgJ4yxh4kA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 20:37:16 +0300
Message-ID: <CAHp75VdSv4Ja7+bjPDvOawuv1ukhKZ==bjQ_MQbNPUds_7mVZw@mail.gmail.com>
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

On Tue, May 4, 2021 at 8:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 4, 2021 at 8:00 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> >
> > Andy asked me to do it before working further on the code.
>
> Thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > Change since v1: new patch
> >
> >  drivers/platform/x86/samsung-laptop.c | 35 +++++++++++----------------
> >  1 file changed, 14 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> > index d5cec6e35bb8..763d97cbbe53 100644
> > --- a/drivers/platform/x86/samsung-laptop.c
> > +++ b/drivers/platform/x86/samsung-laptop.c
> > @@ -388,7 +388,7 @@ MODULE_PARM_DESC(force,
> >                 "Disable the DMI check and forces the driver to be loaded");
> >
> >  static bool debug;
> > -module_param(debug, bool, S_IRUGO | S_IWUSR);
> > +module_param(debug, bool, 0644);
> >  MODULE_PARM_DESC(debug, "Debug enabled or not");
> >
> >  static int sabi_command(struct samsung_laptop *samsung, u16 command,
> > @@ -705,7 +705,7 @@ static ssize_t set_performance_level(struct device *dev,
> >         return count;
> >  }
> >
> > -static DEVICE_ATTR(performance_level, S_IWUSR | S_IRUGO,
> > +static DEVICE_ATTR(performance_level, 0644,
> >                    get_performance_level, set_performance_level);
> >
> >  static int read_battery_life_extender(struct samsung_laptop *samsung)
> > @@ -774,7 +774,7 @@ static ssize_t set_battery_life_extender(struct device *dev,
> >         return count;
> >  }
> >
> > -static DEVICE_ATTR(battery_life_extender, S_IWUSR | S_IRUGO,
> > +static DEVICE_ATTR(battery_life_extender, 0644,
> >                    get_battery_life_extender, set_battery_life_extender);
> >
> >  static int read_usb_charge(struct samsung_laptop *samsung)
> > @@ -843,7 +843,7 @@ static ssize_t set_usb_charge(struct device *dev,
> >         return count;
> >  }
> >
> > -static DEVICE_ATTR(usb_charge, S_IWUSR | S_IRUGO,
> > +static DEVICE_ATTR(usb_charge, 0644,
> >                    get_usb_charge, set_usb_charge);
> >
> >  static int read_lid_handling(struct samsung_laptop *samsung)
> > @@ -908,7 +908,7 @@ static ssize_t set_lid_handling(struct device *dev,
> >         return count;
> >  }
> >
> > -static DEVICE_ATTR(lid_handling, S_IWUSR | S_IRUGO,
> > +static DEVICE_ATTR(lid_handling, 0644,
> >                    get_lid_handling, set_lid_handling);
> >
> >  static struct attribute *platform_attributes[] = {
> > @@ -1291,24 +1291,17 @@ static void samsung_debugfs_init(struct samsung_laptop *samsung)
> >         samsung->debug.sdiag_wrapper.data = samsung->sdiag;
> >         samsung->debug.sdiag_wrapper.size = strlen(samsung->sdiag);
> >
> > -       debugfs_create_u16("command", S_IRUGO | S_IWUSR, root,
> > -                          &samsung->debug.command);
> > -       debugfs_create_u32("d0", S_IRUGO | S_IWUSR, root,
> > -                          &samsung->debug.data.d0);
> > -       debugfs_create_u32("d1", S_IRUGO | S_IWUSR, root,
> > -                          &samsung->debug.data.d1);
> > -       debugfs_create_u16("d2", S_IRUGO | S_IWUSR, root,
> > -                          &samsung->debug.data.d2);
> > -       debugfs_create_u8("d3", S_IRUGO | S_IWUSR, root,
> > -                         &samsung->debug.data.d3);
> > -       debugfs_create_blob("data", S_IRUGO | S_IWUSR, root,
> > -                           &samsung->debug.data_wrapper);
> > -       debugfs_create_blob("f0000_segment", S_IRUSR | S_IWUSR, root,
> > +       debugfs_create_u16("command", 0644, root, &samsung->debug.command);
> > +       debugfs_create_u32("d0", 0644, root, &samsung->debug.data.d0);
> > +       debugfs_create_u32("d1", 0644, root, &samsung->debug.data.d1);
> > +       debugfs_create_u16("d2", 0644, root, &samsung->debug.data.d2);
> > +       debugfs_create_u8("d3", 0644, root, &samsung->debug.data.d3);
> > +       debugfs_create_blob("data", 0644, root, &samsung->debug.data_wrapper);
> > +       debugfs_create_blob("f0000_segment", 0600, root,
> >                             &samsung->debug.f0000_wrapper);
> > -       debugfs_create_file("call", S_IFREG | S_IRUGO, root, samsung,
> > +       debugfs_create_file("call", S_IFREG | 0444, root, samsung,

Actually you may drop IFREG as well as debugfs will add it if there is
no conflicting file type defined.

> >                             &samsung_laptop_call_fops);
> > -       debugfs_create_blob("sdiag", S_IRUGO | S_IWUSR, root,
> > -                           &samsung->debug.sdiag_wrapper);
> > +       debugfs_create_blob("sdiag", 0644, root, &samsung->debug.sdiag_wrapper);
> >  }
> >
> >  static void samsung_sabi_exit(struct samsung_laptop *samsung)
> > --
> > 2.30.0
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
