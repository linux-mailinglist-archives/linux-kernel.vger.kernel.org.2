Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C529237ED3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382511AbhELUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377932AbhELTJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:09:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D900C0612EF
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:04:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2so35242071lft.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BvsCPO/20qH/TAyTy6uJ/xOZE61JFh6apd4RBrMk2I=;
        b=HZpSV/mSx5iq9sqEetSpypgP1dEkMzZDOZFZ28yo4xsiw3DvVm0irHd9h7UZ3J4UzB
         FAUGzseLV1hiSHrJjCHfjcKqbHR0nbTfi0T7I9VIQKp75prfF9AvjQF/nlfcVPO1hdym
         rOhbb43WaPnoc9lLuTVU/HjUdNTvH8m/sUkGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BvsCPO/20qH/TAyTy6uJ/xOZE61JFh6apd4RBrMk2I=;
        b=fj4s6ycvW5pzSQbCR1co1/F+ZyZQKOJVJMpnnXQs+tzaE8hWoM2GW3vWAmVvNNGVzT
         AgyQ7yl74/aYu2oysoVoE8pQtd+MzzQn0LS7DVgcismvwh5sUFS9MSM7g09PfkGWsdGk
         VJ7eoXoLqc7vQjixcKf4iCPViYLm9lQLqet2Zp4jpyUWx/BYkEqW3caqvvEhN5bYUbL6
         qpiIIoD6Z3AK+xtED9FexY8Pg17ke5Yc70V8XS+VvlA68JRNqSVDG3wosseBozGOu5Nm
         47Pddwky5b1PUMb4Eh42sUpI43opDt8Q+MvYWh80vXrDHXGc7ssRJMIguxz47XrriiMF
         WHCQ==
X-Gm-Message-State: AOAM532QPgtljUdkp/sUcJZQw9dyTxsz7SeWAJOnss6sMAObU+4rykvi
        ltAx3QaIe/ruYym8saMA3wNfeUQW8wRXV+o3
X-Google-Smtp-Source: ABdhPJxz3JGsOe1o2L4ETt7z9DPlExFtbQ78jNWxwEitmFKQ5J7yqkDRTw8ElDhlVZ0IMhJLbLEEFw==
X-Received: by 2002:a19:4888:: with SMTP id v130mr25341718lfa.53.1620846265701;
        Wed, 12 May 2021 12:04:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s11sm94911ljc.66.2021.05.12.12.04.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 12:04:25 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a2so14244713lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:04:24 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr24793845lfe.41.1620846264161;
 Wed, 12 May 2021 12:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144837.204217980@linuxfoundation.org> <CA+G9fYufHvM+C=39gtk5CF-r4sYYpRkQFGsmKrkdQcXj_XKFag@mail.gmail.com>
 <YJwW2bNXGZw5kmpo@kroah.com> <CA+G9fYvbe9L=3uJk2+5fR_e2-fnw=UXSDRnHh+u3nMFeOjOwjg@mail.gmail.com>
In-Reply-To: <CA+G9fYvbe9L=3uJk2+5fR_e2-fnw=UXSDRnHh+u3nMFeOjOwjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 May 2021 12:04:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8jOJtKpw-Jsd043sjdL=rPnOD8uD8Tf84_Q36iu_ewQ@mail.gmail.com>
Message-ID: <CAHk-=wj8jOJtKpw-Jsd043sjdL=rPnOD8uD8Tf84_Q36iu_ewQ@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/677] 5.12.4-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:48 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Linus's tree builds MIPS clang successfully.

Note that this might just be a random effect of inlining or other
register allocation pressure details.

So it's possible that upstream builds mostly by luck.

The "couldn't allocate output register" thing really does seem more
like a compiler issue than a kernel source code issue.

             Linus
