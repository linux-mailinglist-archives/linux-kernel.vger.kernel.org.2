Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33140FA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbhIQOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhIQOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:38:34 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:37:11 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so3277511ooe.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHasoNbCFWsiX9dMsKrnxNkdea5daLbcgcWNoEUJAKg=;
        b=DYn3EwXJtdkBVHXuZ1aStNkPPcUVZmW6AQ/X3JXnDFo4Nu3pQZeMPOI9uDfSO9+xZx
         jyuiw9sr27jq29Oz/ES/fgfI9Du6O6Jr813ACDSDlEjmhvlUU31zNB52SIFLyuDDC7Oh
         re++P1iqt7pzhJyWnMKoT8YvwtIsIvOChwB28km/oaqDbdlTE4G5SApBipmZmIcxiMFG
         BSDDD+vKZc9X8qrUjx0lhPi/8ZtVcMCXahlWmmF4inWRk3NLuBEK83KoXoWH8NwA4uuS
         H6pWTo4NQ3o83e0z6I24kXmAGTZLh9jZaBuHoEyyihkCjUcb/E2wUkJ4ShlzZZBPuWzs
         nbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHasoNbCFWsiX9dMsKrnxNkdea5daLbcgcWNoEUJAKg=;
        b=TSXanEQiiGXtRq3PFY/VHXSXOZq/GOqgxrIQhxWVXd9Rz6xeMkzz9OLJ8gSSdJ1Fyp
         aCrO0i7Z1VDcZD0JdY5OLcl7gZUSAZgfGyLOcYbxmHT9UiRhwPWjfWnBqJ/fokuSAaf2
         s9ap5nwrWlS/S/B7iD/lZjJ2fdNl2nYXc45CVBnbAu4f9bMXqyGC4bfPsFs0elYWXoBE
         BusKnHIEXIqjVWAz2+tkq6XcqIG89XkCNDkvL0ndlOvH8OQ+5csV5Qgnj+2hE6IGQK3Y
         0RKVHGGCD1nrABb0kgVPvQWdzVgDil+AAz+3RFbWj+TlV9fxoXK7gwOYSgvQWkntYIrK
         b04w==
X-Gm-Message-State: AOAM530XQ53/0EPJQEfupK1N6SfkuZn8fL9UJlwj8Y/18mOxb3zUg3EX
        ENJk5FYm9EqHy6RL5pyfdKUNz00+Nz11UBnEkdfv9A==
X-Google-Smtp-Source: ABdhPJy6BVBa1rtp9ko/Mki3AyMVFKOss9TpQQybtMS7fCiiPAGaON0g/z1nbJ8vHUHmoSGUy+tUXuBECv6J6FEBoHM=
X-Received: by 2002:a4a:e3cf:: with SMTP id m15mr9150899oov.21.1631889431067;
 Fri, 17 Sep 2021 07:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de> <20210830172627.267989-3-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-3-bigeasy@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 16:37:00 +0200
Message-ID: <CACT4Y+YsrcejyF-VZ5OGtk-diwHtVEJU0Yhipfomur5HTCc=Zg@mail.gmail.com>
Subject: Re: [PATCH 2/5] Documentation/kcov: Define `ip' in the example.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 19:26, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The example code uses the variable `ip' but never declares it.
>
> Declare `ip' as a 64bit variable which is the same type as the array
> from which it loads its value.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  Documentation/dev-tools/kcov.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 347f3b6de8d40..d83c9ab494275 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -178,6 +178,8 @@ Comparison operands collection
>         /* Read number of comparisons collected. */
>         n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
>         for (i = 0; i < n; i++) {
> +               uint64_t ip;
> +
>                 type = cover[i * KCOV_WORDS_PER_CMP + 1];
>                 /* arg1 and arg2 - operands of the comparison. */
>                 arg1 = cover[i * KCOV_WORDS_PER_CMP + 2];
> --
> 2.33.0
>
