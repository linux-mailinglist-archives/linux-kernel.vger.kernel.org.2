Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963533493CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhCYOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhCYOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:10:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lgDxr472HzVsceFaWX9FCws+z+Dv6gd3htj2S1VADz0=; b=BXSgkdufodM52TvQu3niXghYW
        cqgWSiY7CmEMPV4MZFdIVIw5QlRoFgVqYjFMehLPlISSOij9mSQ3BOCh8qg3YeY8x1UAvpEAGwc4x
        VJhz6VbLBCKwnGK8zNU0GlnzlRqTFXyieMPQ10jmWCktePFUJHtHoTkJ+tHYAQi2kwdKQxzcJvMyF
        hHD3HPIDi5dgFqhRjgBQyWsgpO38go1r6eHH+///dj4E50jd2FLhS6jdxJi4RBRcY6Ty4IKGvZ1kk
        nsQ8LWOAHxNoOWJSA4oDlGcr9MDd8PdAdIS1SAiIdPB/dC3zH4rb+p7mwcfikks0+Zm3+DGCcio3v
        JK6sOhV9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51718)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lPQh8-0001oL-QQ; Thu, 25 Mar 2021 14:10:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lPQh4-00064v-MA; Thu, 25 Mar 2021 14:10:38 +0000
Date:   Thu, 25 Mar 2021 14:10:38 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, patches@arm.linux.org.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: syscalls: switch to generic syscalltbl.sh
Message-ID: <20210325141038.GM1463@shell.armlinux.org.uk>
References: <20210301142834.345062-1-masahiroy@kernel.org>
 <CACRpkdZ8niLC8+LFs3+Wa79HCzYGSmKN4uLbkHsY_zk881nPQA@mail.gmail.com>
 <CAK7LNASmu5EocRpQP5DLhkAz5ryHwHw24jO4w0au2tE+2jCo=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASmu5EocRpQP5DLhkAz5ryHwHw24jO4w0au2tE+2jCo=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 11:53:39PM +0900, Masahiro Yamada wrote:
> On Fri, Mar 5, 2021 at 7:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Mon, Mar 1, 2021 at 3:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > > Many architectures duplicate similar shell scripts.
> > >
> > > This commit converts ARM to use scripts/syscalltbl.sh.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > This looks good to me to FWIW:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thanks for the review.
> This patch is already in Russell's patch tracker.
> 
> I manually copy/pasted your Ack:
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9068/1

I see you added a note to 9067/1 about the order of 9067/1 and 9068/1:

"Obviously, 9068 was submitted 30 seconds before 9067, but the patch
tracking system unfortunately picked them in reverse order,
unfortunately."

The patch system doesn't "pick" the patches. It merely accepts them in
the order that it receives them. I also received them in reverse order
into my personal mailbox as well, and also in reverse order from
infradead's mailing list.

2021-03-01 14:29:57 1lGjYa-0004Dd-Ok <= masahiroy@kernel.org
H=conuserg-10.nifty.com [210.131.2.77]:21701 I=[78.32.30.218]:25
P=esmtps X=TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256 S=5966 DKIM=nifty.com
id=20210301142903.345278-1-masahiroy@kernel.org T="[PATCH] ARM:
syscalls: switch to generic syscallhdr.sh" for linux@armlinux.org.uk
2021-03-01 14:30:06 1lGjYj-0004Di-B3 <= masahiroy@kernel.org
H=conuserg-07.nifty.com [210.131.2.74]:55987 I=[78.32.30.218]:25
P=esmtps X=TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256 S=5811 DKIM=nifty.com
id=20210301142834.345062-1-masahiroy@kernel.org T="[PATCH] ARM:
syscalls: switch to generic syscalltbl.sh" for linux@armlinux.org.uk

2021-03-01 14:32:46 1lGjbK-0004E2-0t <= masahiroy@kernel.org
H=condef-10.nifty.com [202.248.20.75]:19522 I=[78.32.30.218]:25 P=esmtps
X=TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256 S=6136 DKIM=nifty.com
id=20210301142903.345278-1-masahiroy@kernel.org T="[PATCH] ARM:
syscalls: switch to generic syscallhdr.sh" for patches@arm.linux.org.uk
2021-03-01 14:33:47 1lGjcI-0004EF-Ny <= masahiroy@kernel.org
H=condef-09.nifty.com [202.248.20.74]:45947 I=[78.32.30.218]:25 P=esmtps
X=TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256 S=5981 DKIM=nifty.com
id=20210301142834.345062-1-masahiroy@kernel.org T="[PATCH] ARM:
syscalls: switch to generic syscalltbl.sh" for patches@arm.linux.org.uk

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
