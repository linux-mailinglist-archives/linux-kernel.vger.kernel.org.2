Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619243C20F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhGIIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhGIIpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5566135E;
        Fri,  9 Jul 2021 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625820186;
        bh=0cImG1X5ufWqEnPoqRKQx45VH1j1qXZqLZOS8MvKO7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AG0dH8uKQ3h/dsgJoiy2tOZ+JYL4upetQCIjFcX2TdjaYO6mmM/WEWT8zCStuBl5D
         080Ye2u8yItVTb2xFzzdckltPpdJnD9fsqltTbZkrg5xxxLFt/p0LThaMD02jEdZfy
         +u8xALybFuIunnIPSr8/TJupvC3ZBDXbyEWi54j/KFHQiQDQ0+AdxGl5EgASHHddos
         9ktJMdmu0Gy4rFu9zXk/kdSDrHH+xrqSY0QSQ4HauLWqGgCpbT0w0gIn2NN/MZMXZ0
         JjGMIVFZUxvi0xJ9jdKNn9m/EY5fdOOtjttHhcMsl4dKqQsnmHcQsHF2hjm95HMIdZ
         vjQwvtpIUpd1g==
Date:   Fri, 9 Jul 2021 10:43:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2] timers: Recalculate next timer interrupt only when
 necessary
Message-ID: <20210709084303.GA17239@lothringen>
References: <20200723151641.12236-1-frederic@kernel.org>
 <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
 <20210708153620.GA6716@lothringen>
 <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 01:37:11PM +0800, He Zhe wrote:
> 
> 
> On 7/8/21 11:36 PM, Frederic Weisbecker wrote:
> > On Thu, Jul 08, 2021 at 02:43:01PM +0800, He Zhe wrote:
> >> Hi,
> >>
> >> Ever since this commit merged in, when nohz_full enabled, the counts of arch_timer interrupt on arm64 arches keep increasing on cores that have been isolated. This can be reproduced on several arm64 boards. After reverting the commit, the counts would stop increasing after boot. my .config is attached.
> >>
> >> root@qemuarm64:~# uname -a
> >> Linux qemuarm64 5.13.0 #1 SMP PREEMPT Mon Jul 5 07:11:27 UTC 2021 aarch64 aarch64 aarch64 GNU/Linux
> >> root@qemuarm64:~# cat /proc/cmdline
> >> root=/dev/vda rw  mem=2048M ip=dhcp console=ttyAMA0 console=hvc0  earlyprintk isolcpus=1-5 nohz_full=1-5 rcu_nocbs=1-5
> >> root@qemuarm64:~# cat /proc/interrupts
> > And I'm not observing that on default aarch64 on qemu either.
> > Are you emulating a specific machine?
> 
> Here is my qemu configuration.
> 
> qemu-system-aarch64 --version
> QEMU emulator version 6.0.0
> Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
> 
> qemu-system-aarch64 -device virtio-net-device,netdev=net0,mac=52:54:00:12:35:02 -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,tftp=/qemuarm64 -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -drive id=disk0,file=/qemuarm64/qemuarm64.rootfs.ext4,if=none,format=raw -device virtio-blk-device,drive=disk0 -device qemu-xhci -device usb-tablet -device usb-kbd  -machine virt -cpu cortex-a57 -smp 4 -m 2048  -smp 6 -m 2048 -serial mon:stdio -serial null -nographic -device VGA,edid=on -kernel /qemuarm64/Image.bin -append 'root=/dev/vda rw  mem=2048M ip=dhcp console=ttyAMA0 console=hvc0 earlyprintk isolcpus=1-5 nohz_full=1-5 rcu_nocbs=1-5'
> 
> >
> > Can you enable the following trace events and send me the output from
> > one of the isolated CPU trace, say CPU 3 for example:
> 
> output_to_send is attached.
> I can confirm that during the sleep the count of arch_timer increases one on
> each isolated core.

Oh that's the trace from CPU 0, precisely the only one I don't need :o)

It's my fault, the last line of the script should have been:

cat $DIR/per_cpu/cpu3/trace > ~/output_to_send

Sorry...
