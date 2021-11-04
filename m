Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20064452C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhKDMQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:16:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3C6C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jv9yDLaUQJYfwPZfANSjIMMGOl7mHof6krfRahDJ8T8=; b=MOFUqP7S2mDlyx2zmif6moqkWc
        TP9SKatpPFrVdP+7SziCDARGap5qJaKegZae4W6I3Sklt+9KTTdv6NO1O8irZRlFYaY3B+dEZBO6n
        ocbkbygoXCUS1hhPXxiuLiyLGHdSWYZ7dsDbXIf3X7phHc2yLQer3JBjGm97Nqsy+cF8vx0gopEn0
        WjhP7fDYr86yfbLAr8ub0P1B0cCACL4dorZbgK6A+GiGcy/V/rl4Jeg8NPGYf0d1Vn0788oRIODtX
        ES8Br8LHf2zR6XKi6VCZ5H9PatjZHBd7a0N5c33Cb7vlbCOhpp2JFC5yeVuOHKHrJk5zszB3kUNJ9
        SSDq5HBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55472)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mibcO-0005vb-9d; Thu, 04 Nov 2021 12:13:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mibcN-0007Jn-Rp; Thu, 04 Nov 2021 12:13:19 +0000
Date:   Thu, 4 Nov 2021 12:13:19 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     saravanak@google.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] amba: some cleanup
Message-ID: <YYPOX3VZbpBeai/z@shell.armlinux.org.uk>
References: <20211104095643.180429-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104095643.180429-1-wangkefeng.wang@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM tree is closed; we're in the mainline merge window. Please
resend after -rc1 is released.

On Thu, Nov 04, 2021 at 05:56:41PM +0800, Kefeng Wang wrote:
> As the v1 of "amba: Properly handle device probe without IRQ domain"
> is merged, some comments[1] from Rob and Saravana is not included,
> let's send them separately again.
> 
> patch1 has been ACKed by Rob[2].
> patch2 is suggested by Saravana.
> 
> [1] https://lore.kernel.org/lkml/20210816074619.177383-1-wangkefeng.wang@huawei.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20210827150600.78811-4-wangkefeng.wang@huawei.com/
> 
> Kefeng Wang (2):
>   amba: Kill sysfs attribute file of irq
>   amba: Move of_amba_device_decode_irq() into amba_probe()
> 
>  drivers/amba/bus.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
