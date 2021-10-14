Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7D42DFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhJNQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhJNQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:55:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF3C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LBqLUSDBXcDspTIIT2BMYaWCoLdz1YbMecXG5wHoYbo=; b=PU7PLLUinoEGOQWjLys9r2UXH/
        xre02cHUFAqXhVGMkSW4cZlCUE1ENmA03ESe+CY54sYt3JjO5Ji9rAQXbOab5KoOa6jOhKeVoB0dW
        Iqev2k8HqWe6eF3GxrpcLVK86FE+lxOXLdHFU2HMho+50kicRF/J5A0yL3qKwEdtN5QPJQmr+bI5X
        LJYu2CgJ5SUe35Hyv4nkHyaDvtsBYD5YXwxo8ofiDjeHm810oAnQGpcJUYfNpOP8KBTalSz9l+1Tm
        Do0edtyanb4jW9i+ys7AcgnRVruz3OKeaUDUtKnHxHOnkxAgu/aL1Jd+KjH5sSSwWU5g2P5EwrJ2C
        o0AfHXLw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55116)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mb3yw-0001Yz-Qe; Thu, 14 Oct 2021 17:53:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mb3yu-0002Jf-Gd; Thu, 14 Oct 2021 17:53:24 +0100
Date:   Thu, 14 Oct 2021 17:53:24 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/8] ARM: clang: Do not relay on lr register for
 stacktrace
Message-ID: <YWhghNxpJD51ZDgD@shell.armlinux.org.uk>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369614818.636038.5019945597127474028.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163369614818.636038.5019945597127474028.stgit@devnote2>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:29:08PM +0900, Masami Hiramatsu wrote:
> Currently the stacktrace on clang compiled arm kernel uses the 'lr'
> register to find the first frame address from pt_regs. However, that
> is wrong after calling another function, because the 'lr' register
> is used by 'bl' instruction and never be recovered.
> 
> As same as gcc arm kernel, directly use the frame pointer (x11) of
> the pt_regs to find the first frame address.

Can I ask that the subject line is corrected. It's "rely" not "relay".

Also, the frame pointer is called "r11" not "x11" if you want to use
the numerical register reference for 32-bit ARM registers.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
