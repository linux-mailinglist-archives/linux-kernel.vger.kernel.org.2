Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8E30B066
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBATd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBATdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:33:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D6C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:32:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i187so24433211lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwv3A3bSAAqY2wCAqqrB5nV+HQVHfwBw6+UsuhpSUq8=;
        b=G5S/Dgal7HfdGnSG6SXEgiDdPQZpL7d6sxZU5vSTKcrz5SG3Vkd1+T8LCywp7pDMQQ
         mB4bD3LmgpPCneKJZmgvxxUqZH3E07tAUqXpmaC9yo4ArxGnnCAs6hXbgpHnHMxPlmzG
         4Cram0LsRP+Czba7W0OFxbOwKKpvGrBkOeOiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwv3A3bSAAqY2wCAqqrB5nV+HQVHfwBw6+UsuhpSUq8=;
        b=Tyol8BlwZpfqRBEQdP6iRb0m/xewaUb0/KtqYFdwsRjbwj6PJCi2kyJTOMtZ/p/4p2
         W0z2ANNJ1StrPk7aD2jChMWkhHa1ap28VKGedn08OUvy4zV492Hybff4vgqSZuKfnw2o
         Q3d8WxCkMrvEe4+LgdqY+ywTo1dBhq+VCQHDOCUD0KTHEf7Z3UAobaTHKxD5zhoywBOA
         vLWbn07k2KTCokhXJyARhWyucm4rqaaEyhHmsNFYp2Xccf7iVqbXC+6uks4lBfg64g4+
         500stcBxi/17ALFfJW7Ta/SA48U0B+/jxhI0ipkNTPCjIDWiLdCpqyuMke4Mv9Ztcnzr
         b10Q==
X-Gm-Message-State: AOAM533rQKuOru6zXuFGNIg5pWxgufbpBGbzRNUHelxwLY52DL9Vu1Vt
        cPdGkqGrJ64jVQnO8epUG9h8E6jWzBhOXQ==
X-Google-Smtp-Source: ABdhPJyhiln/TmtJHAgcLAT5SYXZ2ohI8DEzt9QFYLpnydN6iTvTsmu/HztwhLthYAl4kt3VO7VlJA==
X-Received: by 2002:a19:7ecf:: with SMTP id z198mr8813995lfc.650.1612207960873;
        Mon, 01 Feb 2021 11:32:40 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d23sm3080258lfn.229.2021.02.01.11.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:32:39 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m22so24429840lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:32:38 -0800 (PST)
X-Received: by 2002:a19:8186:: with SMTP id c128mr3292880lfd.377.1612207958309;
 Mon, 01 Feb 2021 11:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20201206214613.444124194@linutronix.de> <20201206220541.594826678@linutronix.de>
 <19a7753c-c492-42e4-241a-8a052b32bb63@digikod.net> <871re7hlsg.fsf@nanos.tec.linutronix.de>
 <98cb59e8-ecb4-e29d-0b8f-73683ef2bee7@digikod.net> <87y2gfg18p.fsf@nanos.tec.linutronix.de>
 <87tur3fx7w.fsf@nanos.tec.linutronix.de> <ghft2hwevu.fsf@gouders.net>
 <877dnrc2sv.fsf@depni.sinp.msu.ru> <8735yfd2q4.fsf@nanos.tec.linutronix.de> <87zh0nbnha.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zh0nbnha.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Feb 2021 11:32:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_-_FP+B6ePabvj55_ok1YbYCsGHzYsZ064FpE4RqkTQ@mail.gmail.com>
Message-ID: <CAHk-=wg_-_FP+B6ePabvj55_ok1YbYCsGHzYsZ064FpE4RqkTQ@mail.gmail.com>
Subject: Re: [PATCH V2] rtc: mc146818: Dont test for bit 0-5 in Register D
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Dirk Gouders <dirk@gouders.net>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 11:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> While it cures the problem on the reporters machine it breaks machines
> with Intel chipsets which use bit 0-5 of the D register. So check only
> for bit 6 being 0 which is the case on these Intel machines as well.

This looks fine, but it might also be worth it simply just checking
for the only really special value: 0xff, and going "ok, that looks
like missing hardware".

That's what a few other drivers historically do in their probing
routines, so it's not unheard of (ie you can find drivers doing that
kind of

        /* If we read 0xff from the LSR, there is no UART here. */
        if (inb(.. port ..) == 0xff)

in their init routines.

Not a big deal either way, I just think it would be more in like with
what other places do in similar situations

      Linus
