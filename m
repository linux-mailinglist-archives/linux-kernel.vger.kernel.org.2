Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88B45AB80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhKWSvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbhKWSvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:51:41 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:48:33 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v64so145495ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0cDGU3aBL/JtvFU6Lqj9TIEFTKrrsLTWwNQVeTfm7s=;
        b=UJ+RaSYUdCuTpsCZQj9E3Oh9qJbvyuGy/4UukrBI48rk2Nj58gRp22Q5xYhb4vPTYQ
         S836CgyDfUSjbbUntu1fu6hwQgtOU+NNXS/hpd+ZkuuL5OGlxrNQooDduy8It3MuFzWg
         gzVzhOfTT8FoN4wNgjAdm4R5OlALjGaiHZfAconX1StgxWhu+iNLBHUfAnl5n86L7fsx
         xugVpbFgqEXK+5rIKSzhKsDpTeR+iYDBDYjBvthud8qfespy38O0nRnjyHMQZkeXPBYz
         KmDQil4XmOWKq9l38u9bPGnUPDJhIpUvifcD2bTWFK+f+zh+qcZC+ere/4WKN9vvBo6n
         7EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0cDGU3aBL/JtvFU6Lqj9TIEFTKrrsLTWwNQVeTfm7s=;
        b=5EmT72h1qBBLbVyDqXQsHwRijAq2oF1VKWsKt+rbUmE7/Q82WIivGc7OcNbixsiVKE
         kIzMSJ7UtNZpZs78pQ6o9Wkn3kpBkE1BQSjl3iwc3Ey2nn4TrJ7oOIdOFL5+qzwjPe5G
         SV6KCDG/Ih+Q8mWMG4LjCzqdPV8+Gp9UpGC9Risg5BZn26MtU6YbyEqSSx5YehtchUwS
         6Llegi/0Rb3febLfVbgnAIPzvzcHB2SjulFSNrK/wLbs1fZDP/6JpRi9h0ZSMJxARBNk
         RPUXdyFMwbKrOSMYV0MaARHFhQWD+6uKufyVYnKTZZXXxpPYOsA4HfmjHNtgiwt2Xstt
         bdCg==
X-Gm-Message-State: AOAM532DOuUCeMrvYuWP6LarheQRxF2Udr6ymEemzR2mseGoFQRgTayC
        En40lYcNKUpHn410q+K4otcBJ6l0+AcF6+eF0TiB9Q==
X-Google-Smtp-Source: ABdhPJzU9v6xYxlXR916SwfBpEwyCUWNGSP479wu5nIbbs9AwafRNm4AxCs/8CG3O42oR0mI9qJxiWj7/+VUFrV8ogU=
X-Received: by 2002:a25:a169:: with SMTP id z96mr8003600ybh.491.1637693312457;
 Tue, 23 Nov 2021 10:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20211113012234.1443009-1-rananta@google.com> <20211113012234.1443009-4-rananta@google.com>
 <87y25gcfti.wl-maz@kernel.org>
In-Reply-To: <87y25gcfti.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 23 Nov 2021 10:48:21 -0800
Message-ID: <CAJHc60yF6BbeQGsYsSLMKd_A1SAVBiZLXBdWMO9NFH1Y2h4JRg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/11] KVM: Introduce kvm_vm_has_run_once
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 8:31 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 13 Nov 2021 01:22:26 +0000,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > The upcoming patches need a way to detect if the VM, as
> > a whole, has started. Hence, unionize kvm_vcpu_has_run_once()
> > of all the vcpus of the VM and build kvm_vm_has_run_once()
> > to achieve the functionality.
> >
> > No functional change intended.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  include/linux/kvm_host.h |  2 ++
> >  virt/kvm/kvm_main.c      | 17 +++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index b373929c71eb..102e00c0e21c 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1854,4 +1854,6 @@ static inline bool kvm_vcpu_has_run_once(struct kvm_vcpu *vcpu)
> >       return vcpu->has_run_once;
> >  }
> >
> > +bool kvm_vm_has_run_once(struct kvm *kvm);
> > +
> >  #endif
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 1ec8a8e959b2..3d8d96e8f61d 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -4339,6 +4339,23 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
> >       return fd;
> >  }
> >
> > +bool kvm_vm_has_run_once(struct kvm *kvm)
> > +{
> > +     int i, ret = false;
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     mutex_lock(&kvm->lock);
> > +
> > +     kvm_for_each_vcpu(i, vcpu, kvm) {
> > +             ret = kvm_vcpu_has_run_once(vcpu);
> > +             if (ret)
> > +                     break;
> > +     }
> > +
> > +     mutex_unlock(&kvm->lock);
> > +     return ret;
> > +}
>
> This is horribly racy. Nothing prevents a vcpu from running behind
> your back. If you want any sort of guarantee, look at what we do in
> kvm_vgic_create(). Alexandru has patches that extract it to make it
> generally available (at least for arm64).
>
Yes, I looked into kvm_lock_all_vcpus(), but the fact that the series
would call the function with the current vcpu lock held caused me to
back off..
Perhaps I can come up with a similar function, kvm_lock_all_vcpus_except(vcpu) ?

Regards,
Raghavendra

>         M.
>
> --
> Without deviation from the norm, progress is not possible.
