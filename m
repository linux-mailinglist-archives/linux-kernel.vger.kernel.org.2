Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A33EF300
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhHQUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhHQUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:00:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EE5C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:00:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h11so657808ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H0r8Sg8GIHL7ae/SnzMGBl2ub4pG3MMj9Emunm8ABU=;
        b=vbCQI770K13kKYd7TMIMun0s/mtTr+0zoRSb7zwX1BlAtuS74KdBeq5jaYInfx+tl1
         z4irD5FEBUsv1wg2xDereDjPSHTyxDEtxPQ1rX17sw/BUL/uXscQO6hJB86dpoUlrLqD
         fcJF30s3b7TNR7fn7pD7WDHk7/t5CCktNQj6wEwbmg9VeRg2+My5RlETQhQJSC5K3bFL
         y7Qb8orpm4yp7IwbjrGki1N/wrRxyMsULWIUdWsZxmoEong0JgOqy/S3k1Tc61jaT5Pr
         nQtqlRp+W6njDPWodszJFhyLxSR8+fZT3lDLj62l5+J8CfK3HXt0i6qWapDzorjw9u99
         WpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H0r8Sg8GIHL7ae/SnzMGBl2ub4pG3MMj9Emunm8ABU=;
        b=EKWaaqIWW6BNaZIeOLo+OE6C3A5+E3QDATVyP4e0zKkYt++cH2spyJjQusgaUUou5S
         PlE9n1eJnB1+nxSLL4pDkMitvEqlDFz9QpBRPkz5NXv3nRY+hfAg/Fq5ZZJSr/D2a8fj
         K+N1yRSQAsNcew/PJhHZYcQ9JenMfpUooFLFm7HVc0oJ3dH5sg0JGBg4Rs7k8KdLJp1k
         WezpTobPTVPLXAemeZpnYGBmjgkc+FYrONJLP3NtIZreZATTvP7VzH69NfpLyK7CbpXo
         QwgK5iQ+Bf6nlLjfmjbN6+2RhGlYJljRZERO2+azPBsEoSBxmDLu/uPcj2JueTLgBKJ8
         4kYw==
X-Gm-Message-State: AOAM5301t+O6/gs20v8XSyQCreR/LjZn2um8iQoXG5XTV7PGAPwNEUsm
        lDpGiNdMMTMsHklidTliPjOqg8257hcJu8yTwO+zFA==
X-Google-Smtp-Source: ABdhPJyf45kXVSLPwK4e20x5z+7OCgIw3RpQIuTIpIw/pWkkjNeCmLonRAsHf8AS/PwbKdQ6GAGyJr6sk5HTVUW/Cik=
X-Received: by 2002:a2e:b819:: with SMTP id u25mr4630513ljo.438.1629230415507;
 Tue, 17 Aug 2021 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210817070913.6387-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210817070913.6387-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 22:00:03 +0200
Message-ID: <CACRpkdYpFYZsJ_WZ9UMBfZ83=5uFG8CGv38PBX+xg01UntdSNQ@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: pull for v5.15
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 9:11 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> Just few commits for v5.15.

Ah Sam's 850 support, nice! Pulled in for v5.15.

Yours,
Linus Walleij
