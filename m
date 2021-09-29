Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B141CACB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344781AbhI2RAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344809AbhI2RAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:00:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5ACF613DA;
        Wed, 29 Sep 2021 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632934704;
        bh=q4dgtgHH+SOQqblaZiTZK7wKV7b2yiFarg51sd83ckI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JcY9Y8FqBZERBzXPm3S4fXyN6inna8kb+CnU5IpBO0rxpRiFjiv3r65E/tMIEUrY2
         LqMxp5k8j2KAyf5NIHvM6jcpCVkjhto8pBaq7kQI2j2scrj8vKcywTGw428dJi3STO
         vbwVmDgF8Uz7X6NWclc/SiTRwi22WKwM4zkVc0mtAsJB9dP84lXxnmo4V8g5N5abjE
         asN1CEN8yku11KWfT/n/0NkVl8Hf9pZQDU4cByXDROlTPmCZQGngn82j2s0o6dHW6L
         YIaij5UxY5T/ugctGR5WzTcQOEGk+dzMci29bxBUqMmk338T2axaQJsC9DeanwKCSA
         cfBPVnZ+aDpkQ==
Message-ID: <308a72e4-6aa9-0c84-21e6-ee613eea35a8@kernel.org>
Date:   Wed, 29 Sep 2021 09:58:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
 <1aae375d-3cd4-4ab8-9c64-9e387916e6c0@www.fastmail.com>
 <YVIxeBh3IKYYK711@agluck-desk2.amr.corp.intel.com>
 <035290e6-d914-a113-ea6c-e845d71069cf@intel.com>
 <YVNj8sm8iectc6iU@agluck-desk2.amr.corp.intel.com>
 <3f97b77e-a609-997b-3be7-f44ff7312b0d@intel.com>
 <YVN652x14dMgyE85@agluck-desk2.amr.corp.intel.com>
 <f6014b16-7b4c-cbb6-c975-1ec34092956f@intel.com>
 <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <YVOg7zgpdQlc7Zjt@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 16:10, Luck, Tony wrote:
> Moving beyond pseudo-code and into compiles-but-probably-broken-code.
> 
> 
> The intent of the functions below is that Fenghua should be able to
> do:
> 
> void fpu__pasid_write(u32 pasid)
> {
> 	u64 msr_val = pasid | MSR_IA32_PASID_VALID;
> 	struct ia32_pasid_state *addr;
> 
> 	addr = begin_update_one_xsave_feature(current, XFEATURE_PASID, true);
> 	addr->pasid = msr_val;
> 	finish_update_one_xsave_feature(current);
> }
> 

This gets gnarly because we would presumably like to optimize the case 
where we can do the update directly in registers.  I wonder if we can do 
it with a bit of macro magic in a somewhat generic way:

typedef fpu__pasid_type u32;

static inline void fpu__set_pasid_in_register(const u32 *value)
{
	wrmsr(...);
}

#define DEFINE_FPU_HELPER(name) \
static inline void fpu__set_##name(const fpu__##name##_type *val) \
{ \
	fpregs_lock(); \
	if (should write in memory) { \
		->xfeatures |= XFEATURE_##name; \
		ptr = get_xsave_addr(...); \
		memcpy(ptr, val, sizeof(*val)); \
		__fpu_invalidate_fpregs_state(...); \
	} else { \
		fpu__set_##name##_in_register(val); \
	} \
}
