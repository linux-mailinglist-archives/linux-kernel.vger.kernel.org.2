Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828EF37EEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442791AbhELWNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:13:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33946 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390419AbhELVGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 17:06:54 -0400
Received: from zn.tnic (p200300ec2f0bb800dc83a7b830fce185.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b800:dc83:a7b8:30fc:e185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECD991EC04DE;
        Wed, 12 May 2021 23:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620853543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hwvjlzB9ZjQc1MjZx7Xbk0cwBahbwiqW8zWrf9aO+jg=;
        b=DE6dG2qA9Ee5FoEoNTxlkh7vTDoLsFsYzlzTg3x8Yo6Z4hs2P3t/1hv2VWeVPzzNxn0n5Q
        NqFAH3FfVY8mNRGAk1CXNeZr6h2Cvaah3JN6M9Y034HIVl6OzLHbKn+BmV0nXl3rWr6P1U
        jcOqYpxlriw0LtFrwqqBeSG6Jy5MloU=
Date:   Wed, 12 May 2021 23:05:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJxDIhGnZ5XdukiS@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 07:00:58PM +0000, Joshi, Mukul wrote:
> SMCA UMCv2 corresponds to GPU's UMC MCA bank and the GPU driver is
> only interested in errors on GPU UMC.

So that thing should be called SMCA_GPU_UMC not SMCA_UMC_V2.

> We cannot know this without is_smca_umc_v2.

You don't need it - just export smca_get_bank_type() and test the bank
type at the call site.

> Maybe. I hope its not too much of a concern if it stays the way it is.

That was just a suggestion anyway - it is not code I maintain so not my
call.

> I wasn't really sure if I should use the EDAC priority here or create a new one for Accelerator devices.
> I thought using EDAC priority might not be accepted by the maintainers as EDAC and GPU (Accelerator) devices
> are two different class of devices.
> That is the reason I create a new one. 
> I am OK to use EDAC priority if that is acceptable.

I don't know what's acceptable because I still am unclear as to what
that thing is supposed to do. It seems you are interested only in
uncorrectable errors.

How are those errors reported? #MC exception, deferred interrupt, simply
logged in the bank and we find them by polling?

Then, the commit message is talking about some "bad page retirement".
What does that do? What can the user do when she sees the

"Uncorrectable error detected in UMC..."

message?

It depends on what "retiring" of GPU pages means...

In any case, dmesg should issue a human-understandable message about the
recovery action being done and what that means for the user: should she
replace the GPU, should she ignore, etc, etc.

> A system can have multiple GPUs and we only want a single notifier
> registered. I will change the comment to explicitly state this.

Actually, the notifier registration should be able to return a different
retval to state that a callback has already been registered but that
warns only currently so I'm guessing we're stuck with such ugly
"workarounds" for their shortcomings.

I'm gonna take a look whether they can be fixed though so that you don't
have to do this notifier_registered thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
