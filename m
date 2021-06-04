Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01E39BC06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhFDPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:38:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B741CC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 08:37:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso6125368pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LS+pVGO6lepWheguoL9jNQS5bAjZn1OmNQofMIhLGLs=;
        b=dMutLh5fistVaDLzLU1mFkRhUBWIPLb//w/PNNl7WxFCXB2Vdbm14D0/ITQsvyYl1k
         VKQzxaWLpzLVkUxn+Eo6i1Cd1fo6dhonC9q98hriiNob6Yy9RnjZ5/iZvTYTgR13zBJW
         IUX1vA8zJAAQrpTbfTbDpHqSRqxtvTwponEL3WNiQMbQYQDR8VKnRLEFpEQZ6dHeN2X3
         plkqygYxnu8mii23D9UJzCzeqf5qZVKhDeH2GmBiSvhQMiFZGAr53a2bJixttQr5oW4w
         p2vT/2x3gVdw6GfVFR1YvOjz/xUyT7p1N31cjrjBMoKiglMySuSZKHse90tVPJ3ELqFR
         GLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LS+pVGO6lepWheguoL9jNQS5bAjZn1OmNQofMIhLGLs=;
        b=SxFRetiAg8FyNCdVWI5+dSW06BgE9u7zxzdU64zFBPArdBqWR0h9Zs+2O7izYo3j50
         qAtuyP35oA2Un634sBKR/G+WuFfgQsqJx3pe8ys1Je6aQ5KEUb2qPNHMai3FlE3RNnVe
         Dzel+JyDauIDuZPQgb2kdYaVNixMx8/B88u1El2r/Mn1nYYZCQ4IpqvufgYj633F5ILV
         jGiXaE1pEMITLewnOb4zxlTvUAzvpiVK3/r9Cz4iz5Ml740Lw9ECdoAQWc5kBFbDHG6z
         MaiWLhpmLPo3z7Fjxoowlh7RssltK0XfOS9vC3WyuJmrj+wah4lxx5d1Z51c+q57RhMz
         m4mw==
X-Gm-Message-State: AOAM53115VrVSVSz/3Pm8KyZ3quQhcaGmIh2JX7LeHiY4KwASfW6VJ9B
        s1mcDWnx09HA7LX1YZJxlj5621rxnlSm6Q==
X-Google-Smtp-Source: ABdhPJzXCnn/exCbTxMz3psca2pXzg5HIQbkYkMNVsSI2w7AR3aChmi4WGl7T+1P8T3i7qGXXFuAug==
X-Received: by 2002:a17:90a:5507:: with SMTP id b7mr17218278pji.27.1622821027043;
        Fri, 04 Jun 2021 08:37:07 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id m5sm2406492pgl.75.2021.06.04.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:37:06 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:37:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] KVM: LAPIC: write 0 to TMICT should also cancel
 vmx-preemption timer
Message-ID: <YLpIni1VKYYfUE8D@google.com>
References: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
 <YLjzJ59HPqGfhhvm@google.com>
 <CANRm+CxSAD9+050j-1e1_f3g1QEwrSaee6=2cB6qseBXfDkgPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CxSAD9+050j-1e1_f3g1QEwrSaee6=2cB6qseBXfDkgPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021, Wanpeng Li wrote:
> On Thu, 3 Jun 2021 at 23:20, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Jun 03, 2021, Wanpeng Li wrote:
> > > From: Wanpeng Li <wanpengli@tencent.com>
> > >
> > > According to the SDM 10.5.4.1:
> > >
> > >   A write of 0 to the initial-count register effectively stops the local
> > >   APIC timer, in both one-shot and periodic mode.
> > >
> > > The lapic timer oneshot/periodic mode which is emulated by vmx-preemption
> > > timer doesn't stop since vmx->hv_deadline_tsc is still set.
> >
> > But the VMX preemption timer is only used for deadline, never for oneshot or
> > periodic.  Am I missing something?
> 
> Yes, it is upstream.

Huh.  I always thought 'tscdeadline' alluded to the timer being in deadline mode
and never looked closely at the arming code.  Thanks!

Maybe name the new helper cancel_apic_timer() to align with start_apic_timer()
and restart_apic_timer()?  With that:

Reviewed-by: Sean Christopherson <seanjc@google.com>
