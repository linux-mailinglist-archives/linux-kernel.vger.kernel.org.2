Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11F43F5C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhHXKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:52:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236150AbhHXKwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:52:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF4BB101E;
        Tue, 24 Aug 2021 03:52:07 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56C5D3F66F;
        Tue, 24 Aug 2021 03:52:05 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:52:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: Re: [PATCH 5/5] arm64: Document the requirement for SCR_EL3.HCE
Message-ID: <20210824105202.GB96738@C02TD0UTHF1T.local>
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-6-maz@kernel.org>
 <20210824104900.GB623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824104900.GB623@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:49:01AM +0100, Catalin Marinas wrote:
> On Thu, Aug 12, 2021 at 08:02:13PM +0100, Marc Zyngier wrote:
> > It is amazing that we never documented this absolutely basic
> > requirement: if you boot the kernel at EL2, you'd better
> > enable the HVC instruction from EL3.
> > 
> > Really, just do it.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  Documentation/arm64/booting.rst | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> > index a9192e7a231b..6c729d0c4bc2 100644
> > --- a/Documentation/arm64/booting.rst
> > +++ b/Documentation/arm64/booting.rst
> > @@ -212,6 +212,11 @@ Before jumping into the kernel, the following conditions must be met:
> >    - The value of SCR_EL3.FIQ must be the same as the one present at boot
> >      time whenever the kernel is executing.
> >  
> > +  For all systems:
> > +  - If EL3 is present and the kernel is entered at EL2:
> > +
> > +    - SCR_EL3.HCE (bit 8) must be initialised to 0b1.
> > +
> >    For systems with a GICv3 interrupt controller to be used in v3 mode:
> >    - If EL3 is present:
> 
> I'll queue this patch only for now.
> 
> A nitpick, I think we should move "For all systems" and "If EL3 is
> present..." above the lines describing the SCR_EL3.FIQ requirement (I
> can make the change locally).


FWIW, with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
