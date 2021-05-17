Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16779383C13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbhEQSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbhEQSSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:18:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26CC061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:16:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t30so5205313pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PMdMoCS0N0C9gK98GW5JwRMFtjaGqy0FDiHN3YGTdug=;
        b=lWpGJosdFYl1Hv0EqU4KUfoJsiTFP0GiorlKdZXB8l7KUlAWY3zfxdnuMF10X8Ijzl
         MfEhQ7b6s5mzjIx12de6svpP7s+eMJO9PRmA4I2uXX2Ed2gBa3UeD9hmuPEfo4EwwN+I
         eHsdu8ac2hJFoIOz8qhesW4uGGgO8nEDIsdXbVoyMUNKIqYLH9Rn4J2Jdf2u0vqIXBHx
         3cwdyHOA9EWTDelxxnRkC0Gk1WaYmRUhXRnTRnRqzWp2uzcXr2qy4BB/33w7P6L7K9By
         /iIzLGMpWh8bXGexSTWY7L4pbwQD/via8n+f+b9MKyC7aI2vB2ARJJs5S7yCbSeKimsf
         5Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PMdMoCS0N0C9gK98GW5JwRMFtjaGqy0FDiHN3YGTdug=;
        b=DoAXWOLUloTPj/FPWxBaFgYEGp8KuGxnnYM3A0yr5F1TFK/DwKTZDv3T+fB17zCSuo
         ex1MBqUY6va0Zq+WqN2JECu1rpdOAbV/U9CncReSk+KxvUZtDdIxnXvh2pX85d0vLV1T
         oyejrSuysprDaKKisAihAxE7Fie2NIu/AJw9dXIwFddKFn/paq9mMfoGk8m7EsvcHGFs
         aUayl3ma+1SLRowjHvjBUMZx0tRnREJWqSvmPPigGUPRJLw2cJOieWZeXKFwP09QMA+p
         LdjCsUWTMjMUUefXy7LDNA7DBlLtOBoQnv3jJayQlEatOTr57pCi6vUdV9qSdFadgBgr
         QuUA==
X-Gm-Message-State: AOAM53066SyxogO1HTKWvti02KZkNEMlJjPhgKaHuyLXgd+G40XSdQYz
        isliR3lDeMqmWibZ73ih4JzzwQ==
X-Google-Smtp-Source: ABdhPJykMJOd6ssKXxD8w2zaQ64k4mRrrYrSw3Oid5xLnuwxUTm/4mA3qZrfoP4qWWzfllKSpKr67w==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr779497pgm.365.1621275404608;
        Mon, 17 May 2021 11:16:44 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id a27sm1939108pfk.91.2021.05.17.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:16:43 -0700 (PDT)
Date:   Mon, 17 May 2021 18:16:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
Message-ID: <YKKzCOW9u6q06E5I@google.com>
References: <7c5adf75d69ea327b22b404b7c37b29712d73640.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5536639a-918d-de8d-ff32-934a13902a03@intel.com>
 <d04e5992-8800-a8df-99de-4dbb40e45d09@linux.intel.com>
 <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
 <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
 <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
 <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021, Andi Kleen wrote:
> 
> On 5/13/2021 10:49 AM, Dave Hansen wrote:
> > On 5/13/21 9:40 AM, Kuppuswamy, Sathyanarayanan wrote:
> > > +#define PROTECTED_GUEST_BITMAP_LEN    128
> > > +
> > > +/* Protected Guest vendor types */
> > > +#define GUEST_TYPE_TDX            (1)
> > > +#define GUEST_TYPE_SEV            (2)
> > > +
> > > +/* Protected Guest features */
> > > +#define MEMORY_ENCRYPTION        (20)
> > I was assuming we'd reuse the X86_FEATURE infrastructure somehow.  Is
> > there a good reason not to?
> 
> This for generic code. Would be a gigantic lift and lots of refactoring to
> move that out.

What generic code needs access to SEV vs. TDX?  force_dma_unencrypted() is called
from generic code, but its implementation is x86 specific.

> > That gives us all the compile-time optimization (via
> > en/disabled-features.h) and static branches for "free".
> 
> There's no user so far which is anywhere near performance critical, so that
> would be total overkil

SEV already has the sev_enable_key static key that it uses for unrolling string
I/O, so there's at least one (debatable) case that wants to use static branches.

For SEV-ES and TDX, there's a better argument as using X86_FEATURE_* would unlock
alternatives.

> BTW right now I'm not even sure we need the bitmap for anything, but I guess
> it doesn't hurt.
> 
> -Andi
> 
> 
