Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2B41DD08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbhI3PNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbhI3PNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:13:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D01C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:11:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so6978410pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMXkTSWKWE6IOTwgZL4qEhWkaG0vz1XKQFudBOV/uFM=;
        b=DZam6ASZNWqT//2uufR62sif+1Las8Y6W53M/dKFeka+a6T8T/wMUkKq4LfWwXrDlS
         AKeBKhORnyrCWco1bRD79u/8tR+v1IoJ9YHG5NR4e5ZRNbA2UVO+wg4uvT4Ka9Sh0PaP
         +HqPeWNFp/fTDC+GcAOuLLiUhXggiGO/IBIWXpAoxkXNqnXphVqgalZ6GrigCzDxzdt8
         bN6SzD7IPT2CiRE+IqRFb+xUtOI83CD09AKDCCbbBEnGtlK0AEuMqQpHM1oixXKfRGzn
         6ESDHBGFAj5axFshHo9uhJGDzEpH1jq++TVtyAV2fcuDl+xxzsrPhrXGJCVJTHWe3SBA
         hUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMXkTSWKWE6IOTwgZL4qEhWkaG0vz1XKQFudBOV/uFM=;
        b=RWMKPifreIej8aKe8OFoahxgJrepSUb/dOVx8Re+mPg/XzbXlAGminql7qbNwWilqT
         WzZr8iRbXd3xHVC+pqdOqHacSSSSt3/7AGKNEe6cB7jORdymDjFO0xPwjSUmNchHhB8Q
         AycmIVF56h8vxoZgcUc/hAmcmpv0uAYOdx09VJPGaF4naIfY07fUpSBqNjN0ZrSsPm6g
         y19GHK+x8rCRoBd2vcjEHixfG4V3656XoOxQs9E0gfz8QjIp8J2Ms9TlZpaqzBfEYdOz
         CayqTqSMiddu7+ZkaC+euagb7uqYXbF32f+UfExd8cRS2vnY9kKW5ChGoaR9wLwwfmmJ
         Gx5Q==
X-Gm-Message-State: AOAM533zwVxDWaA5eVAqK/M1unyaq0QpPeXzp20xZb7yJHVfaJ7hhGbb
        I44jRKDqjOL2sHd8FhulzG0LcQ==
X-Google-Smtp-Source: ABdhPJzWcwPdYwdLJ+5nxnLJ3fIdOxEitU8PB0EX6nFJI4cqI6Goe8KhCueoZ13Y7u1uUk383CaqNQ==
X-Received: by 2002:a17:90a:181:: with SMTP id 1mr7110103pjc.214.1633014691201;
        Thu, 30 Sep 2021 08:11:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c4sm3380348pfd.80.2021.09.30.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:11:30 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:11:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+f3985126b746b3d59c9d@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Manually retrieve CPUID.0x1 when getting
 FMS for RESET/INIT
Message-ID: <YVXTnheIB6MCKGve@google.com>
References: <20210929222426.1855730-1-seanjc@google.com>
 <20210929222426.1855730-3-seanjc@google.com>
 <75632fa9-e813-266c-7b72-cf9d8142cebf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75632fa9-e813-266c-7b72-cf9d8142cebf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021, Paolo Bonzini wrote:
> On 30/09/21 00:24, Sean Christopherson wrote:
> >  	 * RESET since KVM emulates RESET before exposing the vCPU to userspace,
> >  	 * i.e. it'simpossible for kvm_cpuid() to find a valid entry on RESET.
> > +	 * But, go through the motions in case that's ever remedied.  Note, the
> > +	 * index for CPUID.0x1 is not significant, arbitrarily specify '0'.
> 
> Just one nit, this comment change is not really needed because almost all
> callers are using '0' for the same reason.
>
> But, perhaps adding kvm_find_cpuid_entry_index and removing the last
> parameter from kvm_find_cpuid_entry would be a good idea.

I like this idea, but only if callers are forced to specify the index when the
index is significant, e.g. add a magic CPUID_INDEX_DONT_CARE and WARN in
cpuid_entry2_find() if index is significant and index == DONT_CARE.

I'll fiddle with this, unless you want the honors?

> Also, the kvm_cpuid() reference needs to be changed, which I did upon
> commit.

Doh, thanks!
