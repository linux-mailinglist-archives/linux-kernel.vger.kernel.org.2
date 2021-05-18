Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4F3876A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348562AbhERKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbhERKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:37:07 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3HQnmJvFwnqakmh608DrvB8oicJK2URFyDw6ZWw2EkA=; b=o6ElVB+kFcGaqyBi9092RhjhL
        60kc9eQ+86mSQ7mVJMtPDveI4AnsFmEEiVGOu4eq1+8DbDAxnb9S6mVDIPAE8ohxAsvI9/PyK8F3H
        hY6W7I4osHI7sGKwJ1AHfZs7VPdKxYOvTd+mHXD31V8ciE+qB8zuhToiKMvl4mX7meKzJaPuHxolV
        45AS6sWxwin61jmmSi6k8NCcbcChnlbB6cTTGS2dqv32K8Zs7hko6Bg3MBUlwXHn0El9NvNUK8nuR
        wOp6IwMxbZ+2yO7hReWfnINstAq9/znYB1Ce8YTg+U/7LIvVLy8gSDtJ6SinlqvxxPujZiRCLAjL7
        3WZ+LANFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44128)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lix4k-00047c-Vq; Tue, 18 May 2021 11:35:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lix4k-0007oo-Kt; Tue, 18 May 2021 11:35:46 +0100
Date:   Tue, 18 May 2021 11:35:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: initrd is disabled due to memory overlap
Message-ID: <20210518103546.GU12395@shell.armlinux.org.uk>
References: <YKOVzLHGcHoVTqSi@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOVzLHGcHoVTqSi@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 12:24:12PM +0200, Corentin Labbe wrote:
> Hello
> 
> On my SSI1328 gemini board, I use initrd=0x800000,9M in cmdline.
> On next-20210518 and 5.13-rc1 I got:
> Booting Linux on physical CPU 0x0
> Linux version 5.13.0-rc2-next-20210518+ (compile@Red) (armv7a-unknown-linux-gnueabihf-gcc (Gentoo 10.2.0-r5 p6) 10.2.0, GNU ld (Gentoo 2.35.2 p1) 2.35.2) #77 PREEMPT Tue May 18 12:14:41 CEST 2021
> CPU: FA526 [66015261] revision 1 (ARMv4), cr=0000397f
> CPU: VIVT data cache, VIVT instruction cache
> OF: fdt: Machine model: SSI 1328
> Memory policy: Data cache writeback
> INITRD: 0x00800000+0x00900000 overlaps in-use memory region - disabling initrd
> Zone ranges:
>   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
>   HighMem  empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> Built 1 zonelists, mobility grouping on.  Total pages: 32512
> Kernel command line: console=ttyS0,19200n8 initrd=0x800000,9M
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> mem auto-init: stack:off, heap alloc:off, heap free:off
> Memory: 117480K/131072K available (5459K kernel code, 595K rwdata, 1508K rodata, 180K init, 376K bss, 13592K reserved, 0K cma-reserved, 0K highmem)
> 
> On 5.12, initrd is used and works.

I think this is caused by the normal growth of the size of the kernel.
If you look in the System.map for the _end symbol, I think you'll find
that its address is larger than PAGE_OFFSET + 0x800000, causing the
overlap.

If so, the only realistic thing to do is to move the initrd higher up
in memory - I don't think you'll get much traction with the idea of
reducing the kernel's memory footprint.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
