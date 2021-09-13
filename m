Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2754098D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhIMQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbhIMQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:22:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CEC061764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:21:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so22255849lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDprip5fY3voX1Qv8j7L/aqC8hZUhXwNwQ9qHoD5Biw=;
        b=m7SWvcjcOuSUFq4JiGRDT+E6uGirxXLi6uDeqkBo91KEbXZzA+WYa4CF2bPvuTUEpE
         WEp8JcZyUfh7a3ahWwxFDPli0KHOjStveLQAMPW+aOJIwNndaoqzLNcIbJcpeVkmTVVz
         s0zH+Yq2hytNDOXR/pp+RmBY14I8yllyrlv0LSZiCN5qNF6BrQVLkMDr34lMfB+6ydJN
         tV1dFoWevq+aPi3V71JO81+LAjFKaXpn5BMAAoi/zwElKqDV9alPSmtKGZ+XXJk1Bf2P
         St6OxQzkBV2TebshxkYVnAuwv/rG9rrQjnWZRFDMBnhTYGJobrfsQBXOKJTIKpN5t5Me
         2WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDprip5fY3voX1Qv8j7L/aqC8hZUhXwNwQ9qHoD5Biw=;
        b=OGK1hrDuTjqWGAgl+pe8Ey8qObUD3bA1FW6L4OV0RQUFBZf7wEXmEbZCmhoGexUWe1
         vqGo90g6NuBLhdELMAK7j4jJR+zxwV99pr89dXcyu4HlvnPz1vlrlo5QLfXwHJOu/Ul3
         HFtwa1G0otFI9ajtVfg3lzmDEGfF5/Z9hfFRnGzEEY5TnhT4VOK77y/dgT3uEu4qLgci
         MP8BoC96g5kY1ANNzizilQ7ZEPs9yqZMia3G8UnIgoULfJ/ZRNiOi3E/u7YFQdtsacnb
         qdTZ/Vz+lIvLVOMiumXkTYhHms/YQ+bM02LHLUBXZNuHr0zXrk/huyPwGNZ6HJXV/BZT
         Q+pA==
X-Gm-Message-State: AOAM531kNUaJH5mbiMpkFnT5J3UTh4n+Df38jkjw/z2QYprdPp25LhFw
        f6JqnpzoJAx/rBH9XKJDsWXfCJBYLmjmIeTn04m8OQ==
X-Google-Smtp-Source: ABdhPJzHWaFiLOpsPyJcfBHoAy1z8ekjl8TtNbzufPp+6KFlQhI2O5fF7FzpSSK4yxQDFIa9+tWQnAW+uWUSVEBh8JQ=
X-Received: by 2002:a05:6512:c15:: with SMTP id z21mr9760718lfu.193.1631550092955;
 Mon, 13 Sep 2021 09:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210902181751.252227-1-pgonda@google.com> <20210902181751.252227-2-pgonda@google.com>
 <YTqirwnu0rOcfDCq@google.com> <YTqxA23XRryWfCuA@google.com>
In-Reply-To: <YTqxA23XRryWfCuA@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 13 Sep 2021 10:21:21 -0600
Message-ID: <CAMkAt6q3as414YMZco6UyCycY+jKbaYS5BUdC+U+8iWmBft3+A@mail.gmail.com>
Subject: Re: [PATCH 1/3 V7] KVM, SEV: Add support for SEV intra host migration
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 7:12 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Sep 10, 2021, Sean Christopherson wrote:
> > Ooh, this brings up a potential shortcoming of requiring @dst to be SEV-enabled.
> > If every SEV{-ES} ASID is allocated, then there won't be an available ASID to
> > (temporarily) allocate for the intra-host migration.  But that temporary ASID
> > isn't actually necessary, i.e. there's no reason intra-host migration should fail
> > if all ASIDs are in-use.

Ack forcing dst to be SEV disabled will mitigate this problem.

>
> ...
>
> > So I think the only option is to take vcpu->mutex for all vCPUs in both @src and
> > @dst.  Adding that after acquiring kvm->lock in svm_sev_lock_for_migration()
> > should Just Work.  Unless userspace is misbehaving, the lock won't be contended
> > since all vCPUs need to be quiesced, though it's probably worth using the
> > mutex_lock_killable() variant just to be safe.
>
> Circling back to this after looking at the SEV-ES support, I think the vCPUs in
> the source VM need to be reset via kvm_vcpu_reset(vcpu, false).  I doubt there's
> a use case for actually doing anything with the vCPU, but leaving it runnable
> without purging state makes me nervous.
>
> Alternative #1 would be to mark vCPUs as dead in some way so as to prevent doing
> anything useful with the vCPU.
>
> Alternative #2 would be to "kill" the source VM by setting kvm->vm_bugged to
> prevent all ioctls().
>
> The downside to preventing future ioctls() is that this would need to be the
> very last step of migration.  Not sure if that's problematic?

I'll add calls to kvm_vcpu_reset. Alternative #2 using vm_bugged won't
work for us because we need to keep using the source VM even after the
state is transfered.
