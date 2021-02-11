Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1031909A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBKRGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhBKP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:58:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:58:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so3925332pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HeDDVNwJvE2yrKMWyL0hMeAKpq/juTb4nf0aTQ3YIII=;
        b=fH0h91CR7DhcS+JEg8iSiuH+N9x4F/WdXKyPq5PAwBKI7LgvuJUkYbHy7G0NKYvcb8
         icBiIuA7sZJ21p0T6EESdBWVxtplnyjpJLaMzvY2e7LpJLbF/fGxE7Gv4P+fz216xcaQ
         IV5P4qNNp3yCGZA93RPxQTwKrGNn6+3F8frCvuOMyFEmo+hkVhlwWNDR6GO5TP/gDaG9
         VK6Y0jx1edOGRq3et9wCvW+9RUzEtYy5DGo+1JFJVAAaE2wu7k9R+sz9y7mAyuH0QCRe
         Kwvvw1Gdy202iKkkvHP26NJJJeNMfUQwXZmj5H8n88cJ5LFSCidwarEUauZjAfAXyllr
         k1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HeDDVNwJvE2yrKMWyL0hMeAKpq/juTb4nf0aTQ3YIII=;
        b=e8vpNSyKjM07w6WMJ1aGy0wMIHfdmxlsuBpWOEVMQ0kN6ZOh6yBsaWIOanj3scRGO2
         EQkNalCxJqEgi88CFQEcyo/aDKKdMe9NXnMzfM1Dc/ck5sc7uOgXxoKnsiCBly//f9l8
         L43+2MtJbw5o6RO6nt48Tlu1lZOGvMLT62tVIdr2XefJHT8vW1rtLwvJm3NxgpqCoMsL
         OvFQE5fiiis4ddmaLHTY+MgXjq+Y1u0w6LTk2CuKoBkxyE3+NtywDUksJdh6poLtR378
         RvGe2ZZS61GgM34tjaISjRR3a9GmZqaF+3yQb3FJHUR3Hmzy6cDXGSf8IiEEe5TY5ebL
         /6Gg==
X-Gm-Message-State: AOAM533lJdLuhlWg9jMaJN6yOkRGeLVYGWvWwsojRzMNzCJPqE4tJVQE
        8ick3tvKWnTKDHqhgZyE6BhFjQ==
X-Google-Smtp-Source: ABdhPJwwt6iZiYg/YWGFpf7hhe0xQPXn47jDmvogtEKQdTJszmGhYKWm4muvrz1JXSo51238bX6Jrg==
X-Received: by 2002:a63:e108:: with SMTP id z8mr8565022pgh.363.1613059080521;
        Thu, 11 Feb 2021 07:58:00 -0800 (PST)
Received: from google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
        by smtp.gmail.com with ESMTPSA id c18sm6061906pfi.167.2021.02.11.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 07:58:00 -0800 (PST)
Date:   Thu, 11 Feb 2021 07:57:53 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 09/15] KVM: selftests: Move per-VM GPA into perf_test_args
Message-ID: <YCVUAdx3DYLPNwJU@google.com>
References: <20210210230625.550939-1-seanjc@google.com>
 <20210210230625.550939-10-seanjc@google.com>
 <CANgfPd8itawTsza-SPSMehUEAAJ4DWtSQX4QRbHg1kX4c6VRBg@mail.gmail.com>
 <YCSOtMzs9OWO2AsR@google.com>
 <756fed52-8151-97ee-11f2-91f150afab42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756fed52-8151-97ee-11f2-91f150afab42@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021, Paolo Bonzini wrote:
> On 11/02/21 02:56, Sean Christopherson wrote:
> > > > +       pta->gpa = (vm_get_max_gfn(vm) - guest_num_pages) * pta->guest_page_size;
> > > > +       pta->gpa &= ~(pta->host_page_size - 1);
> > > Also not related to this patch, but another case for align.
> > > 
> > > >          if (backing_src == VM_MEM_SRC_ANONYMOUS_THP ||
> > > >              backing_src == VM_MEM_SRC_ANONYMOUS_HUGETLB)
> > > > -               guest_test_phys_mem &= ~(KVM_UTIL_HUGEPAGE_ALIGNMENT - 1);
> > > > -
> > > > +               pta->gpa &= ~(KVM_UTIL_HUGEPAGE_ALIGNMENT - 1);
> > > also align
> > > 
> > > >   #ifdef __s390x__
> > > >          /* Align to 1M (segment size) */
> > > > -       guest_test_phys_mem &= ~((1 << 20) - 1);
> > > > +       pta->gpa &= ~((1 << 20) - 1);
> > > And here again (oof)
> > 
> > Yep, I'll fix all these and the align() comment in v2.
> 
> This is not exactly align in fact; it is x & ~y rather than (x + y) & ~y.
> Are you going to introduce a round-down macro or is it a bug?  (I am
> lazy...).

Good question.  I, too, was lazy.  I didn't look at the guts of align() when I
moved it, and I didn't look closely at Ben's suggestion.  I'll take a closer
look today and make sure everything is doing what it's supposed to do.
