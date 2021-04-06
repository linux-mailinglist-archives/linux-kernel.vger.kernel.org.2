Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A471E3558AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbhDFQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhDFQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:00:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF30C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:00:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c6so15608579lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=01FrvamDTOlQo6YpIArOTKq2pYe+iptFF3nuPSQe+e0=;
        b=a3dTzU3AAb+iP9P2EzxBaBW2xQH3qM5D5CI5oaFYWeIEsgFdF/l6+HTOQobFcuMVVl
         +p7WKeF3WN9fUIlfX7ER0su4M5VAdPWFp/uw5t7hPLZc5cZlQlWq8QIiyHSMyKEuzUEt
         o8j1K/y679zZ7Xo7zhXvqt8reguWRmw384vuxVzTVHsTIWkRDcqJRp0SdjtDwMONo9u+
         5OGJGOEJENOJFjcF5m3oh+/AvG1yyoTpe3nxSSb/X5jJhRbTrUZ6COHd+zGCHxqLWZBE
         6SboLEnT7lJf8VQLr9V5o7UMUUq79CtMRcmmRekaXxaWmXnONRk4lrBHwrTcDI07wHjY
         eNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=01FrvamDTOlQo6YpIArOTKq2pYe+iptFF3nuPSQe+e0=;
        b=TRCvSb2ZN+ZF7RkG4BTrGF62OtRrJgz/HEMeUq8WkoyeJSkYQxaXcSh3zngD0jjuEC
         iU/dGz7oAS7civI+M3+2QWeNt9VeL1OHD8MlwBKCO/iUBR2qs5EeJUxYI/EU9Ewrc+e+
         bk/zt5RHMjJ1WdTxN3sYGHEAoE4ZcUH+wT99LP3CfS0uTMMP6IB/g+KMq+vwRx4ucMf/
         aSxhtKDylNpymNIaUK8J4d/yd+wA2+IvLMNOJfVDZ3wRXwhoXb8Q2Ckc+PRMfp7RIebn
         By8sUJDXNj85bgDC1f50U/ZQSb1xD+PH/JBwKbnVr0OSjmOBkYbullVuhUY69tPs1oI5
         KqFw==
X-Gm-Message-State: AOAM533myzHAprmWO7mRAIEOnQVOxxFdF/Bv1XYhpFqipn+Nsdsmc2BZ
        pKydDNq/FIx6UNwjRbvJyZ1oaw==
X-Google-Smtp-Source: ABdhPJynsZAPPW0wA3ISMZdlq+gqnh8wDztmwNbyjQnsCx/JTW5zTQ1TWsE3n8nS3wgjjFDWOg7vYA==
X-Received: by 2002:a2e:b896:: with SMTP id r22mr18877720ljp.174.1617724814315;
        Tue, 06 Apr 2021 09:00:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z1sm2280028ljo.134.2021.04.06.09.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:00:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7F375101FF7; Tue,  6 Apr 2021 19:00:16 +0300 (+03)
Date:   Tue, 6 Apr 2021 19:00:16 +0300
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
Subject: Re: [RFC v1 23/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20210406160016.4rwy5pxojpohmspn@box>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <33ced467eae950bc3df9e1f01284036fd560d33c.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <17c692a8-72b3-526b-9190-8c41655fa13c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c692a8-72b3-526b-9190-8c41655fa13c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:26:23PM -0700, Dave Hansen wrote:
> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > All ioremap()ed paged that are not backed by normal memory (NONE or
> > RESERVED) have to be mapped as shared.
> 
> s/paged/pages/
> 
> 
> > +/* Make the page accesable by VMM */
> > +#define pgprot_tdx_shared(prot) __pgprot(pgprot_val(prot) | tdx_shared_mask())
> > +
> >  #ifndef __ASSEMBLY__
> >  #include <asm/x86_init.h>
> >  #include <asm/fpu/xstate.h>
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index 9e5ccc56f8e0..a0ba760866d4 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -87,12 +87,12 @@ static unsigned int __ioremap_check_ram(struct resource *res)
> >  }
> >  
> >  /*
> > - * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
> > - * there the whole memory is already encrypted.
> > + * In a SEV or TDX guest, NONE and RESERVED should not be mapped encrypted (or
> > + * private in TDX case) because there the whole memory is already encrypted.
> >   */
> 
> But doesn't this mean that we can't ioremap() normal memory?

It's not allowed anyway: see (io_desc.flags & IORES_MAP_SYSTEM_RAM) in the
__ioremap_caller().


> I was somehow expecting that we would need to do this for some
> host<->guest communication pages.

It goes though DMA API, not ioremap().

-- 
 Kirill A. Shutemov
