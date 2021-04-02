Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013C335279F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhDBIzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhDBIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:55:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1810C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 01:55:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h8so2253395plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVi33W6kFMo5p4VQs7HO2/NAwfVOX/Oq4ggQUR4cf5s=;
        b=FQHNta89onUKom3TbcnPmiHImDN7n8SYW6GvDBG+34z4M01pFAQ/m6KMPd0BcaYH3D
         auDS3XSHvSPopN/JJpse9aSjH78pCqGMHS6pprDERI1WCJdekFgRNaOZMj8jOpkuj38e
         j0iJiOtWwymHGpQ2OQQsh0JUEAPlscQ/jIqZvWevp4ug0Uu8Rxw2H19a7Mh0cLpg6MFy
         UVuNQv2lzYBsTJ2D2XCLreyvSZ9xFZJT7zSqsxdDa6o4gIMQoX9v59+pCvs6vNRljeg/
         fv0rpSFSRZHjnHuKg5AA+vdyYkuwGeR06RSNIbLNYBpmDCZc/IAapy5ta+tQKcr5OKZk
         SwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVi33W6kFMo5p4VQs7HO2/NAwfVOX/Oq4ggQUR4cf5s=;
        b=fFV0nx/QXtDotV1jjBYeIgFHDzhIeePgDC2NW488TuafWzV35SVnvunLzUn3+vmy1m
         E2NXxCOkgmAirXyj22cE3lJNs34Jcn09xLiWE3AllXvL4uJvv+KtQRzO1S9kFEkj0GNM
         LTp8HGtMfHDuk09E/iBA4+0iTUMjzDD22Cj4jVBpXcwrwuC8RaVZqOiaFIAPZ+QRrTCM
         yY0FTfZLS8uHbgaz3rD4H0l6RC/tkqsZsUdyaSUs8uTWcPjuNVtaEffnRH1bDCkceOSm
         zf+v7OSzHp8LK9oBy2eFStvGzbsqMf2+ZFtW8x5Vqz1dlXc01/F4DSWYfwqY/biqAH0P
         h7TA==
X-Gm-Message-State: AOAM531bUWuQ+oAgSUSUvsVmmGlVf9KRZ1mSh41adEsVj6GmTDtXec7R
        t2OCULkDWvv4L+eT0pFObzXIZYfSD07s/RI4jqfQ+Q==
X-Google-Smtp-Source: ABdhPJymf4782vco0OM/BGsM0691U+Z23gZWGigWivFhx70aZZRQDgRXoyGexs9btn9Wb7taONcvEv2MMRFHAogHThw=
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr12598214pjb.80.1617353729010;
 Fri, 02 Apr 2021 01:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210311152314.3814916-1-dlatypov@google.com> <20210311152314.3814916-2-dlatypov@google.com>
In-Reply-To: <20210311152314.3814916-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 2 Apr 2021 01:55:17 -0700
Message-ID: <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> Add a kunit_fail_current_test() function to fail the currently running
> test, if any, with an error message.
>
> This is largely intended for dynamic analysis tools like UBSAN and for
> fakes.
> E.g. say I had a fake ops struct for testing and I wanted my `free`
> function to complain if it was called with an invalid argument, or
> caught a double-free. Most return void and have no normal means of
> signalling failure (e.g. super_operations, iommu_ops, etc.).
>
> Key points:
> * Always update current->kunit_test so anyone can use it.
>   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
>   CONFIG_KASAN=y
>
> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
>
> * Forward the file and line number to make it easier to track down
> failures
>
> * Declare the helper function for nice __printf() warnings about mismatched
> format strings even when KUnit is not enabled.
>
> Example output from kunit_fail_current_test("message"):
> [15:19:34] [FAILED] example_simple_test
> [15:19:34]     # example_simple_test: initializing
> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> [15:19:34]     not ok 1 - example_simple_test
>
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
