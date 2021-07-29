Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA73DAA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhG2R61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2R60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:58:26 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41257C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:58:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id x192so11689401ybe.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNF/a5bvjN6yY0NeAS2hdIVXm+roMge2alW9pMwmuko=;
        b=JlWiJ2f5koN6Y68by0SWuY+92qEnvMIOc2he5kK7q1SnoJT3F9Zd095fzzg9kQ3tuJ
         NZeDROszr1wuGVbp9O1DhIA51YCLqVzmwZqyR3T31agkmOsp0C/W6m4yFPWvVJUz6yzT
         PsJifjS/67SA3HSweicaIkprreujK0QusAotg1Bu/tbc7WObkADK1WPPxvr860k4Gmrm
         jXuKDicPuuMYN4evKAMV4JNUk3UhW+mnrHg56jmpvViSStnETT4p7i6D1ZnJrWfg8rXj
         qu59EQfBXjFlgJ2vfyPlevS+l4+1AFPEmWtGwUqqLLyKo7Ptq744bn3tu+78gUCFixJa
         1K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNF/a5bvjN6yY0NeAS2hdIVXm+roMge2alW9pMwmuko=;
        b=UipvdYToYYNLy7eWLpy2FXHRPap7MtwQoVPCfoih3mXOc/BTCUC113/+dPdhrp5DoC
         75iiI9Nyb5+O7C3jYoaehJvdyMRpzQeR4XqiGhwQjZSI7OFcTwKWDF6MLFpL8mtqblj3
         EQaj8Y3QNJb25uGlv2mU7XvfE1bnIJDzDmPREqVKpVxyPtRSr/G8KfikxqSKPJL5KDXt
         H5mX7HGCKpT9d1yPdyRqE0vqi8vVUh6NHT8e5EnZU7+hs2a/xusINnoGjWswcpD1oTZ3
         ycYCsvxrZO65EXIbpJWLUL3ZwePH9loNq9NB6fGUQaict6GNbww+TNV6P/N9BMsGbmsx
         LMKQ==
X-Gm-Message-State: AOAM532JMNXbV9B3HRGX1s41ano4XE5bEo3T4Sr5T/AX38skFynTllJW
        qLPapmA2qdRmNH4rMYF/fUswQK6fm9hMmMDeNHJcqQ==
X-Google-Smtp-Source: ABdhPJyK28UZkM+Ty6/iCidlB0ZYhzrKD6e0bUr4OwrKaDjd2ib4GWegHiwFsPSJaBTQebky3wO+5VhAeNsqpnMrSQw=
X-Received: by 2002:a25:d70b:: with SMTP id o11mr7840807ybg.213.1627581502347;
 Thu, 29 Jul 2021 10:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210726153846.245305071@linuxfoundation.org> <20210726153852.445207631@linuxfoundation.org>
In-Reply-To: <20210726153852.445207631@linuxfoundation.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 29 Jul 2021 10:58:11 -0700
Message-ID: <CAMn1gO42sPYDajZN7MuysTeGJmxvby=sFuU1eXt0APo_Y5FFSQ@mail.gmail.com>
Subject: Re: [PATCH 5.13 191/223] selftest: use mmap instead of posix_memalign
 to allocate memory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Delva <adelva@google.com>,
        William McVicker <willmcvicker@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Mitch Phillips <mitchp@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        donnyxia@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 9:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Peter Collingbourne <pcc@google.com>
>
> commit 0db282ba2c12c1515d490d14a1ff696643ab0f1b upstream.
>
> This test passes pointers obtained from anon_allocate_area to the
> userfaultfd and mremap APIs.  This causes a problem if the system
> allocator returns tagged pointers because with the tagged address ABI
> the kernel rejects tagged addresses passed to these APIs, which would
> end up causing the test to fail.  To make this test compatible with such
> system allocators, stop using the system allocator to allocate memory in
> anon_allocate_area, and instead just use mmap.
>
> Link: https://lkml.kernel.org/r/20210714195437.118982-3-pcc@google.com
> Link: https://linux-review.googlesource.com/id/Icac91064fcd923f77a83e8e133f8631c5b8fc241
> Fixes: c47174fc362a ("userfaultfd: selftest")
> Co-developed-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: William McVicker <willmcvicker@google.com>
> Cc: Evgenii Stepanov <eugenis@google.com>
> Cc: Mitch Phillips <mitchp@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: <stable@vger.kernel.org>    [5.4]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/testing/selftests/vm/userfaultfd.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -197,8 +197,10 @@ static int anon_release_pages(char *rel_
>
>  static void anon_allocate_area(void **alloc_area)
>  {
> -       if (posix_memalign(alloc_area, page_size, nr_pages * page_size)) {
> -               fprintf(stderr, "out of memory\n");
> +       *alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> +                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +       if (*alloc_area == MAP_FAILED)

Hi Greg,

It looks like your backport of this patch (and the backports to stable
kernels) are missing a left brace here.

Peter

> +               fprintf(stderr, "mmap of anonymous memory failed");
>                 *alloc_area = NULL;
>         }
>  }
>
>
