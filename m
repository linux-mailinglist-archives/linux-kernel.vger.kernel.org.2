Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E63F471B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhHWJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhHWJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:06:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B1C061575;
        Mon, 23 Aug 2021 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WcTJBjwaEsJ+F2xRMsqTK6KuhzP/brFupnhyKBOJUh4=; b=Fg2jR0IZASEiN/LscUdJ1EnOu
        YV2pWnPZWM0IrJO+sU3QNgtNXixzfO7lSNrCCbYE0KxTxs5TeSPKMoMy1L+eceDYPeqxg5nGJt7nz
        DSQKDj5OYaGrRHG+k8V8o1PLp8GwPVptwoliBep1bT1nxvWUF+Ukq7dYHpiAFxTgAe1Q6/uY78Gvx
        NL9XWyiVHx05J1xrRME/C5EBX3NfKYYchQ/2cW3jn9jI8tFpQvC1OtqwyvSIil5ysInLs2gbg0Gy9
        Kkgz+a8vQ+ALEVip1PJhsXtVTQnYzCEEQ2eXxSa9ySMKKMsXy1r6RkEAbn6e9fPimbpty/lrF61PD
        MgdWuQu0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47574)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mI5tJ-0002d7-3X; Mon, 23 Aug 2021 10:05:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mI5tF-00062g-2a; Mon, 23 Aug 2021 10:05:09 +0100
Date:   Mon, 23 Aug 2021 10:05:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] amba: Properly handle device probe without IRQ domain
Message-ID: <20210823090508.GO22278@shell.armlinux.org.uk>
References: <20210816074619.177383-1-wangkefeng.wang@huawei.com>
 <YRw32YE4cnNnWSvl@robh.at.kernel.org>
 <b5ccbf00-b686-d35b-c81a-0ec69f4677a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ccbf00-b686-d35b-c81a-0ec69f4677a0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:19:23AM +0800, Kefeng Wang wrote:
> 
> On 2021/8/18 6:27, Rob Herring wrote:
> > On Mon, Aug 16, 2021 at 03:46:16PM +0800, Kefeng Wang wrote:
> > > Patch 1 and 2 make some cleanup, and patch 3 use of_irq_get() instead of
> > > irq_of_parse_and_map() to get irq number, return -EPROBE_DEFER if the irq
> > > domain is not yet created, amba_device_add() will properly to handle the
> > > no IRQ domain issue via deferred probe.
> > > 
> > > Kefeng Wang (3):
> > >    amba: Drop unused functions about APB/AHB devices add
> > >    Revert "ARM: amba: make use of -1 IRQs warn"
> > >    amba: Properly handle device probe without IRQ domain
> > > 
> > >   drivers/amba/bus.c       | 100 ++++++++++-----------------------------
> > >   drivers/of/platform.c    |   6 +--
> > >   include/linux/amba/bus.h |  18 -------
> > >   3 files changed, 27 insertions(+), 97 deletions(-)
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks Rob.
> 
> Hi Russell, should I send the patches to the ARM patch system?

Yes please - I'll try to squeeze it in for this cycle but it's getting
a tad late for that. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
