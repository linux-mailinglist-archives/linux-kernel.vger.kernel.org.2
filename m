Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CD3880D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbhERT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbhERT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:57:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F481C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:55:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso2166539pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HRboTMWcVL2UZH3bRp+LA1JCHR25V76yBK5UJMIVTcg=;
        b=QFIb1ZcejdFx8BN6fWQrtd4GLjTXxcmP9rUQldfauaSBQYByinqpDRlYPGIJKvw1tK
         R7ehaPJJagouMRcWbGQfajGeWDKp7OvHYESj9E0Zf12UPMKyGrkGAmensTzF8xdHhTd9
         V65Grakm8ZxCwPchXmcABcSssiB/wJTPkdEVnh7/8op1trpEK4zj+/RY73VaEiV9MaA0
         zPdOkYaSK+Irfaae4aPI0/LqMe0aQIzySJWX+iu7IWRwLMYAdkTiagqmLntcPiSc2anv
         /kctR6hYWv8nCaUUhEHms9ZIKPiC6bPjjAPZg1LBLkpKRW1a6BANRPx79Usts1+Pseiv
         ivkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HRboTMWcVL2UZH3bRp+LA1JCHR25V76yBK5UJMIVTcg=;
        b=U+39bWb/9z3wjgWXJ6wrFMUHUVqdylyXyuoTB+P3fYcDLMY8hNg2HeoSmYD+fpB4iC
         3NUGxsg8z0IZB9X7TybQ4dU0TqCnenJ1eYl3978/N3l1WxV/vqCAtrQ1DTw2wL9ImVpI
         6x8GJyTjkxaFIL7/nht13ftQJTtdgmiv9HDyUWy7VzJWRBULEaQD2SmgfRS6gZZk8Hfc
         ezBRKxUN//uL8VGm/TPHkjqzLUzes1be1IxpaqaFVwgGISGqLARoIm2oX4W7hc8x2Eqg
         o02ounXbDsC7RN9wmdf5fURDTGmXtvd/39j4x2bA4DPI1rHnIvHRlt8xisCpgy/3jpZF
         Q61w==
X-Gm-Message-State: AOAM533Br1Bcxal//5iwBWTnDVjZbZdGuk+GozFeKKbCGBCmNk7ezlar
        kDZD8Qv+Q1Kf5xyq/buypglj8Q==
X-Google-Smtp-Source: ABdhPJxXA7Z+gKV9RQu/bY9xESHK0ezQbkXE9Jfvyv/TJMEGk5f2NNN+Y/YOyTQ7jCugfeqpZHet0g==
X-Received: by 2002:a17:90a:66c3:: with SMTP id z3mr7121930pjl.196.1621367743910;
        Tue, 18 May 2021 12:55:43 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w206sm3020841pfc.61.2021.05.18.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 12:55:43 -0700 (PDT)
Date:   Tue, 18 May 2021 19:55:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Make DMA pages shared
Message-ID: <YKQbu3bITMjUMf75@google.com>
References: <1ccf5e60d2d79308d50f93c8c3b32b1394bc7baf.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210518011912.259112-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210518011912.259112-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Intel TDX doesn't allow VMM to access guest memory. Any memory
                                             ^
                                             |- private

And to be pedantic, the VMM can _access_ guest private memory all it wants, it
just can't decrypt guest private memory.

> that is required for communication with VMM must be shared
> explicitly by setting the bit in page table entry. And, after
> setting the shared bit, the conversion must be completed with
> MapGPA TDVMALL. The call informs VMM about the conversion and
> makes it remove the GPA from the S-EPT mapping.

The VMM is _not_ required to remove the GPA from the S-EPT.  E.g. if the VMM
wants to, it can leave a 2mb private page intact and create a 4kb shared page
translation within the same range (ignoring the shared bit).

> The shared memory is similar to unencrypted memory in AMD SME/SEV
> terminology but the underlying process of sharing/un-sharing the memory is
> different for Intel TDX guest platform.
> 
> SEV assumes that I/O devices can only do DMA to "decrypted"
> physical addresses without the C-bit set.  In order for the CPU
> to interact with this memory, the CPU needs a decrypted mapping.
> To add this support, AMD SME code forces force_dma_unencrypted()
> to return true for platforms that support AMD SEV feature. It will
> be used for DMA memory allocation API to trigger
> set_memory_decrypted() for platforms that support AMD SEV feature.
> 
> TDX is similar.  TDX architecturally prevents access to private

TDX doesn't prevent accesses.  If hardware _prevented_ accesses then we wouldn't
have to deal with the #MC mess.

> guest memory by anything other than the guest itself. This means
> that any DMA buffers must be shared.
> 
> So create a new file mem_encrypt_tdx.c to hold TDX specific memory
> initialization code, and re-define force_dma_unencrypted() for
> TDX guest and make it return true to get DMA pages mapped as shared.
> 
> __set_memory_enc_dec() is now aware about TDX and sets Shared bit
> accordingly following with relevant TDVMCALL.
> 
> Also, Do TDACCEPTPAGE on every 4k page after mapping the GPA range when

This should call out that the current TDX spec only supports 4kb AUG/ACCEPT.

On that topic... are there plans to support 2mb and/or 1gb TDH.MEM.PAGE.AUG?  If
so, will TDG.MEM.PAGE.ACCEPT also support 2mb/1gb granularity?

> converting memory to private.  If the VMM uses a common pool for private
> and shared memory, it will likely do TDAUGPAGE in response to MAP_GPA
> (or on the first access to the private GPA),

What the VMM does or does not do is irrelevant.  What matters is what the VMM is
_allowed_ to do without violating the GHCI.  Specifically, the VMM is allowed to
unmap a private page in response to MAP_GPA to convert to a shared page.

  If the GPA (range) was already mapped as an active, private page, the host
  VMM may remove the private page from the TD by following the “Removing TD
  Private Pages” sequence in the Intel TDX-module specification [3] to safely
  block the mapping(s), flush the TLB and cache, and remove the mapping(s).

That would also provide a nice segue into the "already accepted" error below.

> in which case TDX-Module will hold the page in a non-present "pending" state
> until it is explicitly accepted.
> 
> BUG() if TDACCEPTPAGE fails (except the above case)

What above case?  The code handles the case where the page was already accepted,
but the changelog doesn't talk about that at all.  

> as the guest is completely hosed if it can't access memory. 

