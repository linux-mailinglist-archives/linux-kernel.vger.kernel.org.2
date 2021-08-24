Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939F23F5C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhHXKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236365AbhHXKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:49:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0597C61248;
        Tue, 24 Aug 2021 10:49:03 +0000 (UTC)
Date:   Tue, 24 Aug 2021 11:49:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
Subject: Re: [PATCH 5/5] arm64: Document the requirement for SCR_EL3.HCE
Message-ID: <20210824104900.GB623@arm.com>
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-6-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812190213.2601506-6-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 08:02:13PM +0100, Marc Zyngier wrote:
> It is amazing that we never documented this absolutely basic
> requirement: if you boot the kernel at EL2, you'd better
> enable the HVC instruction from EL3.
> 
> Really, just do it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  Documentation/arm64/booting.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
> index a9192e7a231b..6c729d0c4bc2 100644
> --- a/Documentation/arm64/booting.rst
> +++ b/Documentation/arm64/booting.rst
> @@ -212,6 +212,11 @@ Before jumping into the kernel, the following conditions must be met:
>    - The value of SCR_EL3.FIQ must be the same as the one present at boot
>      time whenever the kernel is executing.
>  
> +  For all systems:
> +  - If EL3 is present and the kernel is entered at EL2:
> +
> +    - SCR_EL3.HCE (bit 8) must be initialised to 0b1.
> +
>    For systems with a GICv3 interrupt controller to be used in v3 mode:
>    - If EL3 is present:

I'll queue this patch only for now.

A nitpick, I think we should move "For all systems" and "If EL3 is
present..." above the lines describing the SCR_EL3.FIQ requirement (I
can make the change locally).

-- 
Catalin
