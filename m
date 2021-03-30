Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB55D34EE99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhC3Q6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhC3Q5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:57:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C44C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:57:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c17so12560711pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HwZfvc+RGY+nAYQmW29U2DZoBvul1VM+bc9Xe9lfnbg=;
        b=r4SjL7WLccP+PuDbFoNC9uvkt5/ycVNRxvLRZ5h+n8xk+dQzOS0UAq6lyXj4e11sbX
         MDWZVVUb7RILnl11VUZAO5wqYueZaXs0EDmq3x16CaiW5JvEoeQCIIl22jr9tc/dhD8J
         pa2DPXdm3nv0Gy/9etOnQa1Vi4kiK0f3+2hjpd7yAyKLwD0l6SE9ZG/oUYIP9WffR+rD
         DfHGz60gawsaaz4QQn1vViX7i9TPqWoatNP42j6ZZY73lTNJLTFqn+30z0Gfr9zzdZtb
         qIBhV0kWYGzPJXzrKw2YHB570r9J46MD9eJ12Lu9Db657/zjffpoPi7RXG7vMrF/eoly
         edTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HwZfvc+RGY+nAYQmW29U2DZoBvul1VM+bc9Xe9lfnbg=;
        b=Futg5I+c9xHvTCArNquottxi5kewy2zMa10dmG41ERC/SlFyCMgIPRRYHYhz2Nq4YV
         YarN0Rj6ry+3VMy4AEr6lBw0ds0WGKaKPOYx+x38NcHx7ZKfgBp010/QSCCrWQWAwEEU
         Avd6KO2l5OScqMJRejYjWUbcgzXwlaG5WoBVQcCVzw2ZGccKev2ZYt9755lhsAbMEmFl
         CjenmtD1l6RI+xygcgiOGvfdoK1qKztSASD6rrb2lu1nR/N256ljgiD7YcI3XT6P2ot5
         UhNtUui1nmOzFxDMRRHtGpENXzBIHuaB4YGxyR+8QXrn2wB+yGSys8o2GIvf0PWt9B+2
         EaSA==
X-Gm-Message-State: AOAM532hXsPtRzgt0YEpEDdaA6bCaTWty6nz4tf+pxY8uQSt1BnOuJi2
        OuUtP5DTZi2F+RI7uv61Q+nbVw==
X-Google-Smtp-Source: ABdhPJzppjcx2wf79bPaKg4PXfGpnxWNEy75G9qweb2bDnsy5TSZDvxLzvzNrFK/LiS7N4Fv0rV2mA==
X-Received: by 2002:a63:2a88:: with SMTP id q130mr15416803pgq.49.1617123466118;
        Tue, 30 Mar 2021 09:57:46 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id r2sm19942318pgv.50.2021.03.30.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:57:45 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:57:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Message-ID: <YGNYhWXe57FMm6Ku@google.com>
References: <YGNAQrWMl3AZQ3HG@google.com>
 <4DD05B91-13B3-4842-A215-C8DC6F34F219@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4DD05B91-13B3-4842-A215-C8DC6F34F219@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021, Andy Lutomirski wrote:
> 
> > On Mar 30, 2021, at 8:14 AM, Sean Christopherson <seanjc@google.com> wrote:
> > 
> > ﻿On Mon, Mar 29, 2021, Andy Lutomirski wrote:
> >> 
> >>>> On Mar 29, 2021, at 7:04 PM, Andi Kleen <ak@linux.intel.com> wrote:
> >>> 
> >>> ﻿
> >>>> 
> >>>>> No, if these instructions take a #VE then they were executed at CPL=0.  MONITOR
> >>>>> and MWAIT will #UD without VM-Exit->#VE.  Same for WBINVD, s/#UD/#GP.
> >>>> 
> >>>> Dare I ask about XSETBV?
> >>> 
> >>> XGETBV does not cause a #VE, it just works normally. The guest has full
> >>> AVX capabilities.
> >>> 
> >> 
> >> X *SET* BV
> > 
> > Heh, XSETBV also works normally, relative to the features enumerated in CPUID.
> > XSAVES/XRSTORS support is fixed to '1' in the virtual CPU model.  A subset of
> > the features managed by XSAVE can be hidden by the VMM, but attempting to enable
> > unsupported features will #GP (either from hardware or injected by TDX Module),
> > not #VE.
> 
> Normally in non-root mode means that every XSETBV results in a VM exit and,
> IIUC, there’s a buglet in that this happens even if CPL==3.  Does something
> special happen in TDX or does the exit get reflected back to the guest as a
> #VE?

Hmm, I forgot about that quirk.  I would expect the TDX Module to inject a #GP
for that case.  I can't find anything in the spec that confirms or denies that,
but injecting #VE would be weird and pointless.

Andi/Sathya, the TDX Module spec should be updated to state that XSETBV will
#GP at CPL!=0.  If that's not already the behavior, the module should probably
be changed...
