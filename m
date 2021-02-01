Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397D630A6A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBALfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBALfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:35:32 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7EC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TbkJ5lHaa5UNXXcGQEY9HkpxkXaSF9a600yXDUg3OPc=; b=a/E0syQGtT4kG/vw0P3RfxInR
        JQ2oM7Y+ynbZxFYsWbY/KxKAA7BCB6VQkpdwIC8Cn4b01nTH1Mi4P/tG45e23YoyQTO0slnClCCCG
        +Gt3GN0HIk+UtEmrQxhsYwD3AXjyYZQgOQJPw9TkgsQRgLJo2pxCV3ij0zamsBl2xLAM8cUoF2YAT
        De9f/DKLjtyi5hkqcWWgIDXL0JtkznbnYxr9GLLZ1ZiF7ICak8kRKsQrskXTuvqw8+MCSrKV066z5
        jOEHic+G7pp9sBEtP++bJvFwVQo9D39Q7zbPf38UNLEtetGinaGPVDrku8R0wCr7rqShypZu1GuDM
        m57/pXjQA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37726)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l6XTZ-0003Ec-O5; Mon, 01 Feb 2021 11:34:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l6XTY-0001xl-8x; Mon, 01 Feb 2021 11:34:36 +0000
Date:   Mon, 1 Feb 2021 11:34:36 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org, penberg@kernel.org,
        geert@linux-m68k.org, giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201113436.GE1463@shell.armlinux.org.uk>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wish others who know this code would get involved, and such stuff
wasn't left to me to research and work out whether a patch is correct
or not.

On Mon, Feb 01, 2021 at 12:44:56AM +0000, Giancarlo Ferrari wrote:
> machine_kexec() need to set rw permission in text and rodata sections
> to assign some variables (e.g. kexec_start_address). To do that at
> the end (after flushing pdm in memory, etc.) it needs to invalidate
> TLB [section] entries.
> 
> If during the TLB invalidation an interrupt occours, which might cause
> a context switch, there is the risk to inject invalid TLBs, with ro
> permissions.
> 
> When trying to assign .text labels, this lead to the following:
> 
>  Unable to handle kernel paging request at virtual address 80112f38
>  pgd = fd7ef03e
>  [80112f38] *pgd=0001141e(bad)
>  Internal error: Oops: 80d [#1] PREEMPT SMP ARM
>  ...
> 
> Signed-off-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>

I don't know this code very well, but I don't think this patch is
correct. What happens if we have CRASH_DUMP enabled, and we enter this
function with IRQs already disabled? Should we really be re-enabling
IRQs?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
