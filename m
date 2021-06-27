Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8613B532D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 13:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhF0Lvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhF0Lvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 07:51:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A26C061768
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 04:49:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp27so1082847lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpoElu9HhDNMGczYWroxZynDrE3+UL8THrpTkrlrgBE=;
        b=SeMq4I4fzXXSXZW+ZTJ4cnYUEmcGafFSMeE7zSJzNqKsEB54rze3vvRxqcbaxeFqbt
         UjmCQ1gN+BMf1s2+0oeI1XU6ZKLo/cisq0n4u0rgL+JJErn6sXBtdXgZyMCYmFeTKIQW
         mp1vRjWQSOO4NoVUJ2WrGNXnvKqhmp7uVDyXmWm3bhxP2oWTdAzD6tSC8JUz2ufrlsyA
         6IgvBRUnYwmBpq+Iie0X2AuqlJOs0WqkZv3pixeIozAFt8FbK/4DYNDXlWYS/olf1uZK
         xfCg5zj49WCyoCCYH/IbxQCifxirtTFJALHF3uun6ZmVLct6Av2uFUoJkDy7WsrLGIjz
         HDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpoElu9HhDNMGczYWroxZynDrE3+UL8THrpTkrlrgBE=;
        b=sOKIFvGMXgqlrqrx2ahborQE5NulI97FjzY/zbDXCczmz7Gx0xRCsT3B0jtellr/n6
         vAxdTGNaWo26CqRKuBhLLVm/E0lCT6E1P5mO//cOItncQJf4B/BpWT5EPizZX2XrXTtV
         v6nmCEC/Nbi0Cxmy235DlklMwiMaPkZEtsVxMgoVX/N6mA6F9F6Z5M7WO000Wz8nB7g0
         Yv7JujqOlUytSiJcegsY8ox58f2YtOfbpCJA4kPifWyuedSnsFIrHqhyfID+Tz+licOp
         nKbWCsXTYbk762tSkmlLHr2bKmwihnBKtvgVRNfCFX7Z3/2f8zh0tlWMEC6PZBAfprxO
         qbcw==
X-Gm-Message-State: AOAM533IXhXfLwSuP8AD+zkjqLKKjmSTdEsZ1wzNlJ/idUFM35BhC9OQ
        7tg2wJ8Vyu9fOFr0JSKjTb5HM3B3HooUxfS9THvl0w==
X-Google-Smtp-Source: ABdhPJzsY3TPEADWEnLuc1HU6Lu+XDBmazMUEMM7MH6onGvPBHXknFq0Gn3MrsAqwkzfG8hkFw55hjaWWDobzdrUXaI=
X-Received: by 2002:a05:6512:1508:: with SMTP id bq8mr15388692lfb.529.1624794559770;
 Sun, 27 Jun 2021 04:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210625235532.19575-1-dipenp@nvidia.com> <20210625235532.19575-9-dipenp@nvidia.com>
In-Reply-To: <20210625235532.19575-9-dipenp@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Jun 2021 13:49:08 +0200
Message-ID: <CACRpkdb-AFvLhwOLSs5ocqiZ6ZwZbQMzWGfQ6C3AX+=ouH+=ng@mail.gmail.com>
Subject: Re: [RFC 08/11] gpiolib: cdev: Add hardware timestamp clock type
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 1:48 AM Dipen Patel <dipenp@nvidia.com> wrote:

Just a quick question about this:

> +        GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE | \

Is the usage intended to be such that since hardware timestamp
can not be guaranteed we need to ask for it and fail and if that
fails maybe the software wants to fall back to the realtime or
common timestamp?

I'm thinking from the view of libgpiod or similar apps that abstract
this and they will be "I want to use hardware timestamps if and
only if it is available, otherwise I want to use this other timestamp"
or is that use case uncommon, such that either you know exactly
what you want or you should not be messing with hardware
timestamps?

Yours,
Linus Walleij
