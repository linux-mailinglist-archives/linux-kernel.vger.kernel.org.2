Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4871D3FCCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhHaSDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhHaSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:03:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1828FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:02:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j15so21007282ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5JiuwULGoXcL7aB2osxwY42wDh+kV3b162h9PO86Sk=;
        b=g/lbOvifiM+YK0+3+5R5toBG7oHRdwjWbdzcE0UnR7foVHrPX06WfjotJostDF7c7H
         HppLbLsC5NlGuxjpYCfHQ2f4cTp0d04aVCjpNEUgcmoZNkq1A95dHimEn8SkSu79O6gS
         hQG6murFxwuXjmmEYWxbNpQ4CJHxuDRr3GQgfdStWjax1M2atUedehriZCEEvpcojDwe
         EASdPy3vB6/AJHVm7/JJSuAFIEaJXX0MztsUraeR28e+tFgtoV0ey32rQRp0ijkZ2bIL
         3Icg3A/koUqk7i8LdUcg9viLx2VDSQoAdpaaY74K1ASKKgtwLeAWiz0daIZWZEZIts+/
         pOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5JiuwULGoXcL7aB2osxwY42wDh+kV3b162h9PO86Sk=;
        b=n/cnxktKJV7Sjj/6kKO8c64WSITFstrCvGYE6ed2j2aRLA1BWBussHG3+dR1Q0A1aI
         GIhtRT19SFVUcku/RIaQY47umfzVkLJ5GKbTeemcpbHpW5YvZrevH5VTKiOHYjGitpc3
         q1+2j9PCm1VJ998RB6sw3FNCk9JGVmj5Z/FzAwkGhfgGltxhjEbFq5ejqFWvJxqDp/Gv
         RrsxSTBQ/y7WDqHg2X4nhj0nLlh8O3LWDpWxNY3RA2fr4A8LazIHux2MCLDCib/PjU6x
         S0RR3Gqul2KyVu40F+Ylqv2NEtljDDTgDaoZH9i1Ko9g7vTxXRsRG8iseNHpN2IXqT2j
         9DVQ==
X-Gm-Message-State: AOAM532zQ75TagCVGbQhUsFNluLlO0gsQD3knRQqBLqsuq06Ys6NEADl
        bP8fMtSgFYcG3pMpu0vO1vanhCPFhliLlWJhc92jczBA
X-Google-Smtp-Source: ABdhPJx6vneHBlHvt4Vn7pSRN9C4FSUfA841NFaZ/GSB6DxqS8VB13jLAPzE6DQibcLZFIFfrcZAOcZCSzAK0X+ltYg=
X-Received: by 2002:a92:4b02:: with SMTP id m2mr18726244ilg.94.1630432964318;
 Tue, 31 Aug 2021 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210824075524.3354-1-jiangshanlai@gmail.com>
In-Reply-To: <20210824075524.3354-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 1 Sep 2021 02:02:33 +0800
Message-ID: <CAJhGHyAT+WO4Lf_aOOnb6R4UEJcSAxwkH339MSziqxrEteToKA@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM: X86: MMU: misc fixes and cleanups
To:     LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 1:40 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> The first two patches fix two old possible defects.
> And the others are just cleanups.
>
> Lai Jiangshan (7):
>   KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
>   KVM: X86: Synchronize the shadow pagetable before link it

Hello, KVM people

Ping.  Aside from patch 7 which has been addressed by Sean,
the patchset has bug fixes and useful cleanups.

Could you have a review or an ack?

Thanks,
Lai

>   KVM: X86: Zap the invalid list after remote tlb flushing
>   KVM: X86: Remove FNAME(update_pte)
>   KVM: X86: Don't unsync pagetables when speculative
>   KVM: X86: Don't check unsync if the original spte is writible
>   KVM: X86: Also prefetch the last range in __direct_pte_prefetch().
>
>  arch/x86/kvm/mmu/mmu.c          | 50 +++++++++++++++++++++++++--------
>  arch/x86/kvm/mmu/mmu_internal.h |  3 +-
>  arch/x86/kvm/mmu/paging_tmpl.h  | 38 +++++++++++++++++--------
>  arch/x86/kvm/mmu/spte.c         |  6 ++--
>  4 files changed, 70 insertions(+), 27 deletions(-)
>
> --
> 2.19.1.6.gb485710b
>
