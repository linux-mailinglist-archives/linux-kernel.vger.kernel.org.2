Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E414451C49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349897AbhKPAPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbhKOWdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:33:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FD4C06120E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:46:17 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso988426pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9SsJHXkREEXgOvz8+1WYncw9ZbiSu97hwoPleOY3LI=;
        b=q2Wf+AjvT/KSaRA+UU6FG8okOT5ec7/SfBZH7apyXaG9tStScRgGqPJvgoTKymD22r
         lNEVy+x7YVbskeQiMXR3iWJApCV67N9E9fVQs5HMG6gnop6IuOX3Lnw6563AjoWb8VBC
         m8ec41OXCC3BPN99aYKLyxM/coup9SVu+de+bdpUTFnaW201cAdu/n3muPtyGF6XObUb
         bDQOFSkcAW6curnjSTVtvnFXpFcItxXd/2HJMWRoR76adZl3m4nIkcy30fbIg+mOryvG
         eG6+GB5c51zuia2z1MYBsYfyloBoarHHe3OWYe2DU+wQQ5CmKsTqx2i5iWcDnoaq1Uzd
         X23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9SsJHXkREEXgOvz8+1WYncw9ZbiSu97hwoPleOY3LI=;
        b=Xk/iRQlf+P3Laj8yAiAKB5YbJnrT1SbokXi6pOA9NXCbSk0NG8N4Sk84rEu6+/FMLf
         gAD0MH79uY0TkuDslA4Cj/gah3i6SJGSG6VU/ssqwielkKUFFxsqAi1VKpH1jXm2XERF
         f9C1Tq0nAQ+l+Ca9P5JHyrRaOMfqhI22eedCJG/+kTLD7hkQSNyVOdmTSxLM15RQnI8w
         19FTtXEwVjnd4dgiPX8LmKXzYDc54IIViKfXoysEvluGuzFykKm7dlgAVEAa56gYwBeo
         anEIoTYmy16a7umrYRm9audBBR2t9Xvhl4/cuw13Fg8HIynqrmzNX9yRtnBBXCx7Rv6Q
         fHLw==
X-Gm-Message-State: AOAM530CjYvQ8k5dHpc1cRSoziYOSJAAxQF3MgMdhgRyJLV4JSbHeWQ3
        f9qIwMh/4tfxpGDP4Qiy3L1ZOg==
X-Google-Smtp-Source: ABdhPJylWOwwcpIIvbGQpSaxkQQ9vmcbK3N5vu+frs7m91JCCuk6OpVHXSl/+5abhc6avfDGWqj50w==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr67827969pjb.157.1637012776970;
        Mon, 15 Nov 2021 13:46:16 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t13sm15713136pfl.214.2021.11.15.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:46:16 -0800 (PST)
Date:   Mon, 15 Nov 2021 21:46:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Update number of zapped pages even if page
 list is stable
Message-ID: <YZLVJX1XLF6Rx/2K@google.com>
References: <20211111221448.2683827-1-seanjc@google.com>
 <CALzav=dpzzKgaNRLrSBy71WBvybWmRJ39eDv4hPXsbU_DSS-fA@mail.gmail.com>
 <YZKzr4mn1jJ3vdqK@google.com>
 <CALzav=fKycSowAyaymt9a9hpffbWnFeXvACC5pE5-rMpx+4H4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=fKycSowAyaymt9a9hpffbWnFeXvACC5pE5-rMpx+4H4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021, David Matlack wrote:
> On Mon, Nov 15, 2021 at 11:23 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Nov 15, 2021, David Matlack wrote:
> > > On Thu, Nov 11, 2021 at 2:14 PM Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > When zapping obsolete pages, update the running count of zapped pages
> > > > regardless of whether or not the list has become unstable due to zapping
> > > > a shadow page with its own child shadow pages.  If the VM is backed by
> > > > mostly 4kb pages, KVM can zap an absurd number of SPTEs without bumping
> > > > the batch count and thus without yielding.  In the worst case scenario,
> > > > this can cause an RCU stall.
> > > >
> > > >   rcu: INFO: rcu_sched self-detected stall on CPU
> > > >   rcu:     52-....: (20999 ticks this GP) idle=7be/1/0x4000000000000000
> > > >                                           softirq=15759/15759 fqs=5058
> > > >    (t=21016 jiffies g=66453 q=238577)
> > > >   NMI backtrace for cpu 52
> > > >   Call Trace:
> > > >    ...
> > > >    mark_page_accessed+0x266/0x2f0
> > > >    kvm_set_pfn_accessed+0x31/0x40
> > > >    handle_removed_tdp_mmu_page+0x259/0x2e0
> > > >    __handle_changed_spte+0x223/0x2c0
> > > >    handle_removed_tdp_mmu_page+0x1c1/0x2e0
> > > >    __handle_changed_spte+0x223/0x2c0
> > > >    handle_removed_tdp_mmu_page+0x1c1/0x2e0
> > > >    __handle_changed_spte+0x223/0x2c0
> > > >    zap_gfn_range+0x141/0x3b0
> > > >    kvm_tdp_mmu_zap_invalidated_roots+0xc8/0x130
> > >
> > > This is a useful patch but I don't see the connection with this stall.
> > > The stall is detected in kvm_tdp_mmu_zap_invalidated_roots, which runs
> > > after kvm_zap_obsolete_pages. How would rescheduling during
> > > kvm_zap_obsolete_pages help?
> >
> > Ah shoot, I copy+pasted the wrong splat.  The correct, revelant backtrace is:
> 
> Ok that makes more sense :). Also that was a soft lockup rather than
> an RCU stall.

*sigh*  I'm not sure which blatant "this is the wrong splat" goof is worse, the
explicit tdp_mmu in the backtrace, or the fact that the legacy MMU doesn't rely
on RCU...

I'll get v2 posted.
