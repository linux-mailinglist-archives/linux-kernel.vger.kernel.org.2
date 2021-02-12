Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3892C319B23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBLIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhBLIVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:21:49 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A978C061788
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:21:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v24so11931784lfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J22oY5jJJYHZcZyrz+k91kqCAacMKFIfAIoEnP/Ajh0=;
        b=dcCZN62Nfz34impfEaIHrUkAnPwWrY7VSt0hrlr5klbwwNlfX0KiIxIZ7DlCBstNRa
         v9qZiqB9XF6ZL0DeiFf1x/Bxo0zyV9qKTv9wbcYjHWH2Om5TKyVV62NJ5uIdOWw0f53K
         JQecxjp0p9VdsX+24xmGv1P5O3us1I1POY4r4NXYTBlvFeqPUd6N0VNsKN3vWH9T9wD2
         PhWvKi144v5+A30o+QVhK6myD0eaTS+ll3cVap8FZlQ45GHSzRuTYcIjCqbO0aykZWFg
         uTtMLNfjCee8ZaQn2tPypy8nuw65uf8BtAUqXRrWc8wAtQo9Jl9ncr10WRjHtly/lXsx
         mEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J22oY5jJJYHZcZyrz+k91kqCAacMKFIfAIoEnP/Ajh0=;
        b=R8HZsTF6z0uy2J9CiFPoOMMY1x7Yvbz3rnD3q8fHL90vLfJS+1QiBjDkfGhoOY76ga
         easIDzvSg9FzQTfO4Uct/aRRi7oPdfPOPOz0Ya9yBasWGlAFPt7XgoGN7U39uvaBuaXp
         fueMqmIrNZY5JODi5m3WZRPkvF0jsIwaEm7/ke/1j0pvvGWoKP+jJkeW38yBcJ9ZEcHJ
         T7HAS9JHCy0ostNDKSWKTHt9y76WWdGTSk3DrGSA3wjkyzTL/bvYSiB7RHN4ISEPZTZb
         /F45gTSO5+fh7/Mx3ODv4mrnOWi5hsA7yXvJTN2/Jp1g1GMfaZnfcP9u+RQIqfpFKUwS
         G8jw==
X-Gm-Message-State: AOAM5339DCajfcg+WrU3ZKHR/isg7TT4Y+5taIWMQHjO63E2aiKiSfp7
        DNLsQP/PmiHvYmGgmNDcFMBC2nNln0CIn0oTJcO7XA==
X-Google-Smtp-Source: ABdhPJyhuZMWgGg2Yq2aLGW3OSafEDaTZzOtNuOvna9rKJV/jfN6S6d5/a0SmOmCvbYkm3aarVGluKv9HHxJncu2nU8=
X-Received: by 2002:a19:600e:: with SMTP id u14mr976720lfb.465.1613118066837;
 Fri, 12 Feb 2021 00:21:06 -0800 (PST)
MIME-Version: 1.0
References: <1611747945-29960-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1611747945-29960-1-git-send-email-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 09:20:56 +0100
Message-ID: <CACRpkdaaJNPG9mqTxr5GHi4B3470=9A8iV7s+sZNWiT6VrR83Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: at91-pio4: add support for slew-rate
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:45 PM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> This series adds support for slew rate on SAMA7G5. Along with this
> patch 3/3 fixes some checkpatch.pl warnings.

Patches applied!

Yours,
Linus Walleij
