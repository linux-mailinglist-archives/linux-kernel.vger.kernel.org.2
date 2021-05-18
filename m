Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48CA387FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbhERShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbhERShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:37:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:36:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso2028907pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzgFyTrmOOgigcmGYYikGxaNK4XgtChwrAVVbZtLX9o=;
        b=ggkSLbsBMYtIslwifxZeAUmdD16hUHocnlMQWIpdEVZGLXBsbrg9XyWMm1RMQApdhq
         OtE+qX6+rClBVQHIXI2Oaa8qNKgYbSkAr1Iv2fQzivdHEKA1HxD3eMpzwhT3DEAbNb6K
         3tX2KFT8rsc6iCheN4URUUa++15rMfQgRtN0g0lC9CRka4k8KAEyhmz4voa2BX+rRkuX
         oC9FRPzqxCktWi6xIITPBU0J/decMV562Hj3rfHapwl6mg6FGK1GUKBCjMBFd1k/seoo
         hB/Ki3YKwmMlE1Adik3esKvfZWCxQVbj4mEEEQq3i9bWMSl+H/6M/XR60lLL0kWRY3sa
         gdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzgFyTrmOOgigcmGYYikGxaNK4XgtChwrAVVbZtLX9o=;
        b=Mdm6uB05Q+oee5cLqs6/AMyPPz2C7hT2gtxYDbyR7MK7Z7YrFaqI4VSSzrxM5BA1Gs
         38Wgzc/R7dwPV6n56dwY2uOobiwdWltMnL/xYG2VAjHYZwvqG2xCkwB4ZUIB9cYiJySp
         IBaJszcUb6aAQKOOIkTBYnxqov8fL2ZpQDxtbvdulnwAFSTwD959thoIxTzRo6BJst/Y
         voFNw6bTWPUz2myAgo7A4InkbFelG14pOqF998EoUtbma2SbIN7VnxELroM7J9eIIA6h
         7AKgx6X9cUzO0DD0nxtjQu/sKyzlfoqDXbi5yvKeUpipDY7vvh4tRtzgSIvtckTZYZCU
         Ub2w==
X-Gm-Message-State: AOAM533kg88E4rN8PdmyTRhgvkXrIfX0j//vbVKqH0dbGPKhjePfD3pn
        MJn0FBm7mn6CebybNatxU1c3iA==
X-Google-Smtp-Source: ABdhPJy8NPfIvv9apV8oFlU1Pu9y3CBTRX//6PqoWH1TxZAJAKzJLtR4H25yUzTokKeWUJXwuf51Rg==
X-Received: by 2002:a17:902:a60f:b029:f0:c3c8:2e20 with SMTP id u15-20020a170902a60fb02900f0c3c82e20mr6060286plq.51.1621362986492;
        Tue, 18 May 2021 11:36:26 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id h18sm3517487pfr.49.2021.05.18.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:36:26 -0700 (PDT)
Date:   Tue, 18 May 2021 18:36:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Message-ID: <YKQJJvEV/dEm2qc3@google.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
 <d711ca30-ff84-2efa-4b9e-d9b46f53c0a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d711ca30-ff84-2efa-4b9e-d9b46f53c0a5@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Dave Hansen wrote:
> On 5/18/21 10:21 AM, Andi Kleen wrote:
> > Besides instruction decoding works fine for all the existing
> > hypervisors. All we really want to do is to do the same thing as KVM
> > would do.
> 
> Dumb question of the day: If you want to do the same thing that KVM
> does, why don't you share more code with KVM?  Wouldn't you, for
> instance, need to crack the same instruction opcodes?

Pulling in all pf KVM's emulator is a bad idea from a security perspective.  That
could be mitigated to some extent by teaching the emulator to emulate only select
instructions, but it'd still be much higher risk than a barebones guest-specific
implementations.  Because old Intel CPUs don't support unrestricted guest, the set
of instructions that KVM _can_ emulate in total is far, far larger than what is
needed for MMIO.

Allowed instructions aside, KVM needs to handle a large number things a TDX/SEV
guest does not, e.g. segmentation, CPUID model, A/D bit updates, and so on and
so forth.

Refactoring KVM's emulator would also be a monumental task.
