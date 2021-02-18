Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9C31EDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhBRSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:02:48 -0500
Received: from foss.arm.com ([217.140.110.172]:52464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232284AbhBRP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:27:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8F81ED1;
        Thu, 18 Feb 2021 07:26:27 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.48.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DAA73F73D;
        Thu, 18 Feb 2021 07:26:24 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:26:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 08/25] arm64: Always keep DAIF.[IF] in sync
Message-ID: <20210218152618.GA91307@C02TD0UTHF1T.local>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-9-marcan@marcan.st>
 <20210217122200.GC5556@C02TD0UTHF1T.local>
 <e88fa913-e2ae-35d0-056f-2a5079babbc2@marcan.st>
 <20210218142205.GB89209@C02TD0UTHF1T.local>
 <e66a9d0d-1127-c755-8bd7-7deedca1f3f3@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66a9d0d-1127-c755-8bd7-7deedca1f3f3@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:42:01PM +0900, Hector Martin wrote:
> On 18/02/2021 23.22, Mark Rutland wrote:
> > I think that for consistency we always want to keep IRQ and FIQ in-sync,
> > even when using GIC priorities. So when handling a pseudo-NMI we should
> > unmask DAIF.DA and leave DAIF.IF masked.
> 
> In that case there's one more, in daifflags.h:local_daif_restore():
> 
> 			/*
> 			 * If interrupts are disabled but we can take
> 			 * asynchronous errors, we can take NMIs
> 			 */
> 			flags &= PSR_I_BIT;
> 			pmr = GIC_PRIO_IRQOFF;

Good spot, yes!

I did a quick scan with `git grep 'PSR_[IF]_BIT' -- arch/arm64`, and
AFAICT that's the last one.

> > > And a minor related one: should init_gic_priority_masking() WARN if FIQ is
> > > masked too? This probably goes with the above.
> > 
> > I think it should, yes.
> 
> Done for v3 then. Thanks!

Cool!

Mark.
