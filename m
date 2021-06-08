Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EA3A00BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhFHSqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:46:49 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:35837 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhFHSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:42:18 -0400
Received: by mail-lf1-f47.google.com with SMTP id i10so33684601lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFVHIAFVezn4A//yU0olDz7nXpJepZN2+RpU9TzzyE8=;
        b=pLX4yrmrJ0rUVnKzsKkQ81cTKwTGWP2ONwJS+KHNRS89xxBiyB9MgfAjB86RnAT/Hk
         Tk9YXvOafQ9vrGquEY5afAb6ZJVNQfCN9PtLNt7UuAv+nOahJtWqQBqX3sZrGVpHs8Lf
         EL4D1BDwIKGForCI1dRNmMgqAJY1yw7Y0syMyClHOIQ4j1dVbVW6qMXHzQKLzUt6wUV+
         fubtP6LfDplz66FfEuMuQIwBCWAPHaJtlF5tZ/bPtAFUKFdfAJx/vbuveJ63671EtKeg
         vNbwDbFy0UN+xu82/bT9McIXfWX4QTaZBqQFrHMk199Nwyr0Td4t9+GDLdAf2Lyn9LZM
         i8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFVHIAFVezn4A//yU0olDz7nXpJepZN2+RpU9TzzyE8=;
        b=uJzwI1jcA0tJstUnQ5A+1QGMQ/sj3AtnnALORaogL14vYFchAInGE8to90t7lcJIt4
         dMeZA26f9xM7LzGi5vDK/45L1PZT8ed2sbz1KYK7Ii4scRwl9jGZuDQsb2yC6htSBlNw
         gEhEDf1jGl/Wyu16izGP033Kqjrl9517xTNA6/I1iV1rxTeW5fuRUkT0ZSmeYj7McciU
         +vEFOqGa26YcsNlpuUG3RPafaBAX79B7tVHVcICpkWpBk/qkLqtoHPFV4bs+ik1WLoXI
         DfAxu6TCcYqcfL1CrJzvzOiiZeC+6PTAxlpAgyQwm1keKgMq/C9MYwsSW0+Nm/dkNXI2
         iZsA==
X-Gm-Message-State: AOAM531ZH+2anQqd4NbySwD2NOq9YuuOvU0GWuEokVne4RbpHKtXPYV7
        wXwKiGEu1+VJuFljjYipbYzRaGOHCajZ/an3nmiiqw==
X-Google-Smtp-Source: ABdhPJwSkum5TLbm5F7gzs0qrnq/SuixhE2KyLKYeHZQ7LcH11gymZk7UDXcOBrGLp4Svy45uPgtiw0LT083xIgQJuY=
X-Received: by 2002:a19:4843:: with SMTP id v64mr6200836lfa.374.1623177552600;
 Tue, 08 Jun 2021 11:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jun 2021 11:39:01 -0700
Message-ID: <CAKwvOdmyXV09ZxcDqQ6x43f+Eze4h40W2AoKcCmUhGM2gUWsnQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: devfreq_cooling: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 2:46 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in devfreq_cooling.c kernel-doc comment
> to remove a warning found by clang(make W=1 LLVM=1).
>
> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
> devfreq_cooling_em_register_power(). Prototype was for
> devfreq_cooling_em_register() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

That compiler warning doesn't come from kernel-doc.  Your diff looks
good (the comment was wrong), but the commit message is curious.

Usually that warning is from when the function prototype does not
exist for a function with extern linkage.  It looks like that's always
provided though in include/linux/devfreq_cooling.h.  Can you share a
link to the original report?

> ---
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 3a788ac..5a86cff 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>  EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>
>  /**
> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
> + * devfreq_cooling_em_register() - Register devfreq cooling device with
>   *             power information and automatically register Energy Model (EM)
>   * @df:                Pointer to devfreq device.
>   * @dfc_power: Pointer to devfreq_cooling_power.
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
