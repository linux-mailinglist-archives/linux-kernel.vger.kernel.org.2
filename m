Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E8344C82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCVQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:59:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA6C061574;
        Mon, 22 Mar 2021 09:59:21 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:59:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616432359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQVfYmOjNdPPfTYQ9DYdWbQlRVy8ECEn1P6lOCZxTYo=;
        b=3BQH2Xlnq6MG2qFplKHQxUvgK39aFDz3Hru0oq8bZZ3qQQwM/72ZjC0mDS50mAIPXGPW1x
        ws7MC5j73QM5N84MYgHcL/A3qcnzs2HKxP0dmFO0jzo01OhK6mvq9YKtSBixbIiK0OX667
        IWhu2bF/FNwxiBC0TjoewSLDtUhMe+eMv57ikRal1yT9oNVZECCqjLI9zq9bx+42TLbesK
        1Y5OyrsbRf0qezLg6BKmQZPJF853TaluEWHQxGnuOxZXm0ufQ+ngsSZDDrN8ooaYkIR62o
        OfaZricXCezyJ/g9/Fw3j/SngzPiqdwFr8gg0xmFgWsMf1+sY110cipGDgbvig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616432359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQVfYmOjNdPPfTYQ9DYdWbQlRVy8ECEn1P6lOCZxTYo=;
        b=NoqlvPKS1+sioBwkL1BS9TP7pzlYMyQa2gzuj8HSqqkOYRTMbwOkeF6IAZLaXyaf//qV1N
        aXz1cVr1vseCvPBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] USB: ehci: drop workaround for forced irq threading
Message-ID: <20210322165917.it5d5f5kuvs7jah5@linutronix.de>
References: <20210322111249.32141-1-johan@kernel.org>
 <20210322164200.GB667925@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210322164200.GB667925@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-22 12:42:00 [-0400], Alan Stern wrote:
> What happens on RT systems?  Are they smart enough to avoid the whole=20
> problem by enabling interrupts during _all_ callbacks?

tl;dr: Yes.=20

The referenced commit (id 81e2073c175b) disables interrupts only on !RT
configs so for RT everything remains unchanged (the backports are
already adjusted for the old stable trees to use the proper CONFIG_* for
enabled RT).

All hrtimer callbacks run as HRTIMER_MODE_SOFT by default. The
HRTIMER_MODE_HARD ones (which expire in HARDIRQ context) were audited /
explicitly enabled.
The same goes irq_work.
The printk code is different compared to mainline. A printk() on RT in
HARDIRQ context is printed once the HARDIRQ context is left. So the
serial/console/=E2=80=A6 driver never gets a chance to acquire its lock in
hardirq context.

An interrupt handler which is not forced-threaded must be marked as such
and must not use any spinlock_t based locking. lockdep/might_sleep
complain here already.

> Alan Stern

Sebastian
