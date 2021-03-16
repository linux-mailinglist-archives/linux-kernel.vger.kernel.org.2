Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC85133D0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhCPJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhCPJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:24:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDF1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L2lx90o4BdDmWpFbAcu+Og+AgfQH5O8WgM23Jxff4nc=; b=hmARNqg0Svho+vO/JBIUs7EI+
        1vknHLnSdjHtxZo46iPrDa7FyH0C9PJL0ijLqQqy66n1w3MGzTkKAfbXCX/TiXMb3Wreecw0I9nW9
        Y6HhVZrFf0h3HfkgS92g9cDuWEMzV3vDWYeIa5c6dreBEdNiDKM/ED99EwxLAtDQ2RW1d/Db2DKfd
        SmVhQW/HFSLSZ7XXjzdxuinfb0IA6muO+jF3hsVsOzfQmcUXo6vYBGY3ybBVap4VzPvWOCUndKrbw
        j9MJ0trTgvMCiAJjmM2WeRtNV1pzDAkdWN9/lFZhzoWxTb/mjKay1dXXDDth0YacX02S2KxqcksK3
        26w7s9jaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51352)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lM5w7-00018R-8R; Tue, 16 Mar 2021 09:24:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lM5w5-00068s-Gs; Tue, 16 Mar 2021 09:24:21 +0000
Date:   Tue, 16 Mar 2021 09:24:21 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
Message-ID: <20210316092420.GN1463@shell.armlinux.org.uk>
References: <00000000000069802205bda22b7f@google.com>
 <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:59:17AM +0100, Dmitry Vyukov wrote:
> On Tue, Mar 16, 2021 at 8:18 AM syzbot
> <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1e28eed1 Linux 5.12-rc3
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167535e6d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e0cee1f53de33ca3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0b06ef9b44d00d600183
> > userspace arch: arm
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com
> 
> +arm32 maintainer
> I think this is a real stack overflow on arm32, the stack is indeed deep.

There's no way to know for sure because there's no indication of the
stack pointer in this, so we don't know how much space remains.
Therefore we don't know whether this is something in the dumped
path, or an interrupt causing it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
