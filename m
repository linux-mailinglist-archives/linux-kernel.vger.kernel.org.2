Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87DB445AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 21:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhKDUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhKDUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:10:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C714C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 13:08:06 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e65so6397754pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FCy7XmM3hO8fuNRRbZcDcJH+zhxWlYN4gDh9J8+Gr8Y=;
        b=i5FCB5yRnjsLmIeeLD+iM/48P6iRRBb5/VRgshHlVonSkwBfqOn7mKOOpkzAWa3d+X
         PKSQ3LKxLmU5TahEA0iAsYFe0/FgMn9qDEgQkQEqi5mAczxFwc1Cn8dBnQS3Hv0y+CnZ
         hJDpKn8/cUzWWP643aGY1oRkLzdX767kG/i9NUqhtJxYNm+XoN9nlkNUzMzXe8yzKVEF
         duEfBqvALTNuvmh1IrSc/nyUEA6tzE+2IzaryS3bHVoBmOsDqouXb6PH/74iv7ttaB2U
         s4AL14g2cyov6EqiKyVn48Z/2pU7KF2XOeY+qTvKKtuXPmDbmtZy7QpAeDO8olzGq95w
         rzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FCy7XmM3hO8fuNRRbZcDcJH+zhxWlYN4gDh9J8+Gr8Y=;
        b=NIV8OE6Igj3/zKJYYa2yBgV2pRDnmfx5YKQx1rU3VD6KGX2+HlQzExor76w6XPvRcs
         f2i4NmyTze/V9tst57kIJ0WGIlhu6OuQnmhHM4199FRJZuWV+32+44cWZ1rNEBh1MNFd
         32XuFLDZM0spUNmPQTGfDYxw+FhqBitP7jS2xDuqvWI+oBY1mdO2/ujjXvCrY+x+e3A8
         Qe1R0bzln1l6U1et4qSMyQFhsCi4TPjmW1a6On6q7rsDMfLi6tYEguAq2mFqQtKKYNLa
         weI2pq87UIDTgnaF0VVRFCdFfmayU12/L6+6AIb/9cDhKrQOs+Y6lnl9CySvlxbKQcGk
         w5iA==
X-Gm-Message-State: AOAM532KbHJ5/usS+F/fZ3AmpaKHC0joB2hP2SDAPVrRjKGk5tN3nZnf
        J+S8PgqSGg1l6FKEnwCJHdrqEA==
X-Google-Smtp-Source: ABdhPJw1QIFV3CAI2UcbFZ2VrNW++pdmjxY1ykPw3mNFNIEDqRH5ndwZEhZedIX0vx5gIhpYebrvWA==
X-Received: by 2002:a63:c4e:: with SMTP id 14mr10917845pgm.454.1636056485715;
        Thu, 04 Nov 2021 13:08:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h1sm5941243pfi.168.2021.11.04.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 13:08:05 -0700 (PDT)
Date:   Thu, 4 Nov 2021 20:08:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Durrant, Paul" <pdurrant@amazon.co.uk>
Cc:     Paul Durrant <paul@xen.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: x86: Make sure KVM_CPUID_FEATURES really are
 KVM_CPUID_FEATURES
Message-ID: <YYQ9ofrIKDxbgbu3@google.com>
References: <20211104183020.4341-1-paul@xen.org>
 <YYQzDLLE4WavR2Q6@google.com>
 <90c513d31a1b41daae1a642d2f5c72b0@EX13D32EUC003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c513d31a1b41daae1a642d2f5c72b0@EX13D32EUC003.ant.amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021, Durrant, Paul wrote:
> > -----Original Message-----
> > From: Sean Christopherson <seanjc@google.com>
> > Sent: 04 November 2021 19:23
> > To: Paul Durrant <paul@xen.org>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Durrant, Paul <pdurrant@amazon.co.uk>; Paolo
> > Bonzini <pbonzini@redhat.com>; Vitaly Kuznetsov <vkuznets@redhat.com>; Wanpeng Li
> > <wanpengli@tencent.com>; Jim Mattson <jmattson@google.com>; Joerg Roedel <joro@8bytes.org>
> > Subject: RE: [EXTERNAL] [PATCH] KVM: x86: Make sure KVM_CPUID_FEATURES really are KVM_CPUID_FEATURES
> > 
> > On Thu, Nov 04, 2021, Paul Durrant wrote:
> > > From: Paul Durrant <pdurrant@amazon.com>
> > >
> > > Currently when kvm_update_cpuid_runtime() runs, it assumes that the
> > > KVM_CPUID_FEATURES leaf is located at 0x40000001. This is not true,
> > > however, if Hyper-V support is enabled. In this case the KVM leaves will
> > > be offset.
> > >
> > > This patch introdues as new 'kvm_cpuid_base' field into struct
> > > kvm_vcpu_arch to track the location of the KVM leaves and function
> > > kvm_update_cpuid_base() (called from kvm_update_cpuid_runtime()) to locate
> > > the leaves using the 'KVMKVMKVM\0\0\0' signature. Adjustment of
> > > KVM_CPUID_FEATURES will hence now target the correct leaf.
> > >
> > > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > > ---
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > > Cc: Jim Mattson <jmattson@google.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > 
> > scripts/get_maintainer.pl is your friend :-)
> 
> That's what I used, but thought it prudent to trim the list to just KVM reviewers.

Ah, yeah, I run get_maintainer.pl with "--pattern-depth=1" when I'm sending KVM
patches/series.  That tells the script to stop recursing once its found a match.
