Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD44643B4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhJZOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhJZOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:52:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA1DC061745;
        Tue, 26 Oct 2021 07:50:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 65so15035070ljf.9;
        Tue, 26 Oct 2021 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wv8gi01ZEigq0zjxWHYaalehUKR7G5eHYfl2J1tFc+g=;
        b=ndCAi0POSvM+VeiQLzjMGVUHX1XM64AVfkCRl0OLmB/DxOBCnWNuiYgfsnL9XNXH0X
         U6AXUdWzfqFcuo79jxRoecbK5ib7OZkYMmA2AxtJIJkFTGKGnt+W61I92X8U1EuLQXJt
         /z2IENPVU0sCyFKXNsNEaCMgO7Ng74wEnDP1IwIoretz2JtJm8g2nKe0WXE+M6lfqg+R
         L3mioHMCqvrI5prEnWbrS1g8eN98uyk7bNAW8mAQkvoFzh+p1lYwWXz8bjVGyS1c8AAk
         LV8Gh9k9LSJGQa1zaxhvLaUYL/8wkwNCw9MaJ7ozvmIqX7PS263Y+hG5Ks32/btQ+6mT
         q0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wv8gi01ZEigq0zjxWHYaalehUKR7G5eHYfl2J1tFc+g=;
        b=HEWHeSbYMfKOKHeSGBJSpAEE3ewMZ8aT/a2wcmimshdBiwUkmzp7ay7AjTNOOThKe1
         ALDxSYjzbGYxv36GhTYOG6Bek61v4qF3YkdZklsrO6MHNuh1Y8nqru5Fe5ufVmT+gUJ/
         EL4QjwuDmqdZbyUUTsKWYciJl60gZuDxsblZocI4xqCzH47aIg++RmINrnRpZKB954vc
         IYfm5LlVfsz+WQkURQZeYTFy8utoijEUUrdBziDkdEaeKdUvV/cIcputepGM5ZPCY5Ck
         Y8ODO4w17j3Vcbtn1mLnRBT5dvQZUYXIAr8bimNbsVwHFy6LBC5Ca3jLgao7BrkOsPKT
         pd5A==
X-Gm-Message-State: AOAM533QojhaJE6j0Vc7vr3lkoY16dck4Jbqhe3whbP8z0q70jSPReM9
        ta1fQS2MwIslKX7h1KJPsY4MJSosD1LNQ78o5roIb4hgyJBlDQ==
X-Google-Smtp-Source: ABdhPJyy1EKyBIqz5vqbrvWBotlkahxJX5CZ/VCMCLuv055iVc26/E4mc62j6aAEo261WYq+6qrZefJckS+cTHIt3N0=
X-Received: by 2002:a2e:b5a2:: with SMTP id f2mr5618786ljn.23.1635259822879;
 Tue, 26 Oct 2021 07:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211026033254.1052-1-maahiuzeon@gmail.com> <87fssox7ah.fsf@linux.ibm.com>
In-Reply-To: <87fssox7ah.fsf@linux.ibm.com>
From:   Hill Ma <maahiuzeon@gmail.com>
Date:   Tue, 26 Oct 2021 07:50:12 -0700
Message-ID: <CABpQrUMcCKbgSTnTB4BeUUVwq5jkOw7pGbUC53SGe-4DEVnUag@mail.gmail.com>
Subject: Re: [PATCH v2] macintosh/via-pmu-led: make disk activity usage a parameter.
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On Tue, Oct 26, 2021 at 6:08 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Hello,
>
> Hill Ma <maahiuzeon@gmail.com> writes:
> > Whether to use the LED as a disk activity is a user preference.
> > Some like this usage while others find the LED too bright. So it
> > might be a good idea to make this choice a runtime parameter rather
> > than compile-time config.
>
> Users already have the ability to change the LED behavior at runtime
> already, correct? I.e. they can do:
>
>   echo none > /sys/class/leds/pmu-led::front/trigger
>
> in their boot scripts. Granted, a kernel built with ADB_PMU_LED_DISK=y
> will blink the LED on disk activity until user space is running. Is this
> unsatisfactory?

Yes, indeed. As someone who does not like this behavior on iBooks.

> > The default is set to disabled as OS X does not use the LED as a
> > disk activity indicator.
>
> This is long-standing behavior in Linux and OS X has been EOL on this
> architecture for a decade, so this isn't much of a consideration at this
> point. Seems more important to avoid surprising existing users and
> distributions with a behavior change that makes additional work for
> them. See below.
>
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 43dc35fe5bc0..a656a51ba0a8 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -250,6 +250,12 @@
> >                       Use timer override. For some broken Nvidia NF5 boards
> >                       that require a timer override, but don't have HPET
> >
> > +     adb_pmu_led_disk [PPC]
> > +                     Use front LED as disk LED by default. Only applies to
> > +                     PowerBook, iBook, PowerMac 7,2/7,3.
> > +                     Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
> > +                     Default: disabled
> > +
> >       add_efi_memmap  [EFI; X86] Include EFI memory map in
> >                       kernel's map of available physical RAM.
> >
> > diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> > index 5cdc361da37c..243215de563c 100644
> > --- a/drivers/macintosh/Kconfig
> > +++ b/drivers/macintosh/Kconfig
> > @@ -78,16 +78,6 @@ config ADB_PMU_LED
> >         behaviour of the old CONFIG_BLK_DEV_IDE_PMAC_BLINK, select this
> >         and the disk LED trigger and configure appropriately through sysfs.
> >
> > -config ADB_PMU_LED_DISK
> > -     bool "Use front LED as DISK LED by default"
> > -     depends on ADB_PMU_LED
> > -     depends on LEDS_CLASS
> > -     select LEDS_TRIGGERS
> > -     select LEDS_TRIGGER_DISK
> > -     help
> > -       This option makes the front LED default to the disk trigger
> > -       so that it blinks on disk activity.
> > -
>
> So, if I've been relying on CONFIG_ADB_PMU_LED_DISK=y and I upgrade to a
> newer kernel with the proposed change, from my point of view the disk
> activity LED has stopped working and I need to alter the bootloader
> config or init scripts to restore the expected behavior. That seems
> undesirable to me.
>
> I don't think we rigidly enforce Kconfig backward compatibility, but
> when it comes to a user-visible function on a legacy platform where
> users and distros likely have their configurations figured out already,
> it's probably best to avoid such changes.

I actually asked some distributions that still ship PowerPC BE
architectures to unset it.
https://github.com/void-ppc/void-packages/pull/48
https://github.com/void-linux/void-packages/pull/33275
https://git.adelielinux.org/adelie/packages/-/merge_requests/607

And Debian, which still has PowerPC BE architectures as ports, does
not turn it on.
https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/kernelarch-powerpc/config

The problem I see is the following:
- A distribution might accidentally turn it back on, which happened
with Void already.
- For people like the disk activity behavior, they need to recompile
the kernel to regain the exact previous behavior.

I think we could retain backward compatibility by adding back the
Kconfig and setting the initial value of adb_pmu_led_disk based on the
config. I am not sure if we need two mechanisms for this single
preference though.
