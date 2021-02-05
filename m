Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49094310844
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBEJtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBEJp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:45:58 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B456CC0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1kor7NzFVj5gUja58ZKJIm2pOcR3QalpWv8fBZElwW4=; b=SC1TNd4HnzmHLR5QERapCmGRK
        k2IcYSiCwgfD47iyamg4ZySuuqoRWrkd6HmUMufrU/KJ9LW6BMPv7rvzk/zVFYCwaNh4vJqIwvDYR
        c0Qg8N/i/x4JWWPBKsVey+9T7bUngrQ/YmFMyyXORg6TIbIrRLNg/YeKpbLxrzamtKnfsVAIbcWH3
        V/mN+uOKtiA6sAu1Wt5o5ilIvPwfoLbnac2kBmozSgATI+Ll6jbK+jGQSkGJajBQLsusl8VyI8Mp5
        znO/L6Mi8V0H1qzUDI0Ve0cy120pP+AqYW8zR0CS9uSvU+/6mQ5yzgrdc6GnuyWigu9wF85FrNkB6
        SOLpsRv3g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39468)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7xfg-0007b4-NC; Fri, 05 Feb 2021 09:45:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7xff-00066V-1C; Fri, 05 Feb 2021 09:44:59 +0000
Date:   Fri, 5 Feb 2021 09:44:59 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        rppt@kernel.org, giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210205094458.GF1463@shell.armlinux.org.uk>
References: <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
 <20210201202742.GA17243@p4>
 <20210204234841.GA19339@p4>
 <20210205001833.GE1463@shell.armlinux.org.uk>
 <20210205004050.GA3319@p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205004050.GA3319@p4>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:40:54AM +0000, Giancarlo Ferrari wrote:
> Russell,
> 
> On Fri, Feb 05, 2021 at 12:18:33AM +0000, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 04, 2021 at 11:48:42PM +0000, Giancarlo Ferrari wrote:
> > > Can I ask about having it integrated ?
> > 
> > Thanks for testing. Are you willing for me to add:
> > 
> > Tested-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
> > 
> > to the commit log?
> > 
> 
> Sure.
> 
> I have a question regarding the patch. I saw that the structure start at
> the end of the relocation code:
> 
> data = reboot_code_buffer + relocate_new_kernel_size;
> 
> which means it overlap with the global symbol relocate_new_kernel_size.
> I think is minor comment as the variable is only used in the fncpy()
> then thrown away.

The same is true of the rest of the kernel image if that's how you'd
like to look at it.

relocate_new_kernel_size is just there to tell the C code the size of
the function, nothing more nothing less. It isn't there to be copied.
The copied code doesn't use it.

> Something like:
> 
> data = reboot_code_buffer + relocate_new_kernel_size + sizeof(long);

No. That will place the structure after the size variable, which we
don't want, and...

> and accordingly in the instruction (arch/arm/kernel/relocate_kernel.S):
> 
> adr	r7, relocate_new_kernel_end

... we will then need to follow this with:
	add	r7, r7, #4

or replace it with:
	adr	r7, relocate_new_kernel_end + 4

so that r7 points at "data".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
