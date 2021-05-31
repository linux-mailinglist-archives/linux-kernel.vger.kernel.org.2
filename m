Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8421396964
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEaVrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhEaVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:47:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04534C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:45:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j10so18543547lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qxO63qoHQwurgZn2XoPEjYIcN+mFHhGbtbIXjdWc0v8=;
        b=s7Ix4VKhqB4K4zrqzeVaacfC669p+djkG/lfczT6PN7qOCyyYq37aTWwl04BLXAi2E
         QYrw6UBqb9tsWOxvXSo6xa4gU522ZmxaGtWWVDibayFJFUhOtcPSCV9MuCNUYQEQskVa
         Y+N9geS1Mm4spybentJwStERMGevge7iXLgz8Hm2JDJZ1PxBdpUZ+tOr6eaADm5DzPjB
         5OhN73XGcV7BXMMnBUP/s5POQ3c4vpcNJhUVYnMQsDmAYHGXMks9U02WBmAlzrsgAidK
         PvTMIVH5dhG4McSMfIFp1GnCs955BUowhYIgbkPdgrgsraNPSZrDpNA26MT8szV+W+QA
         4eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qxO63qoHQwurgZn2XoPEjYIcN+mFHhGbtbIXjdWc0v8=;
        b=g0EVF2cb1YSgxeQU3viAaIAdWQZNHhUifLFEkL1E3RIEko8sO2y+X/berwoex4dDNV
         YUbG6d0yZ4B+/44+F1c++hv3CH4mIJ3pfMXrNK9p7VTSNyjDbRyOKzEjeS42lYGJHEiT
         vyK+P4b4MTD6yPlFZJHjdHH3Hs0cLAMm/UPQRBgfAhZ40MK6XpzsGRs4RDUkltcG2XpM
         K47+TXPuZAk6au3YAJmwG5uO/2S65j634GVRFq9grUIOW6vtUrmuDSyviiF4Nos13vPR
         hnZIjzBxymotHOd4NZ2jOmSa0f2QLyjUvZFtHz1uZIcL/ljsJpBI5tBcm4a4LryDgJoD
         CXdg==
X-Gm-Message-State: AOAM531K6my5j4iycAqOlsiYDJcGLomBMVZzjm64iUoAT95kczQnX3tK
        aByVyWyJQtrfNYtTytuyqvUwdg==
X-Google-Smtp-Source: ABdhPJxN5uvnbzD4co0OiX5VpzimnQi+kjJPeWlWUJTkNTCi6HgBNamO4Pb782asIGWrp3CMhI0ZFA==
X-Received: by 2002:ac2:5cc4:: with SMTP id f4mr15592327lfq.83.1622497553249;
        Mon, 31 May 2021 14:45:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e8sm1035101ljj.28.2021.05.31.14.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 14:45:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A3E781027C1; Tue,  1 Jun 2021 00:46:02 +0300 (+03)
Date:   Tue, 1 Jun 2021 00:46:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
Message-ID: <20210531214602.qd6r63s5jbr4vcm5@box>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
 <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
 <YKbDtt2K4Z5gtYRc@google.com>
 <e257f5fa-e209-8a5b-659c-129abb72be42@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e257f5fa-e209-8a5b-659c-129abb72be42@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:56:13PM -0700, Dave Hansen wrote:
> On 5/20/21 1:16 PM, Sean Christopherson wrote:
> > On Thu, May 20, 2021, Kuppuswamy, Sathyanarayanan wrote:
> >> So what is your proposal? "tdx_guest_" / "tdx_host_" ?
> >   1. Abstract things where appropriate, e.g. I'm guessing there is a clever way
> >      to deal with the shared vs. private inversion and avoid tdg_shared_mask
> >      altogether.
> 
> One example here would be to keep a structure like:
> 
> struct protected_mem_config
> {
> 	unsigned long p_set_bits;
> 	unsigned long p_clear_bits;
> }
> 
> Where 'p_set_bits' are the bits that need to be set to establish memory
> protection and 'p_clear_bits' are the bits that need to be cleared.
> physical_mask would clear both of them:
> 
> 	physical_mask &= ~(pmc.p_set_bits & pmc.p_set_bits);

For me it looks like an abstraction for sake of abstraction. More levels
of indirection without clear benefit. It doesn't add any more readability:
would you know what 'p_set_bits' stands for in two month? I'm not sure.

I would rather leave explicit check for protection flavour. It provides
better context for a reader.

-- 
 Kirill A. Shutemov
