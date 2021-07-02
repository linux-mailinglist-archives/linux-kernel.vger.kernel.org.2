Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234DE3BA53B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhGBVtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:49:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2331C061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 14:46:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u25so15161295ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIGiDf2KoFoCdiKZITBe9Z0Y7zxgFpipo+5Evze6LFo=;
        b=t+XLQnzr6P4m9V9FLQwj4VXh+SJjOrtqSzok9vscy7W3LPjqTVZ0AA0olc+OgCpKnw
         3yM9CcXpXAFxUNmD5zTqSzpiN3N/a3sHSUbEKWMqar4lD/vRcUPH+a+k2fN4rTXv/BtP
         LBe4YqHLdXDcdQ4HK9PNFft99AHTAA4rd5tesPFjBQItcsudpZTsIpkXpgoTQ9D8GhfG
         3tVyCylZPXjzw+sa8i5UatOhYIJ+bETAnoUAAW+Z86no6HhyMfI7u78lwqD3EzjrxUgH
         TS6I6bCixGv5q/EG08/kuiV2csTJyOMHNZqC4REOgUjKkfAuws6+McLi/Ryk/qrpIshW
         D+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIGiDf2KoFoCdiKZITBe9Z0Y7zxgFpipo+5Evze6LFo=;
        b=YYvHgSsZawVXAgd7jaZNAtp+TVZH46SxmRXLO37gCyKtyRuKMB4F1pVPKDdGti9sPB
         9qviu8NhxPNhRH/ucs6RjVQPlPg8l4UU5/psZ2eXdQ1jm79GcFDEcksXKdvfYdlvauzu
         WySHPlqyboDLcyEIsuhV9+U9XxnwAuqtl6k6KQOkbyv+bBftS0R3ewpwfAn1cfTpq9v0
         IgT52fRfFWqjFL8mVKZgY5Dje4PWsBeNriB4p+EXBxQB1JuLFNy3ht7ixzYY7y6OZzzG
         HhFVahZSXNKnEZHgiGIEGEAaeX2X1LOwFWsR4U08Th9Jqo7YM9uYw79+gLPQw5k7ArnF
         aFsw==
X-Gm-Message-State: AOAM530i6+688TKqg77SKOWdJBE2PE0+FLr/vFZ5m8jEnEO9OKqEsVX0
        q8lulVSv2jfYaYOvndsWd3QN0rulOpQfbBTqdoyYmQ==
X-Google-Smtp-Source: ABdhPJw8xFvVFmYKqnx+Ve97cw85+M1nnMSFpfktGQJBPUegkCw11tk7cXTuqgvzu2KCnBgXlh8ikOLGk51bI5vZ6kM=
X-Received: by 2002:a2e:82c6:: with SMTP id n6mr1235259ljh.74.1625262386896;
 Fri, 02 Jul 2021 14:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAF78GY0jB_oeKgfZc4SHWBVusGnNfxKk5jTC4UBDsteSEVEzTw@mail.gmail.com>
 <CACRpkdY4bU=bEAyA5ZCx7PVF7nKoPSR7iv6x0t-QM6Bc6bc99Q@mail.gmail.com> <20210702104810.581438d0@gmail.com>
In-Reply-To: <20210702104810.581438d0@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jul 2021 23:46:16 +0200
Message-ID: <CACRpkdbnujCU1H6VmpyZ7p6bMFG0s8PzT-O4GetLUXA21N63qg@mail.gmail.com>
Subject: Re: gpiochip_lock_as_irq on pins without FLAG_REQUESTED: bug or
 feature ?
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 12:48 PM Vincent Pelletier <plr.vincent@gmail.com> wrote:

> gpiochip_lock_as_irq,
(...)
> Actually my question came from yet another misunderstanding on my side:
> I expected this function to act as an exclusive access control (because
> of the "lock" in the name), but I then realised my assumption is wrong.

Well it locks its use to be compliant with being used for IRQ.
So it cannot be turned into an output for example. While reading
its value as input is fine.

Yours,
Linus Walleij
