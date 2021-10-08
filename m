Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95574426D86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbhJHPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbhJHPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:33:38 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44DC061764
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:31:43 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id v4so10940190vsg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfDWQNp2UL5+jS6p6MxQkSeoBswEyDZEW6ZvRWiqAYE=;
        b=FG4nizPJKDttHDSuuLn3c6p8Myl+TE1ZajoLc02DiK82T5KiV2nzbAt9Lv37fLIA8x
         jKWygR3yU4GfALjLvhn9RMbmj/MaEHuxJgQEoSfc5lYuqIkrvBvRubGjJHE63lSnPr1B
         QTFecQ9I+HD1MPhI5wHPc4d0fh3EkJfZl/pqaQT9QiF3n1eJoI8wIO0hbET6LovqlLUG
         idSGGFCcJz6UCgWODWsu5YjmH08T+PLc0TXKMwKEPjR5fsPatYxvLH8cm6U75QRAx9xo
         x0+OJbzzXys4T0ZoXT5HVbErDYC6s1LvqGnsBCkjOLwX9Ue7hn4MVNOPWPtT9ip/m4Ds
         EZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfDWQNp2UL5+jS6p6MxQkSeoBswEyDZEW6ZvRWiqAYE=;
        b=7Z2i8NvTGo80MhM/lmBE67LifaDF3MSNQ3FMsnZUg65/NQFE+2xJkSZf2+BowEyNxt
         9M6aOkPk1b8ySeDl5GGFrnI+fcu5nTUFLpnBg2m/yN52uykGrAmLHUwuqngKpJ/Z7BNg
         eCT0Cf/yZXM81mYvAu9ihGITkWfo1h/W1FoX1BBCccnw+jCKyOkVDYwiJYag0+JPS4ox
         vpDbT/hzkIWc7kNUM9Mi7Mwa5UpPUtbvTYdAKJRa/o5FMUEWODj6hg402YyrYIPjDh/8
         3dDkFAvPxWyY8MsKTfexnfnoFxDox0Or8aagjR3e9adicVKXf/IKE/uQvKjCVjgV5TBy
         OXng==
X-Gm-Message-State: AOAM530+31+gI3GIFHyHGf4tEFykG7YvwCl1EQ9r2KZqWurW2ThRsmEf
        GxMw/QF7c7GdKu7hwfc5B/LyKpynaiVJLHk9NlZ9DQ==
X-Google-Smtp-Source: ABdhPJyvkGFu2hMnsDq29OMlmBSQiVg7L1kDuYFftacecAIHtbfGGV1GkOkzVRQpb7mW2uyOr4/ZNuPmO90t1XUAn1k=
X-Received: by 2002:a67:d91b:: with SMTP id t27mr11899992vsj.55.1633707102322;
 Fri, 08 Oct 2021 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211007194113.10507-1-semen.protsenko@linaro.org>
 <20211007194113.10507-4-semen.protsenko@linaro.org> <abe4bdeb-ee15-d8c8-54af-1cdf7282b004@canonical.com>
In-Reply-To: <abe4bdeb-ee15-d8c8-54af-1cdf7282b004@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 8 Oct 2021 18:31:30 +0300
Message-ID: <CAPLW+4mM978QS8ce9ipnhAPc0ge2H8+ZZ5bsc=7Ryq4-yL8NQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: Add bindings definitions for
 Exynos850 CMU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 at 09:45, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 07/10/2021 21:41, Sam Protsenko wrote:
> > Clock controller driver is designed to have separate instances for each
> > particular CMU. So clock IDs in this bindings header also start from 1
> > for each CMU.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes in v2:
> >   - Added all clock ids
> >   - Added CLK_ prefix for all clock constants
> >   - Added R-b tag by Krzysztof Kozlowski
> >   - Added Ack tag by Rob Herring
> >
> >  include/dt-bindings/clock/exynos850.h | 141 ++++++++++++++++++++++++++
> >  1 file changed, 141 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/exynos850.h
> >
> > diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
> > new file mode 100644
> > index 000000000000..a44c5f91d3c7
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/exynos850.h
> > @@ -0,0 +1,141 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
>
> The bindings are preferred to be under GPL-2.0+BSD. I don't know about
> such policy for the headers but it seems reasonable - allows re-usage in
> other systems. Do you mind licensing it under:
> GPL-2.0-only or BSD-2-Clause
> ?
>

Sure, will do in v3.

> Best regards,
> Krzysztof
>
> > +/*
> > + * Copyright (C) 2021 Linaro Ltd.
> > + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> > + *
> > + * Device Tree binding constants for Exynos850 clock controller.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLOCK_EXYNOS_850_H
> > +#define _DT_BINDINGS_CLOCK_EXYNOS_850_H
> > +
> > +/* CMU_TOP */
