Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB72440CD78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhIOTwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIOTwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:52:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15925C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:50:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y28so8959019lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nI3oXjB5y7fgBDUAfkrt5Qjrdw7kij1HF6V7usZScd0=;
        b=dDkQ2iIzDzvrHagUv0HQt/yEqNuVlVfROtNamlO02CizTu2FICtXWd210Bes/CwlqB
         vjF/fdxzFxIz7v0M5Mc4QD77K9x8ec18TENbGfCqGbSG3HiLnbhqoA4lCtQEqvSsm3+w
         v6hYS+kH7FyOqPuDkRIGswKh56YqlIWBTmiYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nI3oXjB5y7fgBDUAfkrt5Qjrdw7kij1HF6V7usZScd0=;
        b=TR2MIgzw3JxTqhHslBGqqpfSk7wu9/tsLgO5CQuDx0FyeaXZbWoywRU30HC8Jhhi9X
         26RVP4//COWIOoaOUwRsMdmASF2X8IXhDDV5+fzh0ZEO8niKWQQKJxC/wKhnD5ZrcNFK
         JLdEq4WPhL8dCHXB7oAYC4nk60aUBOb876dZ9qofWNR0qrqgB3QPQlOA0+JgNVgwQUVP
         e7jL8bXRSz4Sf1yM0QHDePu0A1EeCNvJ2oWgel46dzDBGZdh4Re9LS9w3/sRws5rpjie
         lk6iGM4c9AZUftK5RC68mVN15V3iX0XQUDYRSDxuY65bCD/MRYhN0rf/3f1uLTP0ooTl
         5Tog==
X-Gm-Message-State: AOAM530N9HEh1y01gMyEaSMIldgs5iNdreS/hAFGUEtHod4a5/VXMMFN
        BsBqthzjSKs+acZhc2jH/QFrQwWBqs2oHqKPJc8=
X-Google-Smtp-Source: ABdhPJxoQzQJBEx4M+SeI6gQAWezlNEd7tfjrQRNuV4iu7FzE+MOVEVf8hP699DfkPr7eGzh+Klgdw==
X-Received: by 2002:a05:651c:154b:: with SMTP id y11mr1552254ljp.480.1631735441008;
        Wed, 15 Sep 2021 12:50:41 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s2sm94644ljj.83.2021.09.15.12.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:50:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x27so8879520lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:50:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr1268421lfu.280.1631735438424;
 Wed, 15 Sep 2021 12:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net> <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
In-Reply-To: <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 12:50:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
Message-ID: <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
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

On Wed, Sep 15, 2021 at 12:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What other notable issues end up being still live? I sent out that one
> patch for sparc, but didn't get any response to it. I'm inclined to
> just apply it (the 'struct mdesc_hdr' pointer misuse one).

Oh, I forgot about the qnx4 one. That happens on sparc, possibly
others, but not on x86-64.

I'll go look at that patch too.

          Linus
