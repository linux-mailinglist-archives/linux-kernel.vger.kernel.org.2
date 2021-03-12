Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F66339053
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCLOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhCLOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:49:32 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E828C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:49:32 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g4so16014468pgj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vE6AFNK5NMZ2XRC6U1hmnn/pzLhXkxOhFssXJpRkl/A=;
        b=EnmQRw2Lg/11jLVauNGBjoo4r8rYVZ+MqNn+ifRNIiIIY5OLTGN/l/FoIQm9AG+Xpc
         aKFy0prh8UWzxpksDEiQbeGTvVxDxZzsLnYtMrUpzVMhs2C+q2/IvSaavvZ/fnxMv16R
         C55VaC36O2oH0/bEQk6dZQamG0p22l1/KydocOz4V7a/dmBqNFFfyZYTbJJLWQ50lAFR
         xqFQ+E/ccgzEqfotQW3SnowAdAjSiLk3QU4cm71GFp2wAI7rZ/ZwvxbHYZX++x/50U1N
         5fq6fUSTTh8vDJ5oEg8b3DXaYT2Cl3Xxpxlw6iMXaB4s6MyoiUdV+MfzDh/c4SspHOW1
         P3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE6AFNK5NMZ2XRC6U1hmnn/pzLhXkxOhFssXJpRkl/A=;
        b=tysGaNKwvGnJFItK5QTQb1rMCVlb13FosOlNRANJ7n0U/u4e7poIlP5nok8Tczzn+i
         9Ajzqnkih69/uXKNVk9oGpnS5PwoN1b3ZcewboEvKBaRAyqUupoF175I++KEfgIt6Voj
         LsU1OriXtEPn/ihQlDfqelBOpvLeOoft5i1iOByg7fqFuiwj7mQWhRnDkhYbnrvDuDlg
         dDF75pwnrpXhktqZOq2/MzKk7eqPLlhEM+xX8N76BcEcesgtDyh+Mj1I9oRZt6OOweHW
         kyhtnOfZyR+1/h/KrldtUNc7vWHcM9vygyZ7mJdZj1ptK/lHa7Vx2YPxgiLZLDA+mvbv
         i6KA==
X-Gm-Message-State: AOAM530sqbW3F+M1WgT9E5V76IKyhzUCv/sfNB2bzn7KolYdXTKjKQHb
        HMFDwHni8C72b9YqsvYfbMOlE9Gf8owkmb7auL1Ycw==
X-Google-Smtp-Source: ABdhPJycA9bbH8kZ194N5M4klbFBxYhcwc60YpqRfxxQFvVVGoCccUvAro/am4OiT8F7DCbKDA+kl8nDlaLl2KKnFl8=
X-Received: by 2002:a63:455d:: with SMTP id u29mr11894620pgk.286.1615560571751;
 Fri, 12 Mar 2021 06:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20210312142210.21326-1-vincenzo.frascino@arm.com> <20210312142210.21326-9-vincenzo.frascino@arm.com>
In-Reply-To: <20210312142210.21326-9-vincenzo.frascino@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Mar 2021 15:49:19 +0100
Message-ID: <CAAeHK+yoeLfkztNCifJuZooBwe+9np98ch50-ToOGKi1swC1vw@mail.gmail.com>
Subject: Re: [PATCH v15 8/8] kasan, arm64: tests supports for HW_TAGS async mode
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
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 3:22 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> This change adds KASAN-KUnit tests support for the async HW_TAGS mode.
>
> In async mode, tag fault aren't being generated synchronously when a
> bad access happens, but are instead explicitly checked for by the kernel.
>
> As each KASAN-KUnit test expect a fault to happen before the test is over,
> check for faults as a part of the test handler.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I believe this needs your Signed-off-by as well, Vincenzo.
