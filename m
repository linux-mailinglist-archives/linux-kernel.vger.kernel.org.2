Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021E03493E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCYOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhCYOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:20:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A5CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bwkza07CK3I496mJr/hRCcP/6zzNBPLmmcQvRMvQpIk=; b=bNiYsVmUPdL0JtJJdhnG+Pjgt
        nNOQ2c0vi3MKCbNbXiAQ9lkCp1aSp7x6yBuZfpJE7/LYeFhyi9rfZB4XRS6L++c0eWn6aks6doT+m
        WOdDyXJfpbLlN//9cHJb22+tenfVjS20UEuDRRpoVy9t4yzjH1cK8eyN+Qs55vl1EnbqMzDBPnx6p
        J389/4oPWk8pUYgQvP3qq5V+J2mCoYxCb+85SwAu1onF0zvs+TjgijaCqV4iI+TH7FDgRxkVGq6gI
        TpPDa0TYEnyYDtaBXhWLs2XfQlt1dGQOE8NtsXDA9TRiUf6Sktze9xjLNdgjIEF1BGYhZfzL9XVOw
        0uZiBLjNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51724)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lPQqO-0001pW-Ar; Thu, 25 Mar 2021 14:20:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lPQqJ-000658-TU; Thu, 25 Mar 2021 14:20:11 +0000
Date:   Thu, 25 Mar 2021 14:20:11 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Liu Xiang <liuxiang1999@gmail.com>
Cc:     Liu Xiang <liu.xiang@zlingsmart.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com
Subject: Re: [PATCH] ARM: fix smp_processor_id() in preemptible warning in
 harden_branch_predictor()
Message-ID: <20210325142011.GN1463@shell.armlinux.org.uk>
References: <20210325095049.6948-1-liu.xiang@zlingsmart.com>
 <20210325100605.GL1463@shell.armlinux.org.uk>
 <CAPPcxxSzNvGu3y+3Fpc5FtV-6mOBPWMihmGhHnbq_qAHe3oYTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPPcxxSzNvGu3y+3Fpc5FtV-6mOBPWMihmGhHnbq_qAHe3oYTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:32:35PM +0800, Liu Xiang wrote:
> Russell King - ARM Linux admin <linux@armlinux.org.uk> 于2021年3月25日周四 下午6:06写道：
> >
> > On Thu, Mar 25, 2021 at 05:50:49PM +0800, Liu Xiang wrote:
> > > When CONFIG_HARDEN_BRANCH_PREDICTOR is selected and user aborts occur,
> > > there is a warning:
> > >
> > > BUG: using smp_processor_id() in preemptible [00000000] code: errnotest/577
> > > caller is __do_user_fault.constprop.4+0x24/0x88
> > > CPU: 1 PID: 577 Comm: errnotest Not tainted 4.14.188-rt87-fmsh-00004-g58055877a #1
> > > Hardware name: FMSH PSOC Platform
> > > [<8010d6d4>] (unwind_backtrace) from [<8010a228>] (show_stack+0x10/0x14)
> > > [<8010a228>] (show_stack) from [<80698f44>] (dump_stack+0x7c/0x98)
> > > [<80698f44>] (dump_stack) from [<803d17d0>] (check_preemption_disabled+0xc4/0xfc)
> > > [<803d17d0>] (check_preemption_disabled) from [<80110eb8>] (__do_user_fault.constprop.4+0x24/0x88)
> > > [<80110eb8>] (__do_user_fault.constprop.4) from [<801112e4>] (do_page_fault+0x2dc/0x310)
> > > [<801112e4>] (do_page_fault) from [<801012a8>] (do_DataAbort+0x38/0xb8)
> > > [<801012a8>] (do_DataAbort) from [<8010b03c>] (__dabt_usr+0x3c/0x40)
> > > Exception stack(0xb21d1fb0 to 0xb21d1ff8)
> > > 1fa0:                                     fffffff4 00000000 00000054 fffffff4
> > > 1fc0: 00000000 00000000 7ed81cc8 7ed81ca0 0007a440 00000000 00000000 00000000
> > > 1fe0: 00000000 7ed81ca0 00010493 0001f330 20030010 ffffffff
> >
> > This is not the right fix - preemption is supposed to be disabled before
> > this function is called. I'm not sure at the present time what the right
> > fix is supposed to be because I've forgotten most of the background
> > behind why this was placed where it is.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
> I have tested with the current mainline kernel, the warning still exists.

Yes, it still exists, because it's never been fixed, but the way you are
fixing it is not correct. We do not paper over warnings with incorrect
fixes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
