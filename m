Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E26398690
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhFBKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhFBKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:33:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E2C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xesr2NHy46oTkj5F598BjmgtyfqdebzNtCPOQtN41lI=; b=MOwT8PujIUWB35U7E+cZMFH4T
        0tquQUglgUSrEQnekmx1Bbgm3tsDglEDWW7ztmf+pyIOZ/sTtYSNV7cSqvUnxgon2oT5quVoVppqK
        zv4nOuc/JcYB/s1VAjRCCtBAS5MBqtB4ibq6fNF1CFJIsLw4Te9ow/DT4l6fACOF937UCxQv3JTFw
        8kgWmVbMFAV/EOs6mMtl9tRl9B13miAFLm9L7WsvHw0nXxo1ewghD9Nxk6id8J0UUFaUjnamMnS1o
        e9UK5oELtrDV15Z80S58RhN1SNHeCBIKQz9mL0Fs8TjVBekd11xD0/tF2CHbgKcrUJUD3lrsIU8Nf
        CUsc03eCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44612)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loO9a-0000zJ-70; Wed, 02 Jun 2021 11:31:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loO9Z-00012a-P0; Wed, 02 Jun 2021 11:31:13 +0100
Date:   Wed, 2 Jun 2021 11:31:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 2/7] ARM: mm: Kill task_struct argument for
 __do_page_fault()
Message-ID: <20210602103113.GF30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-3-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 02, 2021 at 03:02:41PM +0800, Kefeng Wang wrote:
> The __do_page_fault() won't use task_struct argument, kill it
> and also use current->mm directly in do_page_fault().
> 
> No functional change.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

This looks fine, thanks. Please send it to the patch system, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
