Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28D837F40E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhEMIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhEMIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:31:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:30:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l7so30133344edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zRdMo99sBcPVkYh7kqt4rJWFtQ+AE7arsx+IsmBxYQ=;
        b=zzy81YRwLvqZzgj+GAVRg7gO7gSxcD6vZz0p9y37lkWqy9qXdwmV2pXxf7Ci2oOSyT
         iaeFMFenS29V5u125YVd/ikqaYxnj1qrm33lc52I/iNXygB1dEjBHYt+GpkG6Q6nlkZg
         RLfJbcZxdcSumd/o/QfTbr8K9Z3ymxC2J8vquVgceZPODfj7x5bT8p9FNYn1gc6jsD5d
         pGxcbIwNCJVLAbAbQCjamkI9AfOAW33pCLGyYQTFbtl3k4Ei/sWyz+X8wB6fJ/JpGu7Y
         X4onwMc884oaT2zssEUMFi3zNS6v/oDCIVlRnAqqj8ABXL2KCA753oou9NUMsN8J3Ahw
         vOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zRdMo99sBcPVkYh7kqt4rJWFtQ+AE7arsx+IsmBxYQ=;
        b=Bghrtk+otztJvvFOYzGgBi8UiQbFfZwbs+xMdL9hg+GcKu6I279MgCLyk7NICez6+J
         0MwYAjPzMrHOhNBLpccpsk68TFk5GidM+gsC11HCL0ohLEeHrKyN5iw2RZObOC5Rfguc
         9oB3zdoeUWSBQMQJT5X/Of9TCVT08JeFo5O7pOFyPbSl41PUZwp+PqU7O1ACAMQ/rTsr
         eeTzMA9CDO9p4SVWdW+4bZdr1KgJdsGt60uZSgLaWcsSw+zyRXaVan0dAH/+U0b8KLNX
         ErkCK3WmaIPzalCWdcCqwGbG8r9YG6+gEQc/i/TCmSoRtZXUqbmS3br1WO2sqVEJF+6+
         0fdg==
X-Gm-Message-State: AOAM531XCk04HaR20Uwkkw4ZYqHko69xbkg1u2XofnUEl5Z8evdY3pjq
        tO8a4V2ZjqJVEaZfu6E+Nf2r4X5VvW10YPfchrf7cA==
X-Google-Smtp-Source: ABdhPJwGeFX8pHSgnM7O78q4lR707KbYHSCGE+AlKfh5wKAsFR1Tk5ifzZsnGo+0qfgu0fGg5RRVaLsYQZ4/zIeI5Yk=
X-Received: by 2002:aa7:c6ca:: with SMTP id b10mr33639738eds.221.1620894626895;
 Thu, 13 May 2021 01:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144837.204217980@linuxfoundation.org> <CA+G9fYufHvM+C=39gtk5CF-r4sYYpRkQFGsmKrkdQcXj_XKFag@mail.gmail.com>
 <YJwW2bNXGZw5kmpo@kroah.com> <CA+G9fYvbe9L=3uJk2+5fR_e2-fnw=UXSDRnHh+u3nMFeOjOwjg@mail.gmail.com>
 <YJwjuJrYiyS/eeR8@kroah.com> <8615959b-9054-5c9f-0afa-f15672274d12@kernel.org>
In-Reply-To: <8615959b-9054-5c9f-0afa-f15672274d12@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 May 2021 14:00:15 +0530
Message-ID: <CA+G9fYuR0OwYG1fmbro2N4FOk-nw61BJHQmd-B7Jbg+mDhsSAg@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/677] 5.12.4-rc1 review
To:     Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you just need to grab commits c1d337d45ec0 ("MIPS: Avoid DIVU in
> `__div64_32' is result would be zero") and 25ab14cbe9d1 ("MIPS: Avoid
> handcoded DIVU in `__div64_32' altogether") to fix this up.

I have cherry-picked these two patches on stable-rc 5.4, 5.10, 5.11 and 5.12
and the MIPS clang builds PASS.

- Naresh
