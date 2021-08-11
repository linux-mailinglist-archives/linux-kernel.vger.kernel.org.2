Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158713E8C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhHKIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbhHKIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:54:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E922C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:53:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x8so4177480lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AiCUWhgfaQ/Re4MVUqsQq5azIzJHgBMesbI0wlW/ZQ=;
        b=uCwmQccxrxGK0rbVI2asZmP3OKbsYKZ+DvVUn6w4vzMQO2hqr5ZpeMmShnvbBU8/Yr
         ZHrWLxRoxQX1pVuGeAJoOic61PhlPpiwESkj7USTzPr/1EAXEQxFAjqosz11DxT4FlFM
         bbrPVxhBxg2k5VgjesQQZC9WjuEXQz4y4fIV4eunpY/rKbK7wv13z32fDiOGlz5tlXtF
         lC15FlLulxhKFjSC41aMc28F/YM8Gy/fhV1LC5lcLoLFKfmLCcY97MdrfpTDMX36LDzg
         zLXli7upUMMfUBTLWPlXFZlU7rbgvECD5d3SbvaneR1in6XEIMcHGVMHFG3FuiJMk7Pa
         dHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AiCUWhgfaQ/Re4MVUqsQq5azIzJHgBMesbI0wlW/ZQ=;
        b=KsDEtqrp6TuEQ1RuZXON/ItXLBCcLHW1g37xsEvQAT9mE0ZTV7adLKDQ9P9aYvpzq6
         kJxqO8+ITbdkr4DLqUwlWXkDFa9gTj1KD72aVHwx+Yg+0nUi97Ovtyxw7F4sqWjI0LKf
         inQdIe0+Gma5q1QVkoJ82DCQrDISkTRbcCmMrcDH79wcry+m9lqrMJKLVmTAXg2lQ6uv
         4O3K165SnIhl4gZ4hyizn2f+NS0UcNDJcQ36qWWk7fXKt8H5/8MDoBdxNrkONIBRoByc
         rPtIV2+mp6ttEp2SMwLoip9yB1wyvcbW3w+0NnXIMCL5SlHq3su+FnnAgwWoWl0EPXJX
         UUTA==
X-Gm-Message-State: AOAM532HCg6VCLUn91hWs4Sgg5/qO1Kp/oeiIUuIKAx4IKf9I7ElPYZK
        sF3l9XVgI/lVxyPVRWJYb5BjG5l1do4zWcF8qtoaUg==
X-Google-Smtp-Source: ABdhPJwiM31QODgSzneDy7YtTHVThH6UHiJzC+ra8IUt6YwIQr8jCgHTyTZ7OO09tzof0XpJJpPWGQJeaRRxwn8/QIA=
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr13222195lfe.157.1628672020757;
 Wed, 11 Aug 2021 01:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210804044033.3047296-1-hsinyi@chromium.org>
In-Reply-To: <20210804044033.3047296-1-hsinyi@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 10:53:29 +0200
Message-ID: <CACRpkdaC-vD2Op-ZzJY8uWQUoS8WH5UPd0FPpWYkExXDg-5biQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm: dts: mt8135: Move pinfunc to include/dt-bindings/pinctrl
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi, Matthias,

I have applied all three patches on this immutable branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-mt8135

Then I merged this branch into the pinctrl "devel" branch for
v5.15.

Matthias can pull the same branch into his MT SoC tree so
that the hashes will match up in the merge window. No rebasing.

The same patches will then come in to Torvalds in two ways
with the same hashes and match perfectly.

Yours,
Linus Walleij
