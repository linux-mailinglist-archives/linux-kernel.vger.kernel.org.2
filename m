Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9B45A23C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhKWMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:14:09 -0500
Received: from foss.arm.com ([217.140.110.172]:51770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhKWMOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:14:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E824147A;
        Tue, 23 Nov 2021 04:10:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04F373F5A1;
        Tue, 23 Nov 2021 04:10:57 -0800 (PST)
Date:   Tue, 23 Nov 2021 12:10:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        james.hsu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: update compiler option for PAC
Message-ID: <20211123121055.GD37253@lakrids.cambridge.arm.com>
References: <20211115031810.29701-1-Kuan-Ying.Lee@mediatek.com>
 <20211116101147.GB9851@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116101147.GB9851@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:11:47AM +0000, Will Deacon wrote:
> On Mon, Nov 15, 2021 at 11:18:08AM +0800, Kuan-Ying Lee wrote:
> > We pass -mbranch-protection=pac-ret+leaf to support PAC
> > when we use GCC 9 or later.
> > 
> > Before GCC 9, we pass -msign-return-address=all to support
> > PAC.
> > 
> > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > ---
> >  Documentation/arm64/pointer-authentication.rst | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
> > index f127666ea3a8..055d08b0d42d 100644
> > --- a/Documentation/arm64/pointer-authentication.rst
> > +++ b/Documentation/arm64/pointer-authentication.rst
> > @@ -54,8 +54,10 @@ virtual address size configured by the kernel. For example, with a
> >  virtual address size of 48, the PAC is 7 bits wide.
> >  
> >  Recent versions of GCC can compile code with APIAKey-based return
> > -address protection when passed the -msign-return-address option. This
> > -uses instructions in the HINT space (unless -march=armv8.3-a or higher
> > +address protection when passed compiler option as following.
> > +Pass -msign-return-address when we use GCC 7, 8.
> > +Pass -mbranch-protection when we use GCC 9 or later.
> > +This uses instructions in the HINT space (unless -march=armv8.3-a or higher
> >  is also passed), and such code can run on systems without the pointer
> >  authentication extension.
> 
> I think I'd be more inclined to delete this paragraph altogether. It doesn't
> really document anything to do with the kernel, and trying to document the
> behaviour of "recent" versions of GCC is futile.

Agreed. I think the only thing we might want to mention is that we rely
on the compiler to use the HINT space instructions (PACIASP and AUTIASP)
so that a kernel built with pointer authentication support works on HW
without the feature.

So replacing that paragraph with something like:

| When ARM64_PTR_AUTH_KERNEL is selected the kernel will be compiled
| with HINT space pointer authentication instructions protecting
| function returns. Kernels built with this option will work on
| hardware with or without pointer authentication support.

... would make sense to me.

Thanks,
Mark.
