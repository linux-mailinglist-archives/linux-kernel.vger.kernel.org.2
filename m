Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F8F32BCEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447586AbhCCPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843083AbhCCKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:30 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D583AC061794
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s2uZdPqT8uR6Kq7MuZb+mTdVhALYoW2pIBxZZhRSRiA=; b=gLKEwQh9wW26r3K31kcFZj1wU
        wjIrL6TQv/dgnaIrGKCJfzewmUdZNLJ7ZlWy3eYZ0hjlIFuiLAuis/aF2BbMD9J6dvtAywCr9Bm+Q
        1U4Wwg7873NvkKyoSNrMd4bsz6DeXDwVYf5XOZxpA3JyReW3Y1aWOyf8VWz0W2lL9B68aDcLMmqyL
        VONRloOfA/3ysJqjCSqf6tcf36TDiWUTDmof6J/RidBN3JHXwQwNMICjHnxKbLCliZ/l1X5cFwokk
        xzALJv3vL19Vw3iXloazf+EV5fkzK+lh+ZKVoiuffiwFw390nffdQ1+DZSKrNVZZhdc8OLVkETm3q
        59MJpyhJg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48438)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lHOdb-0005lK-2k; Wed, 03 Mar 2021 10:21:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lHOdW-0002Hg-1H; Wed, 03 Mar 2021 10:21:46 +0000
Date:   Wed, 3 Mar 2021 10:21:46 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     menglong8.dong@gmail.com
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        zhang.yunkai@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove duplicate include in
 arch/arm/mach-sa1100/hackkit.c
Message-ID: <20210303102145.GY1463@shell.armlinux.org.uk>
References: <20210303071721.177968-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303071721.177968-1-zhang.yunkai@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 11:17:21PM -0800, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'linux/tty.h' included in 'arch/arm/mach-sa1100/hackkit.c' is duplicated.
> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

I don't see this change has anything to do with module code, so what is
the reason for "module:" in the subject line? What am I missing here?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
