Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B763131AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBHMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhBHLkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:40:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11EDB64E30;
        Mon,  8 Feb 2021 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612784400;
        bh=K9Cte390m+Zrnt4ZIkHX/V6Q/I7IbXsOk45014fi5fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXj1sb/w+UGQvP/XZqXWAC4ISho2rK+joXELt3OieLwjg82MDWHVNtRGYpeE9cMI9
         ZRJ6zbMTV535/+ylFC9JFSniEv1ztG2XuT+jj5uJH9rlKJD6P7OuoQX2DPhc1s4NGD
         IAyW172zQTrq6Vb2IVeeFNrQxxN2VOFP1X6TmJIU=
Date:   Mon, 8 Feb 2021 12:39:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     taehyun cho <taehyun.cho@samsung.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YCEjDboXPkh8IMHr@kroah.com>
References: <taehyuncho>
 <CGME20210208112816epcas2p43777bb9740f7307e38cb534f01099126@epcas2p4.samsung.com>
 <20210208112906.134448-1-taehyun.cho@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208112906.134448-1-taehyun.cho@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:29:06PM +0900, taehyun cho wrote:
> 'ARCH_EXYNOS' is no more used. 'USB_DWC3_EXYNOS' is glue layer
> which can be used with Synopsys DWC3 controller on Exynos SoCs.
> 'USB_DWC3_EXYNOS' can be used from Exynos5 to Exynos9.
> 
> Change-Id: I965b415252a4c64ec5527488be7392113f7ceeb3

Please always run checkpatch.pl on your patches so you do not get grumpy
emails from maintainers telling you to run checkpatch.pl on your
patches...

Please fix and resend.

thanks,

greg k-h
