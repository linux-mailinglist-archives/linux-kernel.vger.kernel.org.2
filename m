Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C403FE119
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhIARZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhIARZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:25:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE4C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 10:24:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y34so485951lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYSskR1qeRze9m2i9qdO3oEtLqePzdlT8/5OwPr7ipE=;
        b=USxu9L1bhF7jMLXIxHLM75peGmrT6vCWPVCsIEvdUlFz0JcMEEocWtOcBR0v1JBKO5
         KCcsomHYd7LgwU8owuOqjW3N6TZrP8kiykgsZDSxatF+N3gqNhPh99DqwD+iiEyBDZfr
         7IG0D+U9NO8Nt/wwlAVsgMVbOcCP7YI4QOjII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYSskR1qeRze9m2i9qdO3oEtLqePzdlT8/5OwPr7ipE=;
        b=ukVBpkRabH5qYzX8JWOnZmLXCVOecIMwphW8UPZ2UmCwV8qVUtUGLX73BZlcwb7Muh
         OStJiOAgoixR30OpRag2XFxMG6VlTR+HCQT6JtoKkKmv2EiSi4sSaFsdc6CVZpJASUH/
         fq18z6ssV4musFIMKyzYbcCcg6j18miMZ+5jSoE/kf0g/GXZOnEYPW150KXj0xivmnfn
         W5xxtA4cNCzZ6s3RR0MKfV1dY1WBhrmr3nPg9w2LfiJtb5LnEmaAXTVly3x1kIej3Mln
         gO9HBBM71TX5P45zOKzJNv3i3/V5aBsP50WKGuWyzCWpUvzjs7Vi2Bg+g9ZRieIeLrCY
         q07Q==
X-Gm-Message-State: AOAM531zozw2bFhGzoLYDUeE3NVaZHbrhBzSC5NzV8f7JGdETUhELApb
        sY9BowPsjSmuu9LrS298OdSMpjcxIdt2dJfH
X-Google-Smtp-Source: ABdhPJxKTjNrcqb8szWiTdH3KT0pNve/Sb1xqM2k5v4p7l6zrSdJ/7tqYz30Uswy6UcbsaOwSkjT2Q==
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr441559lfu.280.1630517090638;
        Wed, 01 Sep 2021 10:24:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c11sm10652lfb.76.2021.09.01.10.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 10:24:49 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f2so329658ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:24:48 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr634325ljh.61.1630517088465;
 Wed, 01 Sep 2021 10:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com> <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
In-Reply-To: <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Sep 2021 10:24:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
Message-ID: <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 9:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What do you mean, per-node page cache?  Multiple pages for the same
> area of file?  That'd be bloody awful on coherency...

You absolutely don't want to actually duplicate it in the cache.

But what you could do, if  you wanted to, would be to catch the
situation where you have lots of expensive NUMA accesses either using
our VM infrastructure or performance counters, and when the mapping is
a MAP_PRIVATE you just do a COW fault on them.

Honestly, I suspect it only makes sense when you have already bound
your process to one particular NUMA node.

Sounds entirely doable, and has absolutely nothing to do with the page
cache. It would literally just be an "over-eager COW fault triggered
by NUMA access counters".

             Linus
