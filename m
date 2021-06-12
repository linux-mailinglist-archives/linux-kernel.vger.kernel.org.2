Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA43A506C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFLTw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:52:59 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:45692 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFLTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:52:58 -0400
Received: by mail-ej1-f48.google.com with SMTP id k7so9669290ejv.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIMk1za7gIwbBysGV1BobCxdF30mvznLvy92C4pEuvY=;
        b=Xplxl9T9BtKZrBQqAGK4q3tu5f0ZJzMu+F4Q0JTyBk8wSMfA2SbJ7AMu5QtBbd7t+U
         1QNoq88nPOiV2jOEapd1kCFY95S0mZAcY5svzcoR5KOUdEVBI1nRTEtnwudyawMhZs0e
         C1xgHjTBP1BNz5HtatANpO1q4eiIdFU36DU85rCGdh4o1MB7vF/5MAs63WgQZJAmG2Fp
         YFKYLjbYjL5jMrEK7AQPqDiKLjt/PsUJXqVarTDNqI+iZGHKCuE64uSr9ZtgmZ0X6poa
         /AHSR4Jyf4XA1ktkXaCTuNliRvFDDS2Owut2HhKu0VDrlrldLy7YOMDArATY3+x1VIMG
         lQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIMk1za7gIwbBysGV1BobCxdF30mvznLvy92C4pEuvY=;
        b=aDzeMMhBY4hDClDic2HlWwYZlgQgQ5JfYOM1h/YUdwUSx8AX2ZoJLLcRPjXbj4EY9A
         Hfc3nxPCTX4dhib5on/M7qqrGdtfFJ/m83IkkH0WNHGJ7Cp/GrUSkzmQfKzWB0CzjuNV
         pS+bOVZsb2Xx05VsWOE3p3w3nzj2tgL8kqYmurMvetZWHqVx23iaZFQ4zZ2FhXg0hq0T
         4573PcdeqDRQJnxSwkHPgmrsOx+WyhuKIe80K2K26pZWSCIoA46y2FC87lRGeZSGAnJ/
         ZeLrHk0Uu2BcTRZsFxqfWbSBYlF+psJLKYxCZePLQu6tF4JzhRNJb9ntf2DrM4taVAPg
         WruA==
X-Gm-Message-State: AOAM5322k8tM/89KnJ1KoTZOA0ZJr+GAQMgFMGXzXtR+wdRwbjF98IGB
        sD4cWov4rviTAktXpU2oYA3Pd1g3BsifGNofok0=
X-Google-Smtp-Source: ABdhPJwhXAh9aO1S25/+ZNsLEAlFqRL0/SSaYDZzQeQd2YO9I4P9Qly952nnVwRxAQq7XNB6jXcUOcmg+9irq1fl3Sc=
X-Received: by 2002:a17:906:1682:: with SMTP id s2mr8758087ejd.172.1623527397423;
 Sat, 12 Jun 2021 12:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210607065435.577334-1-narmstrong@baylibre.com> <20210607065435.577334-8-narmstrong@baylibre.com>
In-Reply-To: <20210607065435.577334-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 12 Jun 2021 21:49:40 +0200
Message-ID: <CAFBinCBFa8UGdY+E+zdTgGEjRYQ6Y57XNf0sV4ixGLruDeCa_w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: meson-sm1-odroid-c4: remove invalid
 hub_5v regulator
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 8:54 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Drop the hub_5v regulator which controls the HUB Reset line with GPIOH_4 which
> is already controlled by a GPIO HOG.
>
> Until we can properly describe how to control USB HUBs reset lines, keeping
> the GPIO HOG is an acceptable solution we use on multiple boards.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
