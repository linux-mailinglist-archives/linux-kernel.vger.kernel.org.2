Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7041C8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbhI2P6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbhI2P56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:57:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:56:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so1841820pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXqhrOe99SMkwy7xOUQxSfO26TmAo7lLUFFlJf608N0=;
        b=Tv8zIpJ1xnCFM6xhqdlL4/vIvDrFT70hpY7YZvbNRnBVFOG4552p58wruczMQgdZKK
         eeSXc9vgKvRWFa2wZKncJtuoLccB/SQD0lZb373whHXgP0hN/syk+1YESmAJ6Ckzumcc
         NhvyhMJ3gxZLYVgkzClSHDzRrlf9ZGze6PJb4Rjp/jG+ril8oNOXTXLsWT1pRrkPtmqL
         4PUV0yFNHSQKSen8HonJ/GYpFyC1hMu/UjTjUXDwstRpbzIuCAqm2crgOGwYwr7WvZkG
         XmVQ1BpAVbDup/q/pmVYh+eI2ZnBlN5C050/HolusT4O+D/tiDJeb9Jde5hqcWLG1a89
         ivNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXqhrOe99SMkwy7xOUQxSfO26TmAo7lLUFFlJf608N0=;
        b=tsP1bzaQrBDXArSjIhM7qvWdzdjAJIHYLqt21p7+8C72cCzLcmjr9YM7MzjlYCEZHh
         /5im/8seC8e2PKyw6dDee0B0Q5bm8GCY7htHMZBq8BruhgZ2+9797U65Tm5GBf83bNTL
         feW0veynu5rtfV5HXCkExyG8aY63+RCkmoU+O8oG41AVfZIAW+7tm7mXh8UXJwZPD1OF
         PQ46JIp+mx1NS+o29jUArNz14Mpq9nHipPIbrb+u6NdnGu3m7nzuugqSKmRttW9mByYY
         h33pdQH1pa7jKDzd7+4iyRvkoghXhYY3S10ic8dCvR1q3DKx3re5alosG8EvwThiWFbs
         P2dg==
X-Gm-Message-State: AOAM530RhZvRl7tb++wKMm2ZFOeKo8yDaMX7dJOMujhQzAkkv+e6oy+e
        lHohR2Mie8/nRyzp//WLF31Fyw==
X-Google-Smtp-Source: ABdhPJyyJ63l3Jgn/wkbO4utLpV1s4Zsct68SOclwmSTKlsnuKe6K74rJe7GIbs8jNqvwhk7Zjw+fQ==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr423618pjn.216.1632930977189;
        Wed, 29 Sep 2021 08:56:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p16sm242556pfq.95.2021.09.29.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:56:16 -0700 (PDT)
Date:   Wed, 29 Sep 2021 15:56:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: Depend on HAVE_KVM => OF instead of
 directly on OF
Message-ID: <YVSMnE8vJFdj7J+N@google.com>
References: <20210921222231.518092-1-seanjc@google.com>
 <20210921222231.518092-3-seanjc@google.com>
 <20210929155328.GD22029@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929155328.GD22029@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021, Will Deacon wrote:
> On Tue, Sep 21, 2021 at 03:22:31PM -0700, Sean Christopherson wrote:
> > Select HAVE_KVM if the KVM dependency is met (OF / Open Firmware), and
> > make KVM depend on HAVE_KVM instead of directly on OF.  This fixes the
> > oddity where arm64 configs can end up with KVM=y and HAVE_KVM=n, and will
> > hopefully prevent breakage if there are future users of HAVE_KVM.
> > 
> > Note, arm64 unconditionally selects OF, and has always done so (see
> > commit 8c2c3df31e3b ("arm64: Build infrastructure").  Keep the somewhat
> > pointless HAVE_KVM dependency on OF to document that KVM requires Open
> > Firmware support.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/arm64/Kconfig     | 1 +
> >  arch/arm64/kvm/Kconfig | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index b5b13a932561..38c0f36a5ed4 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -187,6 +187,7 @@ config ARM64
> >  	select HAVE_GCC_PLUGINS
> >  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
> >  	select HAVE_IRQ_TIME_ACCOUNTING
> > +	select HAVE_KVM if OF
> 
> Honestly, I'd just drop the 'if OF' here. We select it unconditionally a
> few lines below and so I think it's more confusing to have the check.

Work for me.  I all but flipped a coin when deciding whether or not to keep the
OF dependency.

Thanks!
