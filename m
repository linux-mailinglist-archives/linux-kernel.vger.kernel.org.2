Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860C13530BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhDBVZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 17:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhDBVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:25:13 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA28C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 14:25:12 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id p8so1229698ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9rvBUxt0gD7J/4lPVmkW5NC9txJcpKPfeTcuPwhZrE=;
        b=IAS9s+W/KelcH9FuBLGV79jg3RBD5yGvJgOPiLqa5H2ENC9WE56t7KHhTKARkdCq4s
         nrUjlGcDeknGHHiHSXf31RMlCUm7UYHs/BnjnMhy0EWgeH9KpnnNSLlOJE5Q4Qr8OLwN
         8NLNIn+7V5ZYtslSy5abpNiUJ+jHt2RaTgDWr0j3NWTqk89KKA+I7zJjHWbJIxUnZxUL
         TUcf8qxem91c49uxqRDrN2jLEZq7Gd6npHKc8tCgVxO6MVcGI8rMvoaICojGuDpUyTiS
         x6UcGDiqXdRp2yr2aMuyJ6woPc6faJgR16MTSiGLnjinGjZrfTvC0BsxZ5s98nHH4ydL
         yluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9rvBUxt0gD7J/4lPVmkW5NC9txJcpKPfeTcuPwhZrE=;
        b=BW8cqLg2fa1xfynMaPearbxT4aW4OJ7GS6sBLU+WqPbZ7dP6kwpZigagPkyrCVSY5F
         w80laOgbnQ13ZfMQ2oYv4C0VvmaveC6n3+rtgPfvqRLhcSRtyyMWWzs/172s7N7XzWrI
         ddfC9pqPvaBCjYI0hLqyHG+R/+9i5SglanvAakorysvTV0y1u8eUu4x2nQ8+YE/Bj4c8
         QUKaBYl9j1leInp7+6mRsrxXzELI73rRAFdJ9IEONPWzJfle9bT8BYDqoGNmJIb2pBkx
         r16OwQ8OVc5egLWThMm2Liw9pDgQWiLwbfOW9p7BLW2xJdFg6wfzn4Z3eWgo/HQUAlh1
         9r2A==
X-Gm-Message-State: AOAM530JMdo00SG8hVEcVlJO/ooetQNMrF5zhCeDVDlVBLuDbijKP1lo
        LxDq8w9wDjFvjNTIa8dmnoHXO/iC+zsIX2GnNXu52g==
X-Google-Smtp-Source: ABdhPJwCDq6Ept4G8BvWEHVX+L6RWxh/oywAHSZGHMZbbuglhagFIk94ClfIQQ2KRrf/TwAi8ObwNkWq6gHyXtPcPvQ=
X-Received: by 2002:a92:c24c:: with SMTP id k12mr11813867ilo.75.1617398711588;
 Fri, 02 Apr 2021 14:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210311152314.3814916-1-dlatypov@google.com> <20210311152314.3814916-2-dlatypov@google.com>
 <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com> <16fe1cc0-5819-986d-9065-433a80783edb@linuxfoundation.org>
In-Reply-To: <16fe1cc0-5819-986d-9065-433a80783edb@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Apr 2021 14:25:00 -0700
Message-ID: <CAGS_qxozjVfeOa42Y+v7dB0s6Ucvf8yHhRxDpficEJ9MGE-orw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 10:53 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/2/21 2:55 AM, Brendan Higgins wrote:
> > On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >>
> >> From: Uriel Guajardo <urielguajardo@google.com>
> >>
> >> Add a kunit_fail_current_test() function to fail the currently running
> >> test, if any, with an error message.
> >>
> >> This is largely intended for dynamic analysis tools like UBSAN and for
> >> fakes.
> >> E.g. say I had a fake ops struct for testing and I wanted my `free`
> >> function to complain if it was called with an invalid argument, or
> >> caught a double-free. Most return void and have no normal means of
> >> signalling failure (e.g. super_operations, iommu_ops, etc.).
> >>
> >> Key points:
> >> * Always update current->kunit_test so anyone can use it.
> >>    * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
> >>    CONFIG_KASAN=y
> >>
> >> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> >> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> >>
> >> * Forward the file and line number to make it easier to track down
> >> failures
> >>
> >> * Declare the helper function for nice __printf() warnings about mismatched
> >> format strings even when KUnit is not enabled.
> >>
> >> Example output from kunit_fail_current_test("message"):
> >> [15:19:34] [FAILED] example_simple_test
> >> [15:19:34]     # example_simple_test: initializing
> >> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> >> [15:19:34]     not ok 1 - example_simple_test
> >>
> >> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> >> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> >> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
>
> Please run checkpatch on your patches in the future. I am seeing
> a few checkpatch readability type improvements that can be made.
>
> Please make changes and send v2 with Brendan's Reviewed-by.

Thanks for the catch.
checkpatch.pl --strict should now be happy (aside from complaining
about line wrapping)

v5 here: https://lore.kernel.org/linux-kselftest/20210402212131.835276-1-dlatypov@google.com

Note: Brendan didn't give an explicit Reviewed-by on the second patch,
not sure if that was intentional.

>
> thanks,
> -- Shuah
