Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF8308C33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhA2SLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbhA2SLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:11:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F89C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:10:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w18so6711271pfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ih9nZpFKdQtp/jnR4XaYa4e6X54Ve9TzjAXS7ra/gr8=;
        b=uw1AfPuPPKXgR1eJC2TrHBWOVTCNnPrz+/EkhkLBdYD3a7XHR7jhM2snmKZNsrUbR/
         59CXDaU9izcK96kCwZZTlNaDV1giYx7/ozKMdEmjRBHM5Bp/ySHhKAaSkC2Eo4NIv6aS
         oQr+51HF2SJ74gGDhcH9yhxU4KS+/CX8+kDXpXBfKCC6gdAeaUrd6c5QWpO00UusasqB
         U2TPrA9cCzXlinags6+bCD+G6E9nOgpAmLxaaxYeshuhGPdq+1WZzMJtoHopyFnOz1KT
         eZBBltB1PIBIyAt/yI86Q25BapH1Kh2WsOm33eqyHiqxiHizBvXFKAnsVjJZIvg9mZDJ
         82bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ih9nZpFKdQtp/jnR4XaYa4e6X54Ve9TzjAXS7ra/gr8=;
        b=ciQ/hGw27Vaso1lrVNTlz0ZC9tIfHWWpJdQvQPrmkIKbuRgfMLKnWopBmv04zxT0u3
         +ZYe3rf3vfjcLgDiQEUH7HQQ6HQHrTEpkJQoHH4WkqND14jax7ZMVYyqU/DK0YgN/e48
         PP6s3UY0BK1xHN9jCeKFYNFzeuHiB1gIYOaRZQiCnJ0AlNta+wXqgpnOBj4BjsxwGiO6
         cdPiNjCndCkeopFflLVDTUbciq7yGh4d6adBqFp9RiuQBSCc8udGd37gMhyBi5nwo8lD
         AD1NDSuZyjlmTZaMqCcqhoalWAFJPGtVhKfzPqQKEtt6TduyoNcPxGe7ODh9JWvic38z
         /zlg==
X-Gm-Message-State: AOAM531LfAXZhJ6OUEI4k4VbiX0VHzNFnsUu8+fuZCa6MlbkxPkkfPfQ
        n5EncVux/RhJzFvLR3g23y9s19TvpwbukXp5HH8mqA==
X-Google-Smtp-Source: ABdhPJzeiS65cwDy11w6iYkCd0nJQhPN/VoN9rsg9/3vHHHUXIRhQ4HU42gaErR/FeUJAi0L4A6Qr95/MsD866SowJo=
X-Received: by 2002:a62:115:0:b029:1b4:c593:acd4 with SMTP id
 21-20020a6201150000b02901b4c593acd4mr5465555pfb.2.1611943838410; Fri, 29 Jan
 2021 10:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <20210126134603.49759-4-vincenzo.frascino@arm.com> <CAAeHK+xAbsX9Zz4aKXToNTrbgrrYck23ohGJHXvgeSTyZy=Odg@mail.gmail.com>
 <77de8e48-6f68-bf27-0bed-02e49b69a12d@arm.com> <CAAeHK+xMWXpfLs6HuKN73e0p61nm+QrZO1-oXphJpjZprKQVKg@mail.gmail.com>
 <7da762df-6df3-e526-bec1-dc770709c00c@arm.com>
In-Reply-To: <7da762df-6df3-e526-bec1-dc770709c00c@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 29 Jan 2021 19:10:26 +0100
Message-ID: <CAAeHK+zrkLpOe2aJjWVMPHbvSFMXAEP2+fJVZ-3O4E--4-2KfQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] kasan: Add report for async mode
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

On Fri, Jan 29, 2021 at 6:57 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> >>>> +#ifdef CONFIG_KASAN_HW_TAGS
> >>>> +void kasan_report_async(void)
> >>>> +{
> >>>> +       unsigned long flags;
> >>>> +
> >>>> +       start_report(&flags);
> >>>> +       pr_err("BUG: KASAN: invalid-access\n");
> >>>> +       pr_err("Asynchronous mode enabled: no access details available\n");
> >
> > Could you also add an empty line here before the stack trace while at it?
> >
>
> Sure no problem.

Just to be clear: I mean adding an empty line into the report itself
via pr_err("\n") :)
