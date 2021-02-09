Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7DC315CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhBJBxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhBJAFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:05:52 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01262C0698DE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:34:30 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id y11so18906118otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYfAaU+gBcca7IuAhhFeMVoOKmdaZyZ+mleDrl99M6o=;
        b=uMWC68Ks3SY1GdCW+5mYxEwWNi1OLwA4mZXnhEiNyGp0shbrH30kRTYhdUIi0hTZvQ
         oB6vFwXp4o01GrgAw59WEHUxznMVOoxEQMLFXcqX6jWWyXCbBzNrsF5YSrLesSpJ87TJ
         tn+qWNcgkGNP7Kg7ZNtMF/btsp5mIMXhfWtoxh6rw9c07SLWQ4+SCOjIe26QKzCnqTLZ
         lbNrAismaj657IC3R1UrNZeV5XKbrLUJbGUuBzNV60CuyhVc91y83PA94MyGea12z8oX
         SgbhCWEMqvroz5IaWpId+eEtTHrHYHXMghXGRi8K7zQuXN59+sSeMkO7hhV8Lw3nSeGm
         jzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYfAaU+gBcca7IuAhhFeMVoOKmdaZyZ+mleDrl99M6o=;
        b=DVcD7iKKGCTbPDmOgiMb5Am0e4DkUGl2R+11sn/HEkGuH3lfes9bZ8SQZI21KhArg/
         51ECrAhHUnyjk2LuoqHA6SW/5ob+x/Uo6goUB979fi14EPwrok7eafpH/GzkovNFEdB0
         Sa5bd+Wa5+6DR67Abom7lvg53b/qkeOoHVHS6g2i34fuvLul9LSQAKzhOzWL21dHsD3Z
         CWF96ktRBfU9Ezki8D1zDFUmaM+Xi7m2CvDk5AW9qsgQIIorAnn+xQO30eKv4g9bIAZK
         brquhWUnNAAxH0oUP/SUKGUAmEsyWkrBjOQtIz0fYRolQuTg9wcfXBvW6MqwFFyI0VQI
         oaAw==
X-Gm-Message-State: AOAM532UjDM7MvSjgEoWuvUVk+KFSLhqoeUSJM7PCstC+xl1/ZoVM3B5
        VVZq7PVf7F9zBnoSuPneMmuh4RUHjgprJ65Ckigh4A==
X-Google-Smtp-Source: ABdhPJzVv6WwYxud20Q05eogiv5EadoAYl6sP2LpfAO8KxmSzeS3MpXkbVqBHmfZLPwaKo/EbOpeyR3xfUzCaZFl/l0=
X-Received: by 2002:a9d:7a54:: with SMTP id z20mr11279517otm.233.1612906469227;
 Tue, 09 Feb 2021 13:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20210209151329.3459690-1-elver@google.com> <4f39ad95-a773-acc6-dd9e-cb04f897ca16@suse.cz>
In-Reply-To: <4f39ad95-a773-acc6-dd9e-cb04f897ca16@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Tue, 9 Feb 2021 22:34:17 +0100
Message-ID: <CANpmjNOXjwiZpfzhi0Zu-gdQmwiK4dMiAE0ZhRcOnZaw00DaVA@mail.gmail.com>
Subject: Re: [PATCH mm] kfence: make reporting sensitive information configurable
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 19:06, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 2/9/21 4:13 PM, Marco Elver wrote:
> > We cannot rely on CONFIG_DEBUG_KERNEL to decide if we're running a
> > "debug kernel" where we can safely show potentially sensitive
> > information in the kernel log.
> >
> > Therefore, add the option CONFIG_KFENCE_REPORT_SENSITIVE to decide if we
> > should add potentially sensitive information to KFENCE reports. The
> > default behaviour remains unchanged.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Hi,
>
> could we drop this kconfig approach in favour of the boot option proposed here?
> [1] Just do the prints with %p unconditionally and the boot option takes care of
> it? Also Linus mentioned dislike of controlling potential memory leak to be a
> config option [2]
>
> Thanks,
> Vlastimil
>
> [1] https://lore.kernel.org/linux-mm/20210202213633.755469-1-timur@kernel.org/
> [2]
> https://lore.kernel.org/linux-mm/CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com/

Is the patch at [1] already in -next? If not I'll wait until it is,
because otherwise KFENCE reports will be pretty useless.

I think it is reasonable to switch to '%p' once we have the boot
option, but doing so while we do not yet have the option doesn't work
for us. We can potentially drop this patch if the boot option patch
will make it into mainline soon. Otherwise my preference would be to
take this patch and revert it with the switch to '%p' when the boot
option has landed.

Thanks,
-- Marco
