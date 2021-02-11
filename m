Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D333182B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBKAug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBKAue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:50:34 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B25C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:49:53 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e24so4003374ioc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCQoxUWW+WqGD0toLXrCMCFnjUYr8lZy9dGVryfod24=;
        b=rGIqwLFmmaGGhM/AjOQhIUmMxjI00/7np4DL9QFis8v7VWy5z1f8EZ53FnM4wP7vPY
         OjR03eth+8Q7ROgPeyX1worZRj2qV5yio7/EE9s09h+jWqvZqPOJsGtxdrkMOKQ/veBt
         nCEmtnhQr9Chr2lMmcxRbjd01ibIdoTY50uCQklSNAVDwyNFws/PonvZtlfy7DKvRpdI
         /5fGqR6KwvYCi8yQyNK1QFkIjtY9MSjs9582C3Oy2eofSpeuVi6d1+teBZn7UjIaRF3A
         xKmvBH9vrncKScBlV41nvWKUgzfhx9IniFUng8O4MKumRdnJ0jy+ZaoUKwPUO+KMTjFQ
         ir6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCQoxUWW+WqGD0toLXrCMCFnjUYr8lZy9dGVryfod24=;
        b=T14NZBvwA5xI9bAzXx1c1j/kkRMV+vRM3ptMCHk1nvIykvBi0gzryIsilp3QWZFt0G
         q74mtpag9nUTk2Tw/e4uQJ/M5qo3V8j/YZaYXg6YPNY5L9Ca2ohYhigwtXW4lQXYUJCF
         ez+j9N7XP5/j8GhWqfF6IvrpPfTlhuN/FTDINiqy8hxEUlsEjR7gZy5VV50FlRU35KK5
         Pd7qzVOW0HfyQTV0mHa04EtbxL2K2Kv6N+Ck2hn8BGbiF5Gfv+l4sZm+R5O/cPsff1R5
         g1c71VSk0KSpQetqyNTUqc00bHTny/fJghc3/7kLb7P9S7TOVu5QcroTtgmedsf6THDa
         B4VA==
X-Gm-Message-State: AOAM530oX5zEvDo8hCMHP6lbN+8aP6MPOQuy6ZqwnFBnrbFY1i0GbmOU
        55fAj6vEhGYTIp4or/3wGXyzp1cia7mrhR9QIiPTaZo5R+k=
X-Google-Smtp-Source: ABdhPJxpxTGfXP3NRxUBrQcfau2gcrZ5o4LdrjpPcDt4sBzuzTnEpSI4iFOr7MCAzj1pSquZbD/jkVUMnEoWQKKD5Mk=
X-Received: by 2002:a05:6602:2e01:: with SMTP id o1mr3275411iow.9.1613004592900;
 Wed, 10 Feb 2021 16:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com> <20210210230625.550939-3-seanjc@google.com>
In-Reply-To: <20210210230625.550939-3-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Feb 2021 16:49:41 -0800
Message-ID: <CANgfPd9GHjvPF4O6ryo-x-CuuNYchXhWo2mpSopfru1cBmjsfA@mail.gmail.com>
Subject: Re: [PATCH 02/15] KVM: selftests: Expose align() helpers to tests
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
> Refactor align() to work with non-pointers, add align_ptr() for use with
> pointers, and expose both helpers so that they can be used by tests
> and/or other utilities.  The align() helper in particular will be used
> to ensure gpa alignment for hugepages.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 15 +++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 11 +----------
>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 2d7eb6989e83..4b5d2362a68a 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -79,6 +79,21 @@ struct vm_guest_mode_params {
>  };
>  extern const struct vm_guest_mode_params vm_guest_mode_params[];
>
> +/* Aligns x up to the next multiple of size. Size must be a power of 2. */

It might also be worth updating this comment to clarify that the
function rounds down, not up.

> +static inline uint64_t align(uint64_t x, uint64_t size)
> +{
> +       uint64_t mask = size - 1;
> +
> +       TEST_ASSERT(size != 0 && !(size & (size - 1)),
> +                   "size not a power of 2: %lu", size);
> +       return ((x + mask) & ~mask);
> +}
> +
> +static inline void *align_ptr(void *x, size_t size)
> +{
> +       return (void *)align((unsigned long)x, size);
> +}
> +
>  int kvm_check_cap(long cap);
>  int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
>  int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 960f4c5129ff..584167c6dbc7 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -21,15 +21,6 @@
>  #define KVM_UTIL_PGS_PER_HUGEPG 512
>  #define KVM_UTIL_MIN_PFN       2
>
> -/* Aligns x up to the next multiple of size. Size must be a power of 2. */
> -static void *align(void *x, size_t size)
> -{
> -       size_t mask = size - 1;
> -       TEST_ASSERT(size != 0 && !(size & (size - 1)),
> -                   "size not a power of 2: %lu", size);
> -       return (void *) (((size_t) x + mask) & ~mask);
> -}
> -
>  /*
>   * Capability
>   *
> @@ -757,7 +748,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>                     region->mmap_start, errno);
>
>         /* Align host address */
> -       region->host_mem = align(region->mmap_start, alignment);
> +       region->host_mem = align_ptr(region->mmap_start, alignment);
>
>         /* As needed perform madvise */
>         if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> --
> 2.30.0.478.g8a0d178c01-goog
>
