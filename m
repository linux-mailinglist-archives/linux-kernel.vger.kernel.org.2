Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACD44C21D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhKJNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhKJNeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:34:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B805611AD;
        Wed, 10 Nov 2021 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636551073;
        bh=N1v9m8wBIOpNhEYufO2ttASP1N9O2DRWxBJvQ/4r3YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcBSB3bIpV81K0hPzXfL1ntQvDN3uqQeIkjVhUC30tkzFQ8lFaQu3bCOCjF9Q7q5+
         Y5PSKP5EdY3A4ojJQDeJ3Vq9C5/x5uTDLqSa2XiDLq5YT996xZM7MvpjTwiKDy7XeE
         vhVfImlrp6FELHDU87OuTmMfU93XLsqyWMGT7SPs=
Date:   Wed, 10 Nov 2021 14:31:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2] of/unittest: Disable new dtc
 node_name_vs_property_name and interrupt_map warnings
Message-ID: <YYvJn8ds5iI9SqVR@kroah.com>
References: <20211028130423.4025578-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028130423.4025578-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 08:04:23AM -0500, Rob Herring wrote:
> The unittest dtbs have various intentional errors which cause warnings.
> With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
> some new checks: node_name_vs_property_name and interrupt_map warnings.
> These warnings are also generated for static_base_1.dtb, so add
> DTC_FLAGS for it.
> 
> Note that the interrupt_map warnings only appear once interrupt_provider
> warning is re-enabled globally.
> 
> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
> 
> Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/unittest-data/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index a5d2d9254b2c..fbded24c608c 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
>  DTC_FLAGS_testcases += -@
>  
>  # suppress warnings about intentional errors
> -DTC_FLAGS_testcases += -Wno-interrupts_property
> +DTC_FLAGS_testcases += -Wno-interrupts_property \
> +	-Wno-node_name_vs_property_name \
> +	-Wno-interrupt_map
>  
>  # Apply overlays statically with fdtoverlay.  This is a build time test that
>  # the overlays can be applied successfully by fdtoverlay.  This does not
> @@ -82,6 +84,10 @@ apply_static_overlay_1 := overlay_0.dtbo \
>  
>  apply_static_overlay_2 := overlay.dtbo
>  
> +DTC_FLAGS_static_base_1 += -Wno-interrupts_property \
> +	-Wno-node_name_vs_property_name \
> +	-Wno-interrupt_map
> +
>  static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
>  static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
>  
> -- 
> 2.32.0
> 

Note this commit in Linus's tree breaks clang-based systems with the
following build errors:
	FATAL ERROR: Unrecognized check name "interrupt_map"
	FATAL ERROR: Unrecognized check name "node_name_vs_property_name"

Any thoughts about what to do?

thanks,

greg k-h
