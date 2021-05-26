Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9939110C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhEZG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhEZG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:57:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD326C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:55:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ot16so284167pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjiFmCiLoMXys/jJOXLgjINLJSxKbFwfyeipr8yG200=;
        b=UILHNq0ZQ44Op1yN22PE+fr0aPxKsRcqBKe2vgj/ZYCZ5zgqK8ESD6c0o2OctpBqAO
         F4gAYpcVJYglNj74YRntIWOHnu/4MftKwOz/Wv1XjE09wrxeTqPZvM1gXTb8/Gac51M9
         Eez1H76ppX48hU+F3TNmSSSy1KabYUGNcA97NTM445m8zOv6Mag/4vBmqaeqUm3scvXk
         T1k3kW60T8B2TqEuavy1/nAP17gACa3ZkHtkIyetscuvYT+QmJ4is+ecgGBneayKgBn8
         0jnWZX9XPv+8aVYjiFtP4kZ7aVFyX5gdsQHRHMlJMX7+KMSd13kfi7dkTx7O/gDIr3Bx
         MrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjiFmCiLoMXys/jJOXLgjINLJSxKbFwfyeipr8yG200=;
        b=j5KkckSp2P6mHGyloQsoxj3ZA/qpqGYnUvHe/m2qOrP0wswx/TcoIpqOaLu3XhEpyi
         7vL9ws8JWlGRQrieY68vFYUeS3MxWbfofPe21muir5nzh9bcksZ6Op1e/xhymT+f3jkP
         mv8HvAo5v0zFpvyRQDYeAWoUe3FkgF8GLZjULd5SRT4/SkokyaOTF0aKfatkt1QGk0ao
         O9uVCFA+W0/qGXRlmWQi8zWng25LGGuYfvQStSC1HapTaJFiRmRNsMBY22CWw7Mf6d5u
         3uyt4Xv4W69iC4irkUzvo7lPtPicTZlDIg6kj2tlml8NA4gZvwhYvIUi0t6y1AvlCdty
         J0Ew==
X-Gm-Message-State: AOAM5326T8GAg/Rd83e9bghsll2zL7qvwwQYqcmTyxns3toZFOYkKSDL
        eK8vvThIG59+VzukiNn9Y7oGif1XxIX/rwUBsIhupA==
X-Google-Smtp-Source: ABdhPJwRRVEHDVTMqfFTUnYVfd0PVGRjf+M4h6VX2CYE8bx4GDAuDS39o3O9kkzOO/8gmF6Auu/QL9KeqY9zad/UMz4=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr33983187pjb.168.1622012134164;
 Tue, 25 May 2021 23:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-15-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-15-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 25 May 2021 23:55:18 -0700
Message-ID: <CAAeT=FzQBOy=ysxXM24_w0O+p5vrAOWCTMxxv__aF2TG=U_AHA@mail.gmail.com>
Subject: Re: [PATCH 14/43] KVM: x86: Don't force set BSP bit when local APIC
 is managed by userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Don't set the BSP bit in vcpu->arch.apic_base when the local APIC is
> managed by userspace.  Forcing all vCPUs to be BSPs is non-sensical, and
> was dead code when it was added by commit 97222cc83163 ("KVM: Emulate
> local APIC in kernel").  At the time, kvm_lapic_set_base() was invoked
> if and only if the local APIC was in-kernel (and it couldn't be called
> before the vCPU created its APIC).
>
> kvm_lapic_set_base() eventually gained generic usage, but the latent bug
> escaped notice because the only true consumer would be the guest itself
> in the form of an explicit RDMSRs on APs.  Out of Linux, SeaBIOS, and
> EDK2/OVMF, only OVMF consume the BSP bit from the APIC_BASE MSR.  For
> the vast majority of usage in OVMF, BSP confusion would be benign.
> OVMF's BSP election upon SMI rendezvous might be broken, but practically
> no one runs KVM with an out-of-kernel local APIC, let alone does so while
> utilizing SMIs with OVMF.
>
> Fixes: 97222cc83163 ("KVM: Emulate local APIC in kernel")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
