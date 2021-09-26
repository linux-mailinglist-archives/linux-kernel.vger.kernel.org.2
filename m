Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB456418A55
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhIZRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhIZRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 13:23:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B46C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 10:21:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i25so66425276lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxsXhdgX7vRgMbtJNxVOJHUbSgPzUowgMih6IjFc9Mk=;
        b=QG8jv99C+EvTb9rXmt8UYHIVl+UKXQSVyvi0pGYbwWsnrJJXWZrV9MJRNIesjLsC4O
         NsocrFja8vEqQI2ufoYguuDR691oR1xAFiJF/G4RXz+9/JvHZTFIhVKCrSzK8SiqP5Eu
         TpzOdDhgQh9K4VfrAzSRMc6vrwRdhn25UevvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxsXhdgX7vRgMbtJNxVOJHUbSgPzUowgMih6IjFc9Mk=;
        b=d+XZzNJp2Ghx3eurSTDSfVYWYuQ9SJIldYnT6PHbWBHczN3F2tTmVWXsXtfahF6gBf
         aA/JZUJFQ+zejcpFWU6+RcpNqd+D4uV5q7048YHFg8ovC2xO5rlKm1hvEMhzorvjikoj
         5L2BourIh71ZlmfQCjM/Xv/4C8X6rInW8lGEanJgIcT+CoKxYUvzVIewsUuEOul1f4Cw
         fSdBoJ/vMBkKRj6nWsAFcrgYjrVr5dyigeq0QG4ZUnuH3agmD9tNc9f5jF3S+tjCJSaI
         oPm+e0S/4UWx18vURKZkPqw+V8V2DyN8sWDNMlVRG/DdYMcIIl30abc5tktyuOF3KYWX
         ADaA==
X-Gm-Message-State: AOAM5309yoSRV5q72z1CVrUroqgLGjMbA2OmkIMVoyIrk0H1EV4FlPwt
        neUkuCYYmb/ESNWXd+MznSo/ZzJ+UEpv1kdK
X-Google-Smtp-Source: ABdhPJyzHBfM1CA25ZQWyeVCz55TetIxa0X9Dai+Sq2C5yHNZQfK+lm5kfa63YDwXSIN1gZyiE5Jlw==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr24298749ljg.158.1632676895348;
        Sun, 26 Sep 2021 10:21:35 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x1sm1712449ljh.113.2021.09.26.10.21.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 10:21:34 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id m3so66193358lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 10:21:34 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr23190553ljb.95.1632676894076;
 Sun, 26 Sep 2021 10:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <163265189226.178609.9712455554034472888.tglx@xen13> <163265189517.178609.6605494600326137493.tglx@xen13>
In-Reply-To: <163265189517.178609.6605494600326137493.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Sep 2021 10:21:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
Message-ID: <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 3:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - Prevent undefined behaviour to the potential unaligned accesss in the
>    instroction decoder library.

What a horrible fix that is.

This is why we have "get_unaligned()". It might use memcpy()
internally on some architectures (it doesn't really any more - Arnd
cleaned it all up and now it uses a pointer that is marked unaligned),
but more importantly it explains _why_ something is done the way it's
done, rather than be an odd memcpy().

Oh well. The memcpy works, and compilers will do the right thing for
it, but it's ugly.

In this case, it's actually *doubly* ugly, though, because we
literally have functions to "load unaligned data in little-endian
format".

So instead of doing a "memcpy()", followed by a magic special macro
that does a "switch (sizeof(t))" and does a "le*_to_cpu()" on the
result, the code could  literally have used the functions that do this
all for them.

Ugh. Pulled. But it's ugly.

           Linus
