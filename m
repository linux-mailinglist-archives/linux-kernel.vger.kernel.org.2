Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25938B8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhETVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhETVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:20:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE547C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:18:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x18so9033555pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ccUeVdViKeAHhCwYNh1t4eJp3ekIpRE9ztcvr+pqXc8=;
        b=wHSWVnXz7FivIq9wwjhEq7H+1ZNnLKgaemEzla6XyLgWEct/MOsvUJymSra75uuhgV
         1+gk414c8cimmRpUwYDhVxtZ8Ynp/9ZYSl32/dOXJK3AjijgD7h4oVMLKs+cDSpbtnla
         0f6KSQVA/iQebQe5bcCphM5b4J5Bsv00odQTXNj/m4aOdNFJlBt1ikxyUEfe6MqyVqzF
         WPFC3FbTkma2OxzT2Wq/qsAjqMQ9czWQ8OqvogSFMLBCHk8SXpbd7iSF1R1v8BzaBaBf
         RWe/sqy3LlO9fcj2q1W5buP4TO7Mc2myjyaGcprt/ZcPZFCBk10g/a8rNBCR3kthPkoY
         V9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ccUeVdViKeAHhCwYNh1t4eJp3ekIpRE9ztcvr+pqXc8=;
        b=j9sYN17QCtaI7yjoD6GCGj8MnPyCvZt0XqY6PSg6a3+mnNS/1+6/ObY/8Ol+QyYl2t
         xCmDad6xOp4241ZQS2GIHWYkWBJNLZpBfXc66vIUuXemh0oCxBvAs/hINolQ8KMecIKD
         Wzo7dsWcGft0ia0cUzSxD8L93VKmuQUAS7AkY4tJDBqQLQ34AuW7kNho4SeIn/ho/+LS
         KjCO5g0YBUzJQHDyD7x6LEsejAp2h3jvYjWD6ncu0sgC8gkVerNErm0K1/0EVQO0H3RR
         QCQWuh3TFkVptXb03wNETo+EzOBgpVI10iR5Y/GDfdYE1jJOHLa6EuER/j4OI/pbuYC5
         Yb0g==
X-Gm-Message-State: AOAM533bqwsAgSrgRQ5rI+EGTJl5lBzMAci4kN3ZToZki/VvlrLiy4xs
        85uMpbjjAmKT9zQwl9YMiFbHpQ==
X-Google-Smtp-Source: ABdhPJy9aPHb7LXaplw0gOqtT27ArNn1jdSYM+AVIoHeegNo0xuNnque25d78YpiEURAul3CoP2ScQ==
X-Received: by 2002:a05:6a00:22c1:b029:2dc:edbe:5e9 with SMTP id f1-20020a056a0022c1b02902dcedbe05e9mr6429268pfj.51.1621545532278;
        Thu, 20 May 2021 14:18:52 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id h8sm2369266pfv.60.2021.05.20.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:18:51 -0700 (PDT)
Date:   Thu, 20 May 2021 21:18:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
Message-ID: <YKbSOJOKBV1Rjb0T@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
 <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
 <YKbDtt2K4Z5gtYRc@google.com>
 <f348c391-c665-2987-898c-718d2c53729f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f348c391-c665-2987-898c-718d2c53729f@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021, Andi Kleen wrote:
> 
> On 5/20/2021 1:16 PM, Sean Christopherson wrote:
> > On Thu, May 20, 2021, Kuppuswamy, Sathyanarayanan wrote:
> > > So what is your proposal? "tdx_guest_" / "tdx_host_" ?
> >    1. Abstract things where appropriate, e.g. I'm guessing there is a clever way
> >       to deal with the shared vs. private inversion and avoid tdg_shared_mask
> >       altogether.
> > 
> >    2. Steal what SEV-ES did for the #VC handlers and use ve_ as the prefix for
> >       handlers.
> > 
> >    3. Use tdx_ everywhere else and handle the conflicts on a case-by-case basis
> >       with a healthy dose of common sense.  E.g. there should be no need to worry
> >       about "static __cpuidle void tdg_safe_halt(void)" colliding because neither
> >       the guest nor KVM should be exposing tdx_safe_halt() outside of its
> >       compilation unit.
> 
> 
> Sorry Sean, but your suggestion is against all good code hygiene practices.
> Normally we try to pick unique prefixes for every module, and trying to
> coordinate with lots of other code that is maintained by other people is
> just a long term recipe for annoying merging problems.  Same with
> coordinating with SEV-ES for ve_.

For ve_?  SEV-ES uses vc_...

I'd buy that argument if series as a whole was consistent, but there are
individual function prototypes that aren't consistent, e.g.

+static int __tdg_map_gpa(phys_addr_t gpa, int numpages,
+                        enum tdx_map_type map_type)

a number of functions that use tdx_ isntead of tdg_ (I'll give y'all a break on
is_tdx_guest()), the files are all tdx.{c,h}, the shortlogs all use x86/tdx, the
comments all use TDX, and so on and so forth.

I understand the desire to have a unique prefix, but tdg is is _too_ close to
tdx.  I don't want to spend the next N years wondering if tdg is a typo or intended.
