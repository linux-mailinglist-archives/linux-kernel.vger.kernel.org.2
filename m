Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3108E376525
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhEGMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhEGMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:32:01 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F82C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B4OtqkGn285R60YiVqH6q3onTS7Lt7KKKKLOjRmOeV4=; b=ZVM8/wMyekdiVYbyNXTg1uy4i
        Jl9IXPuzvxmeenmYLQI3/GzdtqOmodJRHf3id3FjDcg0GLbXtEyCBabEt7NX8KPj1fc3wRhfdH7/b
        pDaOUqdSLBtQ6Hc+sESBUbdYJYuIIwCBjv39DEa8RxSA51brI5orDHfPHCVTGPuQ/H+dEgfhfyJ+s
        cOvWVc6JVxK6B85MVUKbK9YrNll44QU623fa3W3oYDP97SzMAUoBe9VciVWx4RSPWRCX2vgc2z5yV
        faklLezAiSxTrdHCXSGc22xLy5WZtprqEgqqdnUx3QVJLiekKU+0B/MFqp7iQK1GHnFSdbxcoY/MT
        zuuAASpAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43756)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lezdA-0003iW-2O; Fri, 07 May 2021 13:30:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lezd9-0005lq-GX; Fri, 07 May 2021 13:30:55 +0100
Date:   Fri, 7 May 2021 13:30:55 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: treat exit sections the same as init
 sections when !CONFIG_MODULE_UNLOAD
Message-ID: <20210507123054.GD1336@shell.armlinux.org.uk>
References: <20210507121322.6441-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507121322.6441-1-jeyu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 02:13:22PM +0200, Jessica Yu wrote:
> Dynamic code patching (alternatives, jump_label and static_call) can
> have sites in __exit code, even if __exit is never executed. Therefore
> __exit must be present at runtime, at least for as long as __init code is.
...
> Previously, the module loader never loaded the exit sections in the first
> place when CONFIG_MODULE_UNLOAD=n. Commit 33121347fb1c ("module: treat exit
> sections the same as init sections when !CONFIG_MODULE_UNLOAD") addressed
> the issue by having the module loader load the exit sections and then making
> __exit identify as __init for !MODULE_UNLOAD. Then, since they are treated
> like init sections, they will be also discarded after init.
> 
> That commit satisfied the above requirements for jump_labels and
> static_calls by modifying the checks in the core module_init_section()
> function in kernel/module.c to include exit sections. However, ARM
> overrides these and implements their own module_{init,exit}_section()
> functions. Add a similar check for exit sections to ARM's
> module_init_section() function so that all arches are on the same page.

Shouldn't the module core code itself be doing:

	module_init_section(name) || module_exit_section(name)

itself when CONFIG_MODULE_UNLOAD is not set, rather than pushing this
logic down into every module_init_section() implementation?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
