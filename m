Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F232E618
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCEKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCEKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:19:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28671C061761
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:18:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v9so2755600lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwNLb2P2LVN8VWnFdZc+rwNuJ+QqAA27JjkB8JsHwdE=;
        b=ASt1IVQLPzb9L80bE8m9f6kqqabCk7u0JOhy1MzrBL/Y2CJ0Dk+b11puVpKMC0/6Ns
         ie9feACUA5VpTHep8VxEOVnrNzCWCNw0ghuzbPl2o2TA6BQKPyu2TvpIsSl+n7WOXxhJ
         GnbpuvsdvzZ3lgB/WInil0/rAKCDEgOYM/BQIW1fnTNNKCc9Fub2YSSwCjDghaAsgXLx
         evXri9xJW+v/yVU6UBVsQBMa4XNp4xWamt9MADq5BSFM8ZPLmV2Xkc7NScHS74SmE1hH
         NVzcQFja3IFFj/naH4Ke4fa2zCfotjNhZsI0D7r4QpvMHpkV+H8RGn9fq5IQFSj0RD1D
         yI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwNLb2P2LVN8VWnFdZc+rwNuJ+QqAA27JjkB8JsHwdE=;
        b=rN5bppwwxfzA2MNXhK862EBKfaUlwvq/wgGLgXbxxXTM4GaKH3pIE+ef9rnDbmKb2Y
         KCrxEb4emsNOU5Z3EjgNXCvsELgsYmS8nV7sBWnEr+v72ppXnTj2GYPl+fsvnZbit2IJ
         3Q03Gd9bWsFwMlgQkRQ2Rixe1xMt89KiTbeb795SdYk74tKvBLmqNS0Kcvb137mL4iRc
         pqhAXjBSkdKw0jsgSfNBvZ1zDEoZwOfSfet47gOkIwwuK7OdZzjtL6haL3VBRrEic/sO
         qNxmX+MnbBHlKpKqPqB4bUxGFCv4lEaxQxICFpcsRuP2QFF6ajhwEnBQRANQ1jqkBH0V
         h/xg==
X-Gm-Message-State: AOAM531hYr5S9wT9Y0ZDToppNhSmSIfwM5cwoGQ16ZOztwA0m3Z0uh/C
        CeKVE+rJ6792LqN15gzKqX7AmIipsYEFUdA1RfSdFg==
X-Google-Smtp-Source: ABdhPJxA/IN9FI+YATqXHoTLFT+UsL1VJiDBv807dBmpi79MIpih6Nv69+jErWGhJ3E/idF9JDF05vISQLysXpmYRtw=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr5000896lfa.291.1614939537603;
 Fri, 05 Mar 2021 02:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-7-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-7-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Mar 2021 11:18:46 +0100
Message-ID: <CACRpkdYZX81vEivv331OOsaRUr65aLza3-Au-by5OL+w1D0RPA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 06/27] dt-bindings: timer: arm,arch_timer: Add
 interrupt-names support
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:

> Not all platforms provide the same set of timers/interrupts, and Linux
> only needs one (plus kvm/guest ones); some platforms are working around
> this by using dummy fake interrupts. Implementing interrupt-names allows
> the devicetree to specify an arbitrary set of available interrupts, so
> the timer code can pick the right one.
>
> This also adds the hyp-virt timer/interrupt, which was previously not
> expressed in the fixed 4-interrupt form.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

This looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
