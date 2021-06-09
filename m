Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D823A20D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFIXg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:36:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8478613EA;
        Wed,  9 Jun 2021 23:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623281672;
        bh=v/OMLrZ7k1ho5plhz+nTklqFfax/AAUTQJ3FLEHqrb0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r9XhoTnmXYMSJWHKIs4KYbb8PWWQYhZlDxwpUA22hukjgfvytH2lFZD4XcBmLtMjF
         j0817xJ70upRSk0Ooh8FXVR4T54Kpo7OjI5dPSI33iXoAV3PN3VmKzYGuEUN2hLyeV
         J0ePjL2Cq9nCeturi+r/eUzOTYRLYPeYqPr3629SglOJfmYpIqtC1M/OD6zFgLSpat
         VJA6gtDMJNrjiaXaJbYZ7u6lQjaVV9W+TS0fi+wTmGeDpczh0uDBthEcJ7gbyfAaAg
         885L/ML0f2Xnh4Afw7IXB8whR5z3zfNUFzK1qY8M4nyKB21xt8VmQGffXUTneBMTjn
         o34O/maI4AiDg==
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
To:     "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLShmFEzddfm7WQs@zn.tnic>
 <87y2bv438p.ffs@nanos.tec.linutronix.de>
 <36866b38ec92425b879881a88acf547b@intel.com>
 <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
 <7d8788a9e04d4901a03bcea11e8e842b@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <bd5bb38c-0b81-a302-dd20-ef56fd970c9e@kernel.org>
Date:   Wed, 9 Jun 2021 16:34:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7d8788a9e04d4901a03bcea11e8e842b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 10:32 AM, Luck, Tony wrote:
>>> I've told Fenghua to dig out the previous iteration of this patch where
>>> the plan was to lazily fix the PASID_MSR in other threads in the #GP
>>> handler.
>>
>> Blech.  Also this won't work for other PASID-like features.
>>
>> I have a half-written patch to fix this up for real.  Stay tuned.
> 
> Andy: Any update on this?
> 
> -Tony
> 

Let me try to merge my pile with tglx's pile and come up with something
halfway sane.
