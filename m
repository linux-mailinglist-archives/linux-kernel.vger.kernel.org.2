Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034BA394084
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhE1KBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhE1KBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:01:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LzIDrHUrE4Knqz5XcWPc90W/ZVpVcOaYow+ZB8hxmnA=; b=wfWMkrQhFww+1/w3vRJJUqKRG
        x7gEfNGqVN8NC06t6Tm1H2+xZbgue174dgzk39oaYO3dAuN1dUGWXuzZ2hdy5nUw85L+5cFXzabz4
        rAaKJ7fVPzGhpMhwKeLqlrfqIrWwTK9wCaMULy8crGkiyhgSeodrVmBG6PAe43o4K8M5dmoLIDyRI
        pjzegwLP5H3lM+lDTV5U+/w/r1JlXN7Ad36F+b/P8sUPkxG6XFy2BHIXnzoEcj+2ufOAINCvNf6DE
        ZkbZNLDMMIN6xmbH9LGrSHCX09S0fOV+pgpVfGW2qxBZtRbwfrGIdHiBmHGqKAS58eZwL+4Th72S1
        72PYf1csg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44436)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lmZHd-0008E8-He; Fri, 28 May 2021 11:00:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lmZHc-0004cp-HM; Fri, 28 May 2021 11:00:00 +0100
Date:   Fri, 28 May 2021 11:00:00 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
Message-ID: <20210528100000.GO30436@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
 <a7ad5c03-025a-4cf8-e4b1-2d150bfe3066@windriver.com>
 <20210520090024.GB30436@shell.armlinux.org.uk>
 <f2be5610-9a2c-f4cc-510c-b8fae22f67dd@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2be5610-9a2c-f4cc-510c-b8fae22f67dd@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:52:28AM +0800, Xu, Yanfei wrote:
> Hi Russell,
> 
> Will you send v2? (or I missed something.)

Yes - I've been a little distracted during the last week or so. New
version is in progress.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
