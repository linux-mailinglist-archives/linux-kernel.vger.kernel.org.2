Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8C3EA116
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhHLI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:57:21 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C4BC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:56:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bf25so465483oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpNbFyXnXHPCTrfQK9jrNKENE4zlP3yIY6h8yYZAoL0=;
        b=XKyvMwXf6ld2suQ7v4o10/Mwzba2BnazQYjm/Mnva9F/4jx4nj2FjysWxq3ZQpPKs+
         qcqWHbHCGNka/QHgern7puGDE0EdMCRkOYmgJw2oiPLTFMOwCXZtIiHVYjevSP70wb3y
         oZDKnKBtwE6F9K6DHixs8ztsAOx5w5UHCUNsVjxjqxjdp8qPp/jsqj1PDMn/oYFRpeAV
         I1iDgtnM1M4z7JMqs6Mio86xRD6mtDWHiAB8HVwxv5hUWbnG91XD+UOQ1NeEFqj43dJB
         BG46n7EmY3Zm/dbe4i4iOELegT/bA3SVUCpIYpsdvwTxQeaNb8EkPWnpLigVaQNHK713
         IfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpNbFyXnXHPCTrfQK9jrNKENE4zlP3yIY6h8yYZAoL0=;
        b=exiFXGkmpblTM5s2cDr8Cr+1sioPyhIzTQfohr4KZ0iUUMSOTQDdgLm0L3QJulTsXr
         OJWqvpmylz632WfqAWgpHm2g01ms8Ivi/FhwBvwzHqYhr0zyEcq0kMNpl/1cBzYa1Bq3
         V5iVq92pCNGTwZWpLzDNax4ovEGn39SFK/FZFywaTMz+ihv7BkhRCmRvuHJzE2Z57buT
         Y9myr6XkL4kHMllGb8QVg+8riOGDw2t6xYMu4Ov4bPaO/z7FC3ltraBZh4iPqPEE22GR
         67t2ec0eVYNbujFPx57HWol2tIt+Hn7dcunZKr395RBvF7l4Rh/UhFb3E+EgcP1dtjDw
         yoxA==
X-Gm-Message-State: AOAM5327gucmx9dv0RVS9jp8pqc9dSYQIFWPJEyP3krxwnzHU0a/E4pu
        Jpo2d06HJksWkWmlQnNhE2dKFtRNOwLJJDxEfczxjw==
X-Google-Smtp-Source: ABdhPJymXxOTmk35yp+1Yawr5fY7uG03snHwzVDeA1bE4jw7jms1BHO34si+giJK72JgJCcEloICZoJ0dCiPPSlgzyw=
X-Received: by 2002:aca:2316:: with SMTP id e22mr2503665oie.172.1628758615724;
 Thu, 12 Aug 2021 01:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <6e0ddf32ce140b9e8aaf127e9e40cbfff4430995.1628709663.git.andreyknvl@gmail.com>
In-Reply-To: <6e0ddf32ce140b9e8aaf127e9e40cbfff4430995.1628709663.git.andreyknvl@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 10:56:43 +0200
Message-ID: <CANpmjNMNMoPc8S_xTG3ANBZkVsanq=vnsAPkL=pe+cOXbTySzw@mail.gmail.com>
Subject: Re: [PATCH 5/8] kasan: test: only do kmalloc_uaf_memset for generic mode
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:21, <andrey.konovalov@linux.dev> wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> kmalloc_uaf_memset() writes to freed memory, which is only safe with the
> GENERIC mode (as it uses quarantine). For other modes, this test corrupts
> kernel memory, which might result in a crash.
>
> Only enable kmalloc_uaf_memset() for the GENERIC mode.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Acked-by: Marco Elver <elver@google.com>


> ---
>  lib/test_kasan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 0b5698cd7d1d..efd0da5c750f 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -528,6 +528,12 @@ static void kmalloc_uaf_memset(struct kunit *test)
>         char *ptr;
>         size_t size = 33;
>
> +       /*
> +        * Only generic KASAN uses quarantine, which is required to avoid a
> +        * kernel memory corruption this test causes.
> +        */
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
> +
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> --
> 2.25.1
