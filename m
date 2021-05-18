Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6732B388233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352506AbhERVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352489AbhERVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:37:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC1C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:36:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w4so13164817ljw.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dn4EVgYJrZEh+NwmIsnwQyOdHzd0yPpGagCfbDkwtqA=;
        b=X0U/cWNHtr9rj18Ej6uRpSwMq9LAHrLwzRrt8j/1xbDDR3dC6q7f2BOTa7z06ry3vm
         zwoG7M3aOaXMrIxlPbLasgkIMRg/PI1A+Y+EqZmeTYuoeu8tvk9BJU7Pr/BM2NfzZBIz
         Myayrc2FepSptqNzp+HBnDzeek6r5xIk54DOvDeBARwJ4C9ixlkCXhDq3e+KjdrKr1Qx
         yLtrUgL/tSzUhh/pytENftLVRcYGI7BaMSq7zPh2WOw76vl83zo3FZ5dMQEpkehaGTeE
         txeRQlOs8FFEDhMX5xEQ4Z5SXxKQf77eCj24jNyG1DdYCMVU67lKpSbAO98GvYRUI8hs
         CmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dn4EVgYJrZEh+NwmIsnwQyOdHzd0yPpGagCfbDkwtqA=;
        b=oWy38Ro/OyA1vIsqwDMdrhyc/ONfyrmDZrLExDvQrlQkHoghfAKdQtukRjIc1wHl3Q
         RmXuUCEpH84bulk8+fRGB0ri6WvuUKvVo0jIUGgU2JXFnx8CefxJ1UlFDPGXJZWYS0lq
         7AW7tIyDEXVIcFqW1pWN8JLNB9YndPkZLBmO8LgBWdfjdod4JZd+EJo177BBXnFaRHoj
         B2QsDQP3wcIR9PTIa0Qbbn8NeGKb3CsU0wsrLSdLt3wioo5Xmt9VE4os2pQZH6ty/Mja
         P5+A7ZLCp1/opVyuSCaPvhrGBiiWDPkE0/mTkbXwfYLBFFKwdBPfxKgT/GbLHr0qEc14
         PerA==
X-Gm-Message-State: AOAM533E3V5JCakxPosELr4tSluxVzL7dJ4XcJFU40IkPzJSJCRIA2RG
        kynFvw1HgmVLygPdjlEdy1TM/dJxCHq7utY4uFJ43A==
X-Google-Smtp-Source: ABdhPJxiiYCLgo6v1wkmf1ffz+9LT1EFC2e9HHWQhseZrXKs2+leqMj7P7SZn6RRYUWehbP2Y/PLl9VwzWnfzUL542U=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr5685489ljg.368.1621373773064;
 Tue, 18 May 2021 14:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210505202618.2663889-1-clabbe@baylibre.com> <CACRpkdbR9mt-X-Dt9uR9vGtg_EDJCk3H5Umuh2eUX-PGZ7VBfQ@mail.gmail.com>
 <20210518011930.nywtcgualmsrx35v@gondor.apana.org.au>
In-Reply-To: <20210518011930.nywtcgualmsrx35v@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:36:01 +0200
Message-ID: <CACRpkdbi+1tVL04HQ5Uufpw3-ORp3W4Cs1AyHrjQwJ149T8MMQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] crypto: start to fix ixp4xx
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Corentin Labbe <clabbe@baylibre.com>, chohnstaedt@innominate.com,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 3:19 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, May 18, 2021 at 01:53:56AM +0200, Linus Walleij wrote:
> > On Wed, May 5, 2021 at 10:26 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> >
> > > Loading the ixp4xx crypto driver exhibits lots of error.
> > > All algorithm fail selftests with different reasons.
> > > This series start to fixes some of thoses problem.
> >
> > Excellent! Thanks for taking over this Corentin!!
> > FWIW:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > If I merge my 3 additional patches through ARM SoC
> > will it work out or do I need to think about some clever
> > merging strategy?
>
> Well if your patches don't touch the drivers/crypto then there
> shouldn't be any conflicts.

Sadly they do, it's these:
https://lore.kernel.org/linux-crypto/20210510213634.600866-1-linus.walleij@linaro.org/
https://lore.kernel.org/linux-crypto/20210510213634.600866-2-linus.walleij@linaro.org/
https://lore.kernel.org/linux-crypto/20210510213634.600866-3-linus.walleij@linaro.org/

I guess we could turn it around: I see if I can apply these two
on top of the crypto tree and resend then we hope there is no
collision in the ARM SoC tree instead.

I need to respin the series anyway so shall we try this?

Yours,
Linus Walleij
