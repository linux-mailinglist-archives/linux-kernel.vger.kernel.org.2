Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AE40CB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhIORKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIORKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:10:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46313C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:09:31 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i3-20020a056830210300b0051af5666070so4502463otc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHR7QtxSQA+/ZedfBKDXb+NcR7qgBuUccMd7nT8tD0k=;
        b=HFUlyDSV/PDxVFFF9p8abTMB/VRvN5zoI2a2tQfpl2PbcRHpXLQAdDBD/76ejENIN3
         t9qQS+FXTdBL05lhAdXuyRGRCZ68NFianmrJSo67fEsMqPEYj/CSPivfSbrSfuocSyQk
         ykDT1pgkygwsN04Mho/nYvS2Lz0c6GSTSq+qoLoLTrsi3FWvUTC0laq0A4N08SoLw3GI
         VUsu2CYAb7OGs9KXNtMBk8FviT6fFT1bpI0+0ZPoF0WIlS3papnwN/GQAhA/Y96DpAre
         5ylwNz1Q12t/g2XHtbjd0g1k4lOdG+nSbV0PoEJ9ewGx/rIKa9fbCPv/MY4dPfPuD6MU
         pF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHR7QtxSQA+/ZedfBKDXb+NcR7qgBuUccMd7nT8tD0k=;
        b=v6GIIjTlac0lohHoRW57zGk05/hipfLuvzTArErJUI3pnA5y6bSKa6ca6vOB7FFz7D
         RSv9B+sKObjczVTask6UXlSaBIUsDV+n8f8f6WC0LN2i+Rnpac58KQjkG+UBSwezP4w2
         EJln0pbL62Oc3V+lQsNhFrMsLMJBqxjGkvBokuAcH7VhoqmlLftxGEGrbnZzDyOONIzg
         GYOFuMvrPC/jrHtcR9Uono3re3UBaG488a40maWJSk47xB9QhguiABEQXX7mXpSWNjfj
         NGEv+kcF3DQiua8GuGgTWvdoLo4uQaby3OCgqTB+2iUDDFCO+8jWADXg3DG7TgMJKwrS
         zGpg==
X-Gm-Message-State: AOAM5332NYqTo/0ga2uH0B9iEcDw0gLvjgWx6m/p/N6ktuk5PO0gtZ1v
        6QUXOJed2QCikSyoFsjl+yCoDCZyq98GSqm9Hp9+4w==
X-Google-Smtp-Source: ABdhPJzHU3zgWSrQLQ78yZpdZbzwnhl3H/9f0MKI8xapxPTofOi4gpEq7qToTtFMwZBYHbFkd63BhevCVxUInD+JDkc=
X-Received: by 2002:a05:6830:349c:: with SMTP id c28mr925796otu.35.1631725770184;
 Wed, 15 Sep 2021 10:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210914164727.3007031-1-pgonda@google.com> <20210914164727.3007031-4-pgonda@google.com>
In-Reply-To: <20210914164727.3007031-4-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Wed, 15 Sep 2021 10:09:18 -0700
Message-ID: <CAA03e5HvC_1KTz_Gyw2uvZkHFpvZJcmrRVTc6ZaOCqCqH16YtQ@mail.gmail.com>
Subject: Re: [PATCH 3/4 V8] selftest: KVM: Add open sev dev helper
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 9:47 AM Peter Gonda <pgonda@google.com> wrote:
>
> Refactors out open path support from open_kvm_dev_path_or_exit() and
> adds new helper for SEV device path.
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>  .../selftests/kvm/include/x86_64/svm_util.h   |  2 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 +++++++++++--------
>  tools/testing/selftests/kvm/lib/x86_64/svm.c  | 13 ++++++++++
>  4 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 010b59b13917..368e88305046 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -80,6 +80,7 @@ struct vm_guest_mode_params {
>  };
>  extern const struct vm_guest_mode_params vm_guest_mode_params[];
>
> +int open_path_or_exit(const char *path, int flags);
>  int open_kvm_dev_path_or_exit(void);
>  int kvm_check_cap(long cap);
>  int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
> diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
> index b7531c83b8ae..587fbe408b99 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
> @@ -46,4 +46,6 @@ static inline bool cpu_has_svm(void)
>         return ecx & CPUID_SVM;
>  }
>
> +int open_sev_dev_path_or_exit(void);
> +
>  #endif /* SELFTEST_KVM_SVM_UTILS_H */
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 10a8ed691c66..06a6c04010fb 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -31,6 +31,19 @@ static void *align(void *x, size_t size)
>         return (void *) (((size_t) x + mask) & ~mask);
>  }
>
> +int open_path_or_exit(const char *path, int flags)
> +{
> +       int fd;
> +
> +       fd = open(path, flags);
> +       if (fd < 0) {
> +               print_skip("%s not available (errno: %d)", path, errno);
> +               exit(KSFT_SKIP);
> +       }
> +
> +       return fd;
> +}
> +
>  /*
>   * Open KVM_DEV_PATH if available, otherwise exit the entire program.
>   *
> @@ -42,16 +55,7 @@ static void *align(void *x, size_t size)
>   */
>  static int _open_kvm_dev_path_or_exit(int flags)
>  {
> -       int fd;
> -
> -       fd = open(KVM_DEV_PATH, flags);
> -       if (fd < 0) {
> -               print_skip("%s not available, is KVM loaded? (errno: %d)",
> -                          KVM_DEV_PATH, errno);
> -               exit(KSFT_SKIP);
> -       }
> -
> -       return fd;
> +       return open_path_or_exit(KVM_DEV_PATH, flags);
>  }
>
>  int open_kvm_dev_path_or_exit(void)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/svm.c b/tools/testing/selftests/kvm/lib/x86_64/svm.c
> index 2ac98d70d02b..14a8618efa9c 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/svm.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/svm.c
> @@ -13,6 +13,8 @@
>  #include "processor.h"
>  #include "svm_util.h"
>
> +#define SEV_DEV_PATH "/dev/sev"
> +
>  struct gpr64_regs guest_regs;
>  u64 rflags;
>
> @@ -160,3 +162,14 @@ void nested_svm_check_supported(void)
>                 exit(KSFT_SKIP);
>         }
>  }
> +
> +/*
> + * Open SEV_DEV_PATH if available, otherwise exit the entire program.
> + *
> + * Return:
> + *   The opened file descriptor of /dev/sev.
> + */
> +int open_sev_dev_path_or_exit(void)
> +{
> +       return open_path_or_exit(SEV_DEV_PATH, 0);
> +}
> --
> 2.33.0.309.g3052b89438-goog
>

Reviewed-by: Marc Orr <marcorr@google.com>
