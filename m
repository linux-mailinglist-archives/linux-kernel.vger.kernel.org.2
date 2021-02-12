Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3668331A621
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhBLUiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhBLUiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:38:07 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:37:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r2so441546plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j66JtDHKSYYacXhJ57b4zqjxRlOZnEcxF+9VBlahFek=;
        b=CqOjYfESwcESAZCqoaDy3zoo7YyZckVAYKVV/PK+2XaouNfrSmXWecHqTaiaHMe/a8
         7p4eTSpcXiS1CtvHiwBduKYgH/R6g8rANcQSikbxLfDr6d4I6sDwqPSVFlV9IaOTEKyA
         1rv3teKLA5/aYfs7Mw50AAJzwDrObXRdWE9YdmfmeQnTULAjALECsTjZ4L70ID/4wW4R
         3wZEAGTMUQI69NmUcCbccTzzgKPcqIJQgZpfptixtWq2Q3g8JktG85JPUtYgoq8HMoJy
         qNnIirq1PauaPrhJxjfDlERNnIs6A0EY6smhgYMQ4/xG8nU0e0gCJB5dmqy+63S4bgfo
         nhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j66JtDHKSYYacXhJ57b4zqjxRlOZnEcxF+9VBlahFek=;
        b=slxoWPhSXJ9g1q8xd85jB8egXelK054lyMTYpkyQdzJQvbfRVHFclgi/6KrPuTbiSA
         D4/IcsGKBHFDcfRg878UjnpqwoaLL1/ZNPTF1muMDdkAY7kRf1jx9IwXMSCiM3NWoCEf
         BVytnDjtk8ddBCiDIpE7ua1i9jqdOcRlriDIVlmCFTAZ1Qg8Hs1QA2PxDI9q7LJTIiEd
         vh6It9gmuUGgZt8NQyAKFEVRve1+NHbF/tEJEhfN2/L6jfShbWwbMZflJqdNoqIyOyNq
         dcZB7YIIrakXGi0hIt7SZU/0JFGKuUPrBdD8yNeIOPadIOeE+GgLgJ0Puu7aLqZ4eiLY
         Gp5g==
X-Gm-Message-State: AOAM531kSddZkG4WYgSCqikIZfsLijFWlYCbCKgdYc1tGYaWYmswEl7g
        xZMOojPKLQ6bYQiVOKSbj9Fhfw==
X-Google-Smtp-Source: ABdhPJwLZ9yg71nYuePsjWZyRrKAJwDr8Q9E/d/VGQFF6oKWD6sl6WSIZkzoYAG8inLgTxOAvczCFA==
X-Received: by 2002:a17:902:d886:b029:e1:7784:4db5 with SMTP id b6-20020a170902d886b02900e177844db5mr4407027plz.72.1613162245180;
        Fri, 12 Feb 2021 12:37:25 -0800 (PST)
Received: from google.com ([2620:15c:f:10:b407:1780:13d2:b27])
        by smtp.gmail.com with ESMTPSA id c15sm8572970pjc.46.2021.02.12.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:37:24 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:18 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YCbm/umiGUS7UuVb@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CALCETrWPCTmoeFBEJvw98zwNpw316Xii_16COZAWoYNC=obF+w@mail.gmail.com>
 <YCbfyde9jl7ti0Oz@google.com>
 <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c23bbfd-e371-a7cf-7f77-ec744181547b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021, Dave Hansen wrote:
> On 2/12/21 12:06 PM, Sean Christopherson wrote:
> >> What happens if the guest attempts to access a secure GPA that is not
> >> ACCEPTed?  For example, suppose the VMM does THH.MEM.PAGE.REMOVE on a secure
> >> address and the guest accesses it, via instruction fetch or data access.
> >> What happens?
> > Well, as currently written in the spec, it will generate an EPT violation and
> > the host will have no choice but to kill the guest.
> 
> That's actually perfect behavior from my perspective.  Host does
> something stupid.  Host gets left holding the pieces.  No enabling to do
> in the guest.
> 
> This doesn't *preclude* the possibility that the VMM and guest could
> establish a protocol to remove guest pages.  It just means that the host
> can't go it alone and that if they guest and host get out of sync, the
> guest dies.
> 
> In other words, I think I'm rooting for the docs, as written. :)

I tentatively agree that the host should not be able to remove pages without
guest approval, but that's not the only use case for #VE on EPT violations.
It's not even really an intended use case.

There needs to be a mechanism for lazy/deferred/on-demand acceptance of pages.
E.g. pre-accepting every page in a VM with hundreds of GB of memory will be
ridiculously slow.

#VE is the best option to do that:

  - Relatively sane re-entrancy semantics.
  - Hardware accelerated.
  - Doesn't require stealing an IRQ from the guest.
