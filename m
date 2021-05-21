Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1C38C116
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhEUH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhEUH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:56:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA79C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:55:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k5so10555325pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xRdJqwa+tKO02MZjS283qIQAEmD7PgdimDaucBlw20=;
        b=DuNCFTeyPEeTAG9UW5XVFg1fOtFdbwEVrKnOW7SQCKuLFDTzzcuQxsZ8/BT1KBpS6b
         RycopGMhZBs5XT9pJn+YP7tXZJHG5UXez7n+iwrxzxIp1q4nCsQv693aNM/H6kAh4gIL
         eGapL7PDsO9dd9ygtRW4u9BjCwW2exOfHvfeccH922HelA+B/7wj8UtNXPYX6vEBi0fV
         ZbAFgx3rQWUL2OwvfrqInsKSxwVhQD/8bGpNNjrjSmaXqAo4K8WZ1usUvlJhyNdltWQp
         Mbk/3jpDqyTn1WUwG12V0R0vq6KUSWsgYdRnrxKDWmC3se5gmJCTXW4YIqMMwlya4+jO
         NL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xRdJqwa+tKO02MZjS283qIQAEmD7PgdimDaucBlw20=;
        b=q6BIe8jouePCHjddi6JqWJixNKLOjydBDOWthe06A2aKW9SrIErVZ4g6tVztmJbemq
         Sh3hZLqkLhYdlnKtbB0d96kHEfov94GCcBPArjbWBLNtZ277gmkUYh6XDxCdLRjy9PiK
         qlSUxf8TS5HfMJ/EobJqo+W7DQ59+eb+lt+hmc/PdiDow/n+ZvedO4Wqc135yIpJt7ZX
         6sBwtuU6iFX/b70HP3PQY1RRNoazhbdm4bWqL2gNclCQGcDFdyILO8Ar7wAArifbph0o
         zrEZI/rpU1Jz34mKUMrhCwA+ns/YGKt+zEi2qaF9UX3hnOxukRckg/izExAVs6Se41WC
         SkVQ==
X-Gm-Message-State: AOAM530GePrNG2qVp/rillC/a/QG3QTozZteq43B240/UieiClDtxuHW
        CpMa2xnKwuFspvlvVZu736pRh+Ebr3LJlVfheFQ=
X-Google-Smtp-Source: ABdhPJzeYgb5VFA+42vVkrZWIgFVr47iAF5I7zw9JZawMJLD6pXnQM/KeD17NllAK22se4U/t5bildF3Nrbfh1+r+3k=
X-Received: by 2002:a17:90b:90c:: with SMTP id bo12mr9589555pjb.10.1621583712424;
 Fri, 21 May 2021 00:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
 <CAHp75Vf8kQ73w0R9ieDNjDVkxM-V83QRN9mc6BjRZA8xHpPNAA@mail.gmail.com> <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com>
In-Reply-To: <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com>
From:   Yiyuan guo <yguoaz@gmail.com>
Date:   Fri, 21 May 2021 15:55:03 +0800
Message-ID: <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com>
Subject: Re: A divide by zero bug in lib/math/rational.c (with triggering input)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "tpiepho@gmail.com" <tpiepho@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oskar@scara.com" <oskar@scara.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your timely response.

I am not familiar with the theorem. But any input satisfying the
condition below will
trigger a divide by zero at the first loop iteration:

(given_numerator / given_denominator > max_numerator) || (1 +
given_numerator / given_denominator > max_denominator)

I think such a condition is rather complex and may not be enforced by
all callers of this function.

On Fri, May 21, 2021 at 3:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, May 21, 2021, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>>
>>
>> On Friday, May 21, 2021, Yiyuan guo <yguoaz@gmail.com> wrote:
>>>
>>> In the file lib/math/rational.c, the function
>>> rational_best_approximation has the following
>>> code:
>>>
>>> void rational_best_approximation(
>>>     unsigned long given_numerator, unsigned long given_denominator,
>>>     unsigned long max_numerator, unsigned long max_denominator,
>>>     unsigned long *best_numerator, unsigned long *best_denominator) {
>>>    ...
>>>    if ((n2 > max_numerator) || (d2 > max_denominator)) {
>>>             unsigned long t = min((max_numerator - n0) / n1,
>>>                           (max_denominator - d0) / d1);
>>>    ...
>>> }
>>>
>>> d1 may be equal to zero when performing the division, leading to a
>>> divide by zero problem.
>>>
>>> One input  to trigger the divide by zero bug is:
>>> rational_best_approximation(31415, 100, (1 << 8) - 1, (1 << 5) - 1, &n, &d)
>>
>>
>>
>> Have you read a theorem about this? TL;DR; as far as I can see the input data is not suitable for this function.
>>
>
>
> I think we may add the proper check and saturate the output which in your case should be (255,1).
>
>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
