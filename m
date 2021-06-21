Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6C3AE6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFUKSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFUKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:18:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DACC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:16:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j184so29004628qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g028qSMBY+7FHWgQ6byFnFnLj87H/85dq+TSG5LPRDc=;
        b=dMbw0sPtLnVNky0bvbL7n2B8G/cNnJmwjklXdSXZIf4sPm0yxisaD0h/UaTt9mizJu
         O6ty+V4qDjctKMRD4PppsLpCr2wb0c9fhvwvxqcDTYHzPZvhmqMIDZbT/cN3ngnLhU2/
         nx8nqXsYupY7RZVXbQAHb+k60TosOqyf+YhUScjIlQ7KPvevxs2XObWNQ6JlMn6MVZ3Y
         clX9xTnbEDXtit8ZLjn/ks5b2mepW18e/LpoTnRRvwYKdLbneVyFASMBjAtjsWBPyLio
         LW9Ff+HZmmVJi7qfnSDp185Y1PDAfBw4dm8RvUBKzKn1XhMRPtGuCn1QQAt1BmlkSFc7
         w+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g028qSMBY+7FHWgQ6byFnFnLj87H/85dq+TSG5LPRDc=;
        b=Rv4iPVJrlNaazJ8a89JV3XbEI4d1rd+mWbKthlunwGdrBoVr5j42nYZKb2rsG4FXZV
         JGLYltCpYC2vsQAELwwkA86GuQyAIQNbrfbFCebXKOR7d/zI2QENJptTmhQezzqcrwTW
         u8sTjytkRK7QiqxPYkGqEp04SeCWyrPrRZIHMpW5oA+gEJWwUl6//xuGs+LpudXIOPL6
         XSZYwxnrQEh/GPcXNrkNYs9oi+/SDfXAX2XHdBn+LNnow3lVqwHWAnrz+7We+vAxwSaN
         m96yv8nqezsu66+OBxqScs8de6EWRJzJtyvtipF6bd+VLHrTUaPdHZ+F/Vvqtx0AbyuI
         tb4g==
X-Gm-Message-State: AOAM533o0+D0xrQsYq1FP5PranDGYIAWIoMjlDGNrrKzhDe0L62NwoKB
        ILJDpq7dyedPxikHjtJPNqPgysbvlbQr1wWgsoTOmw==
X-Google-Smtp-Source: ABdhPJypDMFj176dMc1i21SogoUeaBrzqgXepxpRClZ0RyTAaV46g6mff8kXjUE9/OM3Vs2YaCa93iw06eaodU246lE=
X-Received: by 2002:a25:aae2:: with SMTP id t89mr32046600ybi.302.1624270572214;
 Mon, 21 Jun 2021 03:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210524151955.8008-1-a-govindraju@ti.com> <20210524151955.8008-3-a-govindraju@ti.com>
In-Reply-To: <20210524151955.8008-3-a-govindraju@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 21 Jun 2021 12:16:01 +0200
Message-ID: <CAMpxmJVY40F3m_PyQFMbDFNjr4b9sUB8t2efEAP+ComcxQKqSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: gpio: gpio-davinci: Convert to json-schema
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 5:20 PM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Convert gpio-davinci dt-binding documentation from txt to yaml format.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---

Patch applied, thanks!

Bart
