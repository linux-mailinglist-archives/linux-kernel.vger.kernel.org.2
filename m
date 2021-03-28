Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1534BA50
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 03:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhC1BHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 21:07:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhC1BH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 21:07:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616893644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fpLWOQa5k064vWr/E2BsDaZFcDqTg90RbjatbzXz1Ns=;
        b=Fi7bRzWzoFfgTCisJrfZsT5v7F9HUZkFDiMy4VgNxz4AmYIe6CTLh92i+TZDmj9kwCRUrw
        IpWErY9xOGPV612iDDSvj03IRIjzVVbGDf4sGBp30kgC9791EEtN1vQSnWt2DcgbZ3Ye+J
        uiqO06jlNrdDWXuTqJa6fsrCQNv1h4UyPPcB3uTNKjtYpyHa86zdgEwm5y2PsO6uVrr0Zr
        ZQjObvXJ8LPyZtrW1zIXmmK7dXNZiOJ6NzClGkgueagjR2aESzMXYFk5GVUFcPbCQxvQWV
        eZikPT70DCf46BG+su6hoZykx8dUbrLn5PyvBk5KIvEBxhu7Ca/0OTOVN7QnxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616893644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fpLWOQa5k064vWr/E2BsDaZFcDqTg90RbjatbzXz1Ns=;
        b=K/xAf2ZQF7IdmFcAk/JJiPTpZz+HYVCdsciQKZFQL6FI8v6hI5CPvJ41w5Sls3aAwpJUsY
        UqzXbyLZwXUqADDQ==
To:     Willy Tarreau <w@1wt.eu>, Mateusz Jonczyk <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
In-Reply-To: <20210327232551.GA20783@1wt.eu>
References: <20210327203218.119372-1-mat.jonczyk@o2.pl> <20210327211322.121708-1-mat.jonczyk@o2.pl> <20210327232551.GA20783@1wt.eu>
Date:   Sun, 28 Mar 2021 03:07:24 +0200
Message-ID: <87lfa8cchf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2021 at 00:25, Willy Tarreau wrote:
> On Sat, Mar 27, 2021 at 10:13:22PM +0100, Mateusz Jonczyk wrote:
> FWIW I tested on my ASUS 1025C which runs on an Atom N2600 forced to
> 32-bit. I had already tried in the past but wanted to give it a try
> again in case I'd have missed anything. Sadly it didn't work, I'm
> still getting the "requires an x86-64 CPU" message.
>
> Given these machines were really cheap, I've always suspected that they
> employ cheaper, low-grade CPUs, possibly having been subject to reduced
> tests where x86_64-specific parts were not even verified and might be
> defective. This may explain why they forcefully disable long mode there,
> but that's just speculation.

There are some of these '32bit only' CPUs out there in the wild which
actually support long mode. Some of them even do not have the long mode
CPUID bit fused out. But whether it works is a different story:

  - If the CPUID bit is on, then the chance is high, but it runs out of
    spec (guarantee wise)

  - If it's off is still might work by some definition of work as they
    might have fused off more or there are actual defects in some 64bit
    only area which are irrelevant when in 32bit mode.

Even if it could work perfectly fine, the BIOS/SMM/ucode can prevent
switching to long mode.

It's a lost cause.

Thanks,

        tglx
