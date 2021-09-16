Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2932940EA89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhIPTD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbhIPTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:03:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60DC07E5C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:35:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g1so22286296lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t51QwKIKWkGOiuP6SJMrhP/dJST+bSD7Qp/ejqOgA0s=;
        b=PYrRSLFVlXcDD2+pFS2QiDv72x9PP+CSDGgHHxrtNHys/SFAhFt/K9Dl2YKY3s46v4
         n1V6egkmODP63nyS2heOSJmRcvJd8e+uQG22Bg5vVGD2JMQ2HAT6BYtwWfythdLKnTmE
         1gprbKiTFCMpaERdEBSQKexI+QYMoZlOHeBbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t51QwKIKWkGOiuP6SJMrhP/dJST+bSD7Qp/ejqOgA0s=;
        b=WCtio8hgyPKOy8tBv51+WvbmBstyyd/giFHgi+gYrMM4E57GjKQYbiz2IpTOFsiQOE
         gcNVg31DFeaYtRUG1WZ9JhJ25qxUpAYTJKeCtHY42IJvNHCoaW7epyzPDpmoEdm5/LKB
         hpFC5VKpw2EJ740oIKDia9SI8I9kKDLS+uZowE6OyHtWjABNMiyX0DNTXgbHEUjhzrK9
         PIuuBeqjPXFAw3kA+AW9eedjnt11CBbVfoNqhWBA5+efbG5p6ySgp6lTaeWw4joTNoqR
         uL9TnTOL9K3w3C5EPbxFvkggIMrMJTopj9AhRk7ePR0Igp/DQjgZpwA9Zpa6fda8sMle
         Pt6w==
X-Gm-Message-State: AOAM530duMmz26B3hwyM9Bok7i4FWuj1vyflC5B1J+8/03TPJ1GnFoji
        9ji6rzPXkzSrWUeqRPbgl9c/qczt4aMt7Tuh
X-Google-Smtp-Source: ABdhPJxW3NLGkQVeHK2uc/G/0yiw0VZqee/DFZwBSAmpc7+F5aLybuyKALDmtn59CYrQzq6AYx/VRQ==
X-Received: by 2002:a2e:b5a7:: with SMTP id f7mr6133123ljn.19.1631817355751;
        Thu, 16 Sep 2021 11:35:55 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d7sm358846lfa.80.2021.09.16.11.35.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 11:35:54 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id c8so22421087lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:35:53 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr5708746ljm.95.1631817352669;
 Thu, 16 Sep 2021 11:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net> <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
 <20210915223342.GA1556394@roeck-us.net>
In-Reply-To: <20210915223342.GA1556394@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 11:35:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ4jsPadbo4kr4=UKn0nR+UvWUZF9Q-xv0QUXb33SVRA@mail.gmail.com>
Message-ID: <CAHk-=wgQ4jsPadbo4kr4=UKn0nR+UvWUZF9Q-xv0QUXb33SVRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Cree <mcree@orcon.net.nz>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 3:33 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> drivers/net/ethernet/3com/3c515.c: In function 'corkscrew_start_xmit':
> drivers/net/ethernet/3com/3c515.c:1053:22: error:
>         cast from pointer to integer of different size
>
> That is a typecast from a pointer to an int, which is then sent to an
> i/o port. That driver should probably be disabled for 64-bit builds.

Naah. I think the Jensen actually had an ISA slot. Came with a
whopping 8MB too, so the ISA DMA should work just fine.

Or maybe it was EISA only? I really don't remember.

It's possible that alpha should get rid of the ISA config option, and
use ISA_BUS instead. That would be the proper config if there aren't
actually any ISA _slots_, and it would disable the 3c515 driver.

But it turns out that the compile error is easy to fix. Just make it
use isa_virt_to_bus(), which that driver does elsewhere anyway.

I have no way - or interest - to test that on real hardware, but I did
check that if I relax the config I can at least build it cleanly on
x86-64 with that change.

It can't make matters worse, and it's the RightThing(tm).

Since Micheal replied about that other alpha issue, maybe he knows
about the ISA slot situation too?

But anyway, 3c515 should compile cleanly again.

> drivers/net/wan/lmc/lmc_main.c: In function 'lmc_softreset':
> drivers/net/wan/lmc/lmc_main.c:1782:50: error:
>         passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type
>
> and several other similar errors.
>
> patch:
>         https://lore.kernel.org/lkml/20210909050033.1564459-1-linux@roeck-us.net/
> Arnd sent an Ack, but it doesn't look like it was picked up.

I picked it up manually now along with the arm vexpress cpufreq one.

> m68k:

I think these should be fixed as of the pull request this morning.

> mips:
>
> In file included from arch/mips/include/asm/sibyte/sb1250.h:28,
>                  from drivers/watchdog/sb_wdog.c:58:
> arch/mips/include/asm/sibyte/bcm1480_scd.h:261: error: "M_SPC_CFG_CLEAR" redefined
>
> and similar. Patch:
>
> https://patchwork.kernel.org/project/linux-watchdog/patch/20210913073220.1159520-1-liu.yun@linux.dev/
>
> I'll need to get Wim to push it.

Ok, that hasn't hit my tree yet.

> parisc:

This one should be fixed as of the parisc pull this morning.

So a few more remaining (mainly the suspend/resume ones), but slowly
making progress.

             Linus
