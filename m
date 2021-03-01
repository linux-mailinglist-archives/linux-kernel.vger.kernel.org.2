Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23653281A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhCAPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbhCAPAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:00:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED4C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:59:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z11so25917608lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHkHSamHtYZN2zBjW+IN3GEKAgHClM9st3uJzBF9uac=;
        b=dy6kZqDZ6YR96mqfstsbooAGcaoCSHi3acXFHzlth8XjSVZ66ZBmJdwDUspr8D7KXq
         27s/ZPYwIhjkfgxXut1CdJADTz6d2dpfCkgBufPO6CJrXqNmITSx+aLiWaQyugYjVBUW
         4KsRpBLrA4kqSgOoheZ3ILKxoLHiWublNp2x8iQhb5Bjg5w2H+JlBE6C2356H1yWBFc1
         Qlr4iRgBMsSGxdC3XjAKM4mPnLvyZNpQZ6ijsgWL4bm/fAazRSpzFGnUyZJ16516IAY0
         YFq+eYmVrr3EjQpCAvFjflxDdwOBoFFr5SnwMonaNUCZocRv89ljnllhuAl6HWufEYGB
         8DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHkHSamHtYZN2zBjW+IN3GEKAgHClM9st3uJzBF9uac=;
        b=dRonfivuzBW9umgl3B7WcgIir9cQN3/ewBjJ8wDy2seQtOx9DCk2/86up80fE843tn
         EJUo7c0f9c135+4KP04dR0VY0ouu4oxi29967JbbTaFNe9SegCZfa3Aenrvzq/AE96XD
         8SVsyEVSYV0i47GmZb59H+xBZMe3CW2Mnp/FWpkT9hZKgI2PMd1oqdNWvfUA3bCP/70/
         G0ifoCXWsnYSitFSsVUlL+8wR9jTlF76AWUCKP9hlrKe1kVswx+DdUljauSh6r9G6e2M
         iEikQRjC4GcEeSJlQDRZZSBUnijPatnTnwb+EjAkykGJLIxkoZyF0VBv5d6utYrE8VTv
         8bug==
X-Gm-Message-State: AOAM533n9yh8Q450W9j4BKGjHhOVQDHgmJmu95AyvNopE3e58R7i6gIJ
        4gR+e/ASbY4COigjMoGg5qVXokEjR/qa93yAAhLMcQ==
X-Google-Smtp-Source: ABdhPJzIAxVsorGrDKYZ0nSLaNdZUhpWzPw8r5sG6THCi2GjB9JYVIHtDu74TVunpXxS+x+WT+PecnHIZEd68pxodao=
X-Received: by 2002:ac2:5d21:: with SMTP id i1mr9327264lfb.649.1614610781947;
 Mon, 01 Mar 2021 06:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20210203123825.611576-1-lars.povlsen@microchip.com>
In-Reply-To: <20210203123825.611576-1-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Mar 2021 15:59:31 +0100
Message-ID: <CACRpkdYDArX97KByBV62c6toWr9K8m8Mt_jpFKrBfj4EPJ=C5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: pinctrl-microchip-sgpio: Fix wrong register
 offset for IRQ trigger
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 1:38 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> This patch fixes using a wrong register offset when configuring an IRQ
> trigger type.
>
> Fixes: be2dc859abd4 ("pinctrl: pinctrl-microchip-sgpio: Add irq support (for sparx5)")
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

Patch applied for fixes. Sorry for the delay.

Yours,
Linus Walleij
