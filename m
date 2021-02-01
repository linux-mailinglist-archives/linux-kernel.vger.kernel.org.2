Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9648730A83D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBANEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBANEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:04:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FADEC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jSruJqvqP42oOvDzzH5lMZkOJMAUz4mT9HH4X7kw/C4=; b=JHqW05K5DJteLosCaiMf13Anp
        uAEAa2U97sBs5ZlGgUTl8pyHWVurURJGWoFGamVwI6L77AQuAgKwo/AQ7TVYR5qIs9KBQgHeS9Bje
        yJ0aLiTmFvNZMFo2jWIe9on9VAmz9X4UXEvL6yLUSYo5C6G4rzJbBPDwzmiy5Pz+qSzNprr27YIqi
        qpucIE+YIcJLSpjjA5KN8cOVyWHxo6EXSYF1R+VlDjHquedK1pC4a+IrbGk6MJoL8Q2h5bPcw46fP
        XOehEoeSx8H8b7popZKi5rdzcqv6rYs+olXasKST6hJz69c44serqGaSpbcQKAjhWtLAq84oZjFf8
        ZvOEF3QMw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37756)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l6Yrp-0003LN-W4; Mon, 01 Feb 2021 13:03:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l6Yrp-00021n-1z; Mon, 01 Feb 2021 13:03:45 +0000
Date:   Mon, 1 Feb 2021 13:03:45 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>,
        linux-kernel@vger.kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201130344.GF1463@shell.armlinux.org.uk>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201124720.GA66060@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 12:47:20PM +0000, Mark Rutland wrote:
> 1. copy reloc code into buffer
> 2. alter variables in copy of reloc code
> 3. branch to buffer
> 
> ... which would avoid this class of problem too.

Yep, slightly messy to do though:

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 5d84ad333f05..6058e0d3a40d 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -174,18 +174,27 @@ void machine_kexec(struct kimage *image)
 
 	reboot_code_buffer = page_address(image->control_code_page);
 
-	/* Prepare parameters for reboot_code_buffer*/
-	set_kernel_text_rw();
-	kexec_start_address = image->start;
-	kexec_indirection_page = page_list;
-	kexec_mach_type = machine_arch_type;
-	kexec_boot_atags = image->arch.kernel_r2;
-
 	/* copy our kernel relocation code to the control code page */
 	reboot_entry = fncpy(reboot_code_buffer,
 			     &relocate_new_kernel,
 			     relocate_new_kernel_size);
 
+#define set(what, val) \
+	do { \
+		uintptr_t __funcp_address; \
+		int __offset; \
+		void *__ptr; \
+		asm("" : "=r" (__funcp_address) : "0" (&relocate_new_kernel)); \
+		__offset = (uintptr_t)&(what) - (__funcp_address & ~1); \
+		__ptr = reboot_code_buffer + __offset; \
+		*(__typeof__(&(what)))__ptr = val; \
+	} while (0)
+
+	set(kexec_start_address, image->start);
+	set(kexec_indirection_page, page_list);
+	set(kexec_mach_type, machine_arch_type);
+	set(kexec_boot_atags, image->arch.kernel_r2);
+
 	/* get the identity mapping physical address for the reboot code */
 	reboot_entry_phys = virt_to_idmap(reboot_entry);
 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
