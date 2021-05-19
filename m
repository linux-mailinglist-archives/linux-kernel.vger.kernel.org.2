Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1F389789
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhESULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhESULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:11:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:09:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so4023768pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SdBCXg0gqh5qnS8uVaYaL/GELEQlApKoiEiviwsxCNE=;
        b=ShUap1zVSjEf5c9tIcb8T3dxQtq7M5Bf5oSNZC70CMZkV8qiu6KLwlh8zkYnbIdlbQ
         3VVxpXSmlTvPSS0MA1yYxv4e/bUwretCF7OcceYfg8wDgMQG9akv8wKhqry2IPz3LhiG
         5xdRxgMacXaYyaBNXh7uLCPDi6m/Q4OvLmYBMYBrSYbYILDPdMMokt7QcwIedJzkAsXC
         n1vrdyaCPOz54iZSqlfIkvvFiDmRrc1IyW7R3bPTyXODiSijpX5h7WhINw0c2jsqbTHt
         MY+Xepc/OYTPE3ePBcGYftHF89DfPCfCZmSgTlpaAbr1mEjSuK0r7zTI++WtkE35lxnq
         peDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SdBCXg0gqh5qnS8uVaYaL/GELEQlApKoiEiviwsxCNE=;
        b=nYawKG6kPKv1Hn4xJ96JgDOyTVATTMoTA5JyHtwbuAAyydup69C41NoTU4uRKsA2kq
         AhrwS0KLxTtQjF9eAzIM4f2U+yaH4qDh158a4Q6ec2P+sUBGr3L/s3ihGoY+51fkveXG
         p9QkQ6ET1v7HxZuZD+HmCsW3/7JkashAv/HAw1AydVPAU0+xuzQxIU/rqnKYR9nZOWy6
         RMR0/bwXX4ev6cbJK+S53VwNbNHKhJcHZiQLAWNL9CEuLaAsn5v+SaF9LJ/HrCtkfhGq
         TeadTupLgU/Q7K0Nuc6LXUzV2xwt3tqrzgmTY/CXb4lYqirug+MaSC25T1iGWpVf+N9O
         AR9A==
X-Gm-Message-State: AOAM5313DXpCjxyweqzhhfQRbj3VVWDmsIPzWGB/x6JTKvhLprnDYu0p
        wT0Vt3tuyXwfuk6hgw9GGMpwEQ==
X-Google-Smtp-Source: ABdhPJxXK/eJ26z3grljj5l3eAFKlAK40W4bHhSwTd7WDrWw3mop42KK2OsbDnBhkd1i6B3JJaySRw==
X-Received: by 2002:a17:902:854b:b029:f0:b966:1ee6 with SMTP id d11-20020a170902854bb02900f0b9661ee6mr1496588plo.50.1621454993416;
        Wed, 19 May 2021 13:09:53 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w123sm183702pfw.151.2021.05.19.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:09:52 -0700 (PDT)
Date:   Wed, 19 May 2021 20:09:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix-v1 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YKVwjdspTazTXlam@google.com>
References: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
 <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <568d2929-f366-e3be-96f9-0bfa91991ef2@intel.com>
 <02e7b229-4b6f-c1c7-bb63-48e5e9eca5db@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e7b229-4b6f-c1c7-bb63-48e5e9eca5db@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021, Kuppuswamy, Sathyanarayanan wrote:
> 
> On 5/19/21 8:31 AM, Dave Hansen wrote:
> > Was this "older compiler" argument really the reason?
> 
> It is a speculation. I haven't tried to reproduce it with old compiler. So
> I have removed that point.

It's not "older" compilers.  gcc does not support R8-R15 as input/output
constraints, which means inline asm needs to do register shenanigans, and those
are horribly fragile because the compiler does not ensure register variables are
preserved outside of asm blobs.  E.g. adding a print like so can corrupt r10,
which makes it an absolute nightmare to debug/trace flows that pass r8-r15 to
asm blobs since looking at the code the wrong way can break things.

	register unsigned long r10 asm("r10") = __r10;

	pr_info("TDCALL: RAX = %lx, R10 = %lx\n", rax, __r10);

	asm volatile("tdcall"
		     : "=a"(rax) :
		     : "a"(rax), "r"(r10));
