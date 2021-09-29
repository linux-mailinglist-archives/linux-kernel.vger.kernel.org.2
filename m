Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6441BD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbhI2DoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhI2DoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:44:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58238C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:42:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b15so4903634lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuNTL9gPvpWYsW3AwxYryKONOf4+S+yGJL4QxUsihbA=;
        b=h7mvpzImaXE2WV7qwWKc2k5Jqj0LIXIZYtDyLIOOa7f0MYkXYYneJn5QWbqPgwBQxQ
         bSiclPOqlt57iy3gVD8Q6aXV0R3mZs0DU421XL+PEBe9/UyURCMtA4Ux2VfU9AjuLnuL
         dvu5KRMi2MZPbyVWgjqy7XGMiLfXKLHVOQCphKRcU7Ipe18W7J9z3+vFpTPPBhKWFTmA
         aDB1WUxmKCqha1Paw/WytXLKfSPjuU772NfZv7P3hzhteJ6iJdoVt8abA9dBiQbFEnLL
         LgFksSFjwAXKFOE0aYOBuX79a/qG7kTJsQvDZpmvm0CqetzfQXBXBg0vZ8lVKqL+xK+V
         9V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuNTL9gPvpWYsW3AwxYryKONOf4+S+yGJL4QxUsihbA=;
        b=40jkQfyfC8fXm/5nowwVtf+oBs8aGmEQ6VG0KSprHaR45Jdxovc2Ce3P03GlJhY7cQ
         JCeX4pXiuz5BQx1jRbBXrfNigckko++cM3T4ZWM34wPElxEIdZDRhhZxdpZxX+Xwgftn
         o3eX4SLkZv2Yy8BW/ATzu7yd8lLBE0D8aswxxwwScNXyR49PdHjZug00k2tCdgmI/mVL
         /0dEiqqU4tjkKfRxAHEf7bpbipCngBjq7xxNrUADr0M24hwTkYdT+irjxvzfGzcjoe4L
         INO0pR60Tu6brMAYOuviohWws0cGPNoFGCqJVObuY56XuYlDSqd7agKC47a2HeeWXas6
         1pmA==
X-Gm-Message-State: AOAM5328j5Uf8IeDZRplhQoCFiTYFFOpQM/IFJaTAFVmHH/eAL2OoE9I
        lIlHmK4v4PUMd+w5tlest7PiMj8AQwjooZcyulslIA==
X-Google-Smtp-Source: ABdhPJwflCbRIz99ZM3n81OZD0bcobRt+9ytyfnyFvFexD+UThys3zwr5ilEDOM1PEC9Bhei1U3vyqJMMda+w4ALBr4=
X-Received: by 2002:a2e:83c5:: with SMTP id s5mr3615270ljh.515.1632886958477;
 Tue, 28 Sep 2021 20:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235635.1348330-1-willmcvicker@google.com> <20210928235635.1348330-3-willmcvicker@google.com>
In-Reply-To: <20210928235635.1348330-3-willmcvicker@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 28 Sep 2021 20:42:27 -0700
Message-ID: <CALAqxLUju1Bw0dDpi_oK6-eOiP6B2Xm1MV19G53WaRFm3Z_AWw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] timekeeping: add API for getting timekeeping_suspended
To:     Will McVicker <willmcvicker@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 4:56 PM Will McVicker <willmcvicker@google.com> wrote:
>
> This allows modules to access the value of timekeeping_suspended without
> giving them write access to the variable.
>

It's important to cover "the why" not "the what" in these commit
messages, so you might add a note as to what code will be the user of
this (the samsung/clk-pll.c code changed later in this series).

thanks
-john
