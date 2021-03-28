Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFF934BC58
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC1MiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:38:03 -0400
Received: from mx-out.tlen.pl ([193.222.135.175]:26369 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhC1Mh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:37:59 -0400
Received: (wp-smtpd smtp.tlen.pl 22659 invoked from network); 28 Mar 2021 14:37:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1616935076; bh=7Svvik2UzcKhTxyxI6ZgB3tQFlLo0yPD+EfYuon8cLY=;
          h=To:Cc:From:Subject;
          b=srqXskzkMQ2npBRklBgqc42lXY3/vUxigFLXhqzylS2C8A23Jg7ApZp9cfDjOALIf
           VoPATjIysOgFLtCIgG489sgnbwAinOxM7521n5IQD566OmCG3iwKnHoXyonJow4I+4
           snJ9Y/jdSnQKBUWhBfEoA/2wO5jRhjcpM89kGdM8=
Received: from aclp172.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.10.117.172])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 28 Mar 2021 14:37:56 +0200
Message-ID: <059b4775-e130-27c4-26fc-3a0eca07ddae@o2.pl>
Date:   Sun, 28 Mar 2021 14:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>, Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
References: <20210327203218.119372-1-mat.jonczyk@o2.pl>
 <20210327211322.121708-1-mat.jonczyk@o2.pl> <20210327232551.GA20783@1wt.eu>
 <87lfa8cchf.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
In-Reply-To: <87lfa8cchf.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 354c18b07433a45bda22440b695f33a7
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EbOU]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 28.03.2021 o 00:25, Willy Tarreau pisze:
> FWIW I tested on my ASUS 1025C which runs on an Atom N2600 forced to
> 32-bit. I had already tried in the past but wanted to give it a try
> again in case I'd have missed anything. Sadly it didn't work, I'm
> still getting the "requires an x86-64 CPU" message.

Thank you. It looks like your bootloader uses the 16-bit kernel boot protocol. 
The 16-bit kernel boot code checks for x86_64 presence with a similar message ( 
inside arch/x86/boot/cpu.c ), which I did not patch out. If you would like to 
test again, use the same patched kernel, but change in GRUB: "linux16" to 
"linux" and "initrd16" to "initrd" to use the 32-bit boot protocol. Which 
distribution and bootloader do you use?

W dniu 28.03.2021 o 03:07, Thomas Gleixner pisze:
 > There are some of these '32bit only' CPUs out there in the wild which
 > actually support long mode. Some of them even do not have the long mode
 > CPUID bit fused out. But whether it works is a different story:
 >
 >   - If the CPUID bit is on, then the chance is high, but it runs out of
 >     spec (guarantee wise)
 >
 >   - If it's off is still might work by some definition of work as they
 >     might have fused off more or there are actual defects in some 64bit
 >     only area which are irrelevant when in 32bit mode.

Of course, force enabling x86_64 would require passing a kernel command line 
parameter with a prominent warning in documentation, just like with "forcepae".

Greetings,
Mateusz
