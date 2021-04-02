Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB452352F89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhDBTKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBTKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:10:12 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383CC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 12:10:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z9so5371889ilb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JlFDJAcRG6/Jm43XBCYYpnXYN2lAD9aQqAdSxiEkDs=;
        b=EiHnux0s7dQ3PcMjGa8vxU7IIiN7Fa2B6iJ2AJ8c62lDKE+WYDkbJ8wzuU7+rZMWg0
         rZhWkgCnFScZFTXIAf8bhzpZzyo42XSPgYl46t5KJutWanMHoD+oGba52PiINY5llUQ/
         P1fKd+MNu+0svuIOIkEBjftL3rkMJS0dI/BG1b0j9rVh0S7xfco6DQeBz0/a0gPDORJh
         vsd0g2rnBIRLR44G1rgrO+GNEkqRAkEEC2+/+OJ9W9ifsnXhUd+eqpuYqcqOz08AFkqa
         kLJ9Y8FR7XHzoywVA2Z+i31hmpGeYKMYxGv3+9Poks7t2b04NlRIC0EXIIKBNSzDfdoH
         iYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JlFDJAcRG6/Jm43XBCYYpnXYN2lAD9aQqAdSxiEkDs=;
        b=Lbkfyp+LHru6P3pjlLNwsObFZgnSIvnJ4G7nYIdGW/jdDcBMRxYdseIKo+5lHZjkTY
         Ji2eQ7nSsR7EdeRyItH0IFBxsryEuUVAgftnOl7g97iBm4qluY5tX9j+vAa0oiMRbLLH
         GGaay6D7SnkmiAT7CBIUZ4xLoPYu/6U7s/4WSMlwgO2sGk8D/q4LhCFcNK/ComwgSQvU
         QWCdScosJoKlDqUYf76csVLAQNzSVO2s5GjPHG3NIhVovpL8OurkzBAxDhg8c5Bvyfbn
         yyMReM7BD0Ntsb594tuioNatPrtoWez1HKMiY0BxQ/ZcvGFko9gkGD21HK7hUWbk/oWj
         1EUA==
X-Gm-Message-State: AOAM532f9eb91UILhKS4s+pYcBKE8N8pYCPIhBadUT2hT7vl459+lVZE
        BRudTcaanS/5NUKCGZNCM8TrvyLw8ghacOanyfkikQ==
X-Google-Smtp-Source: ABdhPJzZlUx/qgHuq28bDzFofQxEcbrvDubBVZIrnqA7YzNDMQ14VSBDvffECtAMDc3TvMG18/ntODesGW/SmZtA+vc=
X-Received: by 2002:a05:6e02:d52:: with SMTP id h18mr439861ilj.133.1617390610533;
 Fri, 02 Apr 2021 12:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210205221808.1966010-1-dlatypov@google.com> <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
 <9f5df593-6584-b7d4-3b6e-ad77ee6f8760@linuxfoundation.org>
In-Reply-To: <9f5df593-6584-b7d4-3b6e-ad77ee6f8760@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Apr 2021 12:09:59 -0700
Message-ID: <CAGS_qxqE9btMn639uCgDoiqO6PNnNJzqyLA4Vj+b6Ccjhpkbfg@mail.gmail.com>
Subject: Re: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't
 print literals
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 10:47 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/2/21 3:35 AM, Brendan Higgins wrote:
> > On Fri, Feb 5, 2021 at 2:18 PM Daniel Latypov <dlatypov@google.com> wrote:
> >>
> >> Before:
> >>>   Expected str == "world", but
> >>>       str == hello
> >>>       "world" == world
> >>
> >> After:
> >>>   Expected str == "world", but
> >>>       str == "hello"
> >> <we don't need to tell the user that "world" == "world">
> >>
> >> Note: like the literal ellision for integers, this doesn't handle the
> >> case of
> >>    KUNIT_EXPECT_STREQ(test, "hello", "world")
> >> since we don't expect it to realistically happen in checked in tests.
> >> (If you really wanted a test to fail, KUNIT_FAIL("msg") exists)
> >>
> >> In that case, you'd get:
> >>>   Expected "hello" == "world", but
> >> <output for next failure>
> >>
> >> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
>
> Hi Daniel,
>
> Please run checkpatch on your patches in the future. I am seeing
> a few checkpatch readability type improvements that can be made.
>
> Please make changes and send v2 with Brendan's Reviewed-by.

Are there some flags you'd like me to pass to checkpatch?

$ ./scripts/checkpatch.pl --git HEAD
total: 0 errors, 0 warnings, 42 lines checked

Commit f66884e8b831 ("kunit: make KUNIT_EXPECT_STREQ() quote values,
don't print literals") has no obvious style problems and is ready for
submission.

I just rebased onto linus/master again since I know checkpatch.pl's
default behavior had changed recently, but I didn't see any errors
there.

I know this commit made some lines go just over 80 characters, so
$ ./scripts/checkpatch.pl --max-line-length=80 --git HEAD
...
total: 0 errors, 4 warnings, 42 lines checked

I can go and line wrap these but had figured they were more readable
this way if checkpatch.pl no longer complained by default.

Thanks,
Daniel

>
> thanks,
> -- Shuah
