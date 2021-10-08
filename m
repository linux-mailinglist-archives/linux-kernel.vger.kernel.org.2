Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFC427127
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhJHTFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhJHTFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 15:05:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F05C061762
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 12:03:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k26so8972899pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNdarxBooEw49lOrQDkWJsFHINdfUOwPGFjoZVjB6JY=;
        b=pQhiuqG89VNlkxT+bp9+XkUj5SluTR0+dU5Tlv/iOpIybqiv8V8QlMI1pDRCQShvCq
         G9ElIfSbhg3lI1aYL+P0EnfXW7RQURDWe7xnFZh1MKB1i4Wlg1a3AozYscpHyMSl5VwR
         /IWtHCq/nU+jqunOf/uLQxwosX+Dso6VQMvkgYPf0c3Njy1NZOK2s/dDo+xvqnJDOLhM
         9MPhHHVKvxQxn1f8pDHK94wp3ZF1xN4jKOraQ0wGsENrZfy3Q/PKCKuQRhqyi/2YHEej
         owVO7hTd9YkzgB/ZC6Oj1ZidJuKwIxX4QQth2tOh5uz9gq7A8LE7v5Tme86rj0/Ygcwl
         d9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNdarxBooEw49lOrQDkWJsFHINdfUOwPGFjoZVjB6JY=;
        b=MJ4GFSoEr3FoJB+hmKIVJFRYzfVyqR/VmFmsxQ5KojV5fK0ApTMeuF5XKh5eg74g1W
         5FIIloBCQyYlm1bw5yUfDKKIDHe7XG7vPSM6DbmNdeLxoXWHA2eZ+xgGEP0YitIKhkBw
         kmr54V9nEOAI9rFqReoI9EGf6SMNNRVGnx5/i7lBNDRwem54gYDwg458vA4NwPtV6Jtd
         hmdCw6wdVWBL4QKBPbYhinFa+VCsScz5Li4jvwLIdyvIQczqV2RgQzPDATyEeYbnp6n1
         mv4uk4u0otfylbagJiIj9w5b6BiITeuB8KJjpf+d0Y55FvH5rG2sQfDZA22VzqgVtlfm
         OCWQ==
X-Gm-Message-State: AOAM532tEo/r5gO352HTzEDbD1frvqPRhY7f2OcL05RKuDc2EV8M75DB
        tqteq6CpPV5k8IJoXqk60bR3JdGDwEUb/AzVgvzkhw==
X-Google-Smtp-Source: ABdhPJyuf8H30MNhst+1XUSSr6oT+IFsy1XY5RoBYommFm/Ep8eGVuIKC5U90xi2YVmbf9YmaKH0m9RTObE/yDJpkHI=
X-Received: by 2002:a05:6a00:1586:b0:447:b30c:4a65 with SMTP id
 u6-20020a056a00158600b00447b30c4a65mr11858150pfk.0.1633719803151; Fri, 08 Oct
 2021 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211006203617.13045-1-michael.roth@amd.com>
In-Reply-To: <20211006203617.13045-1-michael.roth@amd.com>
From:   Nathan Tempelman <natet@google.com>
Date:   Fri, 8 Oct 2021 12:03:12 -0700
Message-ID: <CAKiEG5rPhDgsVPcZV=DrjJNPk6qy9yVC1ZDdxo6VajnUgp3iRg@mail.gmail.com>
Subject: Re: [RFC 04/16] KVM: selftests: set CPUID before setting sregs in
 vcpu creation
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 1:39 PM Michael Roth <michael.roth@amd.com> wrote:
>
> Recent kernels have checks to ensure the GPA values in special-purpose
> registers like CR3 are within the maximum physical address range and
> don't overlap with anything in the upper/reserved range. In the case of
> SEV kselftest guests booting directly into 64-bit mode, CR3 needs to be
> initialized to the GPA of the page table root, with the encryption bit
> set. The kernel accounts for this encryption bit by removing it from
> reserved bit range when the guest advertises the bit position via
> KVM_SET_CPUID*, but kselftests currently call KVM_SET_SREGS as part of
> vm_vcpu_add_default(), *prior* to vCPU creation, so there's no
> opportunity to call KVM_SET_CPUID* in advance. As a result,
> KVM_SET_SREGS will return an error in these cases.
>
> Address this by moving vcpu_set_cpuid() (which calls KVM_SET_CPUID*)
> ahead of vcpu_setup() (which calls KVM_SET_SREGS).
>
> While there, address a typo in the assertion that triggers when
> KVM_SET_SREGS fails.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c         | 2 +-
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index ef88fdc7e46b..646cffd86d09 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1906,7 +1906,7 @@ void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>  void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>  {
>         int ret = _vcpu_sregs_set(vm, vcpuid, sregs);
> -       TEST_ASSERT(ret == 0, "KVM_RUN IOCTL failed, "
> +       TEST_ASSERT(ret == 0, "KVM_SET_SREGS IOCTL failed, "
>                 "rc: %i errno: %i", ret, errno);
>  }
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 0bbd88fe1127..1ab4c20f5d12 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -660,6 +660,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>
>         /* Create VCPU */
>         vm_vcpu_add(vm, vcpuid);
> +       vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
>         vcpu_setup(vm, vcpuid);
>
>         /* Setup guest general purpose registers */
> @@ -672,9 +673,6 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>         /* Setup the MP state */
>         mp_state.mp_state = 0;
>         vcpu_set_mp_state(vm, vcpuid, &mp_state);
> -
> -       /* Setup supported CPUIDs */
> -       vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
>  }
>
>  /*
> --
> 2.25.1
>

Good catch.
Reviewed-by: Nathan Tempelman <natet@google.com>
