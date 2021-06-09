Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74FE3A0AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhFIEEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFIEE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:04:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B5C3610A1;
        Wed,  9 Jun 2021 04:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623211355;
        bh=vG4MZxfZKKAdoDa8I1pKOegdBTS9SI6qjGNjRE+Y3xI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YYstf3DnnS6f/0+GrLOXK4nzyU5W6nT6O3AszfAKV09kcpG09VXBbFTjrnGGF5vdO
         oUMvMeiZRuSdzfMqE0r/Xtihm+J3EwbiszOmobbcMJ3C5YPrp3WKaWpQ1jhRGEJ4Hs
         dRNc5HmYZG7Mdj5kKCFlj+2F0J2F6a8g/xzMy0u/XLo+V7daRmQSMNx2DR4rTdcNv5
         9tm3Dde1P/+TgNdmtlhpvz95F/SqNuhPuL8XkTCc3UnnYRjqcvCs5KMRCSFEOgQqxf
         PkEokeYpWsUwcNq89+IatiPEiyl4bDy0TU0zxR5SeRgpX6HjFbIgRbHwKGqLTTUKFb
         1Adcc+mQa95Iw==
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
Date:   Tue, 8 Jun 2021 21:02:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 8:40 PM, Dan Williams wrote:
> On Tue, Jun 8, 2021 at 6:10 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> Current TDX spec does not have support to emulate the WBINVD
>> instruction. If any feature that uses WBINVD is enabled/used
>> in TDX guest, it will lead to un-handled #VE exception, which
>> will be handled as #GP fault.
>>
>> ACPI drivers also uses WBINVD instruction for cache flushes in
>> reboot or shutdown code path. Since TDX guest has requirement
>> to support shutdown feature, skip WBINVD instruction usage
>> in ACPI drivers for TDX guest.
> 
> This sounds awkward...
> 
>> Since cache is always coherent in TDX guests, making wbinvd as
> 
> This is incorrect, ACPI cache flushing is not about I/O or CPU coherency...
> 
>> noop should not cause any issues in above mentioned code path.
> 
> ..."should" is a famous last word...
> 
>> The end-behavior is the same as KVM guest (treat as noops).
> 
> ..."KVM gets away with it" is not a justification that TDX can stand
> on otherwise we would not be here fixing up ACPICA properly.
> 
> How about:
> 
> "TDX guests use standard ACPI mechanisms to signal sleep state entry
> (including reboot) to the host. The ACPI specification mandates WBINVD
> on any sleep state entry with the expectation that the platform is
> only responsible for maintaining the state of memory over sleep
> states, not preserving dirty data in any CPU caches. ACPI cache
> flushing requirements pre-date the advent of virtualization. Given TDX
> guest sleep state entry does not affect any host power rails it is not
> required to flush caches. The host is responsible for maintaining
> cache state over its own bare metal sleep state transitions that
> power-off the cache. If the host fails to manage caches over its sleep
> state transitions the guest..."
> 

I like this description, but shouldn't the logic be:

if (!CPUID has hypervisor bit set)
  wbinvd();

As far as I know, most hypervisors will turn WBINVD into a noop and,
even if they don't, it seems to be that something must be really quite
wrong for a guest to need to WBINVD for ACPI purposes.

-Andy
