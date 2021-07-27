Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75A23D7285
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhG0KEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:04:00 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:46912 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhG0KD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:03:59 -0400
Received: by mail-vs1-f52.google.com with SMTP id e4so6776979vsr.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1Rltp5aC928hhgEXj95boe/DWxuoVxGBX01uUMCHls=;
        b=HharK82HdWjQczNqCnToDKK2tBEaLHJ0M9RDgTCK+ek6cUowJgD3u81P82qD0YO9E8
         q0aQRAHxtsLQPCgrKC+AuOqxtv9PJfITQqFQWz7M/qiXmkNynMK0YznZ3EImhTECS2ZD
         qqXUTGbK41T59toTkW7nRUvcSq7Cza5K+ilakLByfX6bx5kxSJHQ65gvn88pAJMIBssO
         7kQsf0LydnNY8QTPR4qtxvr53Fsv2xncOA6ZSjgKsX0qmlIiwc3rUqWCg0ntYdlIm5fj
         +wZGhNv09u1wm4AFbstrGsx32AoS6txUwAl4lHw0q9uEpv5XYOR03DoPsZ/ovXXk8s8x
         jXUw==
X-Gm-Message-State: AOAM530YH+hz6FR0ECpU/i7NDpxycgW8XhMk12KpE8sgFHyytBzAiEZV
        N6TIO22wBSlAj2ZcxxVNh9BqhQneiza8T3cGGJc=
X-Google-Smtp-Source: ABdhPJxrB7YF93pARYWhq+2Ajrw4bqt9huLpzoSpNbmxJxMepUSMaydScT3Hmera1LH4J+8mRlnO3JUVKm36A07jUaY=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr15660407vsb.18.1627380238791;
 Tue, 27 Jul 2021 03:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210727093015.1225107-1-javierm@redhat.com>
In-Reply-To: <20210727093015.1225107-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jul 2021 12:03:47 +0200
Message-ID: <CAMuHMdXXoHLO=jsjb+xtW7GDQsvu8Zuz=JmbaEXT49w5o4SJ9A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/firmware: fix SYSFB depends to prevent build failures
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Jul 27, 2021 at 11:33 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The Generic System Framebuffers support is built when the COMPILE_TEST
> option is enabled. But this wrongly assumes that all the architectures
> declare a struct screen_info.
>
> This is true for most architectures, but at least the following do not:
> arc, m68k, microblaze, openrisc, parisc and s390.
>
> By attempting to make this compile testeable on all architectures, it
> leads to linking errors as reported by the kernel test robot for parisc:
>
>   All errors (new ones prefixed by >>):
>
>      hppa-linux-ld: drivers/firmware/sysfb.o: in function `sysfb_init':
>      (.init.text+0x24): undefined reference to `screen_info'
>   >> hppa-linux-ld: (.init.text+0x28): undefined reference to `screen_info'
>
> To prevent these errors only allow sysfb to be built on systems that are
> going to need it, which are x86 BIOS and EFI.
>
> The EFI Kconfig symbol is used instead of (ARM || ARM64 || RISC) because
> some of these architectures only declare a struct screen_info if EFI is
> enabled. And also, because the SYSFB code is only used for EFI on these
> architectures. For !EFI the "simple-framebuffer" device is registered by
> OF when parsing the Device Tree Blob (if a DT node for this was defined).
>
> Fixes: d391c5827107 ("drivers/firmware: move x86 Generic System Framebuffers support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -254,7 +254,7 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>  config SYSFB
>         bool
>         default y
> -       depends on X86 || ARM || ARM64 || RISCV || COMPILE_TEST
> +       depends on X86 || EFI

Thanks, much better.
Still, now this worm is crawling out of the X86 can, I'm wondering
why this option is so important that it has to default to y?
It is not just a dependency for SYSFB_SIMPLEFB, but also causes the
inclusion of drivers/firmware/sysfb.c.

>
>  config SYSFB_SIMPLEFB
>         bool "Mark VGA/VBE/EFI FB as generic system framebuffer"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
