Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A0379755
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhEJTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:02:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBB5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:01:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y9so22114276ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58v46rcCymqbvtdlk+9Wce0rlMfWCPjj+b2+CKWyW8E=;
        b=f9FifjRkXHq08mKJ154sOQ5A2E5MZKBMXeMrI5AIO/a85ofps0EU79nu77X6CeZ0At
         RZw3FojIUm0g1nh9r0V0mIM8UmEg2bfP1abzhlHVWwgwQxt3sYka5foygoibvN4kRYkU
         yRjFzS52q4Xyapp4QsDxi6Zo/sA8t1T90gC+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58v46rcCymqbvtdlk+9Wce0rlMfWCPjj+b2+CKWyW8E=;
        b=PxjuSbr5RIH8w9UaFhVd8tyD7hrhesn9QBY1j7ggRYsKn42k0xNZMbSmXJHHZ83edK
         1l389a8sEWxr4vYEWBgcCbK76DjpEEw75IJQWDKSk1GZmM0Py72Yixn+5+EMQpD30XEk
         JXWeblIhlivrqvLjXCUYyVd8mf2/6wVAkl1WkGQH2Mr09o6iulAMa1B1vMrxH2q712cz
         vtrdPmCfVbAX3qFtZSHAY8J0Uv65cvfhBY7hR6VUMaFxCd8lrpIorg9HAEXgOqjQWo7m
         lPCjrPK8R+SxGgcP1ltm1dz5Q4V0phQ/j8bMz6Bbc7Dq/5kUBFLnMteT8uiIaMK+VXwD
         e0kQ==
X-Gm-Message-State: AOAM53130Rq1cQ1A1bgwIt0de2e7BzYzqC8xj56gG1wXwzyeRbU+LF6A
        vcLmD/+/QWyc9btr2C5Jw6LgREjS5XNaR2rHKMI=
X-Google-Smtp-Source: ABdhPJx2vZ1mzLe7Mv887ovbM0d195Lega8EKxGc0HswGrDZq0S6JoNozvQISItz2/wPkLySO+rY6w==
X-Received: by 2002:a2e:854a:: with SMTP id u10mr20530047ljj.455.1620673277101;
        Mon, 10 May 2021 12:01:17 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m16sm2367333lfg.229.2021.05.10.12.01.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 12:01:16 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x20so24964572lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:01:16 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr17153559lfe.41.1620673276528;
 Mon, 10 May 2021 12:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
 <20210510025414.GA2041281@roeck-us.net>
In-Reply-To: <20210510025414.GA2041281@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 May 2021 12:01:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsQz-RJzXPu6eeZE+R9m2SH6JoreV6e_mwguitZ5_=zw@mail.gmail.com>
Message-ID: <CAHk-=wjsQz-RJzXPu6eeZE+R9m2SH6JoreV6e_mwguitZ5_=zw@mail.gmail.com>
Subject: Re: Linux 5.13-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 9, 2021 at 7:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Qemu test results:
>         total: 462 pass: 460 fail: 2
> Failed tests:
>         arm:raspi2:multi_v7_defconfig:net,usb:bcm2836-rpi-2-b:initrd
>         arm:raspi2:multi_v7_defconfig:sd:net,usb:bcm2836-rpi-2-b:rootfs
>
> The raspi2 problem (a crash in of_clk_add_hw_provider) is well known.
> It was introduced with commit 6579c8d97ad7 ("clk: Mark fwnodes when
> their clock provider is added"). Unfortunately it appears that there
> is still no agreement on how to fix it.

Hmm. I see

    https://lore.kernel.org/linux-acpi/20210426065618.588144-1-tudor.ambarus@microchip.com/

and don't see any objections to that version.

Does that fix it for you too?

I'm assuming I'll get that through the usual channels.

> There is also a repeated warning
>
> WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:550 irq_domain_associate+0x194/0x1f0
>
> in some pxa boot tests. It looks like that problem has been fixed in -next.

Ok, I won't worry about it then.

Thanks,

                 Linus
