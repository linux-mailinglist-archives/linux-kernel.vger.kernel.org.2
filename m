Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43568380EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhENRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhENRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:10:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2562C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O2WwZG5UT0TfHcCm0KHfCmgki4wkc4NSDE9GZOtTDBw=; b=TF233q9qLO0O68foj6C8iQwRL
        pUyQ1GTm2Et4Zh4ATAmKIqFs8jp3NVXUsWYBojTUb2hwhceKKM0FXl91o+68ZC4A/h+umOZZwbDVy
        HsJCpUAhscY2gYpqmpMipKsfNzjnC2LmJo4mM+pxPp+KEzNRBHcLSrUiNCOP9Y1/H+CObRRCqA+oG
        7cKHeQ8KXbZs8yZaN+xRdARUTtBiBSqvCy6aU27Tqh8UaNtil1RcMnjXBiUpfNwf0ZHOIiQH5vT1L
        4lyCvCTivpisjnxaFOiCHqaDpwrI8+6thMsRIbpIvbLzV2EMzSTXOGhTKJ1xMDiFfDFgqzrphh4In
        j6SNJyRCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43974)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lhbJb-0008UZ-JT; Fri, 14 May 2021 18:09:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lhbJa-0004AI-Ad; Fri, 14 May 2021 18:09:30 +0100
Date:   Fri, 14 May 2021 18:09:30 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] module: check for exit sections in layout_sections()
 instead of module_init_section()
Message-ID: <20210514170930.GE12395@shell.armlinux.org.uk>
References: <20210514160904.21989-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514160904.21989-1-jeyu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 06:09:04PM +0200, Jessica Yu wrote:
> Previously, when CONFIG_MODULE_UNLOAD=n, the module loader just does not
> attempt to load exit sections since it never expects that any code in those
> sections will ever execute. However, dynamic code patching (alternatives,
> jump_label and static_call) can have sites in __exit code, even if __exit is
> never executed. Therefore __exit must be present at runtime, at least for as
> long as __init code is.
> 
> Commit 33121347fb1c ("module: treat exit sections the same as init
> sections when !CONFIG_MODULE_UNLOAD") solves the requirements of
> jump_labels and static_calls by putting the exit sections in the init
> region of the module so that they are at least present at init, and
> discarded afterwards. It does this by including a check for exit
> sections in module_init_section(), so that it also returns true for exit
> sections, and the module loader will automatically sort them in the init
> region of the module.
> 
> However, the solution there was not completely arch-independent. ARM is
> a special case where it supplies its own module_{init, exit}_section()
> functions. Instead of pushing the exit section checks into
> module_init_section(), just implement the exit section check in
> layout_sections(), so that we don't have to touch arch-dependent code.
> 
> Fixes: 33121347fb1c ("module: treat exit sections the same as init sections when !CONFIG_MODULE_UNLOAD")
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Looks good!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
