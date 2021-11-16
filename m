Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476CC453C64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhKPWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPWz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:55:29 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CEEC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:52:32 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso1063820otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OecF1BbqsxHuxs1+6x6lNqlLgG9K3kJNOTTucdcNkPg=;
        b=MtXwM7O5OKvUbeiN2lwW8Ov64fKBAExk180fpvGV+pavI2cbx3Hxt5pyO3yMECmq5X
         LW/pNuqPYP5wpO60MORNu5O4acyH7Uf8iLj+Gqz8p0WqvN82hBLeIrMNzjLZQ1XuFhpu
         ry8yZ3qKdkbGjHzxkb916C2D8n7FT4A05jm8Z8C5kn2WNhwH7fDRxeVoUpY4mXN+c5fc
         7I55116jWuy2qjYjiinKs7LxnfMV0CT3mBwN6/GT7hBwmIcg3YtGgoHhwi7a4eYrV4oR
         B4my2Ux1HnJiaAfIiLKaYM9dOf7bHVsvKUQRzg11mbIRV2mD5BN6jVpYPdYmOjsiQqR2
         huLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OecF1BbqsxHuxs1+6x6lNqlLgG9K3kJNOTTucdcNkPg=;
        b=CfLvA1xVF+tGEBEXz16cx6mDdRlkt4zicTbtGe+vLtkQ54HXZnoZDxf7ViacE8sv84
         8ZK23M+pEwanA8v7Kaw6Sy8qHPrGKlIZY3tc1YSyKuf55c1MIYt18YHhcsfvpfGxbjyO
         FOwmu0/TNbVcGMO07yCLnEMU/lWnvOi6orjILV+8PyXuSDaxpg+F02YpkGse9ah1Bkyw
         xKV2OjEwXws25PJotGYWvgY36rkOsk5xN46gxKVOb2PWu7czqgGSb8m8HBvOXoxRtr4B
         5TCwJ/sB39rq+ABhSuDKdw/8T7aJxx5KWJcbMKVxwfBB+YHxHq1TCDV3aWKm9JeNjxLi
         W5Gg==
X-Gm-Message-State: AOAM530WfzTQnbZr575HpFoLCaiQn3n2eeM4b0BN3Th5GJGJUhwRTJ7X
        CWmLqQWIIxeKIzgZ/394/ToiyseIJzmEQGikhdP/3g==
X-Google-Smtp-Source: ABdhPJy3xSZkgt5J1IN15s2fGgvywYH5rJ/4MbT3jfNX+qjb6TCizzD79OANTnNUA9T03S0RnwU1spPqTJ/pHKES0UI=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr9065421otl.237.1637103151373;
 Tue, 16 Nov 2021 14:52:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
 <CAHp75Ve_qS0Qc8XLHLwFnWEPzQtgNfEeVr8q9L4gK2m5a-By0A@mail.gmail.com> <50c260a1-c6d0-1a0b-45da-ab1a2d1379c3@gmail.com>
In-Reply-To: <50c260a1-c6d0-1a0b-45da-ab1a2d1379c3@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Nov 2021 23:52:19 +0100
Message-ID: <CACRpkda_=LSyqKq=+mocqie667b5pTfM_SAWozxnWpgjMvHg5g@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/4] Drop ROHM BD70528 support
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 7:41 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> I see acks from Andu, Bartosz, Lee and Rob. It'd be nice to see ack from
> Linus W too - but other than that - I guess this is good to go.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
