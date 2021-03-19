Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01A34199B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSKLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:11:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KdBbV8/OXWtTCcyd1IKKVkbLO4A09JYxnlTNuWCStG4=; b=VeLnxRR/h1WJz4HSq3i94YtI2
        nFJG+kq846qcwC1V/Gz8Z+p4etwrafqoDtXTjLCWhtRvtRSGCh3yD9kpPsJl91OJy7w8C6kPI6xCr
        P8b3urGPiSgOWfFiu49lol13VD1pM4U/k2p8ZIdrWacwpJEKEz7WfHl+Xu8NR/r6QQhTiOu4hJmc0
        eL4j3TIzjt7+mb8jInW7ezhTWyQHKn3iSo88D7EU7PEhddtYwl9CL42hYUZ388YOf3ivV0NFQ0CQO
        24fzhwUEk4pvsI/sDC7gA/0mFuL6FT6HnDCjgmRzxC12XPGseZcf9jprql1PZn53VZCICRkDRqMGc
        n9m0R2IOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51474)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lNC5e-0004HU-S1; Fri, 19 Mar 2021 10:10:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lNC5b-0000Ue-8W; Fri, 19 Mar 2021 10:10:43 +0000
Date:   Fri, 19 Mar 2021 10:10:43 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] upstream boot error: WARNING in __context_tracking_enter
Message-ID: <20210319101043.GU1463@shell.armlinux.org.uk>
References: <0000000000004f14c105bde08f75@google.com>
 <CACT4Y+bLkFSc8manYrCukj-_nzwVsV9y6xYWXmGyYFS-PoBRPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bLkFSc8manYrCukj-_nzwVsV9y6xYWXmGyYFS-PoBRPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:54:48AM +0100, Dmitry Vyukov wrote:
> .On Fri, Mar 19, 2021 at 10:44 AM syzbot
> <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com> wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    8b12a62a Merge tag 'drm-fixes-2021-03-19' of git://anongit..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17e815aed00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfeed364fc353c32
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f09a12b2c77bfbbf51bd
> > userspace arch: arm
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com
> 
> 
> +Mark, arm
> It did not get far with CONFIG_CONTEXT_TRACKING_FORCE (kernel doesn't boot).

It seems that the path:

context_tracking_user_enter()
user_enter()
context_tracking_enter()
__context_tracking_enter()
vtime_user_enter()

expects preemption to be disabled. It effectively is, because local
interrupts are disabled by context_tracking_enter().

However, the requirement for preemption to be disabled is not
documented... so shrug. Maybe someone can say what the real requirements
are here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
