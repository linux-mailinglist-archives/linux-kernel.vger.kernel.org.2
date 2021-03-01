Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB657327BF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhCAKX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhCAKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:21:48 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F405CC0617AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i+O8JoyLJe+7Z1qdG2NYON0/XJpNlqwr3ov8jFrGb3Y=; b=hSvM8jxrCGXElab/3xouPTpwp
        wG8l1SqAioX9cSRl45xKFQzMp0IyW8FL1rTKZli6/VQJi+mBv+ZFrapoqqxUBokEtwslBAdvdW6XO
        8B2q3ZeqfDbHt0kvQO46qbiET5jM3n2eH5Jfdv9XMkJaPAlBZY6kFHtvd093ThBlIHlXVs+s/coKR
        EzPDidy1UWxBYKg38zUUUJvA3njAkWrr27iZ67XWgZphEgG8Vqop00YDiKBZifit55ncmn+cJTs01
        nA+xt+KbQGgEj8IOZ93d7wZB0kFcpZWWOCd2ZMpTXwTuPisFchYYyinwtZZMMc7XsJUE2tde5/uj6
        6xYRxSMqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47878)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lGfeZ-0003zn-LC; Mon, 01 Mar 2021 10:19:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lGfeZ-0000HT-0Z; Mon, 01 Mar 2021 10:19:51 +0000
Date:   Mon, 1 Mar 2021 10:19:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] pragma once: convert arch/arm/tools/gen-mach-types
Message-ID: <20210301101950.GV1463@shell.armlinux.org.uk>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <YDvL5H9BLnLYuI2q@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDvL5H9BLnLYuI2q@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 07:59:16PM +0300, Alexey Dobriyan wrote:
> From 72842f89ae91a4d02ea29604f87c373052bd3f64 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Tue, 9 Feb 2021 14:37:40 +0300
> Subject: [PATCH 02/11] pragma once: convert arch/arm/tools/gen-mach-types
> 
> Generate arch/arm/include/generated/asm/mach-types.h without include
> guard.

The fundamental question of "why" is missing from this commit message.
Are we making this change to all kernel headers?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
