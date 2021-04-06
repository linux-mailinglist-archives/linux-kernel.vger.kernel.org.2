Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58D355CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbhDFU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbhDFU1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:27:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EFC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 13:27:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nh5so6332073pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B6bVwta59QdZJoFi3bJY0Ke48f3llQnoh7vx7Q+Q+vs=;
        b=DzB7KSG3PFCjI3n3gM3q8U4FNZ8wynr2yb3Arl5bBRta1QbLZp+E3a99XDPv7mF7c7
         QFDBtiC4sFH5XC/6M9WLt/U4WYYv4FujZHrt7eOoBr1kXYyYURd5wm7PM9/qAQHXvQy7
         Tmpdb2MNgnHUAi2QR5K7aSuaERIojNrdpyyivCBpxmlsaJIkx/tcVrsrZOsMYrtNMt3G
         yjdZXHv1aXduSEPEEnVLStvD5r0EAB7dU2NDN97tR1peFYKX+X0FqV5+CQ9ai0/6zda6
         DZmGCCzLxtmekCY/v4HyiiU5978NyXxBHTqKs6x45USMwHOh4uwXp40U72+hgqfh0eW0
         XiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6bVwta59QdZJoFi3bJY0Ke48f3llQnoh7vx7Q+Q+vs=;
        b=ICRBuUwe6U0eqj28ajuQBnwS6dQn5eHeviwCSA5SNpptvBuajauLcRdBDDTjtl0kqE
         40QG9u5ruXgzCF1IQpg49HswPdv2+ewJsfHfWiDAFEYHNyFsr0mjBYngq7t9yb31eoVM
         8PYQc9JknYZ907B0rPlb2tg0XgRmIZz8MvGXWsip0pwpgr+q3XYrTyMKrSKWvewDCrzZ
         x/YOcKuLkf/ulk9zkEFl4pokUJCbBX3eMEnX+XC1hoOt8PjqQV5AZsB7zWp4TeFOTPnD
         eImTnEfQDB+t+ShulGWjL6rQSRtknIHRobX1UDdnxoqsAuXDl/dGYUldS6TUMQEUUCBV
         s2MQ==
X-Gm-Message-State: AOAM533894vXxRz3UyRTxb0fLOSgHIQKtZ6Xo9phPXxHLUhYHJDOMvWZ
        fdukHeyERVb3sIVugFxlOHK7Nw==
X-Google-Smtp-Source: ABdhPJzgs3cgB5/AeBk2yqXn2OYvazjX1N+GL1XhmIybHMvkc8guKgSNrH1PzJwcUYW6HCnGO+694Q==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr5732203pjr.96.1617740842147;
        Tue, 06 Apr 2021 13:27:22 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w15sm3207908pja.18.2021.04.06.13.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 13:27:21 -0700 (PDT)
Date:   Tue, 6 Apr 2021 20:27:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Steve Rutherford <srutherford@google.com>
Cc:     Ashish Kalra <ashish.kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Will Deacon <will@kernel.org>, maz@kernel.org,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v11 08/13] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS
 hypercall
Message-ID: <YGzEJa8izE//+Niy@google.com>
References: <cover.1617302792.git.ashish.kalra@amd.com>
 <4da0d40c309a21ba3952d06f346b6411930729c9.1617302792.git.ashish.kalra@amd.com>
 <YGyCxGsC2+GAtJxy@google.com>
 <20210406160758.GA24313@ashkalra_ubuntu_server>
 <CABayD+f9o1CZTdak-ktKXpJnxcOAP4KPnYCDBzry91QcK6WVcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABayD+f9o1CZTdak-ktKXpJnxcOAP4KPnYCDBzry91QcK6WVcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021, Steve Rutherford wrote:
> On Tue, Apr 6, 2021 at 9:08 AM Ashish Kalra <ashish.kalra@amd.com> wrote:
> > I see the following in Documentation/virt/kvm/api.rst :
> > ..
> > ..
> > /* KVM_EXIT_HYPERCALL */
> >                 struct {
> >                         __u64 nr;
> >                         __u64 args[6];
> >                         __u64 ret;
> >                         __u32 longmode;
> >                         __u32 pad;
> >                 } hypercall;
> >
> > Unused.  This was once used for 'hypercall to userspace'.  To implement
> > such functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO (all except s390).
> >
> > This mentions this exitcode to be unused and implementing this
> > functionality using KVM_EXIT_IO for x86?
> 
> I suspect this description is historical. It was originally from 2009.
> KVM_EXIT_IO is used for IO port reads/writes.

The purpose of the comment is to discourage use of hypercalls for things that
can instead be done via port I/O and/or MMIO.  The biggest advantage is that KVM
doesn't need to act as an intermediary; userspace can define whatever paravirt
shenanigans it so desires and KVM naturally handles the I/O accesses.

MMIO in particular also allows for finer granularity of permissions in the guest,
e.g. the guest kernel can expose the address to a userspace application to allow
said application to make "hypercalls".  Port I/O technically has similar
properties, but the I/O bitmaps are heinous.

For this particular case, because we want to make a _KVM_ hypercall that just
happens to get punted to userspace, and because there is no known or projected
use case for letting guest userspace control memory encryption it makes sense to
use a "real" hypercall.

> Personally, I would prefer to stay the course and use a name similar
> to KVM_EXIT_DMA_SHARE, say KVM_EXIT_MEM_SHARE and
> KVM_EXIT_MEM_UNSHARE. These just seem very clear, which I appreciate.
> Reusing hypercall would work, but shoehorning this into
> KVM_EXIT_HYPERCALL when we don't have generic hypercall exits feels a
> bit off in my mind. Note: that preference isn't particularly strong.

I'm not against adding a new exit type, I'm against adding _two_ new exit types.

I also don't like using "(UN)SHARE" because there may be future use cases where
the hypercall isn't used to "share' memory, but to inform the host of a change
in state.  I don't have a concrete example, but it's not completely absurd to
think that there might be a scenario where a guest has the ability to use multiple
keys and needs to communicate key usage to the host.  Linux already has horrific
(IMO) names for describing encrypted vs. "other" memory, I'd strongly prefer to
avoid adding yet another potentially wrong name to the mix.
