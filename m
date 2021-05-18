Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110D3882D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352809AbhERWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352810AbhERWnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:43:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:42:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v13so5925062ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XL3tmp4SlD8u+MURb+F7eYCl3cEQ2lvBi6aHFNGgpI=;
        b=a8TzhFVWYyn0p8gHuauSaF9QAB44THnp4+DIPkJyEETzXJh1jxlquPY9Vl4r2rVW+4
         Yo2+PnNdCMTjYPe5bgvECgGdwldO4llzgZTYUOyIYPNM0huStFyVZHD1s0TG388izkID
         iItNKCGPaBhyMC9P9Ii1wEtzIXNi4yUspxpPdM0VK3pbtXpPhqVSCUGen/dTVHQorknP
         wIfUGGh/XrMOAj4rz+qpXw7suPLE46kbWBisSY8d0JtWIvWpmohahiyPiKRmrwR1Q+2S
         0P8XRr2L5w41dlXgVleurmGSWpXdNlmlvRL0HfvkFDDfcDQ5KlkvK751danidsYTKGyN
         O+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XL3tmp4SlD8u+MURb+F7eYCl3cEQ2lvBi6aHFNGgpI=;
        b=DxuH0jV23/a/e5EegkmCwcwUKFQhzMSyG/KGLdkb7SfuDgFrCzfGhmqwUpB31HcY1x
         4UnFH0AI28NqYv0K7U9N4zA6XsZ2OC4lsyIoAjwY6TF4tQ4PT+0OZoRvRUGfAKXKoAsz
         lLr/ggX6ZE/h2YAo2bbYGFaqVBNu8k+C+MWdwN9n5KYKGjTcJ+26a2kzRoerRiipbdeZ
         nhake/BU+9rZ12Ku2xAVw8poXgV0HHi2Ynt7APdEkSsOgl+rh8M0IyuGNr+HdRvIW87i
         o+pHE5ptFO5svYJZ4MPx+Ik+RD35J6Z8nCSbs13elEfpwiS2JuSbRhwB1LYYw7WLKoNN
         qrZw==
X-Gm-Message-State: AOAM533yiDVwBCfllJbwfHllHLWd9gSxNesac3djDPSsLVwvf8fCpqms
        3Ske67ZNhwICALsu9pFCayRfnPVPs6+T7cYxem77jg==
X-Google-Smtp-Source: ABdhPJxILffNNtWQEleAX3EcDbaS2hWIpOqyf1eMTbuGQWCjwjM2RKMZ4DT2Dd217Xr3Qi26abpUlLVRggmxQXklTDU=
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr7573739pjh.170.1621377737935;
 Tue, 18 May 2021 15:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-7-seanjc@google.com>
 <CAAeT=FzS0bP_7_wz6G6cL8-7pudTD7fhavLCVsOE0KnPXf99dQ@mail.gmail.com> <YKQiTlDG1sZ4Zd2E@google.com>
In-Reply-To: <YKQiTlDG1sZ4Zd2E@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 15:42:02 -0700
Message-ID: <CAAeT=FzsXFNiteMB3sjskM401Ty4Ry_w80YcYB4ZYcZn0dqv5Q@mail.gmail.com>
Subject: Re: [PATCH 06/43] KVM: x86: Properly reset MMU context at vCPU RESET/INIT
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +       if (kvm_cr0_mmu_role_changed(old_cr0, kvm_read_cr0(vcpu)) ||
> > > +           kvm_cr4_mmu_role_changed(old_cr4, kvm_read_cr4(vcpu)))
> > > +               kvm_mmu_reset_context(vcpu);
> > >  }
> >
> > I'm wondering if kvm_vcpu_reset() should call kvm_mmu_reset_context()
> > for a change in EFER.NX as well.
>
> Oooh.  So there _should_ be no need.   Paging has to be enabled for EFER.NX to
> be relevant, and INIT toggles CR0.PG 1=>0 if paging was enabled and so is
> guaranteed to trigger a context reset.  And we do want to skip the context reset,
> e.g. INIT-SIPI-SIPI when the vCPU has paging disabled should continue using the
> same MMU.
>
> But, kvm_calc_mmu_role_common() neglects to ignore NX if CR0.PG=0, and so the
> MMU role will be stale if INIT clears EFER.NX without forcing a context reset.
> However, that's benign from a functionality perspective because the context
> itself correctly incorporates CR0.PG, it's only the role that's borked.  I.e.
> KVM will fail to reuse a page/context due to the spurious role.nxe, but the
> permission checks are always be correct.
>
> I'll add a comment here and send a patch to fix the role calculation.

Thank you so much for the explanation !
I understand your intention and why it would be benign.

Then, I'm wondering if kvm_cr4_mmu_role_changed() needs to be
called here.  Looking at the Intel SDM, in my understanding,
all the bits kvm_cr4_mmu_role_changed() checks are relevant
only if paging is enabled.  (Or is my understanding incorrect ??)

Thanks,
Reiji
