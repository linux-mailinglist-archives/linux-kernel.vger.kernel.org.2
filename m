Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E556334D9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhC2WBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhC2WBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:01:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:01:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ce10so21761913ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toyezCdg30sSEAZOhMLaVFjK3eNVHWrmf65IUPFvlVE=;
        b=PmU+1KxhWZdi5Fh5U0BVrNpMExCpP2F6av5vylIDKY9DDZowaatfzMK5XEcMfBAkwd
         TVcGAtJxZWjlbjZr2N570h0X3x7QeBBHTSPRA19X+ZmN6GoMEfTA7v4ioSk+BA2HzeXk
         067z6FsLDCAIrpZGneNLhgh8O4YuagUcJxkbtJXDXq+KnTd5ZsV6S3GAjdJY089UN7Md
         Y3qXf21ahWHD1P222a39xOjgGMMukYLeEWkOi/cziKk/iacGk1UujZpYgxPSv0rE3YJr
         2fpclub80IhrhxKAyeHInreaJ7q0xNy8JsnK2bwR0Q6lF6NBVqNk6AfGXuC6A3kzPR5J
         he2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toyezCdg30sSEAZOhMLaVFjK3eNVHWrmf65IUPFvlVE=;
        b=oLltq86f5LgUstga26gDZho3V8V/ONgU0RKKicxXP/SUEyU5SiecT1FxM+PovRW6gZ
         U4eMEQF6r50LPs47Ioc4LR0YH5A5pPvGt5itZTVLGzXWz4U9m9HmmXLFzyJvGnEESM7/
         75S2yT8weG0S0YTwqGfjkT0ACk26FszpotFg+Xfzvv7BDwXM900w5F9CWc9KHXDjoRop
         aug6RGocv4adCxW9WFjbe3feXP9o1tPvtMxkKEG3z+wU2pZ6sn0H5wohOqLnd5aaYsqu
         CfLb8TCxDrfEOgEQsYn604L/QN6Mth+p4mBV4iUhKtJckqhxGRaEpaEuL+mGjnBnkNyR
         W9AQ==
X-Gm-Message-State: AOAM5321ALpml3vkS15d82gi0VJQQOEmdugpi2v0+gIyK5h+cuE18q42
        6oxsJ95vV+harAmCKeBrCdRvkr76Ge9AIE9opwc=
X-Google-Smtp-Source: ABdhPJznKG/K7Yf6ifOnHyn6fguEd/iMMzBMUyX/HtjM5aOMcAI5GdJKjCNgR1aAVJ54oSzrGJRsGyHE9sA8D48q+gU=
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr30582963eju.439.1617055260095;
 Mon, 29 Mar 2021 15:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210326112650.307890-1-slyfox@gentoo.org> <4e23d404-5125-6c9c-4aa7-5eff0fa1ba33@redhat.com>
 <469d6417-64a5-fe99-1214-bb0351833b74@suse.cz>
In-Reply-To: <469d6417-64a5-fe99-1214-bb0351833b74@suse.cz>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 30 Mar 2021 00:00:49 +0200
Message-ID: <CA+fCnZcZvBT97y3zEatnTvi+RBW5bCrQRim9uK6wobYQOdgNhg@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: ignore init_on_free=1 for page alloc
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 2:10 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> > commit 855a9c4018f3219db8be7e4b9a65ab22aebfde82
> > Author: Andrey Konovalov <andreyknvl@gmail.com>
> > Date:   Thu Mar 18 17:01:40 2021 +1100
> >
> >     kasan, mm: integrate page_alloc init with HW_TAGS
>
> But the mmotm patch/-next commit also changes post_alloc_hook()
>
> Before the patch it was:
> kernel_unpoison_pages(page, 1 << order);
> ...
> kernel_init_free_pages(page, 1 << order);
>
> Now it is (for !kasan_has_integrated_init()):
>
> kernel_init_free_pages(page, 1 << order);
>
> kernel_unpoison_pages(page, 1 << order);
>
> That has to be wrong, because we init the page with zeroes and then call
> kernel_unpoison_pages() which checks for the 0xaa pattern. Andrey?

It's similar to free_pages_prepare(): kernel_unpoison_pages() and
want_init_on_alloc() are exclusive, so the order shouldn't matter. Am
I missing something?
