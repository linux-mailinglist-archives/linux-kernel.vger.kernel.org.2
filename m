Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A1B351E19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhDASeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbhDASOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:14:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19751C02FEAF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:23:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4959393pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tD+X9BuSKumVuODrS7ew+s56RfGVj55Vw8zUed5E1dQ=;
        b=b0yftv4xYST/PHsMhQ7VQUcEa/nNBbEpF+RJLTdGj1yGdsIIOhVvznJPXhAKOgcgrx
         HAGvwGO2hi88fQRtPCWLs1BpGDqSQ0qcLXjLzO8MlBG4jHriu3rrZlvA42wE8LNuX/Fr
         4xdWlPmu2lcnYh2YC1ciLz4MPciden90dX/kioMhjaC/j8B/Dk7gjgOAzVq6bFsrKOvA
         Rw45Ihhg7JDLF03Vng8Sk5QgEspPdJUA5DyyG67THT7pHBSQ46icHHGjcqhSzxPetv6O
         3aXmunw+MHJIZS4VOWhQtBE9wh/bHozCc3KsuxBOZuV+qaR12u7c0dntFbqU1PF18eKr
         WgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tD+X9BuSKumVuODrS7ew+s56RfGVj55Vw8zUed5E1dQ=;
        b=QNWIuK6CoWPBPQIhO7IpUdfwu9FOG05d6A6S2LarsOgcnF52I9sz4r33azEsdnQHkO
         iK2IuXfXprsfngI75unvRJhugHbxl8cZTTAlFZVOnZFarxlE5OWTbcGx0aLXT7936CKk
         Q57LVsB+mU6cbBT1vmHBpSvp/ziwEUk2Hz/hkqfV+aB0tsEtZqTEEYVqNchk/Bk4u6VL
         7KvGwHxSYaluYauzwdSXDHvE5aOl6R+id/O7aHe2JKk+VhY6fnwFBpw+fm1C/Z08MEna
         xF+O9AaTFh/tLfgkpSukchKnMJj2gey/3/s7b6WsnICnw+2M7Q/v2vk6IaPfrPA1lhzn
         5jCg==
X-Gm-Message-State: AOAM533y+82XKudLhdgEJ8BBlkGSwp8QUyYmawnAJ1/4lMZUgFFvJ4o4
        fRl7ycYLHNCsnAmj94nVoN+dGA==
X-Google-Smtp-Source: ABdhPJxA+80V8X8+S9LBr6ks6kcnWa3Io5Z5gpYddSyqtvTMFfjHXGTv/ayoHfoc+ROuWFYuNUqIUg==
X-Received: by 2002:a17:90a:4005:: with SMTP id u5mr9648330pjc.6.1617294183436;
        Thu, 01 Apr 2021 09:23:03 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x3sm5781480pfn.181.2021.04.01.09.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:23:02 -0700 (PDT)
Date:   Thu, 1 Apr 2021 16:22:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, pbonzini@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix potential memory access error
Message-ID: <YGXzY5h1eCQj6aU0@google.com>
References: <1617182122-112315-1-git-send-email-yang.lee@linux.alibaba.com>
 <YGS6XS87HYJdVPFQ@google.com>
 <87mtuis77m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtuis77m.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Mar 31, 2021, Yang Li wrote:
> >> Using __set_bit() to set a bit in an integer is not a good idea, since
> >> the function expects an unsigned long as argument, which can be 64bit wide.
> >> Coverity reports this problem as
> >> 
> >> High:Out-of-bounds access(INCOMPATIBLE_CAST)
> >> CWE119: Out-of-bounds access to a scalar
> >> Pointer "&vcpu->arch.regs_avail" points to an object whose effective
> >> type is "unsigned int" (32 bits, unsigned) but is dereferenced as a
> >> wider "unsigned long" (64 bits, unsigned). This may lead to memory
> >> corruption.
> >> 
> >> /home/heyuan.shy/git-repo/linux/arch/x86/kvm/kvm_cache_regs.h:
> >> kvm_register_is_available
> >> 
> >> Just use BIT instead.
> >
> > Meh, we're hosed either way.  Using BIT() will either result in undefined
> > behavior due to SHL shifting beyond the size of a u64, or setting random bits
> > if the truncated shift ends up being less than 63.
> >
> 
> A stupid question: why can't we just make 'regs_avail'/'regs_dirty'
> 'unsigned long' and drop a bunch of '(unsigned long *)' casts? 

It wouldn't break anything, but it would create a weird situation where x86-64
has more bits for tracking registers than i386.  Obviously not the end of the
world, but it's also not clearly an improvement across the board.

We could do something like:

  	DECLARE_BITMAP(regs_avail, NR_VCPU_TRACKED_REGS);
	DECLARE_BITMAP(regs_dirty, NR_VCPU_TRACKED_REGS);

but that would complicate the vendor code, e.g. vmx_register_cache_reset().

The casting crud is quite contained, and likely isn't going to expand anytime
soon.  So, at least for me, this is one of the few cases where I'm content to
let sleeping dogs lie. :-)
