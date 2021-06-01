Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9213970EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFAKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhFAKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:07:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:06:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e11so18380358ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYSLokhZOVToHjDX8YvfZ/GTnhI3Vsb7W4Dw5LRfxX4=;
        b=tYuVyBl2SRvpemlHslfjIJuF62dTsodKJWlDgxntpqhM/T/7Uh2PzC2irWjNsXNC50
         hf/wxmwRjEt1r40E1Ie/Mqd+eEilnkB0LFj6nUn3ZwXTqjuh8M4RtgFn39lUBPlFwTfQ
         kcsrYTg1x8BFQj6Gb7ZmkI+7NNmKw2ywQF8t1BLOSyKQpPosQaefBQsvta8I4Rpwed08
         rhc8SjcSuWleV0RSdXwCkmU0BqsBT/V8rMtxLOZFWpAL7kksN/wdEprzSauYDYD6O7BH
         XsTm0qd9GJ49tm5z4Fh8r5EkPcVUFRSFhSJiZ7RWAEUQyb2ijbxN1LVM6cgNqkiNixK/
         xlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYSLokhZOVToHjDX8YvfZ/GTnhI3Vsb7W4Dw5LRfxX4=;
        b=hvTq+Av7zj/TPRFxJ7Tmv4TqtjUNS5Vm7R/GI3apy8tI2CinjynC+EspDsFvYs+y4S
         GEFEcTVvSEgwCpKsxW2jgLhrjQ8HIjDXs1QMwdYz1Q9Un9kC2Tg4cgFh2AKG7HKvH+7g
         vSYib8xGmHnZTxmWvg0oXEeTbKtdGHCTFGzXiJDo+ZB0tr42jLgjqqbPUltzDIbLa/ru
         VEJWs5egbsRT5PpbbhuI/lJjR90PRJq/tsQTgLc5Ff52dnh8zyC4BFDgCmlY3bEEr3ju
         Fo1LJPhR/lMgEI6Iuxkmryo5CbOAOwMBOc4p1VjJLnU0F4RIJ+g4uMwfqWGjolvOjsJZ
         gDCg==
X-Gm-Message-State: AOAM531rnC/SEL0E5cy271Yy8ypxBYQV2scIqAMEQj7Aqb24Q1kuE3wy
        WQbm6cEEk7lTf1NhJz1a+TTA/p1uDTP39tGDyXunAg==
X-Google-Smtp-Source: ABdhPJyBsSoyWIetFnXXUIljoJ53aFPzpaF/jLvNpZkUb18d9ksScipYnaimUIICpjvLU7/LSl2KCQXoeMnIbRM8ikU=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr20730123lji.273.1622541976021;
 Tue, 01 Jun 2021 03:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210529111935.3849707-1-andy.shevchenko@gmail.com> <20210529111935.3849707-12-andy.shevchenko@gmail.com>
In-Reply-To: <20210529111935.3849707-12-andy.shevchenko@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Jun 2021 12:06:05 +0200
Message-ID: <CACRpkdb21tMWyoxHuv8CwUB9fZeD332B_ui2jtMP7ocfbi6LSQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] leds: rt8515: Put fwnode in any case during ->probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>,
        Abanoub Sameh <abanoubsameh8@gmail.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 1:19 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> fwnode_get_next_available_child_node() bumps a reference counting of
> a returned variable. We have to balance it whenever we return to
> the caller.
>
> Fixes: e1c6edcbea13 ("leds: rt8515: Add Richtek RT8515 LED driver")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
