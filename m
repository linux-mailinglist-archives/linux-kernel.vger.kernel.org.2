Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408763BF118
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhGGU4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhGGU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:56:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED69C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:53:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c28so7668355lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWu3QVOTeUxlL22eAEVvjuwGrqkBirMWX6Uul/gayos=;
        b=oB1tZvS2C6wdt8bXQ6VyPQ06nRjpDgwW4zhA9viHIgemWVC3N7Km/I5aZtZWAzZNHf
         ziltRaLuxetuvx9MdUC+fS6zoS55xUomEaYfGIwLm6q5g4kitJ228TjDuJQXfQXHfm57
         hWBFZSytJ/98ZLAD5LM+/ALH6G3TGOXldp/SVPm2DT/M0iHrzEs7v0OOrU2kr+V6I+4m
         Syc1GNJYwvznnD4ankuZgO2aCrJKXmNnGpdXVM2Af8PDmhHO8S7za0ZzTcdIwyp8t7WK
         gGvhuNkiKhVrz096b2/UN7GMOsuRFdipJvXOmgt5G28otO0dnhA+hbVBewa04rQaaoMu
         t1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWu3QVOTeUxlL22eAEVvjuwGrqkBirMWX6Uul/gayos=;
        b=eo26R+m7iqTtfhIs3C95cGdjceNOWEjteHKbTRTLM67Jzyt4Q+TTZI+3n0SZ2f6e3R
         8kCU2BYmJyomTSNXuqjSl1Ru9yolcd7Zs2f2C5uVNmGPwUcZvDEyJvBl9WynIJThRc6f
         caHAS58PPgSdWxmS51ODAoMnRiFSGPSyplwJvlm4/2nLWDBje7JqnMULsfmw48/M2dX1
         KHeujsSer+qL8xdKzhd+7GYc/jWsUieP7qm6B4wB7ghzVtoTsPs6S7UcpCStQvUTnYPv
         JP+x+G4/a8Wo8l73Pb4JflBgnODT1r4EORIYbEybSvFcFFn6+Z2ILsVT4H/fpv6eOhbt
         iBCg==
X-Gm-Message-State: AOAM531cuwxVG4nL0a5zQ9c5tvAwa6fJRm/wUP/Xg8iYV7J8i1Ud++8z
        4p1aDWEt4HPhZQBmm0UUiczzOcUz5yv5KNxHd/lEdA==
X-Google-Smtp-Source: ABdhPJyVTPOt80HxqZFB61uQ9A5qxjQORTzjqtIZ+O5e7nCD1vMQJGQNXIH5d5vak8TVCon4dmUFEe03ut3kO4kiuVQ=
X-Received: by 2002:a2e:a78d:: with SMTP id c13mr21293260ljf.0.1625691217400;
 Wed, 07 Jul 2021 13:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <cfa154c-d595-406-eb7d-eb9df730f944@google.com>
In-Reply-To: <cfa154c-d595-406-eb7d-eb9df730f944@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Jul 2021 13:53:26 -0700
Message-ID: <CALvZod4m9iCD9cmfDqRPOqz=i5AkBdLQoJqYz2HQ2Av=mAt8yA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/rmap: fix old bug: munlocking THP missed other mlocks
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 1:08 PM Hugh Dickins <hughd@google.com> wrote:
>
> The kernel recovers in due course from missing Mlocked pages: but there
> was no point in calling page_mlock() (formerly known as try_to_munlock())
> on a THP, because nothing got done even when it was found to be mapped in
> another VM_LOCKED vma.
>
> It's true that we need to be careful: Mlocked accounting of pte-mapped
> THPs is too difficult (so consistently avoided); but Mlocked accounting
> of only-pmd-mapped THPs is supposed to work, even when multiple mappings
> are mlocked and munlocked or munmapped.  Refine the tests.
>
> There is already a VM_BUG_ON_PAGE(PageDoubleMap) in page_mlock(), so
> page_mlock_one() does not even have to worry about that complication.
>
> (I said the kernel recovers: but would page reclaim be likely to split
> THP before rediscovering that it's VM_LOCKED? I've not followed that up.)

I think, yes, page reclaim will split the THP prematurely in this case.

>
> Fixes: 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge pages")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
