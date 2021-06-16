Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34F3A9622
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhFPJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhFPJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:31:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zijywzcu+CRpy/ste35r5eGAhkZFfZgYscvI8y8dbwg=; b=DgHkYvIY5f4HrojOxk+6Los3F
        6s/7F4MufGeVJsyeuJXSDhRMhHEPVB/RvnxGVR8JY1QZNg3LnxYQfSyKS2z7LBpE/p8bucZ248GKG
        d/ZVFelm142vbbhS62giUFbmD+3yZn7B9yPU4XsxilNobujAMVQBGyXF9wOJJrLXoQy0iG8tZqC/h
        MmNhfyAQok6XRUO/QrZg7bE4O3F/dY9E0HaYmVcw5XxsuIWPRl7R5Adw8jYdDbcATtOhchsv1R+A6
        M4DR6+szwRaqzS1Z8Ik7A9dTHcB06wC3j2+6j6jQhfJC/DlprdfxGwCYnoeTJ1j5u2vpWVB/Zqt7Q
        wpFWYHLlw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45054)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ltRqr-0006yX-NZ; Wed, 16 Jun 2021 10:28:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ltRql-0005tq-Ng; Wed, 16 Jun 2021 10:28:43 +0100
Date:   Wed, 16 Jun 2021 10:28:43 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Message-ID: <20210616092843.GZ22278@shell.armlinux.org.uk>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:21:12PM -0700, Andy Lutomirski wrote:
> On arm32, the only way to safely flush icache from usermode is to call
> cacheflush(2).  This also handles any required pipeline flushes, so
> membarrier's SYNC_CORE feature is useless on arm.  Remove it.

Yay! About time too.

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
