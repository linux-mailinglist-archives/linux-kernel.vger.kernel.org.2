Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8903FCF62
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhHaV6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhHaV6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 17:58:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:57:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v123so414746pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CEe5Urw4QMBsnRPkPJtvmyJzkDuJU8sc0GlT6RJl5UM=;
        b=rmpVTSJWBqYH2G+fFotl9CA1FOmWXfA4QDJkH6nUjlGrDeMMEUU5spyGcBpCSamBtS
         n42WT1f1+HKA9cm132h/xjyUEqYf2H1GRw6qVu773tSmRbOrbcazmNF2Ygs3D/A2i+J3
         85SfMpHyFqIDRoCHrWE3AJT910l781bZqWRwowQAOjUALBDrgTUuuSH63yTbXzgb1d3a
         x2VslYC3nnbY51U9w9CHTca7N3HRVlWZMq7VKbs93FGXq4yq/Rt1l6O3YVOuVrR4CkDG
         McbutYrlt0yS84L9tO2yxb6g7e19MinahS7801GIFdJJMFTFI+F5UUuQgqsC0ZGexhci
         7kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEe5Urw4QMBsnRPkPJtvmyJzkDuJU8sc0GlT6RJl5UM=;
        b=gaIs1yeqhXn1pSCm0PZA1Imo09GcczvqjryweMIstiNp6K1HfDL2lJC6CoyyXdHQxB
         Nco/D2iRtsPEjp3r9XIc5ANYOC7DZybqWL32xepWFrIIqOsSz0S1NFXg+x6CR2ODs/w8
         kOp1r/rURJ8ZuCLwXA7pHsZ7Zaq09H0aZok6RqJ+0RQODER3Z+1H0gB6wnSoQja+jz+r
         3dsScnm/PxxoRyi5v90gjNC8jVVMWntEGvcEhQ6ty7zESZKZNQlgPIZ4AVxtGpOQ70DR
         9oJHLOxhICXi3a+DzmuN0Pm3Dc2ntmY9BO2VDtDWhVcQHHvJnghFMxBvJ8woIhStaBYt
         Sd7Q==
X-Gm-Message-State: AOAM531l2rF4R6f+RSt4GonXjrgi4+QJu4bSBS5QPW36/bkvFn1mYV8S
        PkSy+eRc9rOoLn3+aPkR0LEfvQ==
X-Google-Smtp-Source: ABdhPJz/flfm1xsK677wwgR1uWMMQHm00aSsptp3MEVzP94y7o1Xrd8fDiKnUzeZeOabRNJOoVxScw==
X-Received: by 2002:a63:68e:: with SMTP id 136mr27346983pgg.383.1630447025595;
        Tue, 31 Aug 2021 14:57:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g3sm18807838pfi.197.2021.08.31.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:57:05 -0700 (PDT)
Date:   Tue, 31 Aug 2021 21:57:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 0/7] KVM: X86: MMU: misc fixes and cleanups
Message-ID: <YS6lrc6B0S1JlWQ7@google.com>
References: <20210824075524.3354-1-jiangshanlai@gmail.com>
 <CAJhGHyAT+WO4Lf_aOOnb6R4UEJcSAxwkH339MSziqxrEteToKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAT+WO4Lf_aOOnb6R4UEJcSAxwkH339MSziqxrEteToKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021, Lai Jiangshan wrote:
> On Wed, Aug 25, 2021 at 1:40 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > The first two patches fix two old possible defects.
> > And the others are just cleanups.
> >
> > Lai Jiangshan (7):
> >   KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
> >   KVM: X86: Synchronize the shadow pagetable before link it
> 
> Hello, KVM people
> 
> Ping.  Aside from patch 7 which has been addressed by Sean,
> the patchset has bug fixes and useful cleanups.
> 
> Could you have a review or an ack?

I'll take a look this week or next, I'm aiming to start chewing through my review
backlog this week.
