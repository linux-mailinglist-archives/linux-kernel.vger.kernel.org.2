Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA105389FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhETITv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:19:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 01:18:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g18so10140050pfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKI5XksRj1pGQlOxnEMxlDuSukieqpSNRup0Wv06N+E=;
        b=tMRd+yy7HTeqadl9J7L3AKuL71n0YnAbZsYwR0lxSKh0TihCpNujoSDhQ/XQYbjB3Y
         ewDuJonMRbHcJflEcXhG5PT7NQ4DV45oivO1FtrDnP/gZBgxXx4n92A37gk1gGSBFw46
         8IyIMVC+XTN+N2YyHtst2wXE7bbWFHpMUvjeBrfRiatEXhq2x2uUr8vKu/YwkIJ75zaf
         SJz5da7g6NICPOW666b3D3dlbgiillWw5XQlpMwi6q6UHz463Tcgsa7LTEWWssbBVDY5
         mYKoO5HDm1PDK9eYaCIk0Rg1UKWxmIi9YVm4NjavwY0Nnxbj2zBXsAOGf5IEgt/GybUc
         Okpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKI5XksRj1pGQlOxnEMxlDuSukieqpSNRup0Wv06N+E=;
        b=P5qD3MBdz9Ih7iYys+HeT588iFzvNB+rdTwphjgs3BMn3okZkEgowcDYJZKknT5eyy
         4rcnPAe1a5dUO8GJIA8vgg/SnnoHj5hjYzJPatpv3AjIDI1erNbq35bDsFrwM8AAV9Wx
         F/3VSttBQ84x3cG/uu2qJx8dC+VTCfD+X9q9EOjGophxlerit46/yixorwwQtUyqWa2c
         FRn/Tu5u4wOoLLdtkWxEOy3Vr1RW91d6VpbUq+Ec3nO2XnAbkl2+lmXBLOuoWCA2AB2r
         Vy4r8tz4hRSvV+QuFntVwJkD0EDmgGm1nMA4J/UYNhD6y6I2eX8z3D2TD/3wNyt1nSHd
         fijw==
X-Gm-Message-State: AOAM530jrkENIEF1bsf3DoK5lRDfYFqgoKEmzafpHPQWQzg55e4qrTCd
        6ANA7xzDYGStL1PiD2kXPYIFxdYwfd+cmY1DnfQ=
X-Google-Smtp-Source: ABdhPJyetpUWK0Mv5NNi94SFKVjfEE3tf7q63EaUNWPIAXperToAH+OOV5t5wYCneU4jQ8jMEcQazuOLQNbnNsa5W/A=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr3408662pgc.203.1621498708351;
 Thu, 20 May 2021 01:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com> <CACRpkdb30HKOobtP++PqWc7UwM8qV4JC=UPAmUjUgFN_JANa+g@mail.gmail.com>
In-Reply-To: <CACRpkdb30HKOobtP++PqWc7UwM8qV4JC=UPAmUjUgFN_JANa+g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 May 2021 11:18:11 +0300
Message-ID: <CAHp75Vc1qU0sBbLOZdTgjJ_pfN73Utg4wtRV8Ohu-OiaeJuycg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: Drop ARCH_NR_GPIOS definition
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 10, 2021 at 1:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > The conditional by the generic header is the same,
> > hence drop unnecessary duplication.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I think this should go into Russell's patch tracker for convenience,
> if you're not familiar with it I can sign it off and put it in there,
> just tell me.

Nope, I'm not. Please do, thanks!

Since he kept silent I suppose it means an agreement on the change.
It's quite straightforward and can be tested easily.

-- 
With Best Regards,
Andy Shevchenko
