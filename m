Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98283388340
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhERXmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhERXme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:42:34 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:41:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so13374284ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AktLZrGpYgV8H67Vy+ElEpmR7sF/guI5YPVEh+qgC1s=;
        b=VI4tvm90SOABVqSHLlEITyFRSTGVQvmk72TPZQiT547coPipBUixu4qnfqMb7HkmSb
         DmK2/yJ/UmG0BYFOQHVtgS24c8/y/quzeW5Fi+sCKFK87qzHmGeK/sBOCr5M0vpC3wHN
         Fs+Zf4zH5qPw3cYDOxzWWWwkDerQLE7hMmc9vzgTRjSH3km3yENmZQ21VvYiJ0V/yzrZ
         k/jyAX9xmyHpkiF6P2s8QDFZCz9cxHqjTMbePha6Ui7U8hGKzlvOlzjNp9U6qN0VaRg8
         QrJ8fBLkeomp048ykk5CobNdieoH3GJoNAgfsD+IyFhYKxjidYwnitJAjpDdrMMhdAtp
         RSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AktLZrGpYgV8H67Vy+ElEpmR7sF/guI5YPVEh+qgC1s=;
        b=jg8Cw/Cqua7/7nHBggAOoRcFtCrjncbkTShxNar7BXZNfmkR+6nv7L2+uCLJnzlclI
         qKlbmC5fBMyDiKlfIqJnSZiG6XaBqC9ULXAp99rmBiCUahpFwCAtdRuAWEe8Ct0nKP9t
         E5gvNk4lVjkhkEp/2vxS9bL/vewFedKGF2SD9bC4PDOiHYqSfNG8jMzpZre8woNT1kQ1
         4g98ouQoJnsf0PliBnvdEzwq135nyvBCzVCaCVHzBC2vtsOtQ/2gjktGeNGuzqM6H4ao
         soZzW4U8y3RZTj2Cwkcjge53NnOvRjtUN3IE+l3x9di6CIn4hU/Ngp6EoOEr/1EeWeEe
         IFew==
X-Gm-Message-State: AOAM530qxbMXWI1z2BQThBe9VawsVyjOUmP4YtZH3sPv6X47I6tJ4nkm
        2x3LYsWg2lA8s59rAF8qUPanUORZQO8xS4Z5qwJPCQ==
X-Google-Smtp-Source: ABdhPJyEEWE3b4+6Un92qL+0uvA2Tw0R5aXwivUPrWCeMfFADssWM/8q5ALNjXZvRF/YuuyK/mjAG3EK3fmmfBXsEAI=
X-Received: by 2002:a2e:814d:: with SMTP id t13mr5819007ljg.467.1621381272289;
 Tue, 18 May 2021 16:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210518083339.23416-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210518083339.23416-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 01:41:01 +0200
Message-ID: <CACRpkdZXUgORMQXN2RRnPboF=EOBwkuHOWaXX+Xn=k==VVVjgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: Introduce for_each_gpio_desc_if() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:33 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In a few places we are using a loop against all GPIO descriptors
> with a given flag for a given device. Replace it with a consolidated
> for_each type of macro.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is great for readability.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
