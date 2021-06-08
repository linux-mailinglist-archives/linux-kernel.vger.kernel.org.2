Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610F139F2E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFHJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:54:40 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:38643 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFHJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:54:38 -0400
Received: by mail-ua1-f43.google.com with SMTP id d13so10708323uav.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rk3Y2ettFtVoPEnKalPeMnbYq3ARaEwmF9GRRUmO5w=;
        b=W/RduWB2upkcNz3pG1fwKde9xovsIIjqtpSUwdivqMUZJnQ7O2D0lyobPUHVNrH7iW
         rrJf9Lqhq7X1xE3i9vpY0CXLOZCpzmi7p5lcH1qD2ZCwYNufQtP2dMOLE8xlGaADYF0g
         EgPnHuTm24StzWEyCr2PjbapWaa3wypAzhaRQxqGVGczry0gwtYaF0uWrrcYbD/fuDNO
         Bw1oa/BTKVb9VWCeKOKDndGyq7tGIvKuDyW52wJtlil63xSTO+ZqXphfdqEqdg62jy3r
         ML4AOxIgjbI3Nvb8PHkk80PEbnwAcbJ454wBovEnsAKPJnSBiRT0aPpC9+9C4BzbtEh2
         7JIQ==
X-Gm-Message-State: AOAM5312/b73KFpO8KXUJlZlVfzq9qY0j4rQAOJulzhpF2fHj+89i7gs
        pouFBZ3C1KarZxvzPvzmpB0f5bfJZxxW/aRn10SSwwcbxgJ93w==
X-Google-Smtp-Source: ABdhPJxN9Z7jevDKkx2pTcmDaqBW2d4kxYDssKn9WqH4piX4DQv+lGLxW25TxJ1FWbqsUDDK3Z89U2oUxYzCTHLbtrA=
X-Received: by 2002:ab0:708c:: with SMTP id m12mr12993880ual.4.1623145957700;
 Tue, 08 Jun 2021 02:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210429083823.59546-1-jbrunet@baylibre.com> <162008674673.40672.14279142646066453043.b4-ty@baylibre.com>
In-Reply-To: <162008674673.40672.14279142646066453043.b4-ty@baylibre.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jun 2021 11:52:26 +0200
Message-ID: <CAMuHMdVhrMNzuXkD9BQxPaiwS41bsOyJU_kwGYwk5ftto-AGBQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: meson: select COMMON_CLK
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, May 4, 2021 at 2:06 AM Kevin Hilman <khilman@baylibre.com> wrote:
> On Thu, 29 Apr 2021 10:38:23 +0200, Jerome Brunet wrote:
> > This fix the recent removal of clock drivers selection.
> > While it is not necessary to select the clock drivers themselves, we need
> > to select a proper implementation of the clock API, which for the meson, is
> > CCF
>
> Applied, thanks!
>
> [1/1] arm64: meson: select COMMON_CLK
>       commit: aea7a80ad5effd48f44a7a08c3903168be038a43
>
> Best regards,
> --
> Kevin Hilman <khilman@baylibre.com>

Why is this needed, and why would this make any difference?
COMMON_CLK is always enabled on arm64, as the main ARM64 symbol in
arch/arm64/Kconfig selects it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
