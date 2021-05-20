Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5738AE34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhETMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:30:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhETMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:30:34 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOi1H-1m6Rk71cBb-00Q9Pb for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021
 14:29:12 +0200
Received: by mail-wm1-f48.google.com with SMTP id o127so9070549wmo.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:29:12 -0700 (PDT)
X-Gm-Message-State: AOAM532+SKCUV/FS9egs2qUw/O4z66BObdClzDp8uHmoVkaal85Sxl91
        qPVdLDzQHSIQWvnjhyKQs7gWkyZFiwSbFkqjCGM=
X-Google-Smtp-Source: ABdhPJxp7iBt7VFHla9U7M5IY7zxYj89+P8/DR9rTNgiDfB9Cejt9Flz+4djxDcTEo4F68l8U3U0vz2cjP+MgexhQYE=
X-Received: by 2002:a1c:9895:: with SMTP id a143mr3362315wme.43.1621513752085;
 Thu, 20 May 2021 05:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121347.3467794-1-lee.jones@linaro.org> <20210520121347.3467794-7-lee.jones@linaro.org>
In-Reply-To: <20210520121347.3467794-7-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 14:27:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Sej06iAj_F==o3sGfNNT4d98=+0MFQCi539wO+WB9oQ@mail.gmail.com>
Message-ID: <CAK8P3a0Sej06iAj_F==o3sGfNNT4d98=+0MFQCi539wO+WB9oQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] char: applicom: Remove 3 unused variables 'ret' and
 2 instances of 'byte_reset_it'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EnehY51Gaoh4FfHdeHUGrKw75wvJ7lgRoHCWWV/n3dxpGA6/Iy+
 NNPWsvNjHKDcaNZO+8pRtXY411u0p3EcRi+8IFwGlxEUxF08sygKXIjJGyfUDQ4czg8s0e2
 UttDTeN/uQk3tXtKP8dJ5IomwbR8KgQlCXxJJDk/0IQ9fShlkz2p20LWiyuK9sX2O/MBRLM
 Jbof3A2TGda7QLCbX8Qbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3BalCVdRVU=:jZElZ+gjxKQUytrvqx6JxE
 QwKtwk2E9iTi9iVqy/8FvgcjXBfZtCxzPtPXUOPRbf+3f2Yt1DU77kVMV0pysoNQluzwRc9j3
 MYfC0CtwdYySJLa1o74TidZhDNNlzQHZ6HK3VYS4H9XXUd74k/eej2sxbmkDEKciygcaDvhgB
 lQjh8+hcLL8ol8Elci8/3pPIry4G7UJyAkLPNlu2uXxX7nh4Mimm0z/4aW7aAyJ06mDyyX0AN
 Lu2QHIi2EPl1sTXM2Kw0oEM7Kt4N9XP/pQ2ICLA4PaGRuojMvOGFy3DVKH0Ez0sofgvp6Ggpj
 tLHQWQDk938vcfoDUPuvA9KwAbQH2OSlz95hQraX7OVCNNubfK5xAcPm73xFzPHTrOJQwtsAs
 +QkZbEiPmMQvuoWdTKuAJogm+kyzlQ4QJELAsw6bbZo0K6lfJOvYuGlT8icIod9L+DKbd8PJJ
 ifGD30cAERXbbD/3lZplQomLD58uQC1KBm6EW4jPnyqUTwWWArsDVcTEz/KkpsCmjh8O8SZRG
 f/QRvSeYvB6iiQjBDX0BGA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:

> @@ -568,7 +565,7 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
>
>                                 /* Got a packet for us */
>                                 memset(&st_loc, 0, sizeof(st_loc));
> -                               ret = do_ac_read(i, buf, &st_loc, &mailbox);
> +                               do_ac_read(i, buf, &st_loc, &mailbox);
>                                 spin_unlock_irqrestore(&apbs[i].mutex, flags);
>                                 set_current_state(TASK_RUNNING);
>                                 remove_wait_queue(&FlagSleepRec, &wait);

This change doesn't look right to me. It's clear that the code we have is bogus,
but I think what the authors intended was:

--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -577,7 +577,7 @@ static ssize_t ac_read (struct file *filp, char
__user *buf, size_t count, loff_
                                        return -EFAULT;
                                if (copy_to_user(buf + sizeof(st_loc),
&mailbox, sizeof(mailbox)))
                                        return -EFAULT;
-                               return tmp;
+                               return ret;
                        }

                        if (tmp > 2) {

From the git history, I can see that this got changed in linux-2.3.99,
but the previous
version just returned zero on success instead of the number of bytes,
so presumably
nobody ever cared about the returned value.

> @@ -700,7 +697,6 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         void __iomem *pmem;
>         int ret = 0;
>         static int warncount = 10;
> -       volatile unsigned char byte_reset_it;
>         struct st_ram_io *adgl;
>         void __user *argp = (void __user *)arg;
>
> @@ -762,7 +758,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>
>                 for (i = 0; i < MAX_BOARD; i++) {
>                         if (apbs[i].RamIO) {
> -                               byte_reset_it = readb(apbs[i].RamIO + RAM_IT_TO_PC);
> +                               readb(apbs[i].RamIO + RAM_IT_TO_PC);
>                         }

This is a little subtle but should be fine on all architectures now. I suspect
this used to be required a long time ago before the readb() function worked
correctly everywhere.

I'm also reminded that I had meant to send a patch to move this file
to drivers/staging,
as all evidence suggests it has not been used for decades.

       Arnd
