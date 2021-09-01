Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95843FDF0B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbhIAPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:53:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbhIAPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:53:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630511545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+yda3g4fKSFe6XDTsrt7qrSW4bNugPlghIrwmhx3x0=;
        b=C/5O4ExxT+IFac5OHCKVNVEfI+hFfrc9JlxjqNnk8bWiLyx5+Y46tloXH2GSNEZOiG4Ch1
        66JW0ynhR0Myk/q/ywfsCVLK4lEhsNEcbvYcLgNu7/5nBZNyXi0Yxo4IuLOIA6T+UhZzEf
        /bnZ+NtxNbCue0fsRMJP0Wf80Hw0DSuLqgH4u2koUgod3DZ4TkC8cAxuB5R774kYeRYs16
        6q5ZReVT7DeSYkNRx3rWFm5szBCOlfjBrY0HjzM+2KJqIQMRU2yT5/xo4jcDLbw3pCU6rO
        gGDl/z4sP7rpzqxMznLeQSt+dNRYYZvlrhlD1iMJzoZ4FoKyRl7LtC9/Opmyvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630511545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+yda3g4fKSFe6XDTsrt7qrSW4bNugPlghIrwmhx3x0=;
        b=WSkcx623E69QR+EzfTbdZ5qRr9Fck28tLewB/UrRjoY5u5rFmJcQadzz+YfPL+GeJo0cyV
        VQgk1AWIrgeLcQCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <87r1e8cxp5.ffs@tglx>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <87r1e8cxp5.ffs@tglx>
Date:   Wed, 01 Sep 2021 17:52:25 +0200
Message-ID: <87o89ccmyu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01 2021 at 14:00, Thomas Gleixner wrote:
>
> commit b2f9d678e28c ("x86/mce: Check for faults tagged in
> EXTABLE_CLASS_FAULT exception table entries") made use of this in MCE to
> allow in kernel recovery. The only thing it uses is checking the
> exception handler type.
>
> Bah. I'll fix that up to make that less obscure.
>
> The remaining two use cases (SGX and FPU) make use of the stored trap
> number.

Though while for the FPU use case we really want to handle the #MC case,
it's not clear to me whether this is actually correct for SGX.

Jarkko, Sean, Dave?

Thanks,

        tglx
