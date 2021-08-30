Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99F3FBAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhH3RcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:32:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhH3RcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:32:05 -0400
Received: from zn.tnic (p200300ec2f0b3b00d8cdf5b388faf601.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:d8cd:f5b3:88fa:f601])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA53F1EC03FE;
        Mon, 30 Aug 2021 19:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630344666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F78NScsYpwqvpgPkUnjQEmzNw8vwPloEwqLWWWjPdIc=;
        b=gHUjM8LYBihZBiKhxG8eUaIU3GxJ2Eiiesqv/h+xzfolzQ4oGd5/9WDhUZNADUJjEKo20k
        FoL46yG1P5ScJPkMUGE45AcXKsGLgLoDSTKU2IGtfTE8269oCIeu7qFBnLBUPH6AIfDvg2
        nFpd1lz9pomQDEy1g7pbJ0uop7cvML8=
Date:   Mon, 30 Aug 2021 19:31:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YS0V//png0YVPWHG@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
 <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5>
 <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
 <YR14zq2LaExjhFR+@zn.tnic>
 <CAJvTdKnhn8rOKUJ0VKvM08sFYkvmEsSWBsH2ynncxH9_z49bxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKnhn8rOKUJ0VKvM08sFYkvmEsSWBsH2ynncxH9_z49bxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:22:18PM -0400, Len Brown wrote:
> We are forced to complicate their life for AMX (and subsequent features)
> because of the legacy Linux signal ABI.

No, we need to design this interface properly because you folks went and
put this AMX thing in xstates. Where it doesn't belong at all.

> We require that new apps invoke a system call to tell us that they
> are not indeed a legacy program, but that they are a program that
> understands if they use an alt-sig-stack that it must be big enough to
> handle whatever current hardware requires.

Yes, because of the reason I gave above. If no additional 8K fat wasn't
an xstate, we wouldn't be having this conversation.

> The secondary motivation for the system call is the desire to give the
> kernel a hook so that it can refuse to give permission for some apps
> to use AMX, should the need arise.

Yes.

> > prctl(GET_FEATURES_WITH_KERNEL_ASSISTANCE);
>
> The problem is that it adds zero value over the currently used xgetbv(XCR0).
> As it adds no value, programmers will not use it.

Bullsh*t.

First of all, it is a new interface we're introducing and if it is
there from the get-go along with examples how to use it and proper
documentation, people will.

Secondly, from a previous email of mine: "What if this modus operandi of
features userspace can use with kernel assistance but need an explicit
request and are off otherwise, gets extended beyond XSAVE-managed
features?"

In that case you can xgetbv() all you want but the new fat feature is
not even in XCR0. So *then* you *have* to introduce a new prctl() to
query supported features. And right then and there you wish you would've
done that from the very beginning!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
