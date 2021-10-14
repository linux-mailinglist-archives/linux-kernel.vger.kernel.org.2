Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9E42DF26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJNQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhJNQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:30:34 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C521C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lWEb+AyJl9QaLcJtyAVIkR4qyM24DSaL284UvHWF2yw=; b=D+XuSwwrDcU2Anv3c2W2Ucwl5Z
        XMM7bODIyLgHlLJ70KirA48585GE2GakzI0WLCjHGRuhYydvBMMKdbKUPpjJKI9B81lm5KPggHjGa
        slLAyXFKFQF+ciUANfbFNO79rmi3S+SoK3uAfMK+MqbvBH5uom/l0z3QTXEru6nLq4/4O2TxFGSKr
        XS7oXfoTQfLs580XxF3dd77DGJEztP7a1kXmIgVoTzlZze9ML+F1YbJpPegWkrne6l2OervmmdFVw
        blndwEEPs6WFmPwZ0Q8vP1EJvhpLsxdZJdanldtRbk/CM3eQje4x9a1NsZM8ydnAiqAhpJainN+Yu
        KO9igxNQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55108)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mb3ai-0001XP-0v; Thu, 14 Oct 2021 17:28:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mb3ae-0002IO-Eg; Thu, 14 Oct 2021 17:28:20 +0100
Date:   Thu, 14 Oct 2021 17:28:20 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/6] ARM: mm: cleanup page fault and fix pxn process
 issue
Message-ID: <YWhapJ4oiD2dJADk@shell.armlinux.org.uk>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
 <22320379-1905-d678-bfd7-2e5e118fa578@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22320379-1905-d678-bfd7-2e5e118fa578@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 09:41:23AM +0800, Kefeng Wang wrote:
> 
> 
> On 2021/6/10 20:35, Kefeng Wang wrote:
> > The patchset cleanup ARM page fault handle to improve readability,
> > fix the page table entries printing and fix infinite loop in the
> > page fault handler when user code execution with privilege mode if
> > ARM_LPAE enabled.
> 
> Hi Russell, I send the v3(most patches were reviewed by you in v2[1]) to
> ARM patch system due to no more comments, and this patchset is suspended
> too long without any changes, looking forward to your reply and hope it
> could be merged, many thanks.

I did explicitly ask for the first two patches to be sent to the patch
system during the v2 review as a way to cut down on the amount of work
to review the entire patch set each time a new version is posted. Sadly
that didn't happen, which is demotivating for a reviewer.

Having looked through the v3 patch set, I think I'm happy with it.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
