Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29E3B0F39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFVVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFVVHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:07:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64886C061574;
        Tue, 22 Jun 2021 14:05:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id he7so458412ejc.13;
        Tue, 22 Jun 2021 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUc+wnGu+qMMod+izmu7YMTZnrpqEfnlG0hnSla1RfI=;
        b=MhqOn4tLoi01in/oJrMFsXHKfK91kconn54gNEDCGTEr+NqA/5XMsHzTB8B/YRC01f
         EUAJdfEFssAK3vB6ngsO4VzbFE0xn/4SA/xSaOs1s9ql4pP17uvZOqAdxUtbvNJ7eBJy
         cEKLv94QzwJYODppWCl4gbxuH8g4boCwlljHBJuvTvTEeZhi97ooK73FDtI5+l6VCBwe
         2FtW/p7rLb1EwMnKr6DLTl1U9aPcEGJDG7iXTayW6TWbGFJexCfI47aDX7j3vLr/IBKX
         7NJBYwoBchWmz/NJ5q2DLl0YPmiD6ZSg0hITOb6Ev1KAoU7djRN4oLYAy6cL3v3rLGYu
         +zrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUc+wnGu+qMMod+izmu7YMTZnrpqEfnlG0hnSla1RfI=;
        b=tktrx6MKyGv6THMnLKOBsrj1DNlPoFMqihSlL0fa9mYY/Bqw1oSWMDUbaa7+4PKb93
         ky38aubbxis/DFCkIiWia60ftb3vldAFIJjudZj9CO7F0j8t5erE7xXsZ/lu3qYspw4s
         Ov+JEya+by8IA3qrajJI4sLDajIgwGcBIq1Xq2WPzrWwcG0ol++cCMVKYRYNALlkOtte
         YE67WcXsixQbjDUKV6a3g84BSuoAr58YhCm9dwOkWOJPPemgZVAbmWNPaW4+rQizr0o6
         KJDRlFgIG5cVBdZaoVjGvRU+xAVxlgrZgdcv8s3YiAA2s95R2FPMFAHJ/cmjqU7lXdHn
         1zcg==
X-Gm-Message-State: AOAM533VUu/IGKc8MMudNa2Rdi4/Y+P/URT3VJKRgzaNBDlKh1PUzI7u
        R6pkivHhlfY99Bg/mJephS6NOcERDtAOOOtAO+A=
X-Google-Smtp-Source: ABdhPJwMewFnPfwv2MyXFnRt30omw+O65gF6+q13Lx/fCk9guSaZ8IKLEo+FvBPtL66HDFH7uMVWqojGhh/VRFlURTg=
X-Received: by 2002:a17:906:3102:: with SMTP id 2mr1711516ejx.208.1624395906020;
 Tue, 22 Jun 2021 14:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
 <CAFBinCDn_0TeyLG9b9uB+4-4PdeNXgja11wf2CGcQ99tUNjkyQ@mail.gmail.com> <1jr1heqhoy.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jr1heqhoy.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Jun 2021 23:04:55 +0200
Message-ID: <CAFBinCBpkci-BeqLSN+BNbrcAE9sLKM8Hs0BB09AM1GKmtU9_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
To:     Jerome Brunet <jbrunet@baylibre.com>, sboyd@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mturquette@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Jun 7, 2021 at 9:04 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Fri 04 Jun 2021 at 19:18, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Hi Jerome, Hi Stephen,
> >
> > On Mon, May 24, 2021 at 12:37 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> On the 32-bit Amlogic Meson8/8b/8m2 SoCs we run into a problem with the
> >> fast HDMI PLL and it's OD (post-dividers). This clock tree can run at
> >> up to approx. 3GHz.
> >> This however causes a problem, because these rates require BIT(31) to
> >> be usable. Unfortunately this is not the case with clk_ops.round_rate
> >> on 32-bit systems. BIT(31) is reserved for the sign (+ or -).
> >>
> >> clk_ops.determine_rate does not suffer from this limitation. It uses
> >> an int to signal any errors and can then take all availble 32 bits for
> >> the clock rate.
> >>
> >> Changes since v1 from [0]:
> >> - reworked the first patch so the the existing
> >>   divider_{ro_}round_rate_parent implementations are using the new
> >>   divider_{ro_}determine_rate implementations to avoid code duplication
> >>   (thanks Jerome for the suggestion)
> >> - added a patch to switch the default clk_divider_{ro_}ops to use
> >>   .determine_rate instead of .round_rate as suggested by Jerome
> >>   (thanks)
> >> - dropped a patch for the Meson PLL ops as these are independent from
> >>   the divider patches and Jerome has applied that one directly (thanks)
> >> - added Jerome's Reviewed-by to the meson clk-regmap patch (thanks!)
> >> - dropped the RFC prefix
> > please let me know what you think about this v2
> > I am asking because clk-divider is widely used, so I'd appreciate if
> > this gets some time in linux-next (so for example Kernel CI can test
> > this and report issues if there are any).
Do you have any comments on this series?
I am fine with it skipping 5.14 as it's a change which affects
multiple platforms.
So I would like to use the time until the trees are opening for
patches targeting 5.15 to iron out code-review comments.

> Looks good to me
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Thanks Jerome - I'll add it to v3 once I send it (assuming nothing
major changes)


Best regards,
Martin
