Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FDD3AC749
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhFRJVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhFRJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:21:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:19:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f8so3719692lfu.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAudbYmuixSdlEgXtjKJv0n2NcjoWuD1MrQFLPSc52g=;
        b=i5C8dewr2f/tyRhM9g5NxNnNcLNh9mMG/vKU/sMKnAyotQrldYYYfyz0s5IkGQnoGL
         /uRsxQlk3Ah/cVYMiYnk4kCafdM9wn+Rb3rZFs/86/mdLXkrmkSqLiQ3Jp96Rh4p4kDZ
         38yNqvYQ5i6Bjy5RvbYFbqh5yh6RT9EwbrHe5+8U4dEgDuMawkPuE7dNxL8xxk6G5+sA
         iiiH/FBXmF7Bx0mqoMrM4ew9OM+Ip5Np2YlDM0zKqj7vPyA02qqZyTHRw0n1VU0cB38L
         BDYQQX1L6c7k5sXhk+nhs93TCkjMflnYm27BckfqF4Nd66P1PZSh6He+ZrezuQfrsEUM
         6Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAudbYmuixSdlEgXtjKJv0n2NcjoWuD1MrQFLPSc52g=;
        b=NZWhXH1L0cYTkLKAz0bGeuXNYRLR3lUkBweFs8+VMHhh5+Tp45sCPoLHRArzqzH1Yx
         mDm7vR+K5DKu4SPQafK0D8Z8AwODYIWdf7rNugjki/0PFQvr+hAAdzwWi3Z5ZynFpeFu
         1YeZSbzfQ35qu0AcUg6S/aQ9k5CETqzbGcra8Bkd6/zWoCF7L3ahUUh3e8C6Gdr9X2Bc
         DrS4JpyYF9c2Y0TNQBa4MVRrWDT9fyhI9UQujiW5IQNMMNfh1D7bl8Ec5QRybFxrFxfh
         EXGpvuX1ROYAQifz/O6pLc4XUzom8/ERcSGEQXVC705wkpLkuwD9Ydz7jksvgQdzCf5D
         5Z9Q==
X-Gm-Message-State: AOAM531kQNgDP1bUyO6OxM1lQskv9IlHPKC8JCkjraQSODvj/1GgTZxG
        oMw5Si0kn9StPkk80xCRg6fNxXiiNeKXnyQ/UvP4KQ==
X-Google-Smtp-Source: ABdhPJyzppoZc/IBYS2rQQaDKbwIyHNTpyTWkBDrYq/52o4RilfCa7qvcb9XAiDEC/mZ1JHawXGnjMOHWXjJyfJW1rA=
X-Received: by 2002:a05:6512:20c9:: with SMTP id u9mr2406202lfr.291.1624007964644;
 Fri, 18 Jun 2021 02:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210606191940.29312-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210606191940.29312-1-andy.shevchenko@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Jun 2021 11:19:13 +0200
Message-ID: <CACRpkdYH2dCUg7xchRs-37ywDXiWmna5CxkBufgZgYUihAZCZg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: microchip-sgpio: Put fwnode in error case
 during ->probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 9:21 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
>
> Fixes: 7e5ea974e61c ("pinctrl: pinctrl-microchip-sgpio: Add pinctrl driver for Microsemi Serial GPIO")
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied for fixes, I got a bit snowed under because of
patch-spot activity.

Yours,
Linus Walleij
