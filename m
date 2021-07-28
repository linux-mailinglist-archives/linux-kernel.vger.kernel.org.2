Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3233F3D8A79
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhG1JT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhG1JTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:19:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:19:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so1887720plh.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8tz0lmFVcXyPsYMxnRVzzQrkyomXcwXgEWm5HC4cJw=;
        b=EQ29uUAsK6hRusefMY6zPuXHY3mMarlsE3NWmYOCPiNaZpdYC9VMPIt4vmqAilHvy2
         azNvc42lRl89dGDfv6j6M5MU0sWupsbFrnd1ZkDiEM1Vtatppus5qzejTdwgOlhQPucz
         l8bDdC0E1xJD/jUc8/3rt2NQa7FMs/M5SNw6Ldk6kiFmKExyjKrT6cRtb1dNyWwB1Gp9
         EsuRTDTC/x0orCnw3azi55noXdEJLg8QJv/QzkBh9WAyCj+gX1OL0ayKlLqN0hflKYsO
         tSpZnjul/CVCtVBlHKk9pnBHqGUO8HtCm+PI2H5JHQKBsQrGoGdzxTsDRJgkb04o/8jH
         l96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8tz0lmFVcXyPsYMxnRVzzQrkyomXcwXgEWm5HC4cJw=;
        b=GlPcNnXAmtZAjXBRPd29sDnNDzHOt0DenucoseSvwMUlSI9SZAAPuWVNksylonxKiZ
         LLYkMFKLeX12FPTGNVFIotHg2cW7GohvhdQrN/42JxB9NyDewYHvp08StWYzD2Rd2sqR
         SuVPswenJe1abpKtpXFTiMGWU2luJoLLRT+v5WNt0PW53BImIVzpizb1L4N7TuN4lVE4
         KoVQ9OfYPWD69X7pCfmSuRXTWKgYFgD+NZYo+GwWTt5x46fBJiOlNirTBzMKNHimvwC8
         7OpGYdTBmuzLA0qZNItCFnqulUTmdh4bOw7aWKoKSjHOmttL2AcwFVRMuK1OevoIQt8N
         zp9w==
X-Gm-Message-State: AOAM532Yybuymgnsva0eZqknBEIpZehggBOtHprC9F+rPsE5/9czhWvm
        oBikRJViRalqmosyrDDBUic/f/BLltnndg92NRc=
X-Google-Smtp-Source: ABdhPJyQKC910g0YX3/l36BFlz2IaIUSElq7FkB0H+dcUDbUqKbEWW8unMdR1YLLSsgwA7ULsm8u7e2zjtu8U4CIgFs=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr28417501pgg.4.1627463962184;
 Wed, 28 Jul 2021 02:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210727094441.9815-1-andrea.merello@gmail.com>
 <YP/ymvrd1zV7z6rF@smile.fi.intel.com> <YQAlmBEGIaChYgeW@yury-ThinkPad> <CAN8YU5PD9i=qztMLyuFsMQFf80pz04dLOSQ0NJ9=uHb1bTh52w@mail.gmail.com>
In-Reply-To: <CAN8YU5PD9i=qztMLyuFsMQFf80pz04dLOSQ0NJ9=uHb1bTh52w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jul 2021 12:18:46 +0300
Message-ID: <CAHp75VdL9du5QRvi9Jz7kjPDrNwqCtH8-1qXsVbKD_BuKM01uA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bitmap.h: add const modifier to
 bitmap_next_[set/clear]_region() argument
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 9:39 AM Andrea Merello <andrea.merello@gmail.com> wrote:
> Il giorno mar 27 lug 2021 alle ore 17:26 Yury Norov
> <yury.norov@gmail.com> ha scritto:
> > On Tue, Jul 27, 2021 at 02:48:42PM +0300, Andy Shevchenko wrote:

...

> > I try to remove those two because in practice they bring more mess
> > than good. All real use-cases for bitmap_next_{set,clear}_region
> > relate to iterating the whole bitmap, ie nobody just wants to find a
> > next region. Untill recently there was only a single user of the API,
> > so I easily reworked the code to use find_first_bit/find_next bit and
> > by chance return faster.
>
> Ah, that's interesting to know: I'm working on a new driver that used
> find_next_zero_bit() and find_next_bit() [0]; Andy told me that my
> algorithm could be rewritten exploiting some bitmap_* helpers, so I
> rewrote my code using bitmap_for_each_set_region(), which in turn uses
> bitmap_next_set_region().
>
> Should I revert to my previous implementation that uses
> find_next_zero_bit() and find_next_bit() ?

According to the

https://github.com/norov/linux/commit/a2d6e02d19450a49a55f08c151d1f704723bec1a

they are transformed to for_each_bitrange(), etc.

...

> Looks like also bitmap_for_each_set_region() went away indeed ?

See above.

-- 
With Best Regards,
Andy Shevchenko
