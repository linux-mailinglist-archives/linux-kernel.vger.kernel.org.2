Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468FD4586DE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhKUW6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 17:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhKUW6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 17:58:47 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7178C061748
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:55:41 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id r15so32907485uao.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S438G+utz8pjDkvXqx18EM21msuvfiLmqt/53NycU20=;
        b=zF4VuhMkOvolYehi5B/JWkTO1dRxbjNScex3BHFGl5I82XST22YzhAWj5ykjWWb1Eo
         X1SmjNqdH/CeStdilN4MB9awVlBKEudQ0oaI4rkKrZEcjDyGoDT+6tlJlzLHrispfEsK
         qSfaSsn6TIlcsAw6AqEetnZZXf2YxO6GvYphbP4/fLNYRd+HDRPL6IoCdiO50rvHCgCD
         ErDkX1+6ann6fiQH/lsRxQvPIz99xsbQBb1PRPkfOwsI43WL5vCRcUfpy8lzxm+XbxSH
         sWaEPZX2Sd8g4EaPYeB42Flkmlm/IQ3A6GFBwQ1T0xJERsfale5p6LuhlPFFPU455Rxo
         QqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S438G+utz8pjDkvXqx18EM21msuvfiLmqt/53NycU20=;
        b=nYeQDuxSpvkY6K46PY9eF69OXv2zemvvVjo1zhb9MlzZF1WKMBEv1F9h8WUG8VBTtP
         m+SD7BP4RyWdElZAzcncmAV8rSGF6Nha9+g+LvX3l239HJd1pUVpnP4/E19oCHAnT7p6
         arZRGN9LBdAUahCSO5JYtsgQ6PtP8NmkTDn/Mp4T7CMCcMn8E2ls6tASdL6gxJ9JEe40
         o6vBWcoF4xXLXnJ5eE+rzyNngV4IYjjEVTL68xLzweT0jrz3I5QmpjpHe3pt11y018pG
         J0u49eQmNaZXmD9xb5/MoEXyr1pn5fQilVKjSccIyLwNbQsM//C6N2TRzhhyNoKko8aY
         iHYQ==
X-Gm-Message-State: AOAM530dG3Wf0cZFMGKuHOJ26oK4F6Zw2pe/NrsCEMu+MooM21TUThI3
        hYzmw9BkysBmMDbTfbn89V+ZHdaLTXHEoONip08rJw==
X-Google-Smtp-Source: ABdhPJwgf46PvVFqRlUS2culzCgQuSh0I0XL196ZF7cYR8TmgHwR+Gs2ynsMw9ktq+ZcHsUQSvUH0wfBjwF/ur2ckbw=
X-Received: by 2002:a05:6102:4192:: with SMTP id cd18mr123860031vsb.35.1637535340797;
 Sun, 21 Nov 2021 14:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20211022224556.18742-1-semen.protsenko@linaro.org> <YXtVS1YrZqE5kW32@robh.at.kernel.org>
In-Reply-To: <YXtVS1YrZqE5kW32@robh.at.kernel.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 22 Nov 2021 00:55:29 +0200
Message-ID: <CAPLW+4kgQ8CVS6eNXxwePiATHT41E2EhhAP3AbxgFTCnjyO-VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: samsung: Document Exynos850 CMU_APM
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 04:58, Rob Herring <robh@kernel.org> wrote:
>
> On Sat, 23 Oct 2021 01:45:55 +0300, Sam Protsenko wrote:
> > CMU_APM generates clocks for APM IP-core (Active Power Management). In
> > particular it generates RTC clocks, which are needed to enable rtc-s3c
> > driver on Exynos850 SoC.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> > Changes in v2:
> >   - Added R-b tag by Krzysztof Kozlowski
> >   - Added Ack by Chanwoo Choi
> >
> >  .../clock/samsung,exynos850-clock.yaml        | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

This patch series is superseded by:

    [PATCH 0/6] clk: samsung: exynos850: Clock driver improvements

(going to submit that soon).
