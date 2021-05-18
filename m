Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2566A387F83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351516AbhERSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351501AbhERSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:23:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27BCC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:22:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 22so7647142pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0VT3t61ChyW4uJtOTZiVkxVXHvveHsxTfosHpFAjpW8=;
        b=D+0D2KWuEnUUzUHbAyCrrTJKaYgxq/4cqDyuitVDBYdmUgx5d6Kw6zhNFot4o8Ack4
         3kejr7qU0EcQ2m3xwPpzGfUNZvIYx6TKmTTokBxiyyPj6pz5ren3I+kBOrhKP2yk2SA/
         LtoxaD4sHCcFb7GSOyoh7BMz80mkM+OdDCd6PnoJUjWcDN3bWIHf7t4fI93vs+ff9Wi6
         00lTgXBB36+3d1YLYUPqUSzQIgzhyYqjlhqP8247NufceAUjBs6bhTOXAKt/A60shZie
         BTUodAdJQ7LnaQF/jHtcG4n7duG5OM427rGcjb57yBbqEh3u+oZH9vrrYh1KxghMamXT
         5G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VT3t61ChyW4uJtOTZiVkxVXHvveHsxTfosHpFAjpW8=;
        b=W8PaOyAegIXyhKP01MZ/1MbZJ3OTM3mct7Q0EKPr9IrABo8u3Io0tweZ2scfw/7Kid
         xLfaQ40Wdw1VuqJV6UikpHbhsD5WG1Bz3bucqLRMJQnkk7U98RC6vpYfEAjghJNKtLPG
         CntBGcdDnxUSm2YKhJOyIr5IGeRd7ySvoFYMC8BNQU5sjiNtrhOYJdDlJP19zEJYQN6+
         GD097xu8uZ3OmCIVD1gmCfXFbVBLI6lzj5kP0ab6Nk6tej3KsBupdTUS2lZdk8AF00Dv
         sclYCMrcbo0fTbLJ1isax/QTHcn/rHXbfqLfYZiaxyUARHQparTDp8HRwpsAfns9OmBQ
         MPaA==
X-Gm-Message-State: AOAM531xFxPAqYtXA9NAbeiImu5M4FW4pxSAGrX33xNjsQjYP07UfofA
        wd8tUucYkc3QKEgbkbxXvTHkcw==
X-Google-Smtp-Source: ABdhPJylyJpRN9DbhwctWCTzidq8+J1FuNpRmBsrDhN315FWcXIYTjdBU8oDjPJLkLdojfqT2lwuAw==
X-Received: by 2002:aa7:8194:0:b029:2aa:db3a:4c1d with SMTP id g20-20020aa781940000b02902aadb3a4c1dmr6419405pfi.58.1621362136133;
        Tue, 18 May 2021 11:22:16 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w127sm12618752pfw.4.2021.05.18.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:22:15 -0700 (PDT)
Date:   Tue, 18 May 2021 18:22:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
Message-ID: <YKQF08wqTsCQ3qHL@google.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Andi Kleen wrote:
> 
> > The extra bytes for .altinstructions is very different than the extra bytes for
> > the code itself.  The .altinstructions section is freed after init, so yes it
> > bloats the kernel size a bit, but the runtime footprint is unaffected by the
> > patching metadata.
> > 
> > IIRC, patching read/write{b,w,l,q}() can be done with 3 bytes of .text overhead.
> > 
> > The other option to explore is to hook/patch IO_COND(), which can be done with
> > neglible overhead because the helpers that use IO_COND() are not inlined.  In a
> > TDX guest, redirecting IO_COND() to a paravirt helper would likely cover the
> > majority of IO/MMIO since virtio-pci exclusively uses the IO_COND() wrappers.
> > And if there are TDX VMMs that want to deploy virtio-mmio, hooking
> > drivers/virtio/virtio_mmio.c directly would be a viable option.
> 
> Yes but what's the point of all that?

Patching IO_COND() is relatively low effort.  With some clever refactoring, I
suspect the net lines of code added would be less than 10.  That seems like a
worthwhile effort to avoid millions of faults over the lifetime of the guest.

> Even if it's only 3 bytes we still have a lot of MMIO all over the kernel
> which never needs it.
> 
> And I don't even see what TDX (or SEV which already does the decoding and
> has been merged) would get out of it. We handle all the #VEs just fine. And
> the instruction handling code is fairly straight forward too.
> 
> Besides instruction decoding works fine for all the existing hypervisors.
> All we really want to do is to do the same thing as KVM would do.

Heh, trust me, you don't want to do the same thing KVM does :-)
