Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BE3191BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBKSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhBKReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:34:17 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2CC061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:33:37 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r75so6946493oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8P4xaiVI2tG5b2Ole1+tnRAqZYtVrf1Whd339/8WB6E=;
        b=Z7604+y34s6xeuNm8+wCbPBgFd8e3828pzQ7LIQY6cCrUgusKKUU//W1K74Ram4Mjr
         /GehiA5L2HNaOD/080Z7HsglI2qkhP1tvsfaz3RpwH3oxFStnn2UxYLJIuL9q8YHtjcl
         Mc9Hboop2KfBy3Zq6GUCuI8+RfXoPxFEYmk1yIUHi9rlq4kqOoQ9yeAh4PgKkT6STNCq
         sa6lOsfeGvtddTG8xb3BiJiRZ6Hm5Ag+ldsY6HnjtxuYwbdjlu95k3kjedFqrGEc2eq7
         oDiukko4tEMupzQluzSZ8C7ea5oHMQQgOVxIdShF+9kC9AUt4xoc0sm6Jc4DG6f1eFaG
         5GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P4xaiVI2tG5b2Ole1+tnRAqZYtVrf1Whd339/8WB6E=;
        b=XmYtAhRk5Ds63laAOkEA5fS1sBJUOBoEMvAHpGzp767I5/yU53v0KZ9qCBidqhFLxn
         QMfSRB30lorRRgrX3NIaoZZJ9XjhBL0uRQh9NUOwcdrE+piQFeileiQIhDO/OcxPIst5
         Ey/FgZg/K3I15JbMdGFYZsFm1CNQpV5OLxhKpTcO20XE4JS1yuGs+7oNDG7VwieYwREA
         3r2jd+QFzxLOGJYjDavsBR3MuIL33Sy6ZywEI9rwBqN6W4J3XLe1ygmhF5T/Pn7fmCJR
         25Ri+2/1OFIm8Xe+88PWaoMbJ27NoEdSs1NoNZbcW3kIES+Yg3kW8FL7tpX75SHASzK0
         o51g==
X-Gm-Message-State: AOAM5312iqtE/0Eb3ppa+xuPnsmjme6rVi3+urrJ58WC+1VsOm+Dj/Dg
        9KiPCxdO2ciGpdtuH4y420+D/FEB24z3zjTB1YFRGg==
X-Google-Smtp-Source: ABdhPJzxhIqMQoPXo1/OKDNuoU8KVYGDFfutR+x8G74OkgvrTWUFeqz/2TpHQNK/HJ/TWverkr8tq3R38cTEtHGsZCA=
X-Received: by 2002:aca:3b06:: with SMTP id i6mr3487837oia.81.1613064816828;
 Thu, 11 Feb 2021 09:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com> <20210210230625.550939-10-seanjc@google.com>
 <CANgfPd8itawTsza-SPSMehUEAAJ4DWtSQX4QRbHg1kX4c6VRBg@mail.gmail.com>
 <YCSOtMzs9OWO2AsR@google.com> <756fed52-8151-97ee-11f2-91f150afab42@redhat.com>
 <YCVUAdx3DYLPNwJU@google.com>
In-Reply-To: <YCVUAdx3DYLPNwJU@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 11 Feb 2021 09:33:25 -0800
Message-ID: <CANgfPd_W+wqx_UXHR7OWCBY7KEnsdNC12QZmGNjzOSBb1XOUyQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] KVM: selftests: Move per-VM GPA into perf_test_args
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

On Thu, Feb 11, 2021 at 7:58 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Feb 11, 2021, Paolo Bonzini wrote:
> > On 11/02/21 02:56, Sean Christopherson wrote:
> > > > > +       pta->gpa = (vm_get_max_gfn(vm) - guest_num_pages) * pta->guest_page_size;
> > > > > +       pta->gpa &= ~(pta->host_page_size - 1);
> > > > Also not related to this patch, but another case for align.
> > > >
> > > > >          if (backing_src == VM_MEM_SRC_ANONYMOUS_THP ||
> > > > >              backing_src == VM_MEM_SRC_ANONYMOUS_HUGETLB)
> > > > > -               guest_test_phys_mem &= ~(KVM_UTIL_HUGEPAGE_ALIGNMENT - 1);
> > > > > -
> > > > > +               pta->gpa &= ~(KVM_UTIL_HUGEPAGE_ALIGNMENT - 1);
> > > > also align
> > > >
> > > > >   #ifdef __s390x__
> > > > >          /* Align to 1M (segment size) */
> > > > > -       guest_test_phys_mem &= ~((1 << 20) - 1);
> > > > > +       pta->gpa &= ~((1 << 20) - 1);
> > > > And here again (oof)
> > >
> > > Yep, I'll fix all these and the align() comment in v2.
> >
> > This is not exactly align in fact; it is x & ~y rather than (x + y) & ~y.
> > Are you going to introduce a round-down macro or is it a bug?  (I am
> > lazy...).
>
> Good question.  I, too, was lazy.  I didn't look at the guts of align() when I
> moved it, and I didn't look closely at Ben's suggestion.  I'll take a closer
> look today and make sure everything is doing what it's supposed to do.

Ooh, great point Paolo, that helper is indeed rounding up. My comment
in patch #2 was totally wrong. I forgot anyone would ever want to
round up. :/
My misunderstanding and the above use cases are probably good evidence
that it would be helpful to have both align_up and align_down helpers.
