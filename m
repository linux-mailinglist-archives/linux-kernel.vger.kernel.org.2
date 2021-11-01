Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03B441523
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhKAIQQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Nov 2021 04:16:16 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:37532 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhKAIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:16:12 -0400
Received: by mail-ua1-f53.google.com with SMTP id f4so30398245uad.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wKEXgiE+KS/+BQe8KTx4zyXWOlKWlw5eMFNjnPfFT74=;
        b=GJlwhath44vPGzIjv0MmIq/302zQ73KYT+msdmL/kLm7L3YLZtBBC3697tPVsSRCdP
         +Ycm2TnDTFwWDNcrxc2xkaCYf6av/nZPBlRPBXfRDLtQtF6BfCeRbOJPPfJeBkZx4rFI
         LKlw18n2h8PIfqI+s7T+c8Xpv5tQMyL53ckbKlIwkkcrCGsaNg3egnyKv7568Cf+Fx/e
         3OYoYVCDlaJU7Jz5Efza0nYoIIq6RAcd6Kjl8yfhxJdAt5iL3eQeVGmX1Yy/Zf0bZ7Cf
         saElGpWowUOPu+pTZTcprtoYHHkW7+2lJPG3mI5QO2sTSoq164GGz51oucuGNuuDKkU/
         WZgg==
X-Gm-Message-State: AOAM533N5k4S2d2/xaSjCMTkY95nCju7HwGcEnoYB/ROJiBL+kaaHdiz
        0BMlOKm7Ba6cbNEp+1Ix/cnbYnFaInVDjw==
X-Google-Smtp-Source: ABdhPJzMD3S2lcFAEYyh/bN1+6aQbBoDwT31OTMQxipw1q2mBkTE8h80tef3Bkp98IUeDfBznDVMAQ==
X-Received: by 2002:a05:6102:50a7:: with SMTP id bl39mr10616500vsb.12.1635754419017;
        Mon, 01 Nov 2021 01:13:39 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id k28sm1708285vkn.2.2021.11.01.01.13.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 01:13:38 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id e2so30380090uax.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:13:38 -0700 (PDT)
X-Received: by 2002:a67:ee41:: with SMTP id g1mr518643vsp.41.1635754418420;
 Mon, 01 Nov 2021 01:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <20211101002346.GA304515@roeck-us.net>
In-Reply-To: <20211101002346.GA304515@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Nov 2021 09:13:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBgGvt8q9suk6tysgga7sJ4v74eJHHO=ifg2Rc3S9A9Q@mail.gmail.com>
Message-ID: <CAMuHMdWBgGvt8q9suk6tysgga7sJ4v74eJHHO=ifg2Rc3S9A9Q@mail.gmail.com>
Subject: Re: Linux 5.15
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter.

On Mon, Nov 1, 2021 at 1:28 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Oct 31, 2021 at 02:09:07PM -0700, Linus Torvalds wrote:
> Building m68k:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/string.h:20,
>                  from include/linux/bitmap.h:10,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/smp.h:13,
>                  from include/linux/lockdep.h:14,
>                  from include/linux/spinlock.h:63,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:6,
>                  from include/linux/slab.h:15,
>                  from drivers/nvme/target/discovery.c:7:
> In function 'memcpy_and_pad',
>     inlined from 'nvmet_execute_disc_identify' at drivers/nvme/target/discovery.c:268:2:
> arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 8 bytes from a region of size 7
>
> Another instance of the same problem:
>
> In function 'memcpy_and_pad',
>     inlined from 'nvmet_execute_identify_ctrl' at drivers/nvme/target/admin-cmd.c:372:2:
> arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 8 bytes from a region of size 7
>
> This is seen with gcc 11.1 and 11.2. gcc 10.3 builds fine.
> The code in question is
>
>         memcpy_and_pad(id->fr, sizeof(id->fr),
>                        UTS_RELEASE, strlen(UTS_RELEASE), ' ');
>
> and UTS_RELEASE is "5.15.0". I have no idea what might be wrong with the code.

Me neither.  That warning (now error) has been seen with all point
releases (i.e. strlen(UTS_RELEASE) < 8) since v5.0.

> Does anyone have an idea ?

We had a discussion in
https://lore.kernel.org/all/CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com
but without any definitive conclusion.

> Do I need to revert to gcc 10.3 for m68k ?

I'm not sure that might help, as the issue has been seen with
e.g. 8.1.0 and 8.2.0, too, with a slightly different message:
warning: ‘__builtin_memcpy’ forming offset 8 is out of the bounds [0,
7] [-Warray-bounds]

Any suggestions? Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
