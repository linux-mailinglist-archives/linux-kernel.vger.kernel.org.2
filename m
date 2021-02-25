Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E423255D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBYSvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhBYSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:50:35 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA30C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:49:38 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z13so6981614iox.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDdAgu20T1cQm9f7XwcZnf65l89+61sYtEQe0fvPTKs=;
        b=Hd3dRR+eD7zR/MrNqIqAcfi3W3+V0TV4Fb6Gcc8lRNxhnbE0dyjkl4MZIZjSlwxjxs
         1tJ0oao7ymBvmRCrLZzAE6OFwpd4eTCJPyqdmP0/XG4/MTV7WBhDKxaBS2Asd0tYc0eR
         92bXeKXOSx8dYHj3Ids/5zCEpEOs9yd9ilAHK1cYWMt7mrN6LUm3+HAMN7OherueZo48
         qdeiyiuxiTArbsyDN/L45ErZjYIXqe0DgsfNQDRmn71RezUEGKpf4xLlYw6/papcpgV3
         QOS9AtLmS8aldiVFbR7BMtykzT7dAR4aihMSzFs8lf+5N1O1qc4R3R/U8IdMqKKw2+Oc
         ifTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDdAgu20T1cQm9f7XwcZnf65l89+61sYtEQe0fvPTKs=;
        b=hUsMDsJ4t/42O6VIzgTccPKJu1GbG0/pDAK+q8eu8fPW44dYq2kJT2EIsExJiMFqYy
         8DOdunS6Bn0Nn08LTSCfi9Inol4vZj3ziTN4j5QGLSCaDLObCQ7urwtPyfcfEvOIxfNN
         /bgsX0wkoL0fkTuZuI4I7XLIX+8Qr/oLKIIcLqeHKy2faXr7BfPigc2rmNxl/Y2CURQg
         F4Gl8LFsD0jlUfQHe+OJpMm8SLx10V39yNuc/szN6jTvyyvMVDSsVFntU+iqZwDq0D+4
         WeOynwf77wyYBLuhs+NEzX6FESWmGh3ebVtPg25K0e+S9diYZzBilEeF+I5mG03tPyzw
         kYDw==
X-Gm-Message-State: AOAM531y7YvQ3dc/rSBZRP4u+lWmT65WTF+6F8rgPyxCl3+uqU8qZ69y
        YRuUv+kBIzJAUAaFNAgz+Lzs++gHRCQHZ6ezmNqKAw==
X-Google-Smtp-Source: ABdhPJzI9jDoNi62549qscbusuJj9vhua3Y81sm9xWmUH2C1QW5SpO1+ZNmDy7HJVKLIT5lNwOKTxDTUGgvqkZfAIcc=
X-Received: by 2002:a02:9f14:: with SMTP id z20mr4608517jal.47.1614278977487;
 Thu, 25 Feb 2021 10:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20210224085915.28751-1-natet@google.com> <CABayD+cZ1nRwuFWKHGh5a2sVXG5AEB_AyTGqZs_xVQLoWwmaSA@mail.gmail.com>
 <9eb0b655-48ca-94d0-0588-2a4f3e5b3651@amd.com>
In-Reply-To: <9eb0b655-48ca-94d0-0588-2a4f3e5b3651@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Thu, 25 Feb 2021 10:49:00 -0800
Message-ID: <CABayD+efSV0m95+a=WT+Lvq_zZhxw2Q3Xu4zErzuyuRxMNUHfw@mail.gmail.com>
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Nathan Tempelman <natet@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 6:57 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >> +int svm_vm_copy_asid_to(struct kvm *kvm, unsigned int mirror_kvm_fd)
> >> +{
> >> +       struct file *mirror_kvm_file;
> >> +       struct kvm *mirror_kvm;
> >> +       struct kvm_sev_info *mirror_kvm_sev;
> >> +       unsigned int asid;
> >> +       int ret;
> >> +
> >> +       if (!sev_guest(kvm))
> >> +               return -ENOTTY;
> >
> > You definitely don't want this: this is the function that turns the vm
> > into an SEV guest (marks SEV as active).
>
> The sev_guest() function does not set sev->active, it only checks it. The
> sev_guest_init() function is where sev->active is set.
Sorry, bad use of the english on my part: the "this" was referring to
svm_vm_copy_asid_to. Right now, you could only pass this sev_guest
check if you had already called sev_guest_init, which seems incorrect.
>
> >
> > (Not an issue with this patch, but a broader issue) I believe
> > sev_guest lacks the necessary acquire/release barriers on sev->active,
>
> The svm_mem_enc_op() takes the kvm lock and that is the only way into the
> sev_guest_init() function where sev->active is set.
There are a few places that check sev->active which don't have the kvm
lock, which is not problematic if we add in a few compiler barriers
(ala irqchip_split et al).
>
> Thanks,
> Tom

Thanks,
Steve
