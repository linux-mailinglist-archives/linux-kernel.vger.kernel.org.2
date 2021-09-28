Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB441B2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbhI1PcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbhI1PcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:32:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E1C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:30:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e15so94533682lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dR8SwI7xo4O3PMMdZC16ZxBjI2bA95Vf3wk63lcfA2M=;
        b=oLE+6BTJ5k6LXPcuEw3+RcYe2XS/f5mJxXbP1VwlUDABUlzPMLhayafCLsVhkX2NqF
         WpFRgFX/2AhQHcslRSbaiUTVmtqeWR77wqGhY6fXPVo2MlcYMklHxpFc3gCUuHFGZMa1
         5vXdtqUr0EP1jiCZdwLQcHo5V2ZvbH+OdwXMX1fqCmHkwZ27q8UB1hOwMjiL6nsOK1gg
         Ee0CFm9sNd0klFbzde3PVksW/1cxH6cd2mGS03a9Z5V04qklSqZuXpdM/eXNuiQWuKe6
         CS2N4+6Jl9jqTqkXWMcKV/LLzNX7vY/pvky0ao4puIdmv2fHcq51pAmgfToDyk4kf94A
         cjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dR8SwI7xo4O3PMMdZC16ZxBjI2bA95Vf3wk63lcfA2M=;
        b=XYwHpLRDZrmh8XKgGd1cHiQZkfTsjfwBEAqIjD3vwPkCRfyU4W0p+hWi58Acvp9Xx5
         ljL6Kqw5Bl7QIChXMojK9hkSAS5ZBgw4n+mzyCPYE1ax5jmfG8xW4/9l7mVT7y+0vr3D
         vmB5ndUDP1ua0cWk3djsj6/1rfra19n3Uio7iDXHNmHjohtRjGESnwD9s9fwrrWvo/kO
         X9o3YMCkhEreeI0ukSwEaSptfiohUokhpwXM/TRBBbqABAI93v2TkUPJjWUilmo0BZhB
         9sHL/vm4FHgn+fNAWWPT0LGwnxlTlNQiejzNlSzJHODoSw6KbR7EhUbFMsBoujKS2x8r
         Ls/w==
X-Gm-Message-State: AOAM533rT18jkgB5AEWg/p1OQkc9WnvdPsd22uUJHsB7Sk9htZCFw6Dz
        G6Gj4Iru5IO6Z5N75aQJaULcfywdCNCjuXpEfDP+jA==
X-Google-Smtp-Source: ABdhPJzOa2nUIG2Gm7CVTKgXerj2MNhXJSbSLR434OPr+oZn/BNZltUmNgmtWA03xC/qTBo8reGfdRd74MN1kz3m4GI=
X-Received: by 2002:ac2:483b:: with SMTP id 27mr6151373lft.644.1632843020212;
 Tue, 28 Sep 2021 08:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210914164727.3007031-1-pgonda@google.com> <20210914164727.3007031-2-pgonda@google.com>
 <YVMNq4wwjYZ8F7N8@8bytes.org>
In-Reply-To: <YVMNq4wwjYZ8F7N8@8bytes.org>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 28 Sep 2021 09:30:08 -0600
Message-ID: <CAMkAt6q5YbZpnDeFXeQsZcK6WtxdAuMoWqqUwURZ9KLz692MEQ@mail.gmail.com>
Subject: Re: [PATCH 1/4 V8] KVM: SEV: Add support for SEV intra host migration
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 6:42 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Sep 14, 2021 at 09:47:24AM -0700, Peter Gonda wrote:
> > +static int sev_lock_vcpus_for_migration(struct kvm *kvm)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     int i, j;
> > +
> > +     kvm_for_each_vcpu(i, vcpu, kvm) {
> > +             if (mutex_lock_killable(&vcpu->mutex))
> > +                     goto out_unlock;
> > +     }
> > +
> > +     return 0;
> > +
> > +out_unlock:
> > +     kvm_for_each_vcpu(j, vcpu, kvm) {
> > +             mutex_unlock(&vcpu->mutex);
> > +             if (i == j)
> > +                     break;
>
> Hmm, doesn't the mutex_unlock() need to happen after the check?
>

Ah good catch, thanks for the review Joerg! Yes you are right this
results in calling mutex_unlock on a mutex we didn't successfully
lock. I'll fix it in the next version.
