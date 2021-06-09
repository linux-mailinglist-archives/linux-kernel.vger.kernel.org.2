Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E123A1A9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhFIQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhFIQOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A074613B1;
        Wed,  9 Jun 2021 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623255148;
        bh=PKcMvlnuCGLjsb4hOzK8hNIvlkQ5Y4RWi55WNvghvU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PPiPJw2ymMgctmPJluUp2SzAbWsrj2hTh3Tnt4XAxDDWmdQgLwek9UEmTsAf5S2PF
         +eLxnF2d6xXxPytI5wB4OUgY+JGAhXMbXwIUrnCRHPG48qNkgG5wjAF+QoTWfbtIQ5
         vx/ZiVVnk2LKEFDSQPvYY/q+j4ZBOr/E96pnl9o0PnAdHeOaa94zy3XruU8aUkEPUw
         nO2QTaA0v5EminN35R8cZqcSTgP1b+Mcn0Xi72cp21rRb1ycLV7yns8s2Rf+H/NoYl
         y03jBacciv5oDtT53eFnoN70bVYclsLsM+iLOlKd/pI7VsoP+Q5jf3b2neuDzO3MuO
         4n1/QOBRFsGLw==
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
 <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
 <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com>
 <CAPcyv4haWYhqk_xLD56QnB0ahK+fynOmqGdSD907UW-=7B176g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <c2f4254d-3d28-544a-efd2-e65dd40d99f1@kernel.org>
Date:   Wed, 9 Jun 2021 09:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4haWYhqk_xLD56QnB0ahK+fynOmqGdSD907UW-=7B176g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 8:09 AM, Dan Williams wrote:
> On Tue, Jun 8, 2021 at 9:27 PM Andi Kleen <ak@linux.intel.com> wrote:
>>
>>
>> here is no resume path.
>>
>>> Host is free to go into S3 independent of any guest state.
>>
>> Actually my understanding is that none of the systems which support TDX
>> support S3. S3 has been deprecated for a long time.
> 
> Ok, I wanted to imply any power state that might power-off caches.
> 
>>
>>
>>>   A hostile
>>> host is free to do just enough cache management so that it can resume
>>> from S3 while arranging for TDX guest dirty data to be lost. Does a
>>> TDX guest go fatal if the cache loses power?
>>
>> That would be a machine check, and yes it would be fatal.
> 
> Sounds good, so incorporating this and Andy's feedback:
> 
> "TDX guests, like other typical guests, use standard ACPI mechanisms
> to signal sleep state entry (including reboot) to the host. The ACPI
> specification mandates WBINVD on any sleep state entry with the
> expectation that the platform is only responsible for maintaining the
> state of memory over sleep states, not preserving dirty data in any
> CPU caches. ACPI cache flushing requirements pre-date the advent of
> virtualization. Given guest sleep state entry does not affect any host
> power rails it is not required to flush caches. The host is
> responsible for maintaining cache state over its own bare metal sleep
> state transitions that power-off the cache. A TDX guest, unlike a
> typical guest, will machine check if the CPU cache is powered off."
> 
> Andi, is that machine check behavior relative to power states
> mentioned in the docs?

I don't think there's anything about power states.  There is a general
documented mechanism to integrity-check TD guest memory, but it is *not*
replay-resistant.  So, if the guest dirties a cache line, and the cache
line is lost, it seems entirely plausible that the guest would get
silently corrupted.

I would argue that, if this happens, it's a host, TD module, or
architecture bug, and it's not the guest's fault.

--Andy
