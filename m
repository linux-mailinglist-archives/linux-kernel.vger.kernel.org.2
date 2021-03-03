Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2132C068
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578575AbhCCSRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhCCQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:14:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC5C061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:12:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o38so16697870pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EisZFm35+8e+0b6JeFIJMc+sANT14O3XGJM3zZNvXm8=;
        b=jUmj2smBpZsXvifuyxVYJboGtMm1xO2UtgvXTmvnCmSSKvTwo/EKkkHVjYDsSG6ttR
         NzlRAump7IiQ6FYc1uPeNRURlWsnma/Xg15D0NSgIuDzjHfaqdRcA7ZhMZdnKtCdyvAX
         QDKQYeAgHNgKaKL1Y4UWKdHMtlROaTD3glYqydOoOGsX3MB7yyK8jXVB4lW5+VrEMFeR
         D2IvoOIc1oPdV9bj/xnY/9ICgMInrLUdaDk+GhYPVdTkhHDuZ+KsSqSG3eE3mIEhfcu3
         UxvKXFdc/BYrv1YwUD17vRDrA9km95C8AdHW/TnFaHIAt/FNXIdfHCXPZo1GlHSETye9
         pA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EisZFm35+8e+0b6JeFIJMc+sANT14O3XGJM3zZNvXm8=;
        b=R9HgAh0iPhv823hwya/N4LCBSNOrhQNAI5h5QT9m/MKasscPHiBozy9JNPmmtyuPni
         u7UGBVvYs9XDLahnEakUCVyExC6VyVbvNGjXzQHrPUzsyZqPHqpQT63xkN/K5LJ9AOi5
         q5TbNPXKIoe2nfGa2zGfF3Dn9SmsDCHOub/ynW+oPx9XiBKfrE2u4EGbr82oXSOBmfYf
         KgePbDbcUrWGEZicllPDRzjzxWIoMKzAbXP2nNwxU+zcEKX/VtEojJrDEPXavFIMCbC7
         LifCnzfIjmfw0MFdIrHlXGoXcKOWzO5pBRzs9TOwKE7tqgafdgrAQskaJfN4lGUduRAt
         03sw==
X-Gm-Message-State: AOAM532ZRmaai4E/8S+ZFCgT56aqU0IfDZyhCa/jZrVG7hS6uKVcKbf9
        oR7ifYAoflLziHdTx0QxrIDggQ==
X-Google-Smtp-Source: ABdhPJz3833pVMK+aWptujeWmaFB/J5T3c+Qp17/0zz4d5NXW9fnQr2lxBo8ueyvHWT7NpjxP0CsHQ==
X-Received: by 2002:a05:6a00:16cd:b029:1c9:6f5b:3d8c with SMTP id l13-20020a056a0016cdb02901c96f5b3d8cmr8820239pfc.1.1614787970619;
        Wed, 03 Mar 2021 08:12:50 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id n184sm15584962pfd.205.2021.03.03.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 08:12:49 -0800 (PST)
Date:   Wed, 3 Mar 2021 08:12:43 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: LAPIC: Advancing the timer expiration on guest
 initiated write
Message-ID: <YD+1e1iLyKKWL8FX@google.com>
References: <1614678202-10808-1-git-send-email-wanpengli@tencent.com>
 <YD5y+W2nqnZt5bRZ@google.com>
 <CANRm+Cy_rNAai+u5pyBXKmQP_Qp=3e_hwi2g9bAFMiocCpru1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cy_rNAai+u5pyBXKmQP_Qp=3e_hwi2g9bAFMiocCpru1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Wanpeng Li wrote:
> > Side topic, I think there's a theoretical bug where KVM could inject a spurious
> > timer interrupt.  If KVM is using hrtimer, the hrtimer expires early due to an
> > overzealous timer_advance_ns, and the guest writes MSR_TSCDEADLINE after the
> > hrtimer expires but before the vCPU is kicked, then KVM will inject a spurious
> > timer IRQ since the premature expiration should have been canceled by the guest's
> > WRMSR.
> >
> > It could also cause KVM to soft hang the guest if the new lapic_timer.tscdeadline
> > is written before apic_timer_expired() captures it in expired_tscdeadline.  In
> > that case, KVM will wait for the new deadline, which could be far in the future.
> 
> The hrtimer_cancel() before setting new lapic_timer.tscdeadline in
> kvm_set_lapic_tscdeadline_msr() will wait for the hrtimer callback
> function to finish. Could it solve this issue?

Aha!  Yep, that prevents my theoretical bug.  Thanks!
