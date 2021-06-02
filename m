Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C813986F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFBKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhFBKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:51:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B197C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EkbXm6SBuZ2S0H9NVmaaiVML0Iec/wK4VouHyYsGZAY=; b=SVuQF9CmJN0EofsAoaGVsndKk
        EXJIlYIhoKZzXD0d/7t+XDiGdnPUc5ue6Mrspcj5xWXqXossC5eF315bJYzCCREK0/21pHpVzqlWm
        TBAPlyOEq2RQyWyBSLXNmwhLnJSO0I7A2tTM/rHXfYLXo6YhEjsSqfIwpkCj3YywBvWTfZh8gCiL9
        krXR74D8cKT7LymxFF79pnYtzBPlNciOEZd24p1YCX+YSImGSshHLLEeydNJZ/tLDwECNXwh3eJpH
        REaEXqsVkw0dwEYkxQEAGE4XntUy4YVGoer3m3ucM6+IjbNoLJydpDfWuzDzKkOwfPMqOsIajWGUK
        W9lgJA4RQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44620)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loORF-00013O-R8; Wed, 02 Jun 2021 11:49:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loORF-00014N-DZ; Wed, 02 Jun 2021 11:49:29 +0100
Date:   Wed, 2 Jun 2021 11:49:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 6/7] ARM: mm: Provide die_kernel_fault() helper
Message-ID: <20210602104929.GJ30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-7-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-7-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 02, 2021 at 03:02:45PM +0800, Kefeng Wang wrote:
> Provide die_kernel_fault() helper to do the kernel fault reporting,
> which with msg argument, it could report different message in different
> scenes, and the later patch "ARM: mm: Fix PXN process with LPAE feature"
> will use it.

This looks fine to me, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
