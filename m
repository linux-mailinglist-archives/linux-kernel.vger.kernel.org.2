Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED07840AB44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhINKAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhINKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:00:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DEDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BqQzYsxdLI8kcCJ94d+ycuGwOhuCfKsKES6cCvOkuhw=; b=zuqt9x6fxJyg0fI06T9xftv6dj
        g0H9xMeXRbXxt/e2N2ljSYNIdgLN2W7Y+frI+rFGT7CKhN69IkYRE14nAWzqfDz1KYokXZJKjfC2O
        8mvzaG2V1ismwIcxYQqpLKk3JQGAkD+/Hk9EE5n4fB78LKVUR6yUn4LyOwC6OdtlNy+mIAKA286vG
        dlXjbSoo4er4mirDVDWGVrWbzCRUuelEY9EF/NTLvsMsCElavgrx4aZ+SeV2FIUs5oSqYePChCOFR
        9TjlPzUpacufF9Fp4StFIlRuxo/rciGrbzOaY/Rhv8qS0JU/PyL8neiJ0wzOZVBG2nD0OXOr7GEqV
        sbRv824Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45092)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mQ5DG-0004hH-0A; Tue, 14 Sep 2021 10:58:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mQ5DC-0002si-VO; Tue, 14 Sep 2021 10:58:46 +0100
Date:   Tue, 14 Sep 2021 10:58:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC]arm64:Mark __stack_chk_guard as __ro_after_init
Message-ID: <YUByVivmmDr4T6Dx@shell.armlinux.org.uk>
References: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631612642-102881-1-git-send-email-ashimida@linux.alibaba.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 05:44:02PM +0800, Dan Li wrote:
> __stack_chk_guard is setup once while init stage and never changed
> after that.
> 
> Although the modification of this variable at runtime will usually
> cause the kernel to crash (so dose the attacker), it should be marked
> as _ro_after_init, and it should not affect performance if it is
> placed in the ro_after_init section.
> 
> This should also be the case on the ARM platform, or am I missing
> something?

I don't see why it can't be - we only write to it in
boot_init_stack_canary(), same as ARM64.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
