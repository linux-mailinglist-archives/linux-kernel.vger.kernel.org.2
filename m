Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABB3E0A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhHDVpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhHDVpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:45:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920AC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:45:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a8so4978916pjk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfp2nbAaBDmaHCKbc8jdtjyOnO2Mi9ptYsZd0hKtwR4=;
        b=Tvd62UHnA853y4QUoh0E1xlqa/eX01VTvu4Lzbwfj+5WqzN6YtivEoiTt4hcorifYl
         d8MQIi+nCfoH0671wWkOl7X+Llk3ot6Gras7mW8WeWLCzjIWuo1BYzatqwaBicVnYPB3
         AubCV1g6ExfSgTZm5dB+3BXu0Ikq3RIevhV4gPacVAOOioDQFfBx6agBACDo1fBDq24J
         RS2v/l9OD0hOlfimAGaFJqDC1d9gc3AQkZK1EZ/gPn6S10X1gt0jfm3w4fA0mLiLODhL
         sXhQGkRwPZrNuOkq2ydXUK0EdEaW+JrexEGpX0tqorwaDDaccPcFVb+U9dBODFWMesIY
         nzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfp2nbAaBDmaHCKbc8jdtjyOnO2Mi9ptYsZd0hKtwR4=;
        b=oenqa/Jqbsd9qEWi2eD+oxgqkv8eMoC9o83iHBqyD+p1RBy7c74rtUsUHlCTba1CIb
         9u/bH/EbvHgkwTRVA4RKQFi4y2Wlz9LK+vz4O4DRE1Z8fiKZijwVtjOn1UuSKdChoBK5
         LPhOgyy2uQRMH23fUOFtJp+OuY/SXqrJqhXyd9QQytqDnWYHX2CWsV15g0qrUjiIKjc3
         vWnHfObMSw1oS8rHzumcwtyHEGFCxAmQMXzZFDkF2kK/jZwCw68gmrhJUaH/TtSnRwG+
         hCdjVsuAddkPta7b1G3KNPfmFHThPDniucJ8/HooIa+ZoIXzWkOo1HYX5m1fIs7y2GW/
         sCWA==
X-Gm-Message-State: AOAM532rKeCXwEN1Q7F4MFVjFnes8qYm743LK3xEXsyQKaI/F4LBMdZj
        KZ+9gOr/1iEioi+WVoa74GgrNA==
X-Google-Smtp-Source: ABdhPJwBMKYYqyJIg2SCdgsHABnqwhRvRaS0BnO8JD3yPfiFoqd+w2gJBR9n05GRPFTHEFKjMlFvRw==
X-Received: by 2002:a63:5505:: with SMTP id j5mr400634pgb.250.1628113502837;
        Wed, 04 Aug 2021 14:45:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b18sm3873743pfi.199.2021.08.04.14.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 14:45:02 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:44:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/12] x86/tdx: Don't write CSTAR MSR on Intel
Message-ID: <YQsKWuiUyUWoA5kb@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrdFLPaUnC8Q5bn@google.com>
 <4c1ee7b9-9941-fdc4-73f5-3d2ef0530556@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1ee7b9-9941-fdc4-73f5-3d2ef0530556@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 8/4/21 11:31 AM, Sean Christopherson wrote:
> > > On Intel CPUs writing the CSTAR MSR is not really needed. Syscalls
> > > from 32bit work using SYSENTER and 32bit SYSCALL is an illegal opcode.
> > > But the kernel did write it anyways even though it was ignored by
> > > the CPU. Inside a TDX guest this actually leads to a #GP. While the #GP
> > > is caught and recovered from, it prints an ugly message at boot.
> > > Do not write the CSTAR MSR on Intel CPUs.
> > Not that it really matters, but...
> > 
> > Is #GP the actual TDX-Module behavior?  If so, isn't that a contradiction with
> 
> No, #GP is triggered by guest.

#GP is not triggered by the guest, it's not even reported by the guest.  From
patch 7, the #VE handler escalates unhandled #VEs "similar to #GP handler", but
it still reports #VE as the actual vector.

Now, that particular behavior could change, e.g. setting tsk->thread.trap_nr to
#VE might confuse userspace, but at no point does this "trigger" a #GP.
