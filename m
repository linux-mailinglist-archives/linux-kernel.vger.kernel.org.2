Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECBC32BCED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447551AbhCCPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843082AbhCCKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:29 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FC7C06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c22xLj3GaH+4mij0mN1ziDixlex7PdTUYF+mWbqebsA=; b=mFqVtwjrKg2TS1lDq/UU/dtiI
        2M8UdwfvO5WVtheGtZdfG+8F4m/FKIk56js/LbM+8krlM27pF3CrL5jUhFGTMjmzj9b8QnRiRDNBe
        ufvuVzM6/qRWZb6i+Y3peBRewSZTj+gaui1cZignxksaT/Kb180AaZmE1zj+x1xKDDipua5720Ekh
        3vrDkYsqAoeWJg3YzDRF9mBu6FL1RWylWjuLGPfl24QoDRJJEZzbrCttyH9E8bbf5vyDQvWIdYOmi
        CXD5WSL9K2lngXlY5AJexYTIiqA7+Giqxu0eeeKqAtjRVomwjKnv/qGjAFymIMKmAcTUB7Rq3rUX/
        iVgmtU2JA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48440)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lHOfp-0005la-77; Wed, 03 Mar 2021 10:24:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lHOfn-0002Hs-Eg; Wed, 03 Mar 2021 10:24:07 +0000
Date:   Wed, 3 Mar 2021 10:24:07 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     menglong8.dong@gmail.com
Cc:     vladimir.murzin@arm.com, akpm@linux-foundation.org,
        rppt@kernel.org, maz@kernel.org, geert@linux-m68k.org,
        anshuman.khandual@arm.com, zhang.yunkai@zte.com.cn,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove duplicate include in
 ./arch/arm/include/asm/pgtable.h
Message-ID: <20210303102407.GZ1463@shell.armlinux.org.uk>
References: <20210303020422.174818-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303020422.174818-1-zhang.yunkai@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 06:04:22PM -0800, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'asm-generic/pgtable-nopud.h' included in 'pgtable.h' is duplicated.
> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

I don't see this change has anything to do with module code, so what is
the reason for "module:" in the subject line? What am I missing here?

I also think that this patch needs a better explanation, since it's not
a removal of a redundant include, whereas your other similarly described
changes are.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
