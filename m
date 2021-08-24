Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8983F6913
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhHXS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:29:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35196 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhHXS3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:29:21 -0400
Received: from zn.tnic (p200300ec2f114400ce3b938495d443bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:ce3b:9384:95d4:43bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FDA01EC01FC;
        Tue, 24 Aug 2021 20:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629829712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1CrpKVTwPr11Dgq3US6aXtIGvoXycWFbFQqpZ8MNzig=;
        b=IPmBkmoeu7qxRc5dI3tfV9gNBwU8/eMZ/9svvCG9K9Z9rQKEDZS8YY1wkYx0lQiPRtzN+J
        hZeIkd/5knezu+iac+hHoS3SznsSlU69D1m4CqkvWUeKWGMyz2QnCp/rlhj4dSslLnh0G2
        i/8FI0ekd0HZZLkjzzlpEnS3VqBpC+4=
Date:   Tue, 24 Aug 2021 20:29:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] x86/tdx: Wire up KVM hypercalls
Message-ID: <YSU6eixLyNdESBe9@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-10-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUfpQPvL6wsk6Ou@zn.tnic>
 <8ccbf970-fd4f-b1ea-ac85-98acfe296b00@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ccbf970-fd4f-b1ea-ac85-98acfe296b00@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:11:43AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Since TDX code can be used by other hypervisor (non KVM case) we
> want to have a config to differentiate the KVM related calls.

You need to start explaining yourself better. WTH does "to differentiate
the KVM related calls" even mean? Differentiate for what?!

Our CONFIG space is a huuge mess. Adding another option better be
properly justified.

> Compiler raised version generation issue for __tdx_hypercall

-ENOTENOUGHINFO.

Try again.

> Yes. I will fix this in next version.

And here audit all your patchsets. All exports better be _GPL.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
