Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1270435594F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbhDFQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346415AbhDFQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:37:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C35C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:37:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u9so17219150ljd.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUPDO3O3MdLQndirsYklPtGCkJIX8gUjBqVkzFLCdY8=;
        b=ZVjIagnszRefdkzHtfHJBI8N2pzP9hwi4gBOLinEqf5+0hCJEI/C7qRT6xjB+fEwux
         S4Oo5QHsh2ez8nIH69eBc/IZlDQYa/To9SijT6FDGkxXhZu3wtKtY5TdKXxqspXlp7Ka
         YdP0r6NSUFoQ6NqX495Kfh7f9OiHuJ9SLd6vPvMAjcoU3wRF1hecnKfhq8WvC8W+PqeF
         lRY8rzT3Pn/MJ1YvP7wN9q2bof897w45jegeunGlertF2jZr+1ctNeGH/fpHRPSxhJce
         Vpsi0Qb0txBKhhZMwtjYS1Fhsv/t4LQ0Nt4zpJkmzh/YZcDsSqSDwO7glkOmmgtXuPdN
         aFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZUPDO3O3MdLQndirsYklPtGCkJIX8gUjBqVkzFLCdY8=;
        b=Pe4kwYPNRCBgoNksPJK3dnJE6/wmy54nPAjPaBdDaLI/A0cFZzGkIHNEDfY7ztrbtY
         VSOrBDY3Oq1C3G5qjWaqfVLcLTOZND4PJOoYzHnTiwz0p8JBDNP+FUzAJVutcRM2fMCq
         lUunIszewr30Dbs/5R8y7OwUDX0+KFpTgjGv7KZj7dxneYaD2vHKlAr758FcFrbyBq+H
         sqlQcETd9R+MR8Fuf/NxTDgsWXWZ2GeyfZdXMwHRbDxPTW0c/jt7krpkHB7Pbxe0pG3O
         aPXxVARcF/A210g3+iaMBZYc6hLUmauLQaCuSMTbSfKfZ438KwmDo9DWwiZ32rRG89Ho
         t/Wg==
X-Gm-Message-State: AOAM533uyIJye0zu+cHe6S/ZmPRc2F5OXxySi+7ywc2YbPI+YX0WSB33
        vrQE6tW1mq1QJjEYCKqOGDf5gg==
X-Google-Smtp-Source: ABdhPJxsZl7H+SSTAuq0Fdq5UlrDJT4gRHll1O9trs9Yov+tCT6KSwqD5BGSE9GCdu8oH9E+QPsYOg==
X-Received: by 2002:a2e:b52a:: with SMTP id z10mr18999913ljm.320.1617727034722;
        Tue, 06 Apr 2021 09:37:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f20sm2269428ljn.123.2021.04.06.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:37:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 51106101FF7; Tue,  6 Apr 2021 19:37:16 +0300 (+03)
Date:   Tue, 6 Apr 2021 19:37:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 21/26] x86/mm: Move force_dma_unencrypted() to common
 code
Message-ID: <20210406163716.zdf4vgcltj6a3tqt@box.shutemov.name>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <444fe9c7c035417f6abc3e0be2a4861cb573ab28.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d4eb7452-f6dd-2e0e-a790-76abdbbbfee9@intel.com>
 <20210406153755.evphkyms3bwo7scc@box>
 <8d551c07-1361-b431-6195-d81a08e9e83a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d551c07-1361-b431-6195-d81a08e9e83a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 09:11:25AM -0700, Dave Hansen wrote:
> On 4/6/21 8:37 AM, Kirill A. Shutemov wrote:
> > On Thu, Apr 01, 2021 at 01:06:29PM -0700, Dave Hansen wrote:
> >> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
> >>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >>>
> >>> Intel TDX doesn't allow VMM to access guest memory. Any memory that is
> >>> required for communication with VMM suppose to be shared explicitly by
> >>
> >> s/suppose to/must/
> > 
> > Right.
> > 
> >>> setting the bit in page table entry. The shared memory is similar to
> >>> unencrypted memory in AMD SME/SEV terminology.
> >>
> >> In addition to setting the page table bit, there's also a dance to go
> >> through to convert the memory.  Please mention the procedure here at
> >> least.  It's very different from SME.
> > 
> > "
> >   After setting the shared bit, the conversion must be completed with
> >   MapGPA TDVMALL. The call informs VMM about the conversion and makes it
> >   remove the GPA from the S-EPT mapping.
> > "
> 
> Where does the TDX module fit in here?

VMM must go through TLB Tracking Sequence which involves bunch of
SEAMCALLs. See 3.3.1.2 "Dynamic Page Removal (Private to Shared
Conversion)" of TDX Module spec.
> 
> >>> force_dma_unencrypted() has to return true for TDX guest. Move it out of
> >>> AMD SME code.
> >>
> >> You lost me here.  What does force_dma_unencrypted() have to do with
> >> host/guest shared memory?
> > 
> > "
> >   AMD SEV makes force_dma_unencrypted() return true which triggers
> >   set_memory_decrypted() calls on all DMA allocations. TDX will use the
> >   same code path to make DMA allocations shared.
> > "
> 
> SEV assumes that I/O devices can only do DMA to "decrypted" physical
> addresses without the C-bit set.  In order for the CPU to interact with
> this memory, the CPU needs a decrypted mapping.
> 
> TDX is similar.  TDX architecturally prevents access to private guest
> memory by anything other than the guest itself.  This means that any DMA
> buffers must be shared.
> 
> Right?

Yes.


-- 
 Kirill A. Shutemov
