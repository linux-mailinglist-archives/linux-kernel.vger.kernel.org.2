Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18E4107DA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhIRRaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbhIRRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 13:30:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A95C061757
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:28:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g41so13853547lfv.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPMj8VLwTy75eprkO41oC3JgAE7NDa67ow6tA6A6/r0=;
        b=cy1UQNMOS0XYpgCCs7UW1bRKopN5C73/mDGBe3xOEvU9Qfc5peAlSaAnDkUL4a5c+l
         T+T9VcGwQGkOsVeyqqcFOdpSy7FTSjlq6zJMH39qCslLX05iJqtLvtCekhr85+YjZU3Q
         mY8lX8VUfk8l+z37c+OMtnVi/VdXUVL9PCefk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPMj8VLwTy75eprkO41oC3JgAE7NDa67ow6tA6A6/r0=;
        b=kSjHTgx5UGWqMn0fANYZA985POYriaGX9mV2RJMnDqOU4l8h2uTUKQygq8xFgpT6Gi
         P0nE4P7qeRwjFtnqTZPS0KtdhWfEI1sXg4glDYTdtICxySqoNGzN/keGZgxzC92n28f5
         i/O2abXPeGMOg6tEg9/eCWpzBMaT26ntXwKZ8b17P6NJWdXcRxddOu92GfvIZst4BlXy
         wBcPWN1p1VLiUB8G+o8ta985SoyS/gLJyAzBdZQbvNVvpmQcz+Ib02Ze2BBXZadSpwVf
         7VBdCA+wNSCFSm1Sl3oJRA5T9iPJ0x+6lxz5JutfwE73pLypy6MxbX8q87mPBY6YZXie
         n0aw==
X-Gm-Message-State: AOAM530lU8FV/dBGJknV+utqeBCeaHKcgBJK3un6nVcdw6JSoGc1GtTj
        ts1n4hJqLJMkCbbQEB0m2A0NWUtmmXfD4MEP0Ps=
X-Google-Smtp-Source: ABdhPJwpqt2ShUZR15Mqp/pibS0ZlpnXi1yMr5Ctoj/KpCt6SVYtubmY9wlBy4qbSKOGOQ4N0p7RfQ==
X-Received: by 2002:a2e:b44f:: with SMTP id o15mr15379029ljm.430.1631986126655;
        Sat, 18 Sep 2021 10:28:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m10sm819653lfr.272.2021.09.18.10.28.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 10:28:44 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i25so47533253lfg.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:28:44 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr7711431ljb.95.1631986124170;
 Sat, 18 Sep 2021 10:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210918095134.GA5001@tower> <202109181311.18IDBKQB005215@valdese.nms.ulrich-teichert.org>
 <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
In-Reply-To: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 10:28:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixOnf0i1GwYqCT=ihx=QTfB248GOFu6SZQhd3w6mm3aA@mail.gmail.com>
Message-ID: <CAHk-=wixOnf0i1GwYqCT=ihx=QTfB248GOFu6SZQhd3w6mm3aA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     Michael Cree <mcree@orcon.net.nz>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
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

On Sat, Sep 18, 2021 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do not see why you should be using that horrible __EXERN_INLINE. It
> will cause gcc to sometimes not inline at all, and not generate the
> out-of-line body either.

Yeah, that patch doesn't work at all with my cross-compiler, and only results in

  alpha-linux-gnu-ld: arch/alpha/kernel/sys_jensen.o:(.ref.data+0x58):
undefined reference to `jensen_ioread8'

because some of those 'extern inline' cases are never instantiated.

I'll look into it, we can make Jensen build again in case somebody
then gets the energy to see what causes it to not boot.

              Linus
