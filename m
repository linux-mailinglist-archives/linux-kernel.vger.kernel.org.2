Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0179326661
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBZRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:39:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44816 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBZRj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:39:56 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614361153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/BuqB3Oqx0tX4WNfP6KKpm8RPYgYW/KLWsgiNVhvs3E=;
        b=x7KrW2ykM4exs/iT7gBW0KuK7Q2QuqkHTQACVr+7TgroAD9Nhjf37tKbJRdMD2ZtuHoAKo
        r+tUgonAEXIQjU+VFiNdQ1Q9GFoKsjICFhYfvvg8rS3gX9Tf1L1qDuZScQOdQYyAvW0mGD
        6VBSxhZEz0SqpJWEhMmUtQc/R2RvF/W55mQT2JBNUTMvFD2seAcOxhCZOAe4dpnT+djCM9
        vXbpM0Sta7VdENd/+mCefiifPqcr1vxDClrORdb+w6jKqQGQdBQrQnMGs49m4Hqg5kTkR4
        ipFq+US+IEujnctcyHU05WWJR2lJh3csQAJcR2DwnMM+M2wppl2DUPU5nzAB+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614361153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/BuqB3Oqx0tX4WNfP6KKpm8RPYgYW/KLWsgiNVhvs3E=;
        b=GrxkUzIuAItpSsCg7WP1LZlRe7nFXWqayBjou22gY64xetZQI/mC6hQ8WauDI2VtGxxwfj
        Uv+/AOw6UhaORkCg==
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
In-Reply-To: <20210226171943.GA12088@oc3871087118.ibm.com>
References: <20210114170412.4819-1-john.ogness@linutronix.de> <20210226171943.GA12088@oc3871087118.ibm.com>
Date:   Fri, 26 Feb 2021 18:39:13 +0100
Message-ID: <87ft1iwwxq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-26, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> I am seeing KASAN reporting incorrect 1-byte access in exactly
> same location Sven has identified before. In case there no
> fix for it yet, please see below what happens in case of pretty
> large buffer - WARN_ONCE() invocation in my case.

It looks like you have not applied the fix yet:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08d60e5999540110576e7c1346d486220751b7f9

John Ogness
