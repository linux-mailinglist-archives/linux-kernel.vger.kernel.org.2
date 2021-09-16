Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2440EB08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhIPTsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhIPTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:48:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F61C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:47:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so23050732lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRD/cMRbGRL8eW9YNojc5SAnY20xvnXQSyOWFqi/OgQ=;
        b=VVedPAhhXvqQiPi13tSyQOLX8u5tNTR/9Sk0cDvJUoqRmAyM4xwFgAcTzMuUX3x8Qm
         ZQSuXCv1rMT2Y3TZ2fWhNMyoutGjZ6WJE5Xps077l5ng1SPHi96pbXaQZWkufjbUsJ8E
         SwaYeBwWS7O0ujHzV9O6zJeM0kMWN0lvLs7ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRD/cMRbGRL8eW9YNojc5SAnY20xvnXQSyOWFqi/OgQ=;
        b=CiAagdNqaRSAmGHWaNy/k/teMrZP6vJ5VGVIy7P0jduPXP4bJD9+M7w5R36NlwHYva
         PcVfeg2klPqkDWH08fuh1plJxugs1nGi2xrfnbkvYHpv1OrFG/wneTjiWYc9MPexmMri
         eeqo/9vIP1F02cu9If3ZL9Jxm+/V1BNnisexsjyp7bQYxDIarMn6xo197PeUH2VC8XjL
         /cSbF9iv9NdACVzoxhSDdrKsizaxgQwqbpK0gXMp+Qkc04IVowk6TyJpOavBB4v7iu6e
         7huneAfTLjYge8CQtrjF5aAZQ0T/kd8FW+sSvx7fT/eMTdP9cVEXmNon825lp4yuSPyZ
         SlVQ==
X-Gm-Message-State: AOAM533t+ZDrMDniE1pcbNAabq5V0lxa4Hcz3DX4ebKislt7QnMzEoGQ
        lRZC+8+ZKppBF0wtb+2l6siWeAepf3VjGqgb/Jc=
X-Google-Smtp-Source: ABdhPJzGtEimNv1CWGKOSLjXWmaz78oByhzDzyqZyt0wb2y9nnxvvpUIfZ3isapG4bXQquhVVkjtjA==
X-Received: by 2002:a19:6510:: with SMTP id z16mr5056907lfb.566.1631821639454;
        Thu, 16 Sep 2021 12:47:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j12sm444513ljc.121.2021.09.16.12.47.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:47:17 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d42so1437657lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:47:17 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr5248863lft.173.1631821637208;
 Thu, 16 Sep 2021 12:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net> <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
 <20210915223342.GA1556394@roeck-us.net>
In-Reply-To: <20210915223342.GA1556394@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 12:47:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQPjD_XKhVLyB4w2O6Rsi8mq256qVuhR8jMTSwrMPDqg@mail.gmail.com>
Message-ID: <CAHk-=wiQPjD_XKhVLyB4w2O6Rsi8mq256qVuhR8jMTSwrMPDqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Guenter Roeck <linux@roeck-us.net>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>
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
> drivers/net/hamradio/6pack.c: In function 'sixpack_open':
> drivers/net/hamradio/6pack.c:71:41: error:
>         unsigned conversion from 'int' to 'unsigned char' changes value from '256' to '0'
>
> patch:
>         https://lore.kernel.org/lkml/20210909035743.1247042-1-linux@roeck-us.net/
> David says it is wrong, and I don't know the code well enough
> to feel comfortable touching that code. That may be a lost cause.
> "depends on BROKEN if ALPHA" may be appropriate here.

David is wrong.

The code here is bogus, and the docs clearly state that the transmit
data is in units of "10ms":

    https://www.linux-ax25.org/wiki/6PACK

and that

    #define SIXP_TXDELAY                    (HZ/4)  /* in 1 s */

is just wrong, and the actual *uses* of that TX timeout seems correct
for that 10ms value:

        mod_timer(&sp->tx_t, jiffies + ((when + 1) * HZ) / 100);

ie that "when" is clearly given in 100ths of a second, aka 10ms (ok,
that's mainly SIXP_SLOTTIME, with SIXP_TXDELAY being used mainly to
transfer the data to the other side).

So from everything I can see, your patch is correct.

Of course, to make things more confusing, the RESYNC_TIMEOUTs are
indeed given in ticks.

I spent too much time looking at this, but I'm going to apply that
patch. I suspect either nobody uses that driver any more, or the
TXDELAY values don't actually much matter, since they have clearly
been wrong and depended on random kernel configs for a long long time.

I think the most common HZ value on x86 tends to be the modern default
of 250Hz, so the old "HZ/4" means that most people got a TXDELAY of
620ms, rather than the traditional expected 250ms.

The fact that this shows up as an actual compile error on alpha is
just random luck, since alpha uses a 1024Hz clock. CONFIG_HZ_1000
isn't impossible on other platforms either, which happens to compile
cleanly, but causes that TXDELAY byte to sent out as 250, for a 2.5Hz
TX delay.

Of course, it is possible that it's the documentation that is wrong,
but considering that the documentation matches the code (see above on
that "((when + 1) * HZ)/100"), and matches the "it doesn't cause
compiler warnings", I think it's pretty clear that your patch is the
correct fix.

           Linus
