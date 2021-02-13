Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA431AD8A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBMSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 13:18:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218EC061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 10:17:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so4869148ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhflr6Kr9MS69AQNqOu2ql7jseG3hQYP7nXLcNGkx88=;
        b=RiTA03LednoTn/5MhNanTKkkv2Jt2ZRPHodBuydqronzq4blKvXXm8j6bhPDHlxm77
         vhiZdO8Zwf19E9K43qja3AxtMFbEJU0Hg3Wrswqu9Wrwd6qE5GBs4lycql0+VgnFUZZ1
         gTZf33odf1WH3WSbAWOtV8FMgIkMKSM/Q/0Q/f3uJdFWamqhyUzLE5bABC2vU05mr/wn
         oU7fgDSDq1ybepA5OGYCEvSyDLQ63v+gQ8bd/2LO6lp5UoQkUONgiIEcsmxRsZMKe51L
         N28CuHEjHgZXuG6hPhA7qHU36iKjIG778qvSWAQW2tIOlb4gQQ7VSowU46k6l3UsfbHA
         MJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhflr6Kr9MS69AQNqOu2ql7jseG3hQYP7nXLcNGkx88=;
        b=XPc2rDB+U4Zu6siT3MvI/CV2zn6kDSB5wakS5nsKsit8Ra/ftoZ4u/y7EFA7Q62b0P
         smGvkfeWTtOu/IFo95VVFp6B2AsIVRoG/VpquOOPtHGg0Pzr2a7TQCf2+KhnynD3rVs6
         uMFdUhL4FfcFxZKeLydi2oAqng2DDApdNrmZN+G8S/uuhdxacdRE6+U8u4NLRQFVDCFC
         kt5f62cE8fCzXCz30dpGjSnxxvRL4RJuSMjEMbh5TXni/WWgBzBjAPE4HwnmXzxFW9Br
         0xetW0gUXqsbFwTN4ziRiParjYOgr0+YP5Aoe3aR1r3+dDZpQ2LKVfOIG7z1o+7hBCQv
         Lpgg==
X-Gm-Message-State: AOAM5334h60DN+KSeenwKmpakseY02g0A1PMPVw6tsp/IoQ8icdXFgs8
        xnnxGA6CGN2UlWnDiaap8PXXl73zvjk132nMBiU/eA==
X-Google-Smtp-Source: ABdhPJy0t/9pjInJNNa1WNGs8nbaqoOIMROAZAmo4VbwdumMlstfT69NxWAz4MpwQjak15YshARtJK7LbUp2g48lDgw=
X-Received: by 2002:a17:906:43d7:: with SMTP id j23mr8373975ejn.519.1613240267568;
 Sat, 13 Feb 2021 10:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20210213012316.1525419-1-pasha.tatashin@soleen.com> <20210213175151.GA4646@sequoia>
In-Reply-To: <20210213175151.GA4646@sequoia>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 13 Feb 2021 13:17:11 -0500
Message-ID: <CA+CK2bC4X4SmZ4FBXSBO15ErCd3yDeU9i97mZfQWbZaXN2AWNw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: correct the start of physical address in
 linear map
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>, ardb@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We're ignoring the portion from the linear mapping's start PA to the
> point of wraparound. Could the start and end of the hot plugged memory
> fall within this range and, as a result, the hot plug operation be
> incorrectly blocked?

Hi Tyler,

Thank you for looking at this fix. The maximum addressable PA's can be
seen in this function: id_aa64mmfr0_parange_to_phys_shift(). For
example for PA shift 32, the linear map must be able to cover any
physical addresses from 0 to "1 << 32". Therefore, 0 to __pa(PAGE_END
- 1); must include 0 to "1<<32".

The randomization of the linear map tries to hide where exactly within
the linear map the [0 to max_phys] addresses are located by changing
PHYS_OFFSET (linear map space is usually much bigger than PA space).
Therefore, the beginning or end of a linear map can actually convert
to completely bagus high PA addresses, but this is normal.

Thank you,
Pasha

>
> Tyler
>
> > +
> >       /*
> >        * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
> >        * accommodating both its ends but excluding PAGE_END. Max physical
> >        * range which can be mapped inside this linear mapping range, must
> >        * also be derived from its end points.
> >        */
> > -     return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
> > -            (start + size - 1) <= __pa(PAGE_END - 1);
> > +     return start >= start_linear_pa && (start + size - 1) <= end_linear_pa;
> >  }
> >
> >  int arch_add_memory(int nid, u64 start, u64 size,
> > --
> > 2.25.1
> >
