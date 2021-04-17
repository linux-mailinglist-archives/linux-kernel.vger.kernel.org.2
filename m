Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B140436329F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhDQXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:10:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhDQXKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:10:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618701020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psEFuLFbcbSDmGJY//b0/L0oZdcXhaw/o9eQRBL7E+A=;
        b=qc7cO6hIv0vmDQgTyrbHML9x4qjhGzXRQ6bRag4yR84Ikp/ZYhTd7MGWLgVjocdMQ4lhfb
        f1ppmZ6aCb1lbObkiF9Nwe2C6gIFPti8cviX63kZOApo6U7p5xzeaIlRmDVHpNN+9mjVlr
        aS0wfsZ7Curk7HBJeixcPXu4IP7vNvfxXwpgBVymUFpe59WW2KegIBL0ffmBjxw0NhV3/m
        nNefeg5gb3wjJqS94ZB5o5ogpXG3I0ifshtcxvRYOzF5C1gfD2YA6/p7Pc1G6iyNrS8yvK
        3ab1W8CE8WM2xWHLB83H10A1Z+/83V9WZDxAFDc71EkxEqWi0JmwYs+98VADSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618701020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psEFuLFbcbSDmGJY//b0/L0oZdcXhaw/o9eQRBL7E+A=;
        b=sTpKrQyQ1OJZZznulucYo6OqXXHKROh1JzfCGjgC/fy5aBqyDFFBzVgP5D3NDopE1Dsw8Z
        xFkOMuEwKS5keLDw==
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix set apic mode from x2apic enabled bit patch
In-Reply-To: <87k0p0sfhq.ffs@nanos.tec.linutronix.de>
References: <20210415220626.223955-1-mike.travis@hpe.com> <87k0p0sfhq.ffs@nanos.tec.linutronix.de>
Date:   Sun, 18 Apr 2021 01:10:20 +0200
Message-ID: <87h7k4se1v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike!

On Sun, Apr 18 2021 at 00:39, Thomas Gleixner wrote:
> If you can't come up with something sensible anytime soon before the
> merge window opens then I'm simply going to revert 41e2da9b5e67 and you
> can try again for the next cycle.

so I just figured out that Boris wasted his time once more to fix that
up and redo the commit in question.

Won't happen again.

Thanks,

        tglx
