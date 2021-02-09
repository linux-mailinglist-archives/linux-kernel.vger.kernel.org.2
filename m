Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0CA315288
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhBIPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhBIPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:19:19 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C66C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:18:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o63so12651046pgo.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8z+fvqZU/74uT7CiRrXKR/wJqmxTaOLawIi73kIU2s=;
        b=bvzxM6Qp5iy3TfLx73dO4RRCu4N5Rm8b976Dn5V5qWohqQb959MwSJjcVBffKhRX/Q
         BnEA2PW46pj53nh1l/5OHZ2Neki5RYnxUdrXY9mL/Q7agO8tGouC0UG78bZO6mIab+Wz
         dcyg6zh6OPZjsKVch/bD8kEfLE37UlH/YRsKzaDjNyTqRUW+Kg/tv2AA0ylD8G1n3W9C
         IAGN09ouhC7vuOiS7jidXbVu2s9Pu0JCqiugs5tJGDwIVjPO+o69qduZ4QBvmdjSZiw3
         Q/6mLCNaxH6ltG8NUfKhZtRBnlQSIBsufkEXwpD9B7vti/GKv9jJIbXqI4F36wABQJmI
         pdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8z+fvqZU/74uT7CiRrXKR/wJqmxTaOLawIi73kIU2s=;
        b=DnpQ+tk7IFtlthHJUZJGsWQC5lQhuume7qsHKXtzKqbfB2ysNcNZ83PgGb522hkY8z
         Dp8WcQDq7fTcIwaMSYSrLNsWjGCz+8rXWlpsmOFC0oUVUlI3dffAeFi9HAqGZ1Hhqyhr
         0+ONPv3GWYif9xZYqf8LnUo8qCLgsK4rj4i8YUJHwpbYhxPWJR3oc4YO7K8m9mW3tpy4
         V/eaeh3E4q53SwY/LQaMsV441Y5vknB8z5j5ro3Na+Ox/nXyg5AWwNB9pQTvaoUQMIEP
         9cDw8X5e/UFbuAXKr+C3eWeRgNXTVFagc/TkakDr0A1K+ttUmAEaLmEBZzIOPVFek8eM
         5BKg==
X-Gm-Message-State: AOAM530fUHuPDp3I0ewtAQR6qqmWW7reG7oT4M/+KFfiFHsdd6OjW11K
        l30aD0daQrQxmA0QDV4FuuxNYCdGT2hBiOa+CHxqqQ==
X-Google-Smtp-Source: ABdhPJyUpO5az9mRsnj7tNYDjgoANXZS0oHR0ipzH5VpgZN8puZOql1OUlXDQU3c+eu4BGYEkthmYuNMUb4i0NJys9o=
X-Received: by 2002:a63:a0d:: with SMTP id 13mr10387786pgk.130.1612883918125;
 Tue, 09 Feb 2021 07:18:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com> <068ab897dc5e73d4a8d7c919b84339216c2f99da.1612538932.git.andreyknvl@google.com>
 <20210208174247.GA1500382@infradead.org>
In-Reply-To: <20210208174247.GA1500382@infradead.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 9 Feb 2021 16:18:26 +0100
Message-ID: <CAAeHK+yn9ggY5FmwROMZU-q+hQEMgUcqTAo_v=_aFaVhfd6VHw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: kasan: export MTE symbols for KASAN tests
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Will Deacon <will.deacon@arm.com>,
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

On Mon, Feb 8, 2021 at 6:42 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Feb 05, 2021 at 04:39:13PM +0100, Andrey Konovalov wrote:
> > Export mte_enable_kernel_sync() and mte_set_report_once() to fix:
> >
> > ERROR: modpost: "mte_enable_kernel_sync" [lib/test_kasan.ko] undefined!
> > ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!
>
> Please put this under an ifdef for the testing option that pull the
> symbols in.

Sure. I'll send this change as a fix-up patch instead of resending the
whole series.

Thanks!
