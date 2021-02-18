Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439731F0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBRU0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBRUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:25:41 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794E0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:25:01 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so1878748pgo.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RsUf6DAvJrxkKF61sw0FoJj/88tOAO5Hu0eokieYoU=;
        b=uVV7VcwGIlSKFaUa7b1aPfbOLYPEfFHJZjj2DUI9bay30pC6eh7kLqB7j+hN77IW1J
         QRpm0h2wCf5MdhX65mp4sfhgOfmykbNlA2giUJXS58Yohq8NXBFc3FCTy4of89FlUVgx
         D3JZz5LP8iiPJLxZPYPonijMJ4MlkgWJrgBUmIDWtU4lthjQHLQdOKQfyDXQBOBKoRJz
         VBsjzz8BnWoMaNDReGmOVhZe2YM15NWr/q6Kx2CcJxOYVF8C30S1TjVTJ9S+wy2Shb9F
         AT276VJHaV61fbpvMMwX4aAX6/3A/A49G3Vb7j9wQUsyp+suvODbQHNwhE3xxJ+abv01
         tp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RsUf6DAvJrxkKF61sw0FoJj/88tOAO5Hu0eokieYoU=;
        b=iw5yrrsX7cV0Wn0S28zz0OS/rSgdoIPw5mUcTn6m+LxnAW9/fJAfvWxZXYghpkS+Gi
         9A9INkP7Gdlvbm6eDki13cWwPvYL4Ha2oyb5ikAB4AVXjstJOIPOPVu0VSHRbyY7yZCM
         JxIafoQ8SLyi4KUkTWkJWtAvycXvONdFD5PTQASE9Eo14EGWzkg/Bk3Awif2x/X+LHlw
         PgNZSIjYkpGTujl0Jamh+6KFMQNzmqyJgjEUvKkTZtcKlFfBUIZWdVW79vLW1XMIbUYb
         w5Z0692YzgRcHzr8M6HWC0+stQ5IMngpLSGmuXcnqxEm97YTMeALn8EOhQkKRCNvc2t+
         Shzw==
X-Gm-Message-State: AOAM530e7VSGhEiZeaTA8M4/RhKa6Tu20wp8CWtRP1zmQItlaf1uG0Tp
        GiNzNHSMdhmFrR4JKkM5oj0M0D+Gswi8/SLgPCVdwA==
X-Google-Smtp-Source: ABdhPJywjrf+b1Rc115u0wbcv6nZm+Atkfxa49e5vcQLUu9ZBgUmwsWyhbMRPwrI2sTUXDa54lPZ0kFlephrZN9+V7s=
X-Received: by 2002:a63:416:: with SMTP id 22mr5353156pge.286.1613679900548;
 Thu, 18 Feb 2021 12:25:00 -0800 (PST)
MIME-Version: 1.0
References: <8d79640cdab4608c454310881b6c771e856dbd2e.1613595522.git.andreyknvl@google.com>
 <20210218104626.GA12761@arm.com>
In-Reply-To: <20210218104626.GA12761@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Feb 2021 21:24:49 +0100
Message-ID: <CAAeHK+z-Vsuombjed8OYYpFoL4rENpf1J5F3AzQF8+LsqjDHUg@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm, kasan: don't poison boot memory
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:46 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> The approach looks fine to me. If you don't like the trade-off, I think
> you could still leave the kasan poisoning in if CONFIG_DEBUG_KERNEL.

This won't work, Android enables CONFIG_DEBUG_KERNEL in GKI as it turns out :)

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Just curious, have you noticed any issue booting a KASAN_SW_TAGS-enabled
> kernel on a system with sufficiently large RAM? Is the boot slow-down
> significant?

When booting KASAN_SW_TAGS in QEMU with 40G there's a noticeable
start-up delay compared to 2G, but it doesn't seem to be caused by
this memblock->page_alloc poisoning, as removing it makes no
noticeable difference.

I also don't see a noticeable "hang" when booting KASAN_SW_TAGS in
FVP, compared to the one I see with KASAN_HW_TAGS. But I do see a
"hang" in QEMU when going from 2G to 40G with KASAN_HW_TAGS.

It seems that doing STG is much more expensive than writing to the
shadow memory.

> For MTE, we could look at optimising the poisoning code for page size to
> use STGM or DC GZVA but I don't think we can make it unnoticeable for
> large systems (especially with DC GZVA, that's like zeroing the whole
> RAM at boot).

https://bugzilla.kernel.org/show_bug.cgi?id=211817
