Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3E38756E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbhERJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbhERJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:45:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81EFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qfku/C/ExMDL6MsQW+4VS8Zyso0vOR9HeqIIBWxXDsQ=; b=aT7kvUX4ZgWiC2MZBAYrVFoRr
        Vph8pBGByIX51D+IxTJu2yu3C0QakB/JSogfuy+EbjG05Pn2CsvAqBplyiz4wIgj2x2O32yiEh0Dm
        e40eMr3CJ3yo3u2ePLEppfnQk3Ywgbj0DyOEdSsmqYc7Mhfd26GNE8XqygVja3GZUGO+BE8FfVpe0
        trorCvz+swJuaa2kW6LJJx+zTLJDboFQn3eOSJ47YYswMvp5GzR/UZAWI0kHKiGMP/LuuEAye092v
        NY7Ga/oY+e1wUGJiCKZ97qNw7Bxg9W3lts01UyJeKv6fO6l2yzYRMBMB3tr9E/6umHhb4gllOPXOh
        gvcce1yhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44120)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1liwH7-0003z6-Be; Tue, 18 May 2021 10:44:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1liwH5-0007mk-5D; Tue, 18 May 2021 10:44:27 +0100
Date:   Tue, 18 May 2021 10:44:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
Message-ID: <20210518094427.GR12395@shell.armlinux.org.uk>
References: <20210518090613.21519-1-rppt@kernel.org>
 <20210518090613.21519-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518090613.21519-4-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 12:06:13PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> When unused memory map is freed the preserved part of the memory map is
> extended to match pageblock boundaries because lots of core mm
> functionality relies on homogeneity of the memory map within pageblock
> boundaries.
> 
> Since pfn_valid() is used to check whether there is a valid memory map
> entry for a PFN, make it return true also for PFNs that have memory map
> entries even if there is no actual memory populated there.

I thought pfn_valid() was a particularly hot path... do we really want
to be doing multiple lookups here? Is there no better solution?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
