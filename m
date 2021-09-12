Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF6407FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhILTOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhILTOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:14:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD44C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:13:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l11so16308307lfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzZRty5syTefvslqvSNH1KyI4p4ePIHehKrpq3jNHak=;
        b=UhV7ZB03lfxtT+Ye8FzC9W6hmCQoAxoCGQimJcLY7prrx8mbKe9DIiT4SGaXesQFeB
         bwrVZJdZaPGgx4eSKLVt3nOkqcznQcyPpP9BRmCWBP8k038tMJltDQ1VrUpAU3aNMwNA
         gTOxiP2LUi8KOIoIT19q3qZx861ljKejcehZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzZRty5syTefvslqvSNH1KyI4p4ePIHehKrpq3jNHak=;
        b=avIW/j3Q4FE3pRL/0sEI9UjjakCQKZGFs/b8QWJ2hRfkD9csm7+8LjM97i1XnxtMK8
         9fYulubmwy0en2IFiVXd40SKN4K5Uo1nYMwxs1hur9Ub27wDUmiwf0Gv4EhtDItu8cPT
         gl1qMnxwHe/l4yIvMoVdklrshEcq277+tYTm/C625Yvg6H7zqaSTn1dzoOKOuTlF0Mu0
         PxGLUnR7tGPTiu7TL+fld0M4Gwyt1w+KatbmXcSDdnvL4hDqsfrshgMFNbXfA807o6zF
         b59fYvKp0AiD8dvob5meHQX48zE6p0W6ZI97tV7GO9Zb+Ofj1J1PzWT5oY/044SC1wlq
         15Yw==
X-Gm-Message-State: AOAM533e9ZNyGt4zVAE8nyiZUpFAhvQeCPZVyn2eWvfjNdPmcDOdHUEu
        e+cpYMtlgppzHFdkm+T1SyrT9mENR+rx6x6isYE=
X-Google-Smtp-Source: ABdhPJxLdYVle4q1IHWO6sU9OYTvOJh9MYl1+KeJMxzPTvrPthnYaMD1P2uU7zF3VnSFPWS2C9+JvA==
X-Received: by 2002:a05:6512:2345:: with SMTP id p5mr6233595lfu.340.1631474011527;
        Sun, 12 Sep 2021 12:13:31 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z2sm592900lfh.161.2021.09.12.12.13.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:13:28 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id k4so16247658lfj.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:13:27 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr6351605lfv.655.1631474006987;
 Sun, 12 Sep 2021 12:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210912160149.2227137-1-linux@roeck-us.net> <20210912160149.2227137-5-linux@roeck-us.net>
In-Reply-To: <20210912160149.2227137-5-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:13:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1=8shingNuo1CtfJ7eDByDsmwsz750Nbxq=7q0Gs+zg@mail.gmail.com>
Message-ID: <CAHk-=wi1=8shingNuo1CtfJ7eDByDsmwsz750Nbxq=7q0Gs+zg@mail.gmail.com>
Subject: Re: [PATCH 4/4] alpha: Use absolute_pointer for strcmp on fixed
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
> -       if (strcmp(COMMAND_LINE, "INSTALL") == 0) {
> +       if (strcmp(absolute_pointer(COMMAND_LINE), "INSTALL") == 0) {

Again, this feels very much like treating the symptoms, not actually
fixing the real issue.

It's COMMAND_LINE itself that should have been fixed up, not that one use of it.

Because the only reason you didn't get a warning from later uses is
that 'strcmp()' is doing compiler-specific magic. You're just delaying
the inevitable warnings about the other uses of that thing.

            Linus
