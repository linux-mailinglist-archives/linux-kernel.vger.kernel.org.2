Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5B3E48E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhHIPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhHIPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:31:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA92C061798
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:30:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l11so5110895plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0AECcEi2rpt5gm0PQCPyfbI2DBqYy38YFfxxfkJxtfU=;
        b=nvgDcF9oG4oweN91pNjyW0PwF3Wwq1kdB8edecupp/0AAlGgeVxfi6VaUQYhaBKIEQ
         KfxX7PsGRvTGaymoz7UKsMn7m6U3/pvHIAtH9dSiNosjr6WZeZAhce0vGW8uDjdRtKax
         a6u7Ig4lBKVRJw5VhquaWiKNLQ3TVn7Q6byy7hy4H8juTQJEau+Z6YqtOXl1dN4R4Mij
         bqpUPJNiavaIwG/MtPnpZ81XQ1+n8tDBylpVsX3eAbu8sPwPVk7UfHhNHRcSvnMto/9O
         q9iNpgDuNR3OjvkApqeNWTi1MltBiczdHnuiMlcCoaP/YwLWHkMDcMXHnNt53lnK9vCY
         cFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0AECcEi2rpt5gm0PQCPyfbI2DBqYy38YFfxxfkJxtfU=;
        b=Ov9Yt/XvaMkkrpS+pLReBd/K2Txoc9fjHKIo+yS+XSwqKfIOdelI/y48X+eUF1hjII
         zkYqY3Bju4dvkxhfPgS+nUrIc8eEFzhtpdKEOXcWuv+QdAt/pyRE6dfn/FTyD19t1Eyu
         vts9hnWRI32OzcYuvaOa86PvC2KF+ZiuQ7H+1duJfCMCqxlzA5eqU1twBNJ/lxvXDsrA
         G7kbCZgC7z6R5JHZ8725PzJLHO4eGC8heQ8lsS+ghoVgvLmkdXeEHnLNYLlA7DuFxp+e
         +vLEs4SYq38BhTE/Y1VPiH9APRAln10G8D+ADWaZdbnRR67eA1MNz8Bol3zEchQNJPDB
         Q2Ng==
X-Gm-Message-State: AOAM532CzUFIfe3XHYeepK62OhW3LiO5UvM8t5y10k+5XVI0/UyTGywo
        EWdOBWjYiUkepw6WhKVKxvQwpw==
X-Google-Smtp-Source: ABdhPJz3gQIyTN45i1aPVFveM3Bul2uCaHAGbhBoyHJdaWipsW4dCYaNLy3z+6I5IMCotxAlOsp8pQ==
X-Received: by 2002:a17:90a:bb0b:: with SMTP id u11mr36773910pjr.18.1628523012466;
        Mon, 09 Aug 2021 08:30:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y2sm19717321pjl.6.2021.08.09.08.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 08:30:11 -0700 (PDT)
Date:   Mon, 9 Aug 2021 15:30:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2 1/3] KVM: x86: Allow CPU to force vendor-specific TDP
 level
Message-ID: <YRFKABg2MOJxcq+y@google.com>
References: <20210808192658.2923641-1-wei.huang2@amd.com>
 <20210808192658.2923641-2-wei.huang2@amd.com>
 <20210809035806.5cqdqm5vkexvngda@linux.intel.com>
 <c6324362-1439-ef94-789b-5934c0e1cdb8@amd.com>
 <20210809042703.25gfuuvujicc3vj7@linux.intel.com>
 <73bbaac0-701c-42dd-36da-aae1fed7f1a0@amd.com>
 <20210809064224.ctu3zxknn7s56gk3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809064224.ctu3zxknn7s56gk3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021, Yu Zhang wrote:
> On Sun, Aug 08, 2021 at 11:33:44PM -0500, Wei Huang wrote:
> > 
> > On 8/8/21 11:27 PM, Yu Zhang wrote:
> > > On Sun, Aug 08, 2021 at 11:11:40PM -0500, Wei Huang wrote:
> > > > 
> > > > 
> > > > On 8/8/21 10:58 PM, Yu Zhang wrote:
> > > > > On Sun, Aug 08, 2021 at 02:26:56PM -0500, Wei Huang wrote:
> > > > > > AMD future CPUs will require a 5-level NPT if host CR4.LA57 is set.
> > > > > 
> > > > > Sorry, but why? NPT is not indexed by HVA.
> > > > 
> > > > NPT is not indexed by HVA - it is always indexed by GPA. What I meant is NPT
> > > > page table level has to be the same as the host OS page table: if 5-level
> > > > page table is enabled in host OS (CR4.LA57=1), guest NPT has to 5-level too.
> > > 
> > > I know what you meant. But may I ask why?
> > 
> > I don't have a good answer for it. From what I know, VMCB doesn't have a
> > field to indicate guest page table level. As a result, hardware relies on
> > host CR4 to infer NPT level.
> 
> I guess you mean not even in the N_CR3 field of VMCB? 

Correct, nCR3 is a basically a pure representation of a regular CR3.

> Then it's not a broken design - it's a limitation of SVM. :)

That's just a polite way of saying it's a broken design ;-)

Joking aside, NPT opted for a semblance of backwards compatibility at the cost of
having to carry all the baggage that comes with a legacy design.  Keeping the core
functionality from IA32 paging presumably miminizes design and hardware costs, and
required minimal enabling in hypervisors.  The downside is that it's less flexible
than EPT and has a few warts, e.g. shadowing NPT is gross because the host can't
easily mirror L1's desired paging mode.
