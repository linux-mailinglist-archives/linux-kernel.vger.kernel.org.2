Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F307533D835
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhCPPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbhCPPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:51:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51043C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0x7tHwkCAch6coHUwoAB3iKvXa/LjrfJZbY/lbq9O0M=; b=kgZuqLN6kffeuqFkpC8KhGiT0
        qpol77Q7BRzHyKC02hrLQ9GjNk+sIEdh27SOsnYu5uKDg8kjl3Ki3M6MrS/QLh5SmbvOPSAUSJprH
        O3g2K5xgRHZ39f0pdRe4AE3iMEdw/M5Wkq0GnkntFMopTYvav36pfC5CC4zGOQ4ZA23aXP9aAfqiz
        H4hsEBKnnZg785gkRs/930B7NNAmirJHOE1d1t8MymgMYLMvoUVw0VQ9rHlj0Jw0HWeoWOh8xV4hP
        +cB03ub5/eDY8ICw1JTsdZGHVn+aw2Zv6zhjfb8VSSkdZ6VLC48FNNTJm+QkDvSv9Eb1m4b1yQ9TK
        +JTKPDVug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51374)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lMByJ-0001VG-OE; Tue, 16 Mar 2021 15:51:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lMByI-0006Mc-Ou; Tue, 16 Mar 2021 15:51:02 +0000
Date:   Tue, 16 Mar 2021 15:51:02 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
Message-ID: <20210316155102.GP1463@shell.armlinux.org.uk>
References: <00000000000069802205bda22b7f@google.com>
 <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Tue, Mar 16, 2021 at 11:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Mar 16, 2021 at 8:18 AM syzbot
> >
> > > > > [<8073772c>] (integrity_kernel_read) from [<8073a904>] (ima_calc_file_hash_tfm+0x178/0x228 security/integrity/ima/ima_crypto.c:484)
> > > > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline])
> > > > > [<8073a78c>] (ima_calc_file_hash_tfm) from [<8073ae2c>] (ima_calc_file_hash+0x124/0x8b8 security/integrity/ima/ima_crypto.c:572)
> > >
> > > ima_calc_file_hash_tfm() has a SHASH_DESC_ON_STACK(), which by itself can
> > > use up 512 bytes, but KASAN sometimes triples this number. However, I see
> > > you do not actually have KASAN enabled, so there is probably more to it.
> >
> > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> 
> Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> the closest I have installed, and I think the Debian and Ubuntu versions
> are generally quite close in case of gcc since they are maintained by
> the same packagers.
> 
> I see ima_calc_field_array_hash_tfm() shows up as one of the larger
> stack users, but not alarmingly high:
> ../security/integrity/ima/ima_crypto.c: In function
> ‘ima_calc_field_array_hash_tfm’:
> ../security/integrity/ima/ima_crypto.c:624:1: warning: the frame size
> of 664 bytes is larger than 600 bytes [-Wframe-larger-than=]
> none of the other functions from the call chain have more than 600 bytes
> in this combination of config/compiler/sourcetree.
> 
> In combination, I don't get to more than ~2300 bytes:

... which shouldn't be a problem - that's just over 1/4 of the stack
space. Could it be the syzbot's gcc is doing something weird and
inflating the stack frames?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
