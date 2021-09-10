Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F2406509
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbhIJBXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhIJBW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:22:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB740C0698D5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:12:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k23so312336pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uVOCS25mxvjBZ7GClAgZG2jOvpBEyDT5oWpJ4su1Yt0=;
        b=de/KxNe+EOHGeJ83TPp3H465bkg1HK9EVB2o1dpG4Iweuobaf5S23Z/tmwKRyGCUwF
         hsDQbLEk9Lq9p1hCSNh1uONQRtnygBLOdlRdb3wRNe07D0X8G6TzVoN01vqeF0IBebdH
         xPBCopRxx/tA3DCHTKIRULdAS+P+r1E9732rExTvVGNCKAL9eNwfeVZqTvzMuHxe9Ook
         KJX3WdXIg9rI0WJxmr6cm5KbuXMlvJhlcE8duAKulN3TxS7yC+f/UZO5PyfjXDQSS8ZC
         shv23XJR+zsX8LpcPWOxJ32MAXvtB16IWSGCIxm1H9yADYaumBKX9zkizDMQKjR9uAHz
         80sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVOCS25mxvjBZ7GClAgZG2jOvpBEyDT5oWpJ4su1Yt0=;
        b=G6WMRrdEYtvI6MXbiBpzanG7njsXTyr5rs885opopV74rXvHE3hUCAyLtXDbN8+6c+
         C46lwrr68m/dYgBebW07dsRxgwLCBRkih7ExIGd9JZy+avU7PDcCsZFJeB3WoGjr0/ko
         oTkb3Kaz7mtCU6XYTg2FpwNruq1iOt0nOVg798NwgkQ/k6PsHrQmDQs/k1HHlMSl1FTC
         gzh1hik2Y2UJs5Zx4vRDF4zOdyH8xw+RPBEOheO18gaANDvdwzX02b8AoVDGsqcz/NNb
         TXcZYvC0h1mG9wodG49T9UTJ/wdcGIV2Om7KmS0hHDwMHW4tl+ai/Q6IdEdSpLKGLa+9
         eswg==
X-Gm-Message-State: AOAM5338G8HY6j1pX1FvNonVlWjQXxxD86AqF/mH6VMsgchQB1RWjiul
        vwtL6Nn93aRpLZmLjTm/GYodoA==
X-Google-Smtp-Source: ABdhPJyc0QiINKvWbWZq746qOMozDTpBT10Tb6tAjhwfvQj5xHDA5QLN9YlMi2NrjpBfPN1M7S/75Q==
X-Received: by 2002:a17:902:c389:b0:13a:56c8:6696 with SMTP id g9-20020a170902c38900b0013a56c86696mr5260115plg.70.1631236360033;
        Thu, 09 Sep 2021 18:12:40 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t28sm3429475pfe.144.2021.09.09.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 18:12:39 -0700 (PDT)
Date:   Fri, 10 Sep 2021 01:12:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm@vger.kernel.org, Marc Orr <marcorr@google.com>,
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
Subject: Re: [PATCH 1/3 V7] KVM, SEV: Add support for SEV intra host migration
Message-ID: <YTqxA23XRryWfCuA@google.com>
References: <20210902181751.252227-1-pgonda@google.com>
 <20210902181751.252227-2-pgonda@google.com>
 <YTqirwnu0rOcfDCq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTqirwnu0rOcfDCq@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021, Sean Christopherson wrote:
> Ooh, this brings up a potential shortcoming of requiring @dst to be SEV-enabled.
> If every SEV{-ES} ASID is allocated, then there won't be an available ASID to
> (temporarily) allocate for the intra-host migration.  But that temporary ASID
> isn't actually necessary, i.e. there's no reason intra-host migration should fail
> if all ASIDs are in-use.

...

> So I think the only option is to take vcpu->mutex for all vCPUs in both @src and
> @dst.  Adding that after acquiring kvm->lock in svm_sev_lock_for_migration()
> should Just Work.  Unless userspace is misbehaving, the lock won't be contended
> since all vCPUs need to be quiesced, though it's probably worth using the
> mutex_lock_killable() variant just to be safe.

Circling back to this after looking at the SEV-ES support, I think the vCPUs in
the source VM need to be reset via kvm_vcpu_reset(vcpu, false).  I doubt there's
a use case for actually doing anything with the vCPU, but leaving it runnable
without purging state makes me nervous.

Alternative #1 would be to mark vCPUs as dead in some way so as to prevent doing
anything useful with the vCPU.

Alternative #2 would be to "kill" the source VM by setting kvm->vm_bugged to
prevent all ioctls().

The downside to preventing future ioctls() is that this would need to be the
very last step of migration.  Not sure if that's problematic?
