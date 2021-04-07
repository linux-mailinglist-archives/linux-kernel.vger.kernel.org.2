Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20299356858
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345939AbhDGJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350340AbhDGJtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:49:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0D8610F9;
        Wed,  7 Apr 2021 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617788949;
        bh=sAU1j4Aymge3WgB3f/YkePq5P6yMhJPEDXC73w+YBms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFQbjzc2oNbCAJSKvkyUQetu/+pxf3vqRcTSpnKjSG+zFS0QpuDgwSiWhMd7A1Y/X
         bZ3BZ05f9C9ZKqVS24ibR3FEN0XXn1b6vsx6JgpYOw6eCt866X0DyQaVIkEGryiYwo
         yMgucM8AwiwNo+w3OUV2owWg7scGvE6yt3kQTPLw=
Date:   Wed, 7 Apr 2021 11:49:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v1 1/1] driver core: platform: Make
 platform_get_irq_optional() optional
Message-ID: <YG2AEoKfiMHqabbQ@kroah.com>
References: <20210331144526.19439-1-andriy.shevchenko@linux.intel.com>
 <20210406192514.GA34677@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406192514.GA34677@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 12:25:14PM -0700, Guenter Roeck wrote:
> On Wed, Mar 31, 2021 at 05:45:26PM +0300, Andy Shevchenko wrote:
> > Currently the platform_get_irq_optional() returns an error code even
> > if IRQ resource sumply has not been found. It prevents caller to be
> > error code agnostic in their error handling.
> > 
> > Now:
> > 	ret = platform_get_irq_optional(...);
> > 	if (ret != -ENXIO)
> > 		return ret; // respect deferred probe
> > 	if (ret > 0)
> > 		...we get an IRQ...
> > 
> > After proposed change:
> > 	ret = platform_get_irq_optional(...);
> > 	if (ret < 0)
> > 		return ret;
> > 	if (ret > 0)
> > 		...we get an IRQ...
> > 
> > Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This patch causes all my "sh" emulations to stall during boot with the
> following repeated error message.
> 
> sh-sci sh-sci.1: Can't allocate rx full IRQ
> 
> Reverting this patch fixes the problem (and the message is gone).
> Bisect log is attached.
> 
> Guenter
> 
> ---
> # bad: [9c54130cd25528028b2d38f6ada0c79e92210390] Add linux-next specific files for 20210406
> # good: [e49d033bddf5b565044e2abe4241353959bc9120] Linux 5.12-rc6
> git bisect start 'HEAD' 'v5.12-rc6'
> # good: [3981dcd7199773fc8cfbbcc6173e3521b8e49035] Merge remote-tracking branch 'crypto/master'
> git bisect good 3981dcd7199773fc8cfbbcc6173e3521b8e49035
> # good: [da18b6c82eba21e87d6ee76b7b0382eca123cc79] Merge remote-tracking branch 'ftrace/for-next'
> git bisect good da18b6c82eba21e87d6ee76b7b0382eca123cc79
> # bad: [021e2b99a3cb523408609ca1792ab623ff16f334] Merge remote-tracking branch 'staging/staging-next'
> git bisect bad 021e2b99a3cb523408609ca1792ab623ff16f334
> # bad: [685f903c62e3929370293bad184afa04b6fddebd] Merge remote-tracking branch 'char-misc/char-misc-next'
> git bisect bad 685f903c62e3929370293bad184afa04b6fddebd
> # good: [67d49fe7e4d40cfe6919b434d6a4e837230af9d4] Merge remote-tracking branch 'ipmi/for-next'
> git bisect good 67d49fe7e4d40cfe6919b434d6a4e837230af9d4
> # bad: [69e2ae87cfa94c77c3503715e9e0a68e6cc69f8d] Merge remote-tracking branch 'usb/usb-next'
> git bisect bad 69e2ae87cfa94c77c3503715e9e0a68e6cc69f8d
> # good: [2665a13a3e9ef3d08b9ac4b48328ddfba9126987] usb: typec: Fix a typo
> git bisect good 2665a13a3e9ef3d08b9ac4b48328ddfba9126987
> # good: [967f6d162d9fa415cf140d3eef5576d566632292] dt-bindings: usb: mtk-xhci: remove redefinitions of usb3-lpm-capable
> git bisect good 967f6d162d9fa415cf140d3eef5576d566632292
> # good: [d225ef6fda7ce9ff7d28764bd1cceea2d0215e8b] base: dd: fix error return code of driver_sysfs_add()
> git bisect good d225ef6fda7ce9ff7d28764bd1cceea2d0215e8b
> # bad: [72a91f192da032b68519fafaecce03fd002d669a] driver core: add helper for deferred probe reason setting
> git bisect bad 72a91f192da032b68519fafaecce03fd002d669a
> # good: [1768289b44bae847612751d418fc5c5e680b5e5c] driver core: platform: Declare early_platform_cleanup() prototype
> git bisect good 1768289b44bae847612751d418fc5c5e680b5e5c
> # bad: [ed7027fdf4ec41ed6df6814956dc11860232a9d5] driver core: platform: Make platform_get_irq_optional() optional
> git bisect bad ed7027fdf4ec41ed6df6814956dc11860232a9d5
> # good: [318c3e00f13c2f6e11202a22cc302ea8c70552ea] driver core: Replace printf() specifier and drop unneeded casting
> git bisect good 318c3e00f13c2f6e11202a22cc302ea8c70552ea
> # first bad commit: [ed7027fdf4ec41ed6df6814956dc11860232a9d5] driver core: platform: Make platform_get_irq_optional() optional

Thanks for the report, I'll go revert this from my tree now.

greg k-h
