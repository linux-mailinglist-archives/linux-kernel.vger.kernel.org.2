Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED1A3509F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhCaWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhCaWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:06:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F655C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:06:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g15so16281pfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ldJOvK584oweCdPgUHDfK/qF4RMMyycJu/ZdSHEIg4g=;
        b=mKgYI0q1whhfZk02t7D/0W7KypdwuZHEi4lYbxq1uA6ASxwe9+uIVlQC1SiH3JJQ3p
         5xy/ggVNA+gxP+KHBXvgh5fSfSw109D07MVfQ45yHR9AQYq3a8qQyvY7KlhyIzqG4hkN
         slQ3HgdctKyaORCvXS4KMGODl/immGonx3v6dt1Ej5ieFIZY4s2nuYhAJo32bgYHdgYx
         za5W3cligjBXvHM2LBZcE8Bh67sq0we+5zLDTYGYpMTvLZP743w/sNmUvhQMW3+k4vPm
         ad5yziY21a6bBo6FyHRnJ55X45nub7CyEA70A9qDYNrL/x9vf3oiC8XltDD+XiMouNH3
         66MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ldJOvK584oweCdPgUHDfK/qF4RMMyycJu/ZdSHEIg4g=;
        b=Rr4i1N8TN8DVeocq6P5aqyAhROEwj3QMafQE5Pnpp3tfEpHY5d7/0UzPcAM2MIZHzV
         NzjO9b88XZ5oFsrgjO75RxQVIcZKbgCf5r9e4IOKWh0g7uo1I0bW1y76+RyZOWYgB5vh
         G5oIAiaRiqNl+RVOn0MAbX7zzM2Mzn9Lnn9rpS031HRqd17byUz3bZcUQjDy3ypwLgrm
         uA535RPFSWsgXKMYhS7sHVsJbhP6WQF4y7hGUOzNhH2qHUgmvkZA5RJ6Nj/yukKVKkyY
         d8l5UTbN2aM/Httt1/6QnUssqA+zhyAwuqUQsljHVDsLxpYD7hYQuv5oIJc2x9VWyRQK
         SSJg==
X-Gm-Message-State: AOAM533LC6dGBZkLFaYcL3HqmMI4wYJRprOdxjPbxiL7sfiWbvPz/bdU
        JBrWXV7WzfTCZvDymTYZHIJL8w==
X-Google-Smtp-Source: ABdhPJyibKWfvf4TKIgiAFBbZygWQ8K6p7LMtAtKvxpFzc5RZ0ItnoIMUUTm020ulTvbq3gpfyNx3Q==
X-Received: by 2002:a63:1b55:: with SMTP id b21mr5064727pgm.160.1617228381518;
        Wed, 31 Mar 2021 15:06:21 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s17sm3270494pfc.53.2021.03.31.15.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:06:20 -0700 (PDT)
Date:   Wed, 31 Mar 2021 22:06:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGTyWUQbxVZeeko+@google.com>
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YGTvSvr2T2v3t3XA@google.com>
 <5d961c25-3dee-4a5d-4bba-a97d157a5a49@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d961c25-3dee-4a5d-4bba-a97d157a5a49@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Dave Hansen wrote:
> On 3/31/21 2:53 PM, Sean Christopherson wrote:
> > On Wed, Mar 31, 2021, Kuppuswamy Sathyanarayanan wrote:
> >> Changes since v3:
> >>  * WARN user if SEAM does not disable MONITOR/MWAIT instruction.
> > Why bother?  There are a whole pile of features that are dictated by the TDX
> > module spec.  MONITOR/MWAIT is about as uninteresting as it gets, e.g. absolute
> > worst case scenario is the guest kernel crashes, whereas a lot of spec violations
> > would compromise the security of the guest.
> 
> So, what should we do?  In the #VE handler:
> 
> 	switch (exit_reason) {
> 	case SOMETHING_WE_HANDLE:
> 		blah();
> 		break;
> 		...
> 	default:
> 		pr_err("unhadled #VE, exit reason: %d\n", exit_reason);
> 		BUG_ON(1);
> 	}
> 
> ?
> 
> Is this the *ONLY* one of these, or are we going to have another twenty?
> 
> If this is the only one, we might as well give a nice string error
> message.  If there are twenty more, let's just dump the exit reason,
> BUG() and move on with our lives.

I've no objection to a nice message in the #VE handler.  What I'm objecting to
is sanity checking the CPUID model provided by the TDX module.  If we don't
trust the TDX module to honor the spec, then there are a huge pile of things
that are far higher priority than MONITOR/MWAIT.
