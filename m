Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD042CF86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJNA1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhJNA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634171112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6wAubtakjnBoaHKurwtREafNUUZ9/2uTc38nXWsIYM=;
        b=Qt1Ysx5ogwDBtCuBTEXnZRI8reRL4jtzIP9N8zIz3J458bG1Jl3/4LCDwTjLVQoia7vlII
        NmoV0J4IC/O99OTSRBueW4YAnLD1TxcgvWI0xaDdgGAUyJ4akmncEXioSnkZMsMXUTRzj2
        OucyyhIu91z2rEu2MGNVL5ULKL796Yw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-Bc2GBcq-NzidixoxSKiGkA-1; Wed, 13 Oct 2021 20:25:11 -0400
X-MC-Unique: Bc2GBcq-NzidixoxSKiGkA-1
Received: by mail-qk1-f199.google.com with SMTP id y5-20020ae9f405000000b0045fa3120bebso3180083qkl.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 17:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6wAubtakjnBoaHKurwtREafNUUZ9/2uTc38nXWsIYM=;
        b=r2IrVyT3hDQLURcNm7S4epJM3DmMtpsP8rb9yAVpbGN9zs41GarMDmbLUizuiLWz7P
         Knz4NvBLlxtaiCP1lYVOCm4BEkVHtAGnkCDO2yeiQagfJci6YFV8PYe4ugKRIz5/0aVJ
         2mwEn+XCoPtOmxilXfPLfb5ZthzYpRPizcS8taAYoYZlJ2v8P7yB1nzwCNoWfXlCCiPs
         R5nLc1nZuIs9hn09HWY34+c2tqElH619pYZZ+CTX+L7DD0EOOseEk8bmvkoeFkcEfvrt
         sEYjbG3dPcXG65HpBT3uN7jDHX6rJZcbNk8y2LIZp+B6vNwWOrtVMT9shPP7f6ThHxj+
         GREg==
X-Gm-Message-State: AOAM530jrmZl/Sn8cXy+aQUC1l+mGRcovcG5yLXnXuyeSMXbEVMCuh6x
        21v6F30JJqRv5VQgQUKrg2gNq7TQHwVevgZiKt0+gtnthn5NYyeepK+NRJHdojgU8smz6NJJ8g0
        GPAqjuLYMXsybXuiGynPcCZxB
X-Received: by 2002:ac8:7f44:: with SMTP id g4mr2973500qtk.130.1634171110472;
        Wed, 13 Oct 2021 17:25:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3c/96sI9+PeShZ1/XiaEXNpMp+taCmMjQ0F+VvWvS0HHS1brCSDBPDYZuLkZcE0kqdqfYqQ==
X-Received: by 2002:ac8:7f44:: with SMTP id g4mr2973470qtk.130.1634171110291;
        Wed, 13 Oct 2021 17:25:10 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 11sm713183qtt.14.2021.10.13.17.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:25:09 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:25:06 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20211014002506.2rqkgzrvy5ki2rcw@treble>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWaWSmWn6AZ6OLx+@zn.tnic>
 <20211013194251.ndbyj45egz6msl63@treble>
 <87wnmg7bt0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnmg7bt0.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 01:19:23AM +0200, Thomas Gleixner wrote:
> I'm amazed that it's so hard to see that this
> 
>     use()
>     init()
> 
> pattern is broken to begin with.
> 
> So why are you arguing about the placement of this variable in the first
> place instead of actually looking at the code, wondering about the
> obscenity and then asking about the call ordering?
> 
> In case that I might miss something important here due to my lack of CS
> education, please let me know.

I agree that's better.

I'd suggested doing setup_force_cpu_cap(X86_FEATURE_TDX_GUEST) early,
and then just check that instead of needing this new static variable.  I
think Boris said that's not possible because of some ordering reasons
which are eluding me (and I didn't have time to investigate).

-- 
Josh

