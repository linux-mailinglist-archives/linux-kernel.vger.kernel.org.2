Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572C3EA4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhHLMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhHLMzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:55:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D77C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:55:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bq25so1341345ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hetAWS8vJTkbvJ1Yuh2ecULwYt0HQ0q3zS2e3QmOOk0=;
        b=VX3lXUncEAiMWCQXnnXyzQhXlgIUCn+99sQZAdcGcSPeCwxoiBQLOYxunMYCp2evFy
         PvDkaahs2fIVWzYkjnfhqbuT/TcmSgbaRkPDb4/gXnbSiXAHh+q/HnERGAinmqLS6Z0s
         2nqvrzAq2/PAi5rpwaOdTGc+2B9oPKwBy+xyeSL6nEAbvcgKGZMkdIT+Npq4HeHqU4NR
         Ro5GOsX/6ci3aDRIg+zaloKpMkD08g1hXxTdo9pZzGp14KV/8bx+DC72UUAtDAOQJKxM
         uwkBkhURpaVyyIGy9UYYIepFjRFXXsI9BEAsjiFRyz+VCdDKsFXzjC9P2SLrLM5h4891
         yZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hetAWS8vJTkbvJ1Yuh2ecULwYt0HQ0q3zS2e3QmOOk0=;
        b=WiHsC1zReVKgRQ5Vb4fPI1YUUYTFXcBuHmaOb5GFQXTRJTMY9MD840CZ27w8fudrWj
         owwWFRBrEUiAseIZT+ffR2iXRcO5fxH8o++ZcxU+1AjRaGn9DprjQBf9ZjberaNiHj5X
         kIJHZeOguLzOAP1tSzxChXQVZ+G3FszWmAzYFsvWWnNRR6o+PHEYrPHTIREEWakOVIr3
         msWVGevBfUsAm4I3B6gTERiHPHVDqGsVSe1paPJPyaZJCe8vfKAztt29IE35Ad6pPFM+
         1YkrSiEq676X41qTY/0X7CKnrnveUSayJp+Hcp32l0y2zekzu+IXpUwzMZvQYx+xxc7E
         NhwQ==
X-Gm-Message-State: AOAM532dPSBbZb7jkY8aDzG93CKkWb2QPLXPDdVMUR6Q9TCULJkqr6a9
        7bpDjgt+3G2Bai4ZxQrnR38qAxTKTo6ATkMXjs4=
X-Google-Smtp-Source: ABdhPJwUGAz+StzvFe3sEKadoMqkzkGxIfpbIgPqcHNBMpIUdAiRvhJvJxHF1csdmHpux4meRLpWTdAZ/DWt3/yVCko=
X-Received: by 2002:a17:906:d147:: with SMTP id br7mr3613564ejb.126.1628772927836;
 Thu, 12 Aug 2021 05:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628709663.git.andreyknvl@gmail.com> <e9e2f7180f96e2496f0249ac81887376c6171e8f.1628709663.git.andreyknvl@gmail.com>
 <CANpmjNPGsD_nZbcDNVTeL-b9W7X+2_AhzNAiSLdtxuvfyNFMEA@mail.gmail.com>
In-Reply-To: <CANpmjNPGsD_nZbcDNVTeL-b9W7X+2_AhzNAiSLdtxuvfyNFMEA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 12 Aug 2021 14:55:16 +0200
Message-ID: <CA+fCnZcoPO8+43bNakv4_vaA=kQJmBkvUF=hDoE4iTGhjcnv6g@mail.gmail.com>
Subject: Re: [PATCH 3/8] kasan: test: avoid corrupting memory via memset
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:57 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, 11 Aug 2021 at 21:21, <andrey.konovalov@linux.dev> wrote:
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > kmalloc_oob_memset_*() tests do writes past the allocated objects.
> > As the result, they corrupt memory, which might lead to crashes with the
> > HW_TAGS mode, as it neither uses quarantine nor redzones.
> >
> > Adjust the tests to only write memory within the aligned kmalloc objects.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > ---
> >  lib/test_kasan.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index c82a82eb5393..fd00cd35e82c 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -431,61 +431,61 @@ static void kmalloc_uaf_16(struct kunit *test)
> >  static void kmalloc_oob_memset_2(struct kunit *test)
> >  {
> >         char *ptr;
> > -       size_t size = 8;
> > +       size_t size = 128 - KASAN_GRANULE_SIZE;
> >
> >         ptr = kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 7 + OOB_TAG_OFF, 0, 2));
> > +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size, 0, 2));
>
> I think one important aspect of these tests in generic mode is that
> the written range touches both valid and invalid memory. I think that
> was meant to test any explicit instrumentation isn't just looking at
> the starting address, but at the whole range.

Good point!

> It seems that with these changes that is no longer tested. Could we
> somehow make it still test that?

Yes, will do in v2.

Thanks, Marco!
