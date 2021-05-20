Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D303A38B834
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhETUSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhETUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:18:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:16:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso6056231pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INMyeDv6bEn3F5q6tUUsTxPpOgMMj90uTo+ivTj0jug=;
        b=scg4Sz7KckDjkbQzbmob5HLOfhbNb8RD7yL1UAQXpsVMxj4frt3/2DbCZSSVTZRU90
         9jFQH3LXEcPsiYPgwYK06biS93xOuMdDVjZNdSLcX+DiokKY1nt6yOMdv+wERylOc9Vf
         k2Z8v+TrbiMY/KnUmDzUMwWlxv3IuipMQlzuKFnznp6z7YBRIg9DjpmcixpINQbeiDXF
         qPpSORxOS1FUVtnffAqXH00Fw8nsOb/NoZkOn6enLlz8aP3WQak1YbOckFEArOgQy+Ai
         rR2Bz9sIG/PTo7d+1UToVFrt4hQvyWDGbGOc//Yt8214EYjrKZsuV5LiSaMIqb5JhlKT
         9GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INMyeDv6bEn3F5q6tUUsTxPpOgMMj90uTo+ivTj0jug=;
        b=Gl51bA7JL5XfFpZ1V1FFt+r8Kod1SfGQIoC8xI1kSnmTvEHrP5PvKcMEsLHc7ZqsVS
         3mOxLmbxOjzLaDHhh1h69zW/J6WWCeTVQfq0xIK0AfPQjtuv99ukwtpB6fn+FVGIWe8j
         elCPpt+De13gQcxjLbQ+HzM5zHAe8Yq2tBRBsV+4MF0ATtTDBDBczqzaMVcV3bysbeGw
         MuFhtbQFTTBoq7xJg5dk1vMaKXIFhlCV3kIo7vdMhqpq/gcRZ87sEAnsjke4BoYI/qrF
         NnntN08nfFNZtvzj5iKVdYJLixR3gNva3VXJD4XjgeXWIoA4FIgfkhz2ZuJfxSE3qzy2
         Phlw==
X-Gm-Message-State: AOAM533C7qWIzi3wu9biUF+zP8vIrYwgKK/y+8+0lTc6+j/ACxiL2sIA
        h9n5AfYNuqxL9YYxJ3JrDuyolw==
X-Google-Smtp-Source: ABdhPJwZU+p/5/7noEHKI1hJt8g+DIdpz9UT/UYsc1TbLMQWxM3WE0WJ0zwRoWm7gBN6tZ7IDw3jMw==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr6825502pjr.166.1621541818367;
        Thu, 20 May 2021 13:16:58 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o134sm2614308pfd.58.2021.05.20.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 13:16:57 -0700 (PDT)
Date:   Thu, 20 May 2021 20:16:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
Message-ID: <YKbDtt2K4Z5gtYRc@google.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
 <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
 <YKa5gkwGTIUFpzzH@google.com>
 <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27a6d31-8fd9-e650-0adf-5f7a8fc96a1c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021, Kuppuswamy, Sathyanarayanan wrote:
> So what is your proposal? "tdx_guest_" / "tdx_host_" ?

  1. Abstract things where appropriate, e.g. I'm guessing there is a clever way
     to deal with the shared vs. private inversion and avoid tdg_shared_mask
     altogether.

  2. Steal what SEV-ES did for the #VC handlers and use ve_ as the prefix for
     handlers.

  3. Use tdx_ everywhere else and handle the conflicts on a case-by-case basis
     with a healthy dose of common sense.  E.g. there should be no need to worry
     about "static __cpuidle void tdg_safe_halt(void)" colliding because neither
     the guest nor KVM should be exposing tdx_safe_halt() outside of its
     compilation unit.
