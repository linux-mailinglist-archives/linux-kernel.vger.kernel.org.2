Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138D30B151
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhBAUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhBAUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:05:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485CEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 12:04:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lw17so470319pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Er+3gSvGmPD8gB+0H5nskQtEmoQnaFUKfPK4BzJ3IdY=;
        b=DQXWHKUAOl+6nuNBIcPbQqaNwY8TdE+kp78aiNtN4D6zLY853C2Q8NNPnJSR2J/laE
         D27MyCmz5qygk9b2ZHVMbykuaeF5g2Mo7SXwxQOkt1q9XpgVfK4wpOFTfrqfE01ASkDw
         3sACp4olX4VzOiATjE+y5nxv1BKJRrlTtwPDIRR9vgap6flWizHnC8gvAxKKxKWzrwhE
         7xNaRcK1Y3uF2wjE/iA/OD6RTxSanunLfEvuPuEqtf422MaAsa34aVNOrLrGbzxG5p/3
         D8LwAIMJKynJTVglpYBO3xYXT3EOluDt5/BssadUrOtNBvQfmSls3vGBIETtKpuAqMro
         xCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Er+3gSvGmPD8gB+0H5nskQtEmoQnaFUKfPK4BzJ3IdY=;
        b=M8r1AVDOHm94ULgQaRUsS/yeSbKppsUvgIZdUq8dissHOYphqtmaHYHFbx1lxyb3xj
         fphnrdkprjtBGsOFmbxspJc+nMwLMNCKqHJGIGCpogKtaB3pcoKmuPSmBxhRxw/HOfpz
         D5n9Zpe3g2qhBohnXnGdiz4sfIsHHopj3Ai/b/ViiNE0qz9Rc/qPjrQ0aZbX2186AIoF
         3zYqQVkJUET4h7QfxRS3iIQPxi8lRUQkoey3BKv+kljxLywqvAJrSx2043RseAu4UVlh
         xos1IhN+vN6X9JtQZT/vCtbniDJPPAeaFY/PUMREfR4GXxAK91FUHLdHKApd2N9BYc8j
         ZVQw==
X-Gm-Message-State: AOAM5307BIbCJM1dGPsX/m49ITYQjN5tqYI4YsgAXcT2U6+SEPt85zvm
        6ALrJHLW3WlCSfifvpAWxrCxPJ/Q81NtvmxbXEtQ0Q==
X-Google-Smtp-Source: ABdhPJxA+IMt4iXXITzeYTc61BsQzJCR/cFKLgyNeCCYaJQTuWxQK1fCY3WUu0m8LAjZg5y9ELwSH6lsK7w6RC4vljM=
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr521695pjb.41.1612209876585;
 Mon, 01 Feb 2021 12:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20210130165225.54047-1-vincenzo.frascino@arm.com> <20210130165225.54047-3-vincenzo.frascino@arm.com>
In-Reply-To: <20210130165225.54047-3-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 1 Feb 2021 21:04:25 +0100
Message-ID: <CAAeHK+y=t4c5FfVx3r3Rvwg3GTYN_q1xme=mwk51hgQfJX9MZw@mail.gmail.com>
Subject: Re: [PATCH v11 2/5] kasan: Add KASAN mode kernel parameter
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:52 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> @@ -45,6 +52,9 @@ static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  EXPORT_SYMBOL(kasan_flag_enabled);
>
> +/* Whether the asynchronous mode is enabled. */
> +bool kasan_flag_async __ro_after_init;

Just noticed that we need EXPORT_SYMBOL(kasan_flag_async) here.

There are also a few arm64 mte functions that need to be exported, but
I've addressed that myself here:

https://lore.kernel.org/linux-arm-kernel/cover.1612208222.git.andreyknvl@google.com/T/#m4746d3c410c3f6baddb726fc9ea9dd1496a4a788
