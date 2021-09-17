Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0254101E0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhIQXqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhIQXqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:46:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859ACC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:45:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so39880841lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Adpjj8eb9qPefLqJjlRRH4Z+UTglNnbz6imJOtpowtE=;
        b=Stu4Yvcx+jZlQ6bo4SsaVgSClupIVtykd85F8zGJwqrRts+FNZKGCFRHGGl/XECWkG
         F9ceDrRBFlGqgZoQ6Ro8gV1Ip44OxLU7jAJ8prtT6k4BUAx+NwH/Xp81ioV+o3QUYC52
         LPzi4M8ehhgEOcyl4/4wqcrQZjedLbviqQKZ6MNPcNbSLRaetIZMhcsL9Zvh/JyttAtG
         gcfm4hdIKFBeRTjVl6zUTB8mzTG55FQ+hsNogyDh7ZK9ME8jFvqcND6CLG1i7ZEDogID
         xrxJQhuQvKImxHbaGmUJWoahxq6WwUdESY32n6tpsr7dznrHmSaWcdXRxdNh+oRIo2kq
         L02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Adpjj8eb9qPefLqJjlRRH4Z+UTglNnbz6imJOtpowtE=;
        b=nKCzKbJcQRSVxelTQjXgBVVKO/C/tXu/Qw+eeC6Su3MboYmsC/6b8yiPBq++Vfdbqw
         QKChm1dGNN7XhrLdCacybYA2m48hFVSfpdtfui4CM+/RJ6rymsRNHRVrUE6xIK3vQGli
         AP7sAdphS1zraTeKBeZ7QsJE3QdfPia6ToGlkJ/otKMoZ14ZtDM4MifpigtqYJjdSUK3
         slV3TsbpkUmzMKtLhfqJTZfkD2xrxpHe39/359EMTqfMBlC6zKKYUlZQQc5JOrYsU1IO
         xQ1Jk4CE2pxxcdMMxD1vk492Hx9lAssB3qxZcyKw8e+Yw2rlWddmsP6XVXY3nsCDR8a3
         GM8w==
X-Gm-Message-State: AOAM531QAqO1f0vFmHbSVDvMsAVb+8QGdO4TO/jT5kG0Fvs3cm1nXP92
        wgbCz9ByIlj46dC1SqlTNK0mC/B3AlnYrMaGPxvaLg==
X-Google-Smtp-Source: ABdhPJySPdlC4kFGb/uPqpNRVO7RsaaNmYQ7Dsfc4dTO/WXhWAE1PedasJyvgTCKrCA5g+mA2q9H0CQsy0ibTumhe7A=
X-Received: by 2002:ac2:4651:: with SMTP id s17mr5137396lfo.584.1631922319876;
 Fri, 17 Sep 2021 16:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210913192816.1225025-1-robh@kernel.org> <20210913192816.1225025-5-robh@kernel.org>
In-Reply-To: <20210913192816.1225025-5-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 18 Sep 2021 01:45:09 +0200
Message-ID: <CACRpkdb5ZOyaoVg74ByFDqv9Da-=zaBwD_4uTnd7ZTe875dY3Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: clock: arm,syscon-icst: Use 'reg'
 instead of 'vco-offset' for VCO register address
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:28 PM Rob Herring <robh@kernel.org> wrote:

> 'reg' is the standard property for defining register banks/addresses. Add
> it to use for the VCO register address and deprecate 'vco-offset'. This
> will also allow for using standard node names with unit-addresses.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Yeah this is better, dunno why I did it like that. I guess
it was the Wild West of DT bindings back then.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
