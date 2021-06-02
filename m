Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F09398F74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhFBQAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhFBQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:00:35 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71290C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xE3+bSp5Uq0gZUInDE6RsIp0ZZwW4TKitUfgOu4xU6o=; b=0dBsKgvLd8j9MEogNOQasu51H
        f0UAVkQZNLu3Zwid7ejnCBZPonLqsFVB9IUiyzI/s7Ncg6kxw6MnHxY+kt6upYfDIKTpP/3HY+zkb
        XBPEd+gfR+n5+uaMTiRPj2qZ2tpVKnDDCowmsf7aOIBec2sTo8lyJ7jLU63+BCGsXZWImuJlwDAcg
        RtZGoyS1pUlR/jBv9ejYJCUlh0LVP40euTM4/73VMihvO3QTiWPrrEj1iUSc7R4v1q2j3+BZbtbyu
        SGorxmNi3W495y8aSOdVwHWkf1aKK8AwbsSbj83i82ant6V9yb8N7eIXHqD0HLJo+f/VoVtKAAVdC
        lmoZj+1kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44634)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loTGY-0001TQ-OH; Wed, 02 Jun 2021 16:58:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loTGV-0001Fi-DN; Wed, 02 Jun 2021 16:58:43 +0100
Date:   Wed, 2 Jun 2021 16:58:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 7/7] ARM: mm: Fix PXN process with LPAE feature
Message-ID: <20210602155843.GN30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-8-wangkefeng.wang@huawei.com>
 <20210602105255.GK30436@shell.armlinux.org.uk>
 <62f08378-85e7-2a07-3fd0-b287047ce1b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62f08378-85e7-2a07-3fd0-b287047ce1b5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:13:14PM +0800, Kefeng Wang wrote:
>   IFSR format when using the Short-descriptor translation table format
> 
>     Domain fault      01001            First level   01011     Second level
> 
>     Permission fault 01101            First level   01111     Second level
> 
>   IFSR format when using the Long-descriptor translation table format
> 
>    0011LL Permission fault. LL bits indicate levelb.
> 
> After check the ARM spec, I think for the permission fault,  we should panic
> with or without LPAE, will change to

As I explained in one of the previous patches, the page tables that get
used for mapping kernel space are the _tasks_ own page tables. Any new
kernel mappings are lazily copied to the task page tables - such as
when a module is loaded.

The first time we touch a page, we could end up with a page translation
fault. This will call do_page_fault(), and so with your proposal,
loading a module will potentially cause a kernel panic in this case,
probably leading to systems that panic early during userspace boot.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
