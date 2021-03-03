Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755CD32BD20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448193AbhCCPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCCKbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:31:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F376164EE1;
        Wed,  3 Mar 2021 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614767441;
        bh=YkUt7e1p9mMc+VuaDIEttpy+Wk4e/s1d1rMVjVEMx7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKDnFaWQR2efae0gE0M3Yb0vTthj+v6Ocf1f1nJhU1Y5ryNg8VWgsHwu2ja6+TNhU
         i9GeAlHOsyTURts43rdIYnq2R+2GOFYBxKSFEYvzng5UdxxzEaaJSbfEzgmHrDaI+l
         RFNHsVAAjJr4EtdHxHVCCingTonARplZYRFbV9QI=
Date:   Wed, 3 Mar 2021 11:30:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YD9lTjWc25Nn7jAR@kroah.com>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:24:01AM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2021 03:26, taehyun cho wrote:
> > 'ARCH_EXYNOS' is not suitable for DWC3_EXYNOS config.
> > 'USB_DWC3_EXYNOS' is glue layer which can be used with
> > Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
> > can be used from Exynos5 to Exynos9.
> > 
> > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> 
> NACK because you ignored comments from March. Please respond to them instead
> of resending the same patch.
> 
> Anyway, when resending you need to version your patches and explain the
> differences. Please also Cc reviewers and other maintainers. I pointed out
> this before:
> scripts/get_maintainer.pl -f drivers/usb/dwc3/dwc3-exynos.c
> 
> The driver - in current form - should not be available for other
> architectures. It would clutter other platforms and kernel config selection.
> If you want to change this, you need to provide rationale (usually by adding
> support to new non-Exynos platform).

No, these crazy "ARCH_FOO" things need to go away.  For systems that
want to build "universal" kernels, why are they being forced to enable
"ARCH_*" just so they can pick specific drivers?  That is not done on
other architectures, why is ARM64 so "special" in this regard.

How do you "know" that these cores/devices are tied to specific ARCH_
platforms?  We don't, so that dependency should not be there.

Just let any arch pick any driver if it can be built, you never know
what it might be run on.  Removing ARCH_ dependencies in Kconfig files
is a good thing, please do not discourage that from happening.

thanks,

greg k-h
