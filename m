Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639ED453689
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhKPQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhKPQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:00:55 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B03C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:57:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 8so6667861pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mctdfT/mLWAUfvZZLvhHazXaY3Gm15pDMZVIQeirzJs=;
        b=jRvz3gtPvFWZ5WeAmF5DynWdAlHppEXPCykwNGOhANQ4d2QvZpMm0FziEYiDqg9PJ5
         XKk+6nC+XqK71O57sDxaPsuYZq/bKwyCwlVUXYP9A5W1CNFUu4XltPI/vjLdIFys1iOW
         9O7zeIAHG3s7iwvKEB3ycWW4fdccXZ/yVD9TC69Hjcl/ivd6BKPO3jyq0r39p+4HcbVL
         zUfj1U3RoNgvaft+JGK/PJVP9S4wkTDCvI5/7d+sYuhSe5r7wMxyCFB2JrXgVJJF5iae
         EEYQ69hdQVMtIKs5EX29ZgiI+RiXaj+KJFwoFKzi7kqz08jzgzcdHLGpXNjqe7VOfoPr
         2Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mctdfT/mLWAUfvZZLvhHazXaY3Gm15pDMZVIQeirzJs=;
        b=aypI/+bigz0DIPU0AqlRODj9mWSjvJNV3FdYETBkTC2Tr9gH2P+p7+f0QeVmX48Tb1
         808na8IEC4t3l39CciQYxTIqwvJONmdund0jh4mqujidRuR1vv96s+NLK7rPckMut9re
         Vh/SY2uiWHTxPJ03CQ/2PPdx+kIA7cgPSk6n1C8lZeXBuh13vj2R5IRrLdl61+bmP9Tb
         G0vn1c40De02bfq3mP45FFtWamB4EupSh85UQcLzzekNNIJfBj2WN1blOjo2lvGjGAUS
         LQLYTk4tpzXriUCu9gdsj3GWNBNPSZzExgT1aukzJJ7DcEOzCOKHl51dEr4QfPfQKA0t
         5zNA==
X-Gm-Message-State: AOAM533yrMuVEW8k2Fgjxib38H+k1cJpnSB297EAk84Qu+5+m4jsxer4
        tJcZzzTpQ24mXhhiBLDgDCzEcg==
X-Google-Smtp-Source: ABdhPJy3mhqLa0tkkmoYF+8en/twKJl1RoDR89VUSxeBiCMGX+MXuH8mKcqVvkbnWIizd4zB4uhPAw==
X-Received: by 2002:aa7:9d1e:0:b0:494:6dec:6425 with SMTP id k30-20020aa79d1e000000b004946dec6425mr104681pfp.83.1637078276989;
        Tue, 16 Nov 2021 07:57:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p19sm21785939pfo.92.2021.11.16.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:57:55 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:57:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     =?utf-8?B?6buE56eR5LmQ?= <huangkele@bytedance.com>
Cc:     Chao Gao <chao.gao@intel.com>,
        zhenwei pi <pizhenwei@bytedance.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, chaiwen.cc@bytedance.com,
        xieyongji@bytedance.com, dengliang.1214@bytedance.com,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: Re: [RFC] KVM: x86: SVM: don't expose PV_SEND_IPI
 feature with AVIC
Message-ID: <YZPVAHMp+aIaEkXT@google.com>
References: <20211108095931.618865-1-huangkele@bytedance.com>
 <a991bbb4-b507-a2f6-ec0f-fce23d4379ce@redhat.com>
 <f93612f54a5cde53fd9342f703ccbaf3c9edbc9c.camel@redhat.com>
 <CANRm+Cze_b0PJzOGB4-tPdrz-iHcJj-o7QL1t1Pf1083nJDQKQ@mail.gmail.com>
 <d65fbd73-7612-8348-2fd8-8da0f5e2a3c0@bytedance.com>
 <20211116090604.GA12758@gao-cwp>
 <CAKUug92xp7mU_KB66jGtdYRhgQpgfCm67r+3kMOMdbrGOrTQcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKUug92xp7mU_KB66jGtdYRhgQpgfCm67r+3kMOMdbrGOrTQcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021, 黄科乐 wrote:
> > The recently posted Intel IPI virtualization will accelerate unicast
> > ipi but not broadcast ipis, AMD AVIC accelerates unicast ipi well but
> > accelerates broadcast ipis worse than pv ipis. Could we just handle
> > unicast ipi here?
> 
> Thanks for the explanation! It is true that AVIC does not always perform
> better
> than PV IPI, actually not even swx2apic.
> 
> > So agree with Wanpeng's point, is it possible to separate single IPI and
> > broadcast IPI on a hardware acceleration platform?
> 
> 
> > how about just correcting the logic for xapic:
> 
> > From 13447b221252b64cd85ed1329f7d917afa54efc8 Mon Sep 17 00:00:00 2001
> > From: Jiaqing Zhao <jiaqing.zhao@intel.com>
> > Date: Fri, 9 Apr 2021 13:53:39 +0800
> > Subject: [PATCH 1/2] x86/apic/flat: Add specific send IPI logic
> 
> > Currently, apic_flat.send_IPI() uses default_send_IPI_single(), which
> > is a wrapper of apic->send_IPI_mask(). Since commit aaffcfd1e82d
> > ("KVM: X86: Implement PV IPIs in linux guest"), KVM PV IPI driver will
> > override apic->send_IPI_mask(), and may cause unwated side effects.
> 
> > This patch removes such side effects by creating a specific send_IPI
> > method.
> 
> > Signed-off-by: Jiaqing Zhao <jiaqing.zhao@intel.com>
> 
> Actually, I think this issue is more about how to sort out the relationship
> between AVIC and PV IPI. As far as I understand, currently, no matter
> the option from userspace or the determination made in kernel works
> in some way, but not in the migration scenario. For instance, migration with
> AVIC feature changes can make guests lose the PV IPI feature needlessly.
> Besides, the current patch is not consistent with
> KVM_CAP_ENFORCE_PV_FEATURE_CPUID.
> Paolo's advice about using a new hint shall work well. Currently try
> working on it.

IIUC, you want to have the guest switch between AVIC and PV IPI when the guest
is migrated?  That doesn't require a new hint, it would be just as easy for the
host to manipulate CPUID.KVM_FEATURE_PV_SEND_IPI as it would a new CPUID hint.

The real trick will be getting the guest to be aware of the CPUID and reconfigure
it's APIC setup on the fly.

Or did I misundersetand what you meant by "migration with AVIC feature changes"?
