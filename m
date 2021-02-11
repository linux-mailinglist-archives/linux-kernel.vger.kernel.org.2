Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4631830B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhBKBZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 20:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBKBY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:24:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D5C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 17:24:19 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e133so4034978iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 17:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zla1aseDY0i8ZjT1ec0ROE6/Adt1RXQPhkWU9OqIF0M=;
        b=l2YGJfLf7V0TgKMNBOJIo9ucNdfO6LpRBqp6kriBbqmbnO755M7J8QgMaZr1Pxg470
         OTgmn4sGMeWaAubUKhiZdpUpL4RGzRV6D2nwxvVq8hzbQAieow+Tqn9w5JCZJSGyGtkg
         kvQ2xxE73PywQxzJBAISx1kI2YQBk8uq4zr9XXtzVTlo3z5DoCLgJzqeahBd1jVSFs99
         dtxl/n9lSHnu1hHauy+q7Ll06aL+6CPyMPKvaZneHGGOGUlqYUIPmwXk6eWn9DaUZ51W
         39ybxyjwqco+TUuTlbw7dzZ/IeYe31PQq/vA+1YQalafs4S1oS/Qv9XDX7YMdlnRdM/A
         DeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zla1aseDY0i8ZjT1ec0ROE6/Adt1RXQPhkWU9OqIF0M=;
        b=cXWb9e5gBf+RRoCxynXpPItlG5ryrvlQHsikYcPT72a8nIy4CWBdhAN/zErJOswVwq
         hmunpB0x+HGXlTxHkoT417GU1oLqaj1C7Hd5jWycyouTZR2huQkW9/b8tUvpOmUC2HdV
         hxOihnjpXtqtrhLoJT3AzyLCLh/ramGDmgO+A1BavYzZTizCvFv9M/wYTlBGADN5DGBZ
         QwVveVi/gCcUeSkNEzpARzlP6gKvGcicDALZGjukee77YMnSfhVzZxnyZtFPcJUgsj0p
         FvcQ5jJT91w+QD5etC84AjHbbdgI27nofh0tNIvu8vsy/yL1ug79JbNPogp0ZE+bEexD
         oZXw==
X-Gm-Message-State: AOAM531TE5fnBBto54gTwVNk0yTJvAzLB5Tf8lIYdi04BQejqnyCxlmS
        2jRZEqR369KD+x8Db4NtQUVxQle78JaS1GkwxxrY4g==
X-Google-Smtp-Source: ABdhPJyWLoD6wei5cy+7TWvW434EWRU0+F8jmfBMftYf6Xg5hlZI4LdGs/JzD+ElgPKL0RKSAAm6AFukc92t3pnf/GU=
X-Received: by 2002:a02:30cb:: with SMTP id q194mr6182761jaq.57.1613006659142;
 Wed, 10 Feb 2021 17:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com> <20210210230625.550939-8-seanjc@google.com>
In-Reply-To: <20210210230625.550939-8-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Feb 2021 17:24:08 -0800
Message-ID: <CANgfPd9DnjYO_mDqpxpAw3o_C=BbeH7hcFX5wJU_tg4nPbk=zA@mail.gmail.com>
Subject: Re: [PATCH 07/15] KVM: selftests: Capture per-vCPU GPA in perf_test_vcpu_args
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 3:06 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Capture the per-vCPU GPA in perf_test_vcpu_args so that tests can get
> the GPA without having to calculate the GPA on their own.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/include/perf_test_util.h | 1 +
>  tools/testing/selftests/kvm/lib/perf_test_util.c     | 9 ++++-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
> index 005f2143adeb..4d53238b139f 100644
> --- a/tools/testing/selftests/kvm/include/perf_test_util.h
> +++ b/tools/testing/selftests/kvm/include/perf_test_util.h
> @@ -18,6 +18,7 @@
>  #define PERF_TEST_MEM_SLOT_INDEX       1
>
>  struct perf_test_vcpu_args {
> +       uint64_t gpa;
>         uint64_t gva;
>         uint64_t pages;
>
> diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
> index 73b0fccc28b9..f22ce1836547 100644
> --- a/tools/testing/selftests/kvm/lib/perf_test_util.c
> +++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
> @@ -127,7 +127,6 @@ void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
>                            bool partition_vcpu_memory_access)
>  {
>         struct perf_test_args *pta = &perf_test_args;
> -       vm_paddr_t vcpu_gpa;
>         struct perf_test_vcpu_args *vcpu_args;
>         int vcpu_id;
>
> @@ -140,17 +139,17 @@ void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
>                                          (vcpu_id * vcpu_memory_bytes);
>                         vcpu_args->pages = vcpu_memory_bytes /
>                                            pta->guest_page_size;
> -                       vcpu_gpa = guest_test_phys_mem +
> -                                  (vcpu_id * vcpu_memory_bytes);
> +                       vcpu_args->gpa = guest_test_phys_mem +
> +                                        (vcpu_id * vcpu_memory_bytes);
>                 } else {
>                         vcpu_args->gva = guest_test_virt_mem;
>                         vcpu_args->pages = (vcpus * vcpu_memory_bytes) /
>                                            pta->guest_page_size;
> -                       vcpu_gpa = guest_test_phys_mem;
> +                       vcpu_args->gpa = guest_test_phys_mem;
>                 }
>
>                 pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
> -                        vcpu_id, vcpu_gpa, vcpu_gpa +
> +                        vcpu_id, vcpu_args->gpa, vcpu_args->gpa +
>                          (vcpu_args->pages * pta->guest_page_size));
>         }
>  }
> --
> 2.30.0.478.g8a0d178c01-goog
>
