Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713FB3E489C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhHIPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhHIPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:24:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E9DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LHtWttbPcNIV+8uOkGGlKUxbwyqqXh3re7hu/BS1IJk=; b=tLeIZ5IB0Dk/kUi+zEHT6ya9e
        QHgTSoKWaCPYKABO6465OQ5H+eoasC8yk6J4NuN84ho679JCMaNxCTaLrzhqIHxf5ERjqtbLqLHJu
        VrDKpvxj+nBoWP7CeSfDnizscmnth9kpq1yS3drZm6UNv0LdZObC7yG3KJKNjBGNv4aJUaSt3Mvs6
        R1LBegN/X2svwKOFke/Eu5HQXo9whvL7G/ee4FQqTqvtCmTQYbx3HyJ7UyAVpZOU0SaMlywwXxQZC
        jvQ1jglE4L3BTcvOS+bBjMZSFwXOiLBGwVGlQt7E8HmYraB4bjb63KGwXhiYfSvklVrUYc44cWTQr
        SOl3Li+9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47116)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mD78Z-0005rv-6s; Mon, 09 Aug 2021 16:24:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mD78X-0001Hd-RX; Mon, 09 Aug 2021 16:24:21 +0100
Date:   Mon, 9 Aug 2021 16:24:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     David Heidelberg <david@ixit.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: atags_to_fdt: don't warn about stack size
Message-ID: <20210809152421.GU22278@shell.armlinux.org.uk>
References: <20210809151021.5137-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809151021.5137-1-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 05:10:21PM +0200, David Heidelberg wrote:
> The merge_fdt_bootargs() function by definition consumes more than 1024
> bytes of stack because it has a 1024 byte command line on the stack,
> meaning that we always get a warning when building this file:
> 
> arch/arm/boot/compressed/atags_to_fdt.c: In function 'merge_fdt_bootargs':
> arch/arm/boot/compressed/atags_to_fdt.c:98:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> However, as this is the decompressor and we know that it has a very shallow
> call chain, and we do not actually risk overflowing the kernel stack
> at runtime here.
> 
> This just shuts up the warning by disabling the warning flag for this
> file.
> 
> Tested on Nexus 7 2012 builds.
> 
> Original Author: Arnd Bergmann <arnd@arndb.de>
> Reference: https://lore.kernel.org/lkml/8232115.18ykgQ6J5T@wuerfel/
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

I assume Arnd never sent his v3 from what I see in the thread you link
to above.

This needs to go to the patch system to be applied. Details in my
signature below. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
