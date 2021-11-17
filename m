Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63B4454302
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhKQI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhKQI42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:56:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F334360EBD;
        Wed, 17 Nov 2021 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637139210;
        bh=o6etGoUAw0MU2+u2wtIY46DjtntsBZYr7eHRot7BNHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNKkpoJN5yQ1jboaKHkA11HOaTmnn/PPZO96FSrA6vKDf4cs7GkqVsCxT3SHgQZW/
         rR6GC1/DoC/t09sw0MYsfhQ4Za8TCBFxZO49VBuyU8pgAEJxazhzrlKPSl3jfNwbeK
         V81+V1aC1OveoZ2FqAcC7q0NRCqKWMaHSwtKpt6A=
Date:   Wed, 17 Nov 2021 09:53:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, wells.lu@sunplus.com,
        Tony Huang <tony.huang@sunplus.com>
Subject: Re: [PATCH 2/2] misc: Add iop driver for Sunplus SP7021
Message-ID: <YZTDCG6bTjh7BoUH@kroah.com>
References: <1637131687-23000-1-git-send-email-tony.huang@sunplus.com>
 <1637131687-23000-3-git-send-email-tony.huang@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637131687-23000-3-git-send-email-tony.huang@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:48:07PM +0800, Tony Huang wrote:
> Add iop driver for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tony.huang@sunplus.com>

Along with everything that Arnd said, one more thing:

> +#define IOP_KDBG_INFO
> +#define IOP_FUNC_DEBUG
> +#define IOP_KDBG_ERR
> +#ifdef IOP_KDBG_INFO
> +	#define FUNC_DEBUG()	pr_info("K_IOP: %s(%d)\n", __func__, __LINE__)
> +#else
> +	#define FUNC_DEBUG()
> +#endif

This should just be deleted entirely, use ftrace if you want to see what
your kernel driver is doing.

No single driver should have special debugging macros like this, use the
kernel-wide system please.

This driver code can get a lot smaller after you make these cleanups.
Also be sure to use scripts/checkpatch.pl to remove the issues that it
points out so we don't have to say the same thing.

thanks,

greg k-h
