Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC50318363
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBKCCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBKB4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:56:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D8C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 17:56:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 18so2653702pfz.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 17:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKLj/g3nhtAURGmPeDu+2QOeEfRKahaeGqDg+bXkVJU=;
        b=GD54P6anPyNigOUVV/uON4RTNJJRworqBxXIlSkqOMqf4ocaF+6YPBU2hoo+gNimh3
         zkqPo0H0h7cAlhPG3W50iskZkkBi6aKsxYHE3A0taDuHtjB2X8KsLzid7AyQnU4yyM5c
         kk3MQVv9m5e9Q8eu1ETHA2LupiCItmt7OyrBlgeOkqMbLuMNzcWJ6NqkHYPn1Rng+rWs
         K3wj8sNhuKQxpGDMCkPb7upokARfHZzyOnsRhMhtr2l+6+xUKYBELl89WkoyooWIM5pm
         HOWyPvno0qd3SqMbExU3WZoob5lE29OgZlNTLBS2GXg/mfpEHIcJdEsVbki9mowKbQoT
         mlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKLj/g3nhtAURGmPeDu+2QOeEfRKahaeGqDg+bXkVJU=;
        b=bQkLniJPaJxVViCx6lWQ+b34q941T8Unm54QkM4zGhwah3l2S1m++OZzUmVmBmFhPN
         s1NMHQ86FXyrAq4bq4nJUcou1cB4vYTDXF+zclcE2+ThwTmYU1C+wCk0B3JWyXgM4C0d
         BL74yBksq38C2mrm+K4d4X+otWbVmgzlEYPZuTiACtvgZiNsJGltViRawGsC/MI2OD+X
         WTIblVEdE2WEfmA/9vjWY6oKb8kvqoGP+rFsFWZydsXA1BTJ9cQwOjDXqQysd2QAXPGn
         5LQujD6QAF0tj7WngPMeP7bOrgfmQvnSIipDfk/3zzGx5juT0djL3+YyuzeaSWp26BTI
         k7rg==
X-Gm-Message-State: AOAM532fwIDRZKi8aP76bLbJdDGXpqGe9fvXg2BJfV6AlvVhHlkGYy/S
        k8j9SRMsmcy75+ZD1qyw4nVF0g==
X-Google-Smtp-Source: ABdhPJxI49ISepd0OO1jRXMVLETm6ZbA6jqQiTyBfPFVpp3NzJ1x7fGY0B9Bzq1rmMfjQ2qWt5/WIA==
X-Received: by 2002:a63:6f8a:: with SMTP id k132mr5906900pgc.59.1613008571706;
        Wed, 10 Feb 2021 17:56:11 -0800 (PST)
Received: from google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
        by smtp.gmail.com with ESMTPSA id x20sm3602105pfn.14.2021.02.10.17.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:56:11 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:56:04 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 09/15] KVM: selftests: Move per-VM GPA into perf_test_args
Message-ID: <YCSOtMzs9OWO2AsR@google.com>
References: <20210210230625.550939-1-seanjc@google.com>
 <20210210230625.550939-10-seanjc@google.com>
 <CANgfPd8itawTsza-SPSMehUEAAJ4DWtSQX4QRbHg1kX4c6VRBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd8itawTsza-SPSMehUEAAJ4DWtSQX4QRbHg1kX4c6VRBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021, Ben Gardon wrote:
> > diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
> > index f22ce1836547..03f125236021 100644
> > --- a/tools/testing/selftests/kvm/lib/perf_test_util.c
> > +++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
> > @@ -9,8 +9,6 @@
> >
> >  struct perf_test_args perf_test_args;
> >
> > -uint64_t guest_test_phys_mem;
> > -
> >  /*
> >   * Guest virtual memory offset of the testing memory slot.
> >   * Must not conflict with identity mapped test code.
> > @@ -87,29 +85,25 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
> >         TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
> >                     "Requested more guest memory than address space allows.\n"
> >                     "    guest pages: %lx max gfn: %x vcpus: %d wss: %lx]\n",
> > -                   guest_num_pages, vm_get_max_gfn(vm), vcpus,
> > -                   vcpu_memory_bytes);
> > +                   guest_num_pages, vm_get_max_gfn(vm), vcpus, vcpu_memory_bytes);
> >
> > -       guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
> > -                             pta->guest_page_size;
> > -       guest_test_phys_mem &= ~(pta->host_page_size - 1);
> > +       pta->gpa = (vm_get_max_gfn(vm) - guest_num_pages) * pta->guest_page_size;
> > +       pta->gpa &= ~(pta->host_page_size - 1);
> 
> Also not related to this patch, but another case for align.
> 
> >         if (backing_src == VM_MEM_SRC_ANONYMOUS_THP ||
> >             backing_src == VM_MEM_SRC_ANONYMOUS_HUGETLB)
> > -               guest_test_phys_mem &= ~(KVM_UTIL_HUGEPAGE_ALIGNMENT - 1);
> > -
> > +               pta->gpa &= ~(KVM_UTIL_HUGEPAGE_ALIGNMENT - 1);
> 
> also align
> 
> >  #ifdef __s390x__
> >         /* Align to 1M (segment size) */
> > -       guest_test_phys_mem &= ~((1 << 20) - 1);
> > +       pta->gpa &= ~((1 << 20) - 1);
> 
> And here again (oof)

Yep, I'll fix all these and the align() comment in v2.
