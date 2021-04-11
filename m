Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873B35B602
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbhDKQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhDKQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 12:04:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 09:03:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f8so12102282edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfZgknz44RIyZV3OVgESHFCGGox2VIjLnfpUwRDEyZo=;
        b=lENuuVkia+zCtsiN5M4UDbuZ7xT82SJhX8Gzr8ikzg3mbjOzmi33Dj+a+Ior9aydzb
         z+UDibHBQvtY9zxknDNFvzsvddutYbaMnObHNHCiC2UVepDSx6OqxBj5V91PMSW5L5Vo
         ug/CuU97cmc+LmQuXnrNThLNSlcAhcuL0ZYHp9gFoCAxKnHlO2hqIfqPp/AhEuyNfM7+
         Qc5hugNZxs2Dna5KhRat5jmFG9cM7f/U7G0OlYYsx5OgCm702dtkPe/DMINLACPrL5SN
         EVJ/V4kmnOJ1uK2ZZ6dhupoKZL0uvA1Rjn5wxkumeBHI5g1TS/a/x5CUUCfnMNQ5azis
         EDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfZgknz44RIyZV3OVgESHFCGGox2VIjLnfpUwRDEyZo=;
        b=RE03Y6DuIl5SEV8O3brMwGiVaDUhH38aH0ZXdTe20+ok12zG6kzm5E7nAoRufBxZNH
         tGpJyQYEbXe0D+sTzp5pA+Nt+NoA4cXOXG+vCcSfpnwXTil+RpoMrriHnyvqEmR2wqpi
         dYRBZQDhKc4AnOHHlRrl+RVCCVtZJ838VXt5Uqou1eywgrOvtN53ngpBP+aYrFTYtkPI
         ValBij+niXEYOsQ1xaF6BQaxI2u/ViLHKm0ocljpJJEVDBZHp0i90YoxSD2dwbgdfX1r
         yQGA70UAcgu6cq4bB+UeoaM0P2z3ifL8x0OCfrTIbhTkVTY3BBcrue0HrAR/EqK6Vxod
         TnIg==
X-Gm-Message-State: AOAM533fxQPCOgxbVbvgXypKuCkKsQVBGcVOr8/xFjd7+Tv652mCe2kd
        6C59bB6YqgdnWAOZFeDNgM1emnxJS3ZOKatu+xGmNw==
X-Google-Smtp-Source: ABdhPJxGU5PHqWYzSWtsm+8wSY6EVho5MZGQGfCoW6t53C/1lV6GRoE6mvIo90ozLfVFGdEeSuvt6KO94toLP3j4kIY=
X-Received: by 2002:a05:6402:27ce:: with SMTP id c14mr25798056ede.263.1618157025138;
 Sun, 11 Apr 2021 09:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de> <20210410094752.GB21691@zn.tnic>
 <20210410121144.GC21691@zn.tnic> <87r1jiug4e.fsf@linux.intel.com>
In-Reply-To: <87r1jiug4e.fsf@linux.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sun, 11 Apr 2021 09:03:34 -0700
Message-ID: <CALCETrXD6aKet8gpQUmcH0Z2AtHoGY-7MDK8WmCtH3_K=EYjtg@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:52 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> Borislav Petkov <bp@alien8.de> writes:
>
> > From: Borislav Petkov <bp@suse.de>
> > Date: Sat, 10 Apr 2021 14:08:13 +0200
> >
> > There are a bunch of MSRs which luserspace has no business poking at,
> > whatsoever. Add a ban list and put the TSC-related MSRs in there. Issue
> > a big juicy splat to catch offenders.
>
> Have you ever seen any user programs actually write those MSRs?
> I don't see why they ever would, it's not that they have any motivation
> to do it (unlike SMM), and I don't know of any examples.

I have actually seen real user programs poke MSR_SYSCALL_MASK.
