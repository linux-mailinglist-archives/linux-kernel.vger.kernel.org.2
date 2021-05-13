Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B037F3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhEMIF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhEMIFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:05:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C52AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UGVeLUfkE741v0vrebTsGqGFMyK8FgbBkSmiFM6fwfU=; b=QPL6+9Dcdv9AnDuSsOZ42yggr
        t7qhBQOzMUrLxMDeN5+dQ6aQrHtcwZ3NDv0l358PO2RnbYAnbAZC48AAhoLu8XDOvCCse1wkylRTt
        L4jJbZ2xJiL27YMAtsYyFkwlEBgMWWxO3HTOiOfWTvOahUZ45lV9MyTNUTqNw9iv84G2Vrewf9bvy
        jwk6tvnyRLl/zk/+EzzqbHxdHrayhKogyfYhqoSljFLydJomhuFFO8mz67ZUAMJvrKU/gWzToXbrh
        i0NDIhfU2NPL3l/JqCyFebFFnwYPKquzKQQNVtZJ+LwiS3Vv370mpciKRgXxNunpGw3g003fpDzAP
        Zrm/7DtQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43914)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lh6K3-0005nc-KG; Thu, 13 May 2021 09:03:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lh6K1-0002pL-W2; Thu, 13 May 2021 09:03:54 +0100
Date:   Thu, 13 May 2021 09:03:53 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/mm: Drop [PTE|PMD]_TYPE_FAULT
Message-ID: <20210513080353.GR1336@shell.armlinux.org.uk>
References: <1620885113-5938-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620885113-5938-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:21:53AM +0530, Anshuman Khandual wrote:
> Drop these unused symbols i.e PTE_TYPE_FAULT and PMD_TYPE_FAULT.

They're documentation, although PTE_TYPE_FAULT ought to be used by
__swp_entry() to show that better.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
