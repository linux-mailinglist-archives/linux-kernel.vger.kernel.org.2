Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4938E39A93B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFCRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhFCRdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:33:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14028600EF;
        Thu,  3 Jun 2021 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622741497;
        bh=CYn3EZTKJSh4MDX20btEjoQc2gajFSLKSEiCLpjOtyY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UAfQrL/7OJGOkvO3MmOhUAvtCeD/mHVyyYbGmRCp6YswxdYsZq38j7rp2gh0G4bhW
         L98RJBLj9EVzi9azrc/Av2CuAvjOzYOtDhxzLz819aT/E3Wm/eBofItZHJb+he3jFe
         gMhfZD35ABXCWbxTpPJMR4U3aAkVMD3MMzM9724UXggGSCuSLk95MHApGY0Vrnq435
         /Ql2LfZn30+bGoyfvo7j9QMIrgh83CLd7NlfSlJQORtxTenr6qxgIoe3eK8FcA/f0f
         WvyPBLVV1JHqbQ0MGwJOd3CStKpYjqJOFOiOhGphNIJ8I8AErF1fedToDDc5a7AOi3
         wPMrxiTypLfQQ==
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
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <db552f51-76ee-b7f5-20f1-14f1c703d423@kernel.org>
Date:   Thu, 3 Jun 2021 10:31:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <36866b38ec92425b879881a88acf547b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 1:37 PM, Luck, Tony wrote:
>>> ... so on a PASID system, your trivial reproducer would theoretically
>>> fire the same way and corrupt FPU state just as well.
>>
>> This is worse and you can't selftest it because the IPI can just hit in
>> the middle of _any_ FPU state operation and corrupt state.
> 
> That sounds like we should abandon the "IPI all the other threads
> to force enable the PASID for them" approach. It would just be a
> nightmare of papering over cracks when the IPI was delivered at
> some inconvenient moment when the recipient was in the middle
> of touching xsave state.
> 
> I've told Fenghua to dig out the previous iteration of this patch where
> the plan was to lazily fix the PASID_MSR in other threads in the #GP
> handler.

Blech.  Also this won't work for other PASID-like features.

I have a half-written patch to fix this up for real.  Stay tuned.

> Seems like a better direction than trying to fix the IPI method. The virtualization
> folks will like this way more because IPI in guest causes a couple of VMEXIT
> so is somewhat expensive.

It happens at most once per PASID-using process.

