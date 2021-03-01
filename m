Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5141329CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442671AbhCBCPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbhCATnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:43:41 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B90C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 11:43:00 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a17so20942179ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 11:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bl+ZuzEypuf8kg9PH2Q+NcKdz61SR9M1N9NpVnL3IcY=;
        b=f8FI/aqMcBBwEswSOdmXhLFX2VmTftmQin4Rehq7YmdpV9rTs2SDqzaK8M7LvMOD55
         vr6M95MznwWygUjeVeAXYL9pdYzu8EJ4nqzFAQBEy+Q47DlFyUCXsskZ0r9gqBJthmEW
         y/Bm4+KZFyW5bHsHSAcIXpCSy+dyNpwWlhRUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bl+ZuzEypuf8kg9PH2Q+NcKdz61SR9M1N9NpVnL3IcY=;
        b=XHIxu5Ga/1uGVeid0Yq+zBjrqjTqsexnFI9MPQM6uKBPwR1t/HSgdOwos5jjgT0/Yi
         4RpnoMISPHMFhU7Zra26mTS+67pqw2P1qbvCns8EXitPRaVjKrgzs1GhOg/ed1hrWyZ4
         biE2PkkbFwdiE2N7EnJhrzIHRRAQLWeLa22h3IYZugJaIoDnQ7ns+wGZsySqrWBEjfiF
         yphlPOXNNaFrRe0gAgzHuiR4G2V02yabkBRsPICXD860om6/nsuoWQ2yo4HHQ5QoDT9p
         B7JXfeCDFGbUzdaNZCvR70iso/0V2sPsaUArej8niMf8ykoGzCJGlTKzmiSK7dD6A6rt
         OZow==
X-Gm-Message-State: AOAM532E9Ies3css8ag45E5+bJbPvbt1V2SBy/pLpUr6Aa0oOqo7FC9S
        zAZKufeoiftfqhzShATyKkHIkX05Zz2RYg==
X-Google-Smtp-Source: ABdhPJwwnYS58WKw6TIGMVZoc4VctJZn/B7dOYOoWWedUPVgW7xNQ2uzj3phENt7rNj9l2VGoPvJ3Q==
X-Received: by 2002:a2e:3812:: with SMTP id f18mr10581949lja.29.1614627778947;
        Mon, 01 Mar 2021 11:42:58 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k13sm805173lfg.192.2021.03.01.11.42.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 11:42:58 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id p21so27383938lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 11:42:57 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr10013711lfu.41.1614627777255;
 Mon, 01 Mar 2021 11:42:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614616683.git.dsterba@suse.com>
In-Reply-To: <cover.1614616683.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Mar 2021 11:42:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whd9rDePO5M6roDcxvb9EWNTQ2FuLd3rWKWHQ03FqT2ZQ@mail.gmail.com>
Message-ID: <CAHk-=whd9rDePO5M6roDcxvb9EWNTQ2FuLd3rWKWHQ03FqT2ZQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kmap conversions for 5.12, take 2
To:     David Sterba <dsterba@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 8:52 AM David Sterba <dsterba@suse.com> wrote:
>
> Ira Weiny (6):
>       mm/highmem: Lift memcpy_[to|from]_page to core
>       mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
>       mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
>       mm/highmem: Add VM_BUG_ON() to mem*_page() calls
>       btrfs: use memcpy_[to|from]_page() and kmap_local_page()
>       btrfs: use copy_highpage() instead of 2 kmaps()

So I've pulled this now, although I still end up wondering about one case there:

-       char *map;
-
-       map = kmap(page);
-       memcpy(map, data_start, datal);
+       memcpy_to_page(page, 0, data_start, datal);
        flush_dcache_page(page);
-       kunmap(page);

where that flush_dcache_page() is now done outside the kmap of the page.

If you have an architecture that does both (a) highmem and (b) virtual
caches, it means that the "memcpy_to_page()" gets done using one
virtual address, and the flush_dcache_page() could in theory be done
using another virtual address.

I do not believe this is a problem in practice (flush_dcache_page()
might have to kmap it again, but presumably get the same virtual
address, although who the heck knows). And I personally don't know
that we should even care any more - I've been arguing that we should
start deprecating highmem entirely, and while there are 32-bit arm
chips that still use them, I hope to $DEITY that those ARM chips
aren't the garbage virtual cached ones.

Furthermore, I think that kunmap() always guaranteed that the cache
was flushed anyway before unmapping, because anything else would have
been too broken for words anyway. So I think _all_ of those
flush_dcache_page() cases were just largely bogus.

I can't be bothered to really look into it, because at some point,
crap hardware is just too crap to even care about. Pure virtual caches
are where I personally say "I don't care". But I'm mentioning it
because there might be some masochistic person out there that finds
this issue interesting, and wants to do some self-flagellation to dive
into this all and make sure it's ok.

           Linus
