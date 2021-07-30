Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826FE3DBEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhG3TFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhG3TFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:05:15 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CFC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:05:09 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id d22so4375597uaw.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI7MSErWXqY8bqPMsLO7ItBW3m+DVtFHrgMs+xiZXJA=;
        b=bD1vPWsa2lKCLWxXOLT+1UnDwNSAZJwXtAOcVDw+V/e40KbH2sue31nkHNrjIfFRB/
         BslMGwza2qlB9k4lB4tO8GZi4lLygpVjJnrgAiTX9A7XBavBoVYpWz3C439RTw40hYb7
         73WS9zbvN0I0GTONPEJId0bIjO6Zedp5S1f6UUSWvz+fMoo07JM1RVxe7VoY2BjtChkG
         tINUW4cLZsSrQXDv/IC1J4t5H4sO1p60pLv1CLwlu7PZSlznBrwaq8HglsTegVI/57/i
         EWGSpjcw2sq4qEWxwTHVfSifkhwulE/3Tp9P4dX00x66yvod5f/3IpJCqOX4iPM3SVa+
         24Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI7MSErWXqY8bqPMsLO7ItBW3m+DVtFHrgMs+xiZXJA=;
        b=TiestjY/sU7ZoKnGIP/ooSKf5MZRRF0pRbgaqhxLjawZbYz2cluLL0bNeiMP9vPNZJ
         5dy5RaacR7Odlj/es7JEsE9Wt25Sc0ZIE1AlyyqQeTMw5CV3lfO7rAGXnqrdJ6dDY4H9
         yhhaMYGQ6bCNIxXFlut9NOrUHGIbEjFvLtGjDkNlp28Yath0VZJsrTRCNOcq2V8jeHfz
         HI0etE7jUcicUXfUT4A0QHBthD3zAjGlZUQpl3iVA0IMebSih6yxnjVo0vGHKve9jU3z
         CVgovFKo333yv8HXn1AyWGeAgEbnqE3RmR/4Df2fEJ2YJxbNNLm7raQDb94Bm3gYGinv
         kdXg==
X-Gm-Message-State: AOAM530vIN5Q3LjMhExYEMt1LqQngGdSKULp6Kepmu7kU3kAfFek94hc
        VPa6cV/WPXhRjiul90F5vL1P4gDUmIjGTGPldhYN/w==
X-Google-Smtp-Source: ABdhPJxKt0a6oYMaEe+KWlQ+pBTttefGnJsa9zMvoC3nKXiwFjF1SfuJWc7o7a7CAIlZOh6JUnBHXF86ZK2SwHk1TRQ=
X-Received: by 2002:ab0:4e22:: with SMTP id g34mr3841963uah.17.1627671908951;
 Fri, 30 Jul 2021 12:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-8-semen.protsenko@linaro.org> <45da758c-d32d-293b-f4c7-12b58ebca8ac@canonical.com>
In-Reply-To: <45da758c-d32d-293b-f4c7-12b58ebca8ac@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 30 Jul 2021 22:04:57 +0300
Message-ID: <CAPLW+4=xa-cMR-oqOmEV=su6k=pWE8qSupYoq5evaDr=T26aEA@mail.gmail.com>
Subject: Re: [PATCH 07/12] dt-bindings: serial: samsung: Add Exynos850 doc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 at 19:35, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 30/07/2021 16:49, Sam Protsenko wrote:
> > Add compatible string for Exynos850 SoC.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
> Thanks for the patches!
>
> Please put this one before other serial changes but does not have to be
> first in the entire series.
>

Done. Will be present in v2.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> Best regards,
> Krzysztof
