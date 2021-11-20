Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB6457A68
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhKTB0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 20:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhKTB0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 20:26:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869FC061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:23:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso12253510pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Xij941QtBI1Uy4eu8Bu4KYhGHxK/4BecrqjrKxNLxc=;
        b=GpoQ21DjhXv2BUYJlGx0hMtF15Q8bpsRbq0wJvD6yrNvx1DYqqtNexsuLz1NRYVJ7e
         NHFLzQYzZOyh+GJfAJnENBvIm+qSEHAVkgDfaCl/Zr3pl/+QESPUvhi1a2uPxB+ICwuy
         d5j4VltRnAABaR74WGpaFwAADwy0tlcySm0JDW/fekN3+r5XTQVTXr1Oeo7Jdu+sGAFN
         rv5qPR8lCfq27Bt1ONuGfxXO5QpeOfd39C4seaS4JUP7gy5aJprSPYN7u6PlhL8Ju2dl
         odxJsmR6NbgGQCOlLIJktpJf2jC+gWvVcaW+8w8uNLE8ah6nxpfEwfFkX5r9M/k9m+ys
         91CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Xij941QtBI1Uy4eu8Bu4KYhGHxK/4BecrqjrKxNLxc=;
        b=GQB/UaHirjTiGsOGbwQ9HImHwqGf06eyBx16BB4vEfPo/VjBEf0EYvSmXYWOx03/XF
         BF/JaMfRgYR+RNf2FZrDHEkcBbkhkEasB0yugFXSTbmqgFFVOSnDHWzcQRLqP+uq8o4A
         3FOoi1ciUK0c8wjydfp5PYqqfnSYqpwruM8PqcBOIJc3GFiLbjh+O2LVU3togCqGJCU8
         wlSWgXWatt755yIMra7SFEUG+zbk4ClcnZfYdeQCai1TE8X2ZGQL9Zf7QDucwNx0JluV
         5mWubk5+gMekKAR6r6uFNp4gKxQalxyN3bVOccKw52JQQhrZ6iAbBBmmKvCvURF8qwb8
         GkhQ==
X-Gm-Message-State: AOAM53013gw6PMDaxOq1pTgfMz2cA2uCoc+DQhgFo0Y6OverX+ESHNcp
        vwr94jtVguvwwo8m+pfUKI92HmW9snPzdg==
X-Google-Smtp-Source: ABdhPJzlUE1Um8kito32w8cWRvgp+EMtWNpSCF44SWtHzwom4+CZVI8C0AgTahILZETsub8pzqpAog==
X-Received: by 2002:a17:90b:3ec4:: with SMTP id rm4mr5349860pjb.88.1637371400077;
        Fri, 19 Nov 2021 17:23:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k12sm635804pgi.23.2021.11.19.17.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:23:19 -0800 (PST)
Date:   Sat, 20 Nov 2021 01:23:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <YZhOBD6vlkBEyq8t@google.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <YZf4aAlbyeWw8wUk@google.com>
 <20211119194746.GM876299@ziepe.ca>
 <YZgjc5x6FeBxOqbD@google.com>
 <20211119233312.GO876299@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119233312.GO876299@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021, Jason Gunthorpe wrote:
> On Fri, Nov 19, 2021 at 10:21:39PM +0000, Sean Christopherson wrote:
> > On Fri, Nov 19, 2021, Jason Gunthorpe wrote:
> > > On Fri, Nov 19, 2021 at 07:18:00PM +0000, Sean Christopherson wrote:
> > > > No ideas for the kernel API, but that's also less concerning since
> > > > it's not set in stone.  I'm also not sure that dedicated APIs for
> > > > each high-ish level use case would be a bad thing, as the semantics
> > > > are unlikely to be different to some extent.  E.g. for the KVM use
> > > > case, there can be at most one guest associated with the fd, but
> > > > there can be any number of VFIO devices attached to the fd.
> > > 
> > > Even the kvm thing is not a hard restriction when you take away
> > > confidential compute.
> > > 
> > > Why can't we have multiple KVMs linked to the same FD if the memory
> > > isn't encrypted? Sure it isn't actually useful but it should work
> > > fine.
> > 
> > Hmm, true, but I want the KVM semantics to be 1:1 even if memory
> > isn't encrypted.
> 
> That is policy and it doesn't belong hardwired into the kernel.

Agreed.  I had a blurb typed up about that policy just being an "exclusive" flag
in the kernel API that KVM would set when creating a confidential VM, but deleted
it and forgot to restore it when I went down the tangent of removing userspace
from the TCB without an assist from hardware/firmware.

> Your explanation makes me think that the F_SEAL_XX isn't defined
> properly. It should be a userspace trap door to prevent any new
> external accesses, including establishing new kvms, iommu's, rdmas,
> mmaps, read/write, etc.

Hmm, the way I was thinking of it is that it the F_SEAL_XX itself would prevent
mapping/accessing it from userspace, and that any policy beyond that would be
done via kernel APIs and thus handled by whatever in-kernel agent can access the
memory.  E.g. in the confidential VM case, without support for trusted devices,
KVM would require that it be the sole owner of the file.
