Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D5A3C2753
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGIQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:13:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4555C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:10:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso8534566pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q06fwHRHMX96E1HCBPishz+R4ck8i/x3l8SYTB/YKHg=;
        b=CC9JmBHwIAQ4EgZxzlZCN6Z/G2V3MvFBUCnzbUL3RwREbffTl0vlTwkvT9DLm+lrs9
         LwYViIzIUU8BJQExdWRy9/pChl1Id+cpbBLN7qQ1VYe9PkT84zo0s5Mf1B5YPwq0dVyX
         Yh2qQ7VGpjxWkERM5mHRhMxKAXSgELt9hTHVBDeKlXWi9Md8+ZVSx3EdPBhF/4LG2g2o
         f4M8hqW8yX7rdmnj1vMBUsO0lVjrLgi5861wG4WqhYUZxeFAHK5NRdbx7I6sO6hTZZK1
         E6ys9+nvUNp15KOkxLZfKn8moabnZlh5QoHdy9CJvAOwAlhNF6Jwd2/UEvHBFeH76LuN
         ZVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q06fwHRHMX96E1HCBPishz+R4ck8i/x3l8SYTB/YKHg=;
        b=hNhhCev2spiWGwAcvtrMHB+NigJE8MvSmeVQAGyYMgssjKICENHujHLlI5OIWXKyge
         q+T3lhs6VYLUd89CW0/SSso1LLahoRS1AbvlY2VpwOv63UgMubJ6FXzzxgZ7z0T8rzdX
         2NeuJ3Kij11adk2E1Jaw7+KyOVRSLnhsj76L+Gt6egqt5Ar8PwM1jE6ztyFmEs8WgiM/
         PO3vbdwkYBrBRdtmd3JyCQEpVM/lJgnvM7CQZ3hjXDL8aaz7wa0HGumAx9vneyQX293e
         +IMZBVbvnRqAz5T4CC6ZffbX6P7kTFFWrRLRZsAExxejrC+4a8ePeHXU5yuGjeQbRsW7
         5vIg==
X-Gm-Message-State: AOAM5311j/NyW+chjD15WjMhAjby2H9USrtuo4J1SN8TISeIhB4kCE4R
        kh6QcfCrZS3x+LeZ38eOq/VrDVnQHK9YeX4QtGNxVuHy+dA=
X-Google-Smtp-Source: ABdhPJx1wt/UMqZCTZlu/2xSkZRo8Mx1FEeXPRuiPQ+Qfllb6LF0Am6D1LMwsDltoAwUKxoP3NKs1R5nxAhyRdDjX4E=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr4797902pjb.228.1625847053099;
 Fri, 09 Jul 2021 09:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
In-Reply-To: <CAHp75VfKyqy+vM0XkP9Yb+znGOTVT4zYCRY3A3nQ7C3WNUVN0g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Jul 2021 19:10:14 +0300
Message-ID: <CAHp75VeL89xaP9xjnigvv7Hki20=b7drp5iZ+ZfhZke6WGWsRA@mail.gmail.com>
Subject: Re: parallel panel display stopped working
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 5:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Parallel (4 bits)  panel display stopped working.

This part appears to be a configuration issue. So, we have only one
left, i.e. oops on remove.

-- 
With Best Regards,
Andy Shevchenko
