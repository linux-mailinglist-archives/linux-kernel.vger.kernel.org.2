Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A93DB639
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbhG3JoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhG3JoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:44:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EECEC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:44:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u3so16682275lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSCwltWdPXmblIHamxUhI05Uq7n2den6ZgF9R7DaFn4=;
        b=xeMyN/81jIIBUIIPGv4MjO+wpFeEDtmra7GQGX3QU3h8Hb9mmbgSycf+J0C65Jeslj
         Vaeqi29BQwiK6VXTRAcCE1Mp0XuMiw5aimnapcx81Jx4clQhdhZQcErbYTKGS2FUf9Wv
         onVs0Y3dVxQFdX6vAGFIj+B+aOWKSB8VzznbVejE15zKaWK2j0pl4aaVNxXanMa6XaMh
         40HQGRC1OnIeOop9hV1mhhaVrmMFCqBUJmlBIjVY0b7dFWj+dHlkH4IRMNzpjMobHofx
         B4i6i33BM5n2ynrOyvRUKKC9qQ2ZLLGM4LxS+ktMJtcS4TKYXqPOx5FZY5kYrODj68Rn
         p5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSCwltWdPXmblIHamxUhI05Uq7n2den6ZgF9R7DaFn4=;
        b=LEfh8AlURQn43cj/QYPHbFhso0lKovdyhb+tCJqK0a0u4khM+vpuh67zIsR9SAF0FR
         F7bqiQDa3d5vu2XTffFQJn/GkKWz+m3WLA1qeO6tGx6a+vIYBTbIRy/WlqznjKCCrlPb
         oFTJ7e6eW1aT6UIxTFu2txifUsm2vjtNZVooMKco+uclRnHhQcReL/QqyblMRF/QvNl5
         QGCg3eIHyK4XdsBJDiv0M2VnulrnT3DG5pvFuFlBSX7NrrUczNlas2JLiKl2QBcMAiYw
         uuaRBA/xJEc8gyaHvolo6KIWPAi/Cpy/kd8/24gJ+LBpCREy6w0HrLCKw78P+8PikB4I
         PoRg==
X-Gm-Message-State: AOAM5307Ui0F8IFJfwDRw2svYfmjBBLHIgd0oVh0G+LXb9GdtqgYhGI6
        NU0of2KFjdROmI/X6O2+YJMwBkLiT2CBNLFQYpYqzA==
X-Google-Smtp-Source: ABdhPJwUN8tOstKiqJ4hZXfwWh3D5l5tf2aApmfRxp/MrpCTTLYEDbAp+g/L2HeIdEYxSw4NcH9bCa6d8+TUmxGs21s=
X-Received: by 2002:a19:7b14:: with SMTP id w20mr1284500lfc.29.1627638256424;
 Fri, 30 Jul 2021 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb30HKOobtP++PqWc7UwM8qV4JC=UPAmUjUgFN_JANa+g@mail.gmail.com>
 <CAHp75Vc1qU0sBbLOZdTgjJ_pfN73Utg4wtRV8Ohu-OiaeJuycg@mail.gmail.com> <YOxFdUCVTT9mFXtk@smile.fi.intel.com>
In-Reply-To: <YOxFdUCVTT9mFXtk@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 11:44:05 +0200
Message-ID: <CACRpkdZDOGrY8Ks7nne4KrV2dg4x87e3UdbB=pSZncTa7XFgUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: Drop ARCH_NR_GPIOS definition
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 3:37 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Any new on this, please?
>
> It's kinda not good when the (simplest) patch is stuck like this :-(

Ooops, my fault. Now it is in Russell's patch tracker:
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9103/1

Yours,
Linus Walleij
