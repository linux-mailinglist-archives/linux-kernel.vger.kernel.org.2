Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9239867E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFBKbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFBKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:31:16 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626F4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+9K0ZBY+cfWGtXy7iN7+32ZXUN6yO9gDst2tILKfNoQ=; b=V2c4PKbHUqXuQifwKnhHoE9Up
        RWm9TSqtCo4RaoK69ZNTIpW7ACz2ZxD2Iqm0SsouGhPHhWpregK4bJMbfHwIn6P0ltlHm9n+GDOZ1
        BCHmpyw429bpvlFfIRXuhFlW028ZkbhmeqLgQGmFoTapN/74Jos1btVmzb2q4Nq5cG/VenX4Ats5K
        Yr6Naagv1cerHLzf4i2QeGQzFSGXhXSRMdq5zSl8FY3wxXaUeycntI+gW2A2AXIRha9DIqVA9Zds6
        1EpGRaL2e4EBBc95xedLikzIlrna3hV66O49YFe1EHXzCWsFMvYtKZlEQ6i66b65MxRJ200i77ylj
        l2ZOUftbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44610)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loO7t-0000yx-RU; Wed, 02 Jun 2021 11:29:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loO7t-00012M-4x; Wed, 02 Jun 2021 11:29:29 +0100
Date:   Wed, 2 Jun 2021 11:29:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 1/7] ARM: mm: Rafactor the __do_page_fault()
Message-ID: <20210602102929.GE30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 02, 2021 at 03:02:40PM +0800, Kefeng Wang wrote:
> Clean up the multiple goto statements and drops local variable
> vm_fault_t fault, which will make the __do_page_fault() much
> more readability.
> 
> No functional change.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

This looks fine to me. Please send it to the patch system (details in my
email signature.) Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
