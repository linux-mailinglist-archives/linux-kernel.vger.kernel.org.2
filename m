Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69E3111EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhBESZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhBEPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:19:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABE4C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:53:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q72so3947222pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcw9n9RMMUVWxg70MWeK9kZh+kpeij9pYEkv2fQx0mw=;
        b=VozpUkTk78uVgRSkBc98kz8O+i6S29kQobFxqGqpIM0Zvx5qN4kR40XAhEA/qvd8D7
         5EACMb1+Or7OFaMSnYoakkDR6b4t7k6xAHEp+klsPMmrHdDfZCUqLKuWxyJU7sWzrxme
         F2dovMuQ1dSXqUMzF0/+7Dlr0hu5GWseR+BrscB1QH4bWW+4vby5MAcJ84dlz9DZmLnW
         XpnNjelS5ggUGC8/YDYbFEZtE1GlAtwgaqjoKnLW0Oxl2VqbCJZavudq4gniB5ayG7iP
         FQm9F4aC8512iDs3dK7kHOstKS2vFH+H5WiK8561SNaBrVAkJGDiPozqmfzG6LeVW5S3
         YUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcw9n9RMMUVWxg70MWeK9kZh+kpeij9pYEkv2fQx0mw=;
        b=SMtNgk+j810QKpqf3qQWGU9Cwjmnd7pT8vYnrf7pz7LS0k+xhfrCYOfLStfityE/gD
         h4yDGsopR31nY0+RT88wku5nyNvDwPDzDWpx7to8LP/7o9gQVP+KZfqMhDh5EVn/ShMJ
         8yiD79oIm/M+oZzRV6tmd+0opGXnBXwjo+EGhjbmRrcnswe6lygsayru6DQfZKgL/8T7
         BAQhG+sktrGoHiKxyy3OTv8nIpqMRNqiajPyu7kRev73Q8jUSbwRXN1h3kssya3av8Nb
         KVzUsFbC0ncm9jIBwo4XKQMvnYjUzmHWhf/1ryun2y60Uf0RJZWNIPdjIcKz9hAvAnQ8
         NCHw==
X-Gm-Message-State: AOAM533WbTh70wruzZrQhBzfufvO/ZuGT69S/tg6CteIyPcQ/nF1Va4s
        2t/M9PZhLI79S+R38PCCjmhxM57ulkkgEUFc2ew6JQ==
X-Google-Smtp-Source: ABdhPJzOx1jzUf8Kvry3ymXe4EY4ug/A0RJ08P7be71hr9k0BaqcMjZLARXIWNDFyLts341ZMN8uGabiZm2lJPK4mDs=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr4916787pjb.166.1612544030033;
 Fri, 05 Feb 2021 08:53:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Feb 2021 17:53:39 +0100
Message-ID: <CAAeHK+zNRd4BZz4v2r2Q__Px+Cs1ncmBiYbLPyaTnixbiCp0nw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] kasan: optimizations and fixes for HW_TAGS
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:39 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This patchset goes on top of:
>
> 1. Vincenzo's async support patches [1], and

Nevermind this, Vincenzo is planning to do more work on the async
patches, so I'll post v3 of this patchset based on the mm tree.


> 2. "kasan: untag addresses for KFENCE" fix [2] (already in mm).
>
> [1] https://lore.kernel.org/linux-arm-kernel/20210130165225.54047-1-vincenzo.frascino@arm.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=dec4728fab910da0c86cf9a97e980f4244ebae9f
