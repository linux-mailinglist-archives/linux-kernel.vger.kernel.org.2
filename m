Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3F3DFF3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhHDKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbhHDKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:14:23 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B2C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hthaXayFsAFuO4fgMsEzj4PkQ40X+DJilzikZbi39ck=; b=v1C/YnksCL/7UjCynklphOGHw
        B8DZFolIHZHedAANNrkCQYpGq9jpYEIKeP6GEy8GrhIpZnT8xASeQRhOUuXVO4I1wG9sjiBSsb5tX
        DnhniUTWtO+ENmJmu9INyHjNSCV4x4TCdTOlSaccEEVI6YQb0Er587hOLW4lTXp6JLmLjDzLtuS3l
        puk1pGsvo/I1VBovWzN8cjn3SZM2RCGW0opFHD9VqP9eg6uTgbVsh34bPVlL+IDMA+9TWN+bZ4g94
        itTRiLfvgeLImtKcdooqOGMkmwy+Yg4AIZ+Tdqf5Sv/dh14RQn9BcoB2IqG5mD/1gfgqs71bOIJFt
        /D69kAYVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46930)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mBDuW-0008W5-9E; Wed, 04 Aug 2021 11:14:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mBDuQ-0004iR-T1; Wed, 04 Aug 2021 11:13:58 +0100
Date:   Wed, 4 Aug 2021 11:13:58 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     cgel.zte@gmail.com
Cc:     yong.yiran@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] 'linux/tty.h' included in 'hackkit.c' is
 duplicated. It is also included in the 21th line.
Message-ID: <20210804101358.GO22278@shell.armlinux.org.uk>
References: <20210804093907.618719-1-yong.yiran@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804093907.618719-1-yong.yiran@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 02:39:07AM -0700, cgel.zte@gmail.com wrote:
> From: yong yiran <yong.yiran@zte.com.cn>
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>

Hi,

The commit message and summary(subject) could do with some improvement:

1) I don't think having "It is also included in the 21th line." in the
   summary adds value.

2) Maybe the summary should be

	"Remove duplicated 'linux/tty.h' include in 'hackkit.c'"

3) the commit message should say something, maybe along the lines of:

	"Remove all but the first include of linux/tty.h from hackkit.c."

Thanks.

> ---
>  arch/arm/mach-sa1100/hackkit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> index 3085f1c2e586..3fe34ee7c0ab 100644
> --- a/arch/arm/mach-sa1100/hackkit.c
> +++ b/arch/arm/mach-sa1100/hackkit.c
> @@ -18,7 +18,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/tty.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
