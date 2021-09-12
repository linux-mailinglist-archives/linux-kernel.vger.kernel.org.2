Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F09407F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhILTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhILTNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:13:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E07C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:11:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l10so16256617lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1PHZ6ydkqEkrZPVcY11k8G+o6nXM73c5JaOIi36jdM=;
        b=Mmh3TCnuXic/hCA6XvkP2osD5zmauEUtEa852ODITJl9q7DRJZnlYFaFYG+mxH6vf6
         Z+ggUrlsmP9EQRyIHakVw8bJD81GHQopdHiqd4QBP+UGydXePHYv5SH2cpjAaKjOE5af
         i5L6vjez7vZKGjXnjuCG5wVITdXtC1IYH3rOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1PHZ6ydkqEkrZPVcY11k8G+o6nXM73c5JaOIi36jdM=;
        b=myV5yFTt8L0nyah2vlZQYswoUJ9892NhtQHoVA2cHTF9ct0bpIbV4Err0AfH/2JVuw
         9RlSCyeKEedtzRwz9NX3ZpohYD7aEQP8I76bylpfDopLeZVVF6kkPCAysue5YoUQ4Rlk
         nU8i3k1C9+vzGC5X5jvg/iiGaQ/L966SoIIwLCzyVbm34KT+PPCvTVWRfpoCOPwAzhlL
         zw6RSxGkIFSZS7/DMtSyvtJ+DeC2ojrsEcms20+sZvckOCDtEe7yPKUJVhTljmkIr9RA
         OfFHqeSWZQZsVqeG6ol0yXzB8GuKXxvY7xBs7F3m3cFvRIe0pl3bv5X6Nx+ky1o5L1uv
         Go/w==
X-Gm-Message-State: AOAM531K1Fvt/dZ1wJx4ZjUdCT4NB4063YAgqObsmL3s0mN6xerVWfw4
        Y5GqVq6mlAqV8PNV4VQkI3kqEO4guraqvFFLJ8I=
X-Google-Smtp-Source: ABdhPJzfwugy/vQDN5dgU6WYvh/qp41VJFC4FkcDDD187RmFJEVIrcxEfuxjfOs8IjDChxsBg9jlAw==
X-Received: by 2002:a05:6512:a8f:: with SMTP id m15mr5933440lfu.635.1631473914853;
        Sun, 12 Sep 2021 12:11:54 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id j13sm591777lfu.214.2021.09.12.12.11.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:11:54 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id s10so16231221lfr.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:11:54 -0700 (PDT)
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr6147162lfv.474.1631473913911;
 Sun, 12 Sep 2021 12:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210912160149.2227137-1-linux@roeck-us.net> <20210912160149.2227137-4-linux@roeck-us.net>
In-Reply-To: <20210912160149.2227137-4-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:11:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1TBvyk7SWX+5LLYN8ZnTJMut1keQbOrKCG=nb08hdiQ@mail.gmail.com>
Message-ID: <CAHk-=wi1TBvyk7SWX+5LLYN8ZnTJMut1keQbOrKCG=nb08hdiQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] parisc: Use absolute_pointer for memcmp on fixed
 memory location
To:     Guenter Roeck <linux@roeck-us.net>
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

On Sun, Sep 12, 2021 at 9:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> -       running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);
> +       running_on_qemu = (memcmp(absolute_pointer(&PAGE0->pad0), "SeaBIOS", 8) == 0);

This seems entirely the wrong thing to do, and makes no sense. That
"&PAGE0->pad0" is a perfectly valid pointer, and that's not where the
problem is.

The problem is "PAGE0" itself:

    #define PAGE0   ((struct zeropage *)__PAGE_OFFSET)

which takes that absolute offset and creates a pointer out of it.

IOW, _that_ is what should have the "absolute_pointer()" thing, and in
that context the name of that macro and its use actually makes sense.

No?

An alternative - and possibly cleaner - approach that doesn't need
absolute_pointer() at all might be to just do

        extern struct zeropage PAGE0;

and then make that PAGE0 be defined to __PAGE_OFFSET in the parisc
vmlinux.lds.S file.

Then doing things like

        running_on_qemu = !memcmp(&PAGE0.pad0, "SeaBIOS", 8);

would JustWork(tm).

Hmm?

             Linus
