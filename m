Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF23CA054
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhGOOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhGOOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:15:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FAFC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:12:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso6353717pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/PWgL5TbLebBgtXBw2Ow5Z68fL5u2acy5iXXSSXc+o=;
        b=RSbJ/iFetXw6qXpLlFt4zSEJwzM5SaIE0T110oALZixVEKkztk3EIX6eqKhnEwbm4D
         GeSJLI95Ncf71UoB1jU/R5HK5t4tBCrAedB5j2sUBL/KpXV5/n+oA1tVaY9BPWWhqY+f
         bwYX/TeADY9ULGcpKMvYhHVep/FpI2nyLYMY98XRD/5/ImaiBDAwGy6ID++t+LYXtjSs
         ihm/efClBQSprDXj0ZOTsGpRqbcmS7e5j3pJnGItcD76mZHHRV6TYWjEPr1Ikz1Cgzr3
         +PKE+FcdOwempaRWZXJ2Rmlkzx/Y3xeaZRGK6V4fIgPjkg89Kou/iAZAC9g6gAoC1RZx
         N3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/PWgL5TbLebBgtXBw2Ow5Z68fL5u2acy5iXXSSXc+o=;
        b=kP1ZxGgh2T1aYjj6WDObv2RVhSj+aU/kijWirxQoNHDLFvbecx+3964tE0X/OE0xXr
         5JnHfQjXvShraK/RKokAI7dOVYr/tIc2BQImfOecHb7k/3kKyPZKzGf63jTuMw4+Wkc7
         TRDncn40EoyAI/l/ZT0fBTR8kChx+usi+ljFOy0wn1VnEzCMZeFURaMcB3m7BOZ7luno
         m+6j1Ctwy3WUcDot4vo3dL8/PcoYA8JPFVk5sBfvjhPEuF13AEwN4pQdojwZ5zQcU6l/
         8nsY83fDQ/Tx5eFLVTVRTIVXCPRKJxr/ZG7q6YyxU/k19wTYElicluyHKb/TkHy+wJMn
         doKQ==
X-Gm-Message-State: AOAM532vSZHveht88FAy3oNnWQN3H979Yhx9Gc37h6fJdARpZM1Dww9Y
        M9cmWsNeoenDyfxHyOk8ksqBIk+Mew+OZH+9Uzg=
X-Google-Smtp-Source: ABdhPJyZpr3wj1kjZoMlD/WgLXlsPbY14IuygVeoZJeNrSjvGV/LFfRYD8izVv6kdPsmSegR/2rPxt5Aw1A9GvdCPqQ=
X-Received: by 2002:a17:902:fe0a:b029:11d:81c9:3adf with SMTP id
 g10-20020a170902fe0ab029011d81c93adfmr3720222plj.0.1626358353492; Thu, 15 Jul
 2021 07:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
 <CAHp75VeL89xaP9xjnigvv7Hki20=b7drp5iZ+ZfhZke6WGWsRA@mail.gmail.com> <20210714110218.izcop7grykhfyvll@lem-wkst-02.lemonage>
In-Reply-To: <20210714110218.izcop7grykhfyvll@lem-wkst-02.lemonage>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 17:11:54 +0300
Message-ID: <CAHp75VdGnuOPUKYSc0cFvXEY8Vt7LGiP2pS518=890FfV9Fk=g@mail.gmail.com>
Subject: Re: [RFC] auxdisplay: Fix oops on hd44780 module unloading
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 2:02 PM Lars Poeschel <poeschel@lemonage.de> wrote:
>
> On Fri, Jul 09, 2021 at 07:10:14PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 9, 2021 at 5:40 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > Parallel (4 bits)  panel display stopped working.
> >
> > This part appears to be a configuration issue. So, we have only one
> > left, i.e. oops on remove.

Thanks for the prompt reply!
As usual, rc1 is like after war ruins which needs to be fixed here and
there before doing something useful.

> Could you please test, if this little change fixes the oops ?

I think you meant "RFT" in the subject line.
Anyway, I have tested it and it seems to be working fine.

Reported-and-tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> -- >8 --
>
> Fix this oops:

(Note, please, reduce it as much as possible to the bare minimum
required to understand the issue and the cause)


> [  218.825445] kernel tried to execute NX-protected page - exploit
> attempt? (uid: 0)
> [  218.832965] BUG: unable to handle page fault for address: ffff8f8f06559dc0
> [  218.839863] #PF: supervisor instruction fetch in kernel mode
> [  218.845540] #PF: error_code(0x0011) - permissions violation
> [  218.851132] PGD e601067 P4D e601067 PUD e602067 PMD 645a063 PTE
> 8000000006559063
> [  218.858587] Oops: 0011 [#1] SMP PTI
> [  218.862099] CPU: 0 PID: 7 Comm: kworker/u4:0 Tainted: G         C
>      5.13.0+ #23
> [  218.869870] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> BIOS 542 2015.01.21:18.19.48
> [  218.878681] Workqueue: kacpi_hotplug acpi_device_del_work_fn
> [  218.884380] RIP: 0010:0xffff8f8f06559dc0
> [  218.888328] Code: ff ff d2 2b 21 8c ff ff ff ff 08 00 00 00 00 00
> 00 00 78 34 fa 02 8f 8f ff ff 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 <72> 65 67 75 6c 61 74 6f 72 3a 72 65
> 67 75 6c 61 74 6f 72 2e 30 2d
> [  218.907138] RSP: 0000:ffffad36c0043c90 EFLAGS: 00010246
> [  218.912387] RAX: ffff8f8f06559dc0 RBX: ffff8f8f062cbc00 RCX: ffff8f8f01239fc8
> [  218.919542] RDX: 000000002a3cccf8 RSI: 0000000000000001 RDI: ffff8f8f06559480
> [  218.926701] RBP: ffffffffc037e279 R08: 00000000d5832520 R09: 0000000000000001
> [  218.933856] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8f8f062cbc00
> [  218.941010] R13: ffffffffc038e028 R14: ffffffff8c5e0b60 R15: 00000000fffffffd
> [  218.948166] FS:  0000000000000000(0000) GS:ffff8f8f3e200000(0000)
> knlGS:0000000000000000
> [  218.956286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  218.962053] CR2: ffff8f8f06559dc0 CR3: 0000000002ef4000 CR4: 00000000001006f0
> [  218.969208] Call Trace:
> [  218.971678]  ? hd44780_common_clear_display+0x17/0x30 [hd44780_common]
> [  218.978252]  ? charlcd_write_char+0x21a/0x810 [charlcd]
> [  218.983519]  ? charlcd_puts+0x30/0x60 [charlcd]
> [  218.988083]  ? charlcd_unregister+0x24/0x70 [charlcd]
> [  218.993167]  ? hd44780_remove+0x1e/0x30 [hd44780]
> [  218.997901]  ? platform_remove+0x1f/0x40
>
> Reported-By: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  drivers/auxdisplay/hd44780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> index 2e5e7c993933..8b2a0eb3f32a 100644
> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -323,8 +323,8 @@ static int hd44780_remove(struct platform_device *pdev)
>  {
>         struct charlcd *lcd = platform_get_drvdata(pdev);
>
> -       kfree(lcd->drvdata);
>         charlcd_unregister(lcd);
> +       kfree(lcd->drvdata);
>
>         kfree(lcd);
>         return 0;
> --
> 2.30.2
>


--
With Best Regards,
Andy Shevchenko
