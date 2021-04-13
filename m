Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40D335E4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347159AbhDMR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhDMR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:26:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:25:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f29so12433043pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5vr3PwJeGNJ+ARdvZPnoqmm3/dVq98uqA1dFm+w77rA=;
        b=B7qaXV9ZpUN50AEatDo+ijkDYDeSfHKMdIVqdGTVHitzoOJT0zvMuxU0B0u4QWCCAP
         CLuhYic90AuWUMGifY2q4J/m7AQK/VOUK0iZCrLvVxXh8/46dOYWPDzBMMSbBxTmT7K0
         FK2MbSTKqRvsXRCvu4Bgwmn5TqPkPFTYeXDk0D5Nleqk9FP+XL4BHB43oCPN6xWdgrPK
         vl7s2pml4EQajThYGfZyiWPUnlLAdYrcKoJfrQrKaSIzKf7L1JkqXk3zCP1S2L3bzjJN
         g2RV2sXQNFhhjWlsvct+CwERTwCLjBWpimrjQQFn4zAgOlncRNGg2oKBIO9O/4u40b0a
         NxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5vr3PwJeGNJ+ARdvZPnoqmm3/dVq98uqA1dFm+w77rA=;
        b=pqSglIPsFgd59DXvq/U1NmuyjnC4FEN0covczEf/Erz2l4CdzUD2p32uEU//m4ilUW
         f3awc7E1A8P/EY8ArG0PrYGYg8rgMfM16FHV9gi4AfFIOayysjG8sm6wtPMkHnUdjc5p
         G2RLrrs1A9GKsYJaOGhtqkZjkatYMSjXceH6+fVj8NA+PZJp+/Gi6IDn+FK5wsTw+QVH
         kFYbL/tz6vcwZei4rwzTd4as+VtN4uhout+VDyYaM4FQ5sODPiEYwZOspOa3P3//YTnw
         tzf05M+7Kdux1JR6hIu6cTL05cQZ3g9ran/+3Nk/Dn7hp1/yqzerwtM0R6FcumsNBBK9
         7jGQ==
X-Gm-Message-State: AOAM531+KUqtlqtMf7oH+5O3RkSqsMlLDkZStgjF5x+qR2wlhqgt8okv
        b1C6TXjmL1sr/Z8hdRIUjP4Qlg==
X-Google-Smtp-Source: ABdhPJzOEwhO/ZQZjBRucPtwUXd+BgP4ag+EUzaOeZrRo+QYusDeHN+kT7aq911ZWked1Moq/CiKuw==
X-Received: by 2002:a62:4e96:0:b029:248:effc:9a4d with SMTP id c144-20020a624e960000b0290248effc9a4dmr1498365pfb.71.1618334744252;
        Tue, 13 Apr 2021 10:25:44 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id b7sm15201183pgs.62.2021.04.13.10.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:25:43 -0700 (PDT)
Date:   Tue, 13 Apr 2021 17:25:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 0/3] KVM: Properly account for guest CPU time
Message-ID: <YHXUFJuLXY8VZw3B@google.com>
References: <1618298169-3831-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618298169-3831-1-git-send-email-wanpengli@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021, Wanpeng Li wrote:
> The bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=209831
> reported that the guest time remains 0 when running a while true
> loop in the guest.
> 
> The commit 87fa7f3e98a131 ("x86/kvm: Move context tracking where it
> belongs") moves guest_exit_irqoff() close to vmexit breaks the
> tick-based time accouting when the ticks that happen after IRQs are
> disabled are incorrectly accounted to the host/system time. This is
> because we exit the guest state too early.
> 
> This patchset splits both context tracking logic and the time accounting 
> logic from guest_enter/exit_irqoff(), keep context tracking around the 
> actual vmentry/exit code, have the virt time specific helpers which 
> can be placed at the proper spots in kvm. In addition, it will not 
> break the world outside of x86.

IMO, this is going in the wrong direction.  Rather than separate context tracking,
vtime accounting, and KVM logic, this further intertwines the three.  E.g. the
context tracking code has even more vtime accounting NATIVE vs. GEN vs. TICK
logic baked into it.

Rather than smush everything into context_tracking.h, I think we can cleanly
split the context tracking and vtime accounting code into separate pieces, which
will in turn allow moving the wrapping logic to linux/kvm_host.h.  Once that is
done, splitting the context tracking and time accounting logic for KVM x86
becomes a KVM detail as opposed to requiring dedicated logic in the context
tracking code.

I have untested code that compiles on x86, I'll send an RFC shortly.

> v1 -> v2:
>  * split context_tracking from guest_enter/exit_irqoff
>  * provide separate vtime accounting functions for consistent
>  * place the virt time specific helpers at the proper splot 
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Michael Tokarev <mjt@tls.msk.ru>
> 
> Wanpeng Li (3):
>   context_tracking: Split guest_enter/exit_irqoff
>   context_tracking: Provide separate vtime accounting functions
>   x86/kvm: Fix vtime accounting
> 
>  arch/x86/kvm/svm/svm.c           |  6 ++-
>  arch/x86/kvm/vmx/vmx.c           |  6 ++-
>  arch/x86/kvm/x86.c               |  1 +
>  include/linux/context_tracking.h | 84 +++++++++++++++++++++++++++++++---------
>  4 files changed, 74 insertions(+), 23 deletions(-)
> 
> -- 
> 2.7.4
> 
