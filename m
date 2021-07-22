Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75AA3D2486
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhGVMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231938AbhGVMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626960320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAnmeuIfQdncCUiW75D8IzEpkqgkah2ZNrMDpLBYjTo=;
        b=iLlI69Nmr/bfh+f/nL4Jl2NViZ7djwp10TLqaUW2YNfMGymStQd/x/pCCweC3401OZSrZy
        5H4Xh4q2bKCMbvckuCm+Ox/l+N1u+Uu5fhzsmfXvJ5QqKlZcn1l40q3+70LtJJi1d098Yz
        W2I5dLbpJn3Hi2R4Kh0T99xrtAq0nC4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-CpVLOyBHNw2cMJ9HBa6-DQ-1; Thu, 22 Jul 2021 09:25:19 -0400
X-MC-Unique: CpVLOyBHNw2cMJ9HBa6-DQ-1
Received: by mail-il1-f200.google.com with SMTP id s12-20020a056e02216cb02901f9cee02769so3546585ilv.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 06:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAnmeuIfQdncCUiW75D8IzEpkqgkah2ZNrMDpLBYjTo=;
        b=VkB8NDoWduOub6L4hYu8Zx03KK/0s2tiIwi9nP3ZfY6Ht2i01QHaqB0cgSySQOP+r+
         8soELbNa4Xfx60ORZ1ApVeDyyJxujaIqHrejdpH0oLYwnSj+kPRDvkV4SWynsYNoh4O7
         +DDoFdby14272yHyA5uSMS7zb6tQCqVvshoCh8tvMMY4AHirNzaUcq7zAurFBH4sqbsH
         Md9WfC+yFGgH5QavMKLfh6zGs8iHtuFEikKRLFGu6W6/YkA/+qwjlCnzhoj/lYctoc49
         XVO0q5bB+MbW8Kve/QdCXxvKHDwhv7Uw+kQllNJBE5xcUnYpWgwd2xgOACagOrxOgQEE
         kb4w==
X-Gm-Message-State: AOAM533nQxqYQRJ8UXuDyR/uiF5RH5HnPw1YeYOB/zSYo1HkT/MbrbsZ
        u2U8F4zri3NT9a72D5BRDZXLUB98v//sjWMkpTEItb8y/0Bo0Z6fzpiatCrYTITGXu+Zs/zoVdT
        lejk+ZK4fcgVgp7mEPGZE6CyT
X-Received: by 2002:a6b:f101:: with SMTP id e1mr17328420iog.118.1626960318896;
        Thu, 22 Jul 2021 06:25:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO7B6+/GK3ldKKhKw6OpJsBYn9h5NNBp2v0iNDfsc4BXVWjBxmWixYMqcWppyKDhuCURsoJA==
X-Received: by 2002:a6b:f101:: with SMTP id e1mr17328405iog.118.1626960318688;
        Thu, 22 Jul 2021 06:25:18 -0700 (PDT)
Received: from gator ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id z6sm14874865ilz.54.2021.07.22.06.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 06:25:18 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:25:15 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        will@kernel.org
Subject: Re: [PATCH 00/16] KVM: arm64: MMIO guard PV services
Message-ID: <20210722132515.y66qi23r6ty3anax@gator>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210721214243.dy6d644yznuopuqx@gator>
 <874kcm3byd.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kcm3byd.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:00:26AM +0100, Marc Zyngier wrote:
> On Wed, 21 Jul 2021 22:42:43 +0100,
> Andrew Jones <drjones@redhat.com> wrote:
> > 
> > On Thu, Jul 15, 2021 at 05:31:43PM +0100, Marc Zyngier wrote:
> > > KVM/arm64 currently considers that any memory access outside of a
> > > memslot is a MMIO access. This so far has served us very well, but
> > > obviously relies on the guest trusting the host, and especially
> > > userspace to do the right thing.
> > > 
> > > As we keep on hacking away at pKVM, it becomes obvious that this trust
> > > model is not really fit for a confidential computing environment, and
> > > that the guest would require some guarantees that emulation only
> > > occurs on portions of the address space that have clearly been
> > > identified for this purpose.
> > 
> > This trust model is hard for me to reason about. userspace is trusted to
> > control the life cycle of the VM, to prepare the memslots for the VM,
> > and [presumably] identify what MMIO ranges are valid, yet it's not
> > trusted to handle invalid MMIO accesses. I'd like to learn more about
> > this model and the userspace involved.
> 
> Imagine the following scenario:
> 
> On top of the normal memory described as memslots (which pKVM will
> ensure that userspace cannot access),

Ah, I didn't know that part.

> a malicious userspace describes
> to the guest another memory region in a firmware table and does not
> back it with a memslot.
> 
> The hypervisor cannot validate this firmware description (imagine
> doing ACPI and DT parsing at EL2...), so the guest starts using this
> "memory" for something, and data slowly trickles all the way to EL0.
> Not what you wanted.

Yes, I see that now, in light of the above.

> 
> To ensure that this doesn't happen, we reverse the problem: userspace
> (and ultimately the EL1 kernel) doesn't get involved on a translation
> fault outside of a memslot *unless* the guest has explicitly asked for
> that page to be handled as a MMIO. With that, we have a full
> description of the IPA space contained in the S2 page tables:
> 
> - memory described via a memslot,
> - directly mapped device (GICv2, for exmaple),
> - MMIO exposed for emulation
> 
> and anything else is an invalid access that results in an abort.
> 
> Does this make sense to you?

Now I understand better, but if we're worried about malicious userspaces,
then how do we protect the guest from "bad" MMIO devices that have been
described to it? The guest can request access to those using this new
mechanism.

Thanks,
drew

