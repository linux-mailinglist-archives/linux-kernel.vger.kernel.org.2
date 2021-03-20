Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A70342BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhCTLMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCTLMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CADC0610DF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:58:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so5922582pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5zI2N5eJsydBU4Kcf42YOrHjn6io9gty356v6rFjA8=;
        b=MFdk55cDiztRPczRYLRP549RjuIeKF0AIp4SjgX3MPitKrAiBQmL+3B6fDVdbGp29b
         PUaECFdwPWjub31RPKSP6hd4Jdkx6Pw6nQGXqm6vdhrgJpFFmhm/NSU2GoTaoVES08Zn
         sys1uEQxBK19w7AUJq4OlzAFlbyVUow+on8U23bB2Pke+QYFfkoO4LkLn7RjGza2L471
         Xbm+XNbYu9NuylDY3GjwEqdbXivxL5Xwvx0jPKiVHLBoakvxkz/TWvLKo0KKnDgZujyO
         aedAeAQdlZ5VTti+ng3DIhL8don6SVSSK9WO2slXEnNv9fiu4wm435pLTWvA3LgWyQfw
         xd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5zI2N5eJsydBU4Kcf42YOrHjn6io9gty356v6rFjA8=;
        b=OCnkAG9AvPHDmLpg2rebke4iYfxmFgmVQO+3li8H/MRbegn1wg5hqYek+e4P+vEv6+
         GlNVCOj7B1z/Qlp22CmBQHLXmjUZSbdDafIXi/afwiG4XCc94SqUuDKU9mS78fSXO9Aa
         xfeofrBqF6H1HbhoQlyHFcaeuZbF2qMso+1M3XbVkrrvEj6kFg1RscnNjmIbuJUzwUPY
         CxDjHH/cg0w0JJOZMYWKz6Vb9oKzgk+W2bXtQTBqI0bxJPv5aYW4o6pErG8NXpzyswTN
         YMz5PtVPiHPI/UwVbKxa0DZEeUN0Tu7U9I0KNpMI71huYKrXo1DLRSfm0OlgskjEe3Pg
         XJaw==
X-Gm-Message-State: AOAM533Zpp7T71UcCmQIfJF5yY5l7+xyU91EXOVvDXRStQyLDhRNhA2R
        uZ9IVgaAVRFhoVgA4m/bGv/hJz4fPAsikFT03OM=
X-Google-Smtp-Source: ABdhPJw5kUIy++IOlDbOtcj6eYptzIgzQj2SAi2MSa+Ei/4lyq8DnBYoDk+j/GWGOqnzZS7ad9KYgr8Mgjtv7vnRJWM=
X-Received: by 2002:a17:902:f242:b029:e4:6dfc:8c1f with SMTP id
 j2-20020a170902f242b02900e46dfc8c1fmr17927976plc.0.1616237936028; Sat, 20 Mar
 2021 03:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com> <20210319174108.GD6832@arm.com>
In-Reply-To: <20210319174108.GD6832@arm.com>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Sat, 20 Mar 2021 18:58:45 +0800
Message-ID: <CANr2M19+FtoAiEgKecJFdkdhaBLidiGjFvNY1f1kOMsvdQZEVA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, dan.j.williams@intel.com,
        aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        ardb@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        broonie@kernel.org, linux@roeck-us.net, rppt@kernel.org,
        tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 1:41 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Lecopzer,
>
> On Sat, Feb 06, 2021 at 04:35:47PM +0800, Lecopzer Chen wrote:
> > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> >
> > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > by not to populate the vmalloc area except for kimg address.
>
> Do you plan an update to a newer kernel like 5.12-rc3?
>

Yes, of course. I dealt with some personal matters so didn't update
these series last month.

> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > Acked-by: Andrey Konovalov <andreyknvl@google.com>
> > Tested-by: Andrey Konovalov <andreyknvl@google.com>
> > Tested-by: Ard Biesheuvel <ardb@kernel.org>
>
> You could move these to individual patches rather than the cover letter,
> assuming that they still stand after the changes you've made. Also note
> that Andrey K no longer has the @google.com email address if you cc him
> on future patches (replace it with @gmail.com).
>

Ok thanks for the suggestion.
I will move them to each patch and correct the email address.


Thanks,
Lecopzer
