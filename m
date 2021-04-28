Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED536DFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhD1TrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhD1TrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:47:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB99C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:46:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 10so1930361pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tnFbK/m34T+YczbPV3B35Ijs+zqtM3fwowY1mDhKJFc=;
        b=pvARdwGF0S8Ixolprjybf5Ip1Lps/0g6GP6H1ioVUPhiNrhkYq7ReYvmOOXfA5E+wy
         eh1KHK/czSQjDrFT9FqF28C3ybrISEk29pO8V3pXOVdRI/uv+Uf/zKqUDzvSg31FnIqw
         j+6Y0f7Zh2c7IWAFHjbPl2PQxry57sQDf/RVjOe2XGZ4W5n8egpelmZbmBoip3D+xJl2
         ZLOqqKMV006i/xJcASIT4Aj9BenQeOVyCHy/68ZAiFVfyylSbL6yrBp053r3grompIri
         +uS8/cG2NgaSeAXmHaH6IDQXR1UkC+wwJrsKmRwT2SKTO43YyngwK1FKUqSrixizJ07+
         0rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnFbK/m34T+YczbPV3B35Ijs+zqtM3fwowY1mDhKJFc=;
        b=qFJs/pn/YDofsXuI/C61EQCpXZ7X9EEXzqRwcPg74mbw9IGFTQvLUc/VRehtP3sLrG
         wU9DCpqurt7O6c+jO7oCixuAIR5YnKup3tZ3WmqTdtE+0FXNm3D9jq5p/hQCU62AZAXS
         ZUAOmisy1PHOfLI7ZN/5LjCxDC2gTi81+yH47SWzPDqpmanBHca6s7F+1+LH1lutr6CM
         Lcf2rvxdqEiZGaJ1sd2JYl1LcQbeAxGKdfVyWPuuapodYXp5CXTkeHrf27tsg7ilxn3P
         D3wTh/mFPaRpPzWFdtrnDRewwDeQDo0XOawJ6QV1kWzLXGERVvVrN24tW+vaM6WfqqIC
         Zodg==
X-Gm-Message-State: AOAM531egGvlzebraawyoM8tsK8Jz3guhCINQegIFbY7nwqDGLK2u/qk
        FRajUlDIeAiaVddaUvFePRgBIQ==
X-Google-Smtp-Source: ABdhPJyGN3I1yKZWpUnE2dN7SnNQMyc9AKTQeQSDT0JpVN6vSHgSTrPP96KO8WIRTiayKbJWV9HPmA==
X-Received: by 2002:a65:4082:: with SMTP id t2mr28910055pgp.396.1619639181194;
        Wed, 28 Apr 2021 12:46:21 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with ESMTPSA id l62sm436394pfl.88.2021.04.28.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 12:46:20 -0700 (PDT)
Date:   Wed, 28 Apr 2021 12:46:17 -0700
From:   Ricardo Koller <ricarkol@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 0/5] KVM: x86: Use kernel x86 cpuid utilities in KVM
 selftests
Message-ID: <YIm7iWxggvoN9riz@google.com>
References: <20210422005626.564163-1-ricarkol@google.com>
 <c4524e4a-55c7-66f9-25d6-d397f11d25a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4524e4a-55c7-66f9-25d6-d397f11d25a8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:02:09AM +0200, Paolo Bonzini wrote:
> On 22/04/21 02:56, Ricardo Koller wrote:
> > The kernel has a set of utilities and definitions to deal with x86 cpu
> > features.  The x86 KVM selftests don't use them, and instead have
> > evolved to use differing and ad-hoc methods for checking features. The
> > advantage of the kernel feature definitions is that they use a format
> > that embeds the info needed to extract them from cpuid (function, index,
> > and register to use).
> > 
> > The first 3 patches massage the related cpuid header files in the kernel
> > side, then copy them into tools/ so they can be included by selftests.
> > The last 2 patches replace the tests checking for cpu features to use
> > the definitions and utilities introduced from the kernel.
> 
> I queued the first, but I am not sure about the rest.
> 
> An alternative is to copy over the code from kvm-unit-tests which encodes
> the leaf/subleaf/register/bit values into the X86_FEATURE_* value.  Sharing
> code with kvm-unit-tests is probably simpler than adding #ifdef __KERNEL__
> and keeping the headers in sync.
> 
> Paolo
> 

Thanks. I was thinking about kvm-unit-tests, but the issue is that it
would also be a copy. And just like with kernel headers, it would be
ideal to keep them in-sync. The advantage of the kernel headers is that
it's much easier to check and fix diffs with them. On the other hand, as
you say, there would not be any #ifdef stuff with kvm=unit-tests. Please
let me know what you think. 

Thanks,
Ricardo

> > Thanks,
> > Ricardo
> > 
> > Ricardo Koller (5):
> >    KVM: x86: Move reverse CPUID helpers to separate header file
> >    x86/cpu: Expose CPUID regs, leaf and index definitions to tools
> >    tools headers x86: Copy cpuid helpers from the kernel
> >    KVM: selftests: Introduce utilities for checking x86 features
> >    KVM: selftests: Use kernel x86 cpuid features format
> > 
> >   arch/x86/events/intel/pt.c                    |   1 +
> >   arch/x86/include/asm/cpufeature.h             |  23 +-
> >   arch/x86/include/asm/processor.h              |  11 -
> >   arch/x86/kernel/cpu/scattered.c               |   2 +-
> >   arch/x86/kernel/cpuid.c                       |   2 +-
> >   arch/x86/kvm/cpuid.h                          | 177 +-----------
> >   arch/x86/kvm/reverse_cpuid.h                  | 185 +++++++++++++
> >   tools/arch/x86/include/asm/cpufeature.h       | 257 ++++++++++++++++++
> >   tools/arch/x86/include/asm/cpufeatures.h      |   3 +
> >   .../selftests/kvm/include/x86_64/cpuid.h      |  61 +++++
> >   .../selftests/kvm/include/x86_64/processor.h  |  16 --
> >   .../kvm/include/x86_64/reverse_cpuid.h        | 185 +++++++++++++
> >   .../selftests/kvm/include/x86_64/svm_util.h   |  11 +-
> >   tools/testing/selftests/kvm/lib/x86_64/svm.c  |   6 +-
> >   tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   5 +-
> >   tools/testing/selftests/kvm/steal_time.c      |   5 +-
> >   .../kvm/x86_64/cr4_cpuid_sync_test.c          |  23 +-
> >   .../selftests/kvm/x86_64/set_sregs_test.c     |  25 +-
> >   .../selftests/kvm/x86_64/vmx_pmu_msrs_test.c  |   8 +-
> >   .../kvm/x86_64/vmx_set_nested_state_test.c    |   5 +-
> >   .../selftests/kvm/x86_64/xss_msr_test.c       |  10 +-
> >   21 files changed, 749 insertions(+), 272 deletions(-)
> >   create mode 100644 arch/x86/kvm/reverse_cpuid.h
> >   create mode 100644 tools/arch/x86/include/asm/cpufeature.h
> >   create mode 100644 tools/testing/selftests/kvm/include/x86_64/cpuid.h
> >   create mode 100644 tools/testing/selftests/kvm/include/x86_64/reverse_cpuid.h
> > 
> 
