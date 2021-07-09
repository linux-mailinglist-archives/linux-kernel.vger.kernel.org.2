Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26D3C221B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhGIKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhGIKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:19:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C6C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+5TICEsa94xNlu+MZ0tydmQ+U5vWint8NY+YS0CgtLc=; b=W8AmzrPBw7iJxbKQeZ5eRqIIA
        7cNn5zbRxcRp8/Bpt/6v0HIEDFr+LIQ7VSYSqujbtWV3MYYBlNe1KH+XLAKoasU5R03JgGF34bXAU
        F++yS6EC0aLTznbLp87HXkbuZFt93AnbhiQM3rnqe15JiK6etWyXxBgRz2h7f3ZdINkeS1idhQGUm
        aH+IMcLZJjB84ps5Elmh/bvEpmrWq+zS4mCCO0jdPynOGIgJbh3wh/2cnqt81+Kck1ELm4nzZnrYx
        ecZXDEab/e/8+bmdrhljGmC0j4L2Ciiet30zPajs6ytzj48B7VY6dtwP0xrvl7NjpKrfS6JF4cBc9
        ur8ckvLGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45908)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m1nYO-0001ii-Ni; Fri, 09 Jul 2021 11:16:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m1nYM-0004st-Dy; Fri, 09 Jul 2021 11:16:14 +0100
Date:   Fri, 9 Jul 2021 11:16:14 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <20210709101614.GZ22278@shell.armlinux.org.uk>
References: <YOgK8fdv7dOQtkET@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOgK8fdv7dOQtkET@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 04:38:09PM +0800, Ming Lei wrote:
> I observed that NVMe performance is very bad when running fio on one
> CPU(aarch64) in remote numa node compared with the nvme pci numa node.

Have you checked the effect of running a memory-heavy process using
memory from node 1 while being executed by CPUs in node 0?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
