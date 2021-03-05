Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245F932F4B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCEUnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCEUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:43:19 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA0EC061760
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 12:43:19 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e6so2155325pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 12:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KySvOFZxt1c0YZjiiuNCyl7b6HcxJLjY37j04g7aO08=;
        b=v01vynvWKOKYGLu1bYQ0lAk1nsOmhbm1OSnXePtIutOsSy6HrVj34Y4JSn87NiIV42
         dvi0Yb+BPfBlpUYyhJqxEbEYLAVvXTaueiY7R3SoCMLuDiEfHUJgVXEIh8QDGhiKO2Bn
         UBA81bDq4AR/FMm0VkQdOgDgQ8Tko1G/x2Hx3BnrxQif2Le02xGPaWyjHmUmRv85+LZI
         1bbiA/QreROxid8rT4tJpsm8atCtZgIuHU2Of7zWAPh1QNIbsfc4ZUN0Zuc1405Ompiv
         TRxBGrETyO+4NadWKk2eRvsNd7hNftC9FHWy71LnmGbH7oS57EBLXv91cLwIuFGxBUXO
         OFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KySvOFZxt1c0YZjiiuNCyl7b6HcxJLjY37j04g7aO08=;
        b=tDhR1N6ryJvS7yiPCjmcIUME3Q4cxCG8dq3rGxhnPHPguGu0iqV19Fcq6zNeOKNDiJ
         TE+0WnVZgX+UyQx/qbW95ZP0dpDY5Unhw08Vw4wj31GacCbyU+p7fmmuHxy6uDosoml7
         9q/cF40THsmKQRacap4+l/7xwm8GpRlhqvDkv+JzioIbbW+W1JSTyPJS4u67xL+O7e5f
         Hj7TK9LOINIsmLlsWnjLHESJERe3xJQvykORdZbiFqMsa4Kn1DhXBfL91o9bn2AvNTXV
         Tyvm8XfaQgemnarP7wucBZHvVfTskKnmU+wBztT/+7cQWHErPr9U3NxYhrLKFSrak+b5
         /GAg==
X-Gm-Message-State: AOAM532qcAt+bNpWPG3Da0M99E9B6eFJ5SLxttPu5FDemaJ/KNZmOTJH
        mQj92X/FNTucFXEQEC8KNZNpocq+x+FKiGWQE1vABg==
X-Google-Smtp-Source: ABdhPJzBngssd2CcwsYrGrHXFib6t8QarZRWlst7uENKB3mpnYGMKqkdEJNJqM7S5X/KNSxpEZrpw+nr95LOci9yQkw=
X-Received: by 2002:a05:6a00:16c7:b029:1b6:68a6:985a with SMTP id
 l7-20020a056a0016c7b02901b668a6985amr10597366pfc.44.1614976998900; Fri, 05
 Mar 2021 12:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20210224085915.28751-1-natet@google.com> <20210305140409.GA2116@ashkalra_ubuntu_server>
 <ba4121bd-cad7-49f3-d53c-d1b03d95ca39@redhat.com>
In-Reply-To: <ba4121bd-cad7-49f3-d53c-d1b03d95ca39@redhat.com>
From:   Nathan Tempelman <natet@google.com>
Date:   Fri, 5 Mar 2021 12:43:07 -0800
Message-ID: <CAKiEG5oicgF=wuYda6RhH_Memc_gnoYSeiimVthkuxckKWN9_w@mail.gmail.com>
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ashish Kalra <ashish.kalra@amd.com>,
        Thomas Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 7:13 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/03/21 15:04, Ashish Kalra wrote:
> >> +    /* Mirrors of mirrors should work, but let's not get silly */
> >> +    if (is_mirroring_enc_context(kvm)) {
> >> +            ret = -ENOTTY;
> >> +            goto failed;
> >> +    }
> > How will A->B->C->... type of live migration work if mirrors of
> > mirrors are not supported ?
>
> Each host would only run one main VM and one mirror, wouldn't it?

That's correct. You could create a second mirror vm of the original
(A->B, A->C) if you needed two in-guest workers, but I don't see a use
for a chain. If anyone can see one I can write it that way, but in the interest
of keeping it simple I've blocked it. Originally I'd built it with
that functionality,
but allowing a chain like that smells like recursion and from what I
understand we don't like recursion in the kernel. There's also the fear as
steve mentioned that we could blow the callstack with a long chain of
destroys starting from the leaf.
Ideally we give userspace one less gun to shoot itself in the foot with.
