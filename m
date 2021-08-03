Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01823DEAC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhHCKYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhHCKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:24:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298FC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:23:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p5so24760806wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nP9D6D93L6qc5wew7Nn46YCj/dOgm/CGIsmnHV7G9M=;
        b=Ho4RQEFtqmvBySDaWHiw1aTqR3SvwRCIavU7WYhFyFZhuNLD+JoxHFCrzhAGnlwv45
         nGcmz5APzAtb38Smfo7PXQOSiH9KG+hvvvDyezbbCsXufg9MGoEC2R5Hdso09fGEMt6q
         SvkrB1zNZe8acO7dxYIUmRnRXfp6O3KpfKQrqXJdOX8R+4/+K1zFHXDlzjLJ/HOYxZtH
         FYAc+DfRi8FWVr0tTLlKp54se6JvxmOaP/V4ia6YKhaHu5fhhzBDNVmUGB2ktw/ZXwSx
         R1cpS1W9iOhYU6OAgDBOYDoRukjsvsNjbWcfyU9AmBb67uctkwKkttxb7JCAhkUatIxC
         Yv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nP9D6D93L6qc5wew7Nn46YCj/dOgm/CGIsmnHV7G9M=;
        b=Zv+RDC/jobCACWTO21cUOuW6Jxc+jYI5pok9qriyfIV/awm427xt+ABMKeefMmpzPa
         Ps+3LLinCMq9HslJaPIz0CJrKzURJz0JO5YowyBGlwZ3nqcliv5kJhMAGqeES+eFyget
         pZVRqtiQQGks9PMPSc6NO2OXyHOkI+lYJ74bFFl5rBXXEbI9Vblu5LWonxvtr1NBIs1n
         8pjxUGRht5vSSe6qPyeav6NAG8HUMv1UgK8Nh8B87V9TOeDV06ZKI0N6q7oWDN6Ye1Cc
         kcbFLCyrsu8JErEDiNHUiIO9ChpvetDYHzYpMhvsSJD6n4UBbyvPQGVUZB2AbDR5bvy+
         /GnQ==
X-Gm-Message-State: AOAM530aVz+lz1yPJqfNRApuFiB4du+yN3yTET7G7sTVbD+gxIrBXziF
        CiVaL65P+Ncls8Fz/rok2a+Xaw==
X-Google-Smtp-Source: ABdhPJw6dFoHt9c3udAF7oPNiz9FzEP1I0FGJKO5RGfwj7M7cAIND+fyusk+0UJkJ+0JmosBwI1pOw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr23463332wrr.105.1627986231087;
        Tue, 03 Aug 2021 03:23:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:754:7d1b:7303:129a])
        by smtp.gmail.com with ESMTPSA id n5sm12842687wme.47.2021.08.03.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:23:50 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:23:47 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v3 15/21] KVM: arm64: Introduce addr_is_memory()
Message-ID: <YQkZMyyqgqb8+Uqq@google.com>
References: <20210729132818.4091769-1-qperret@google.com>
 <20210729132818.4091769-16-qperret@google.com>
 <CA+EHjTxrdA3wVsBe7zwvvGUGgoWuaGwuWCBL0k2+FcAdTGB=Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxrdA3wVsBe7zwvvGUGgoWuaGwuWCBL0k2+FcAdTGB=Qw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 Aug 2021 at 16:52:31 (+0200), Fuad Tabba wrote:
> Hi Quentin.
> 
> On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
> >
> > Introduce a helper usable in nVHE protected mode to check whether a
> > physical address is in a RAM region or not.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index cc86598654b9..5968fbbb3514 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -51,6 +51,7 @@ extern const u8 pkvm_hyp_id;
> >  int __pkvm_prot_finalize(void);
> >  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
> >
> > +bool addr_is_memory(phys_addr_t phys);
> 
> I'm just wondering about the naming of the function. I understand what
> you're trying to achieve with it, but an address without a unit that
> conveys size or type seems to be missing something. Would

Well it does have a type no? I was hopping this would make it clear what
it actually does.

> memregion_addr_is_memory or something like that be a better
> description, since it is what find_mem_range finds?

I think the callers shouldn't need to care about the implementation
details though. This just replies to the question 'is this physical
address in RAM range or not?'. And I could actually imagine that we
would change the implementation some day to avoid the binary search, but
the users probably don't need to care.

Thanks,
Quentin
