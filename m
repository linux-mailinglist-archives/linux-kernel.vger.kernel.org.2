Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C83E7E05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhHJRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D16C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:09:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628615372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qzC/LvzQoV4rEBw81fDUV8N2YJ6GodUbmge4n5nlRYY=;
        b=PfRonojs7JWe7xu4IW2sSftyh4m0Y4rJryqyIu35UQtua2i/0v0n6i5SmnI5+K6O48R7I6
        mngicddYeveWzX0dWzQam7AB3JoLwM9vJKOKbfv2mvMQ9SJanaaKgk87LabcMCS+0haP+Y
        aXmtgVfBzeiEZnTUgTIZMvBniBEFMN8nSm7/53C9d6dIeBM4JfU2tsvNfGob1rtMuPkSTa
        d/3FQf1IHT43P4ABi+wQ9b/d3FnKIDJ49NRj24g3SytwaEUTMIzPwYTtCZEF+8Cd691pxo
        fUu7jZ1uCoGR+tBfpQ6aMHotinbnYdBX1h7Ii5QFtPMqQo+vHNf7WKYntRsiuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628615372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qzC/LvzQoV4rEBw81fDUV8N2YJ6GodUbmge4n5nlRYY=;
        b=7/fFI4h7TiEvKt/nJP4QMq6cyM7iMsOhGe1NAbPp80ZaFkExmwgydp0N5sPkxp5GEVjOvj
        jE20Smgq7jscJ6Aw==
To:     blinkin@email.it
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug report for kernel v4.15-rc8+
In-Reply-To: <217397770.2008922.1628604301644.JavaMail.zimbra@email.it>
References: <629765464.1655403.1628264743080.JavaMail.zimbra@email.it>
 <87tujxssp2.ffs@tglx>
 <217397770.2008922.1628604301644.JavaMail.zimbra@email.it>
Date:   Tue, 10 Aug 2021 19:09:32 +0200
Message-ID: <877dgtql9v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2021 at 16:05, blinkin@email.it wrote:
> The general symptom is a slow and unresponsive system (e.g. on gnome
> there's a delay before displaying typed characters, up to 3-5
> seconds. Animations are jittering, mouse clicks sometimes are missed).
> 3D games are now impossible to play due to poor performance.
>
> System feels as if the CPU is always busy (htop shows one core at ~
> 90% most of the time both with and without the workaround, not sure
> it's correlated)

That's definitely wrong. What is consuming CPU time?

> It's running OpenSuse Leap 15.2 (the bug came out when upgrading from
> 15.1, thus going from kernel 4.12 to 5.3) I suspect the same bug is
> responsible for making me switch to suse after failing to upgrade
> debian from 9 (kernel 4.9) to 10 (kernel 4.19)
>
> The workaround is to pass irqaffinity=0 on boot.
>
> Attached: dmesg output with and without the irqaffinity parameter,
> lspci output, /proc/cpuinfo contents.
>
> Let me know what else is needed.

1) You're booting with an out of tree module:

   > [   17.080069] vboxdrv: loading out-of-tree module taints kernel.

   Please reproduce without this.

2) Please provide information what is consuming 90% of a CPU

3) Please provide the output of /proc/interrupts for both boot scenarios

   Take a snapshot right after boot and another one a minute later.

Thanks,

        tglx
