Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4CA45A3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhKWNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhKWNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:32:11 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:29:03 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id p2so43671792uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sXFNEr7bt67n8VDV4U18M9iV94NtVvGwfpDSHWxuDDc=;
        b=VIuHbVCbHKgc+4BML7WAxDuy3yk9WBLcCtvyQW75aO+glesRe1Erv+3Mt9vObWlRbK
         /6y6H9R9FOJv/ezPXiokzKXB7ptnlb21/uy4Hh9BZo/jH4DcOl38pYDL63AUDIou/j/o
         tyHBDdUbkF46SlYgtRxfA2zV0BI6HfI1j5iLPihbJpx5kyvkd+/AlwFsdVG5GNbnKQdt
         nFX75TsSEtZqSQKJKytclkpORI2vZnhLVlbB14VxxBCTesd6YgHdnrrDVcbuiFKascWo
         WAPY7Gw+4UqhsYScbc+Hisu6NHuJ1jK05YKmGswLK2U4OcmYPObydMZ4UDnot4QA2t+E
         R+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sXFNEr7bt67n8VDV4U18M9iV94NtVvGwfpDSHWxuDDc=;
        b=xQw3QY/Ae2zGq28NrY3oroKqdvE6DZ7J0x08QJMP7qfFEw2DEaqg529O3I3enx5jzc
         cg1FSaTCrW/aVJ8LHaxJKC/S6hZg4dvTSJjX3yxaWiWJxK0vBX1vymLpDWwUNAJgy/mP
         1mT18x3YeLMKh9Df8X1TqTLq5Ox3h6dUILPvkpajyI8+HtFXOhMsbXc+Vwn67+wd9vcT
         nF9GgH5f05Xa72EQVAa5zwQv4MSoSgkTIAxJxSoqpKLftEctsJ7N9KS2s2XkK8l40fH/
         d2hsqsgqjOPRiQP3oqNsLhRANDE1R+N1lu28EOhpsShwMcTaJ/9ze5HWgCWmtAd8pe+M
         hA0Q==
X-Gm-Message-State: AOAM5334eH0GF7icPrqxHS64+kfUktFiq6pTEW93MXQTLMYhTxxN2z80
        f/2XqPZlRELOzJKxIxlc41pzIyJ23BIJHXgWK9YGww==
X-Google-Smtp-Source: ABdhPJyniR7xoa91LB2UyWWzz1h/PRN2VNMVG4SXjDejgjUpZoSu7WMj43cIgMMaAh9ZTURRCTlyPw2GoMwNx8aKWy0=
X-Received: by 2002:a05:6102:4192:: with SMTP id cd18mr9063225vsb.35.1637674142289;
 Tue, 23 Nov 2021 05:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20211101193531.15078-1-semen.protsenko@linaro.org>
 <20211101193531.15078-2-semen.protsenko@linaro.org> <f7dd62c9-9c4d-4130-58ee-54ec2b7729f9@linaro.org>
In-Reply-To: <f7dd62c9-9c4d-4130-58ee-54ec2b7729f9@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 23 Nov 2021 15:28:50 +0200
Message-ID: <CAPLW+4=+_oHGsjo=k3AJXAmeH+dqQoknZVAsO6Fhex2gvJFq2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] clocksource: exynos_mct: Refactor resources allocation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 18:00, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 01/11/2021 20:35, Sam Protsenko wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Move interrupts allocation from exynos4_timer_resources() into separate
> > function together with the interrupt number parsing code from
> > mct_init_dt(), so the code for managing interrupts is kept together.
> > While touching exynos4_timer_resources() function, move of_iomap() to i=
t.
> > No functional changes.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
>
> Applied, thx
>

Hi Daniel,

Can you please let me know the URL for your tree where you applied
this one? I checked [1] and linux-next, but this patch seems nowhere
to be found.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux.gi=
t/

Thanks!

> [ ... ]
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
