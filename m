Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66A35CF63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbhDLRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbhDLRY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:24:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:24:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n2so21539799ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsoHiH3lUM15pmvDC/yVK68gfG2gY8C/mzb2TrzRVIg=;
        b=HfEaOFR+ILIfElMp8c7qI2aVrkU6BOk9zMD48pmVJsxQlxe54dQDN3ARURZciD/rSd
         xn0p++v7JeFgOM8igTuF4zzu+LVTIyW7X6QcMLNcn9ZmnSIf7xLODQ9LxiTIhPZ2lmWC
         2MjzM2hRrISNQ8LHIx1T3DL9/JmZBWsKFDOtF3lG5xIqXhpnsbS7m4ybt1+djzGkWq5t
         S5cJ3xjt6zhvmEb5BK1k8FeOphNJITnlq1Q1DsaSqKa6MDy3Z509Mm7NQtgDcc56uL/X
         AVqw9UPKa98CxaqMYfVEWdb755TOwXcXNH8ACefrulCPuYWpVyuWDB1uyJQCBaADuRfD
         PZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsoHiH3lUM15pmvDC/yVK68gfG2gY8C/mzb2TrzRVIg=;
        b=DlT2pdpDFFUg1qUIXBy2yprDqztp4iR2k3jLVIbImuCnXk9epyNYH6kR1LjJ97Uday
         kKKWtgW5Y7/PXzNLR5BaLDXlcVg/lYXSHSy0C+FntT+qIbPJRHMswwwOoMxsnjTNV8P+
         rYKOGEDT0RF0zJE3HxkRWu0gEEkESu7Rr/MWowWOnu9E51GmsJ0G7iTs3X/t6B7UBpLu
         Vispzm+a6cYvhD0MPo1K4qzTiO6pqQT/3+9AcAC0ZX0vNdpXBYRF2oBZF/Oog4rgK5WE
         TgzxCC4zFW4IY1mQNMF5lbKx3nuqmNYGu+HNJg3Xm8PbcfFyOh0BrEGxLt54vJO4WA+2
         bB3Q==
X-Gm-Message-State: AOAM533IlOIyWmYTsXIIV/nPHxgnGUJqagBR3cD1ti+x9/NtjiQ5DglL
        4pRkVvmxeS/LELNsABxc2l6TTWnFuuuQAcwhxEn4CQ==
X-Google-Smtp-Source: ABdhPJxDYxgd3VYsrnjhRizmx30PeyHsb3cdNMqTtGT9FMurQYGpntuj+xuLUwhV7q2ewqn+APN+YI4X0mD+FCWjLjg=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr3006235ejc.418.1618248277407;
 Mon, 12 Apr 2021 10:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com> <2f386325-58f5-6f4d-060e-f0261b6f19ee@intel.com>
In-Reply-To: <2f386325-58f5-6f4d-060e-f0261b6f19ee@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Apr 2021 10:24:32 -0700
Message-ID: <CAPcyv4jx6cpdimDjyJtVkHLGmq_jcb0SWpz+Yx05iB0LM9CUyw@mail.gmail.com>
Subject: Re: [RFC v1 00/26] Add TDX Guest Support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021 at 8:02 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> It occurred to me that I've been doing a lot of digging in the TDX spec
> lately.  I think we can all agree that the "Architecture Specification"
> is not the world's easiest, most disgestable reading.  It's hard to
> figure out what the Linux relation to the spec is.
>
> One bit of Documentation we need for TDX is a description of the memory
> states.  For instance, it would be nice to spell out the different
> classes of memory, how they are selected, who selects them, and who
> enforces the selection.  What faults are generated on each type and who
> can induce those?
>
> For instance:
>
> TD-Private memory is selected by the Shared/Private bit in Present=1
> guest PTEs.  When the hardware page walker sees that bit, it walk the
> secure EPT.  The secure EPT entries can only be written by the TDX
> module, although they are written at the request of the VMM.  The TDX
> module enforces rules like ensuring that the memory mapped by secure EPT
> is not mapped multiple times.  The VMM can remove entries.  From the
> guest perspective, all private memory accesses are either successful, or
> result in a #VE.  Private memory access does not cause VMExits.
>
> Would that be useful to folks?

That paragraph was useful for me as someone coming in cold to TDX
patch review. +1 for more of that style of commentary.
