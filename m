Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999BF369B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbhDWT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhDWT6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:58:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF5C061574;
        Fri, 23 Apr 2021 12:57:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cb1003e0d9ed13dff4615.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:b100:3e0d:9ed1:3dff:4615])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70E671EC0249;
        Fri, 23 Apr 2021 21:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619207876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wvsKEi1eJGHeLPZJEa6xjsiy+KUSZ+p+/AowYRFXmJo=;
        b=NAgX5GALzUPNTfLUFHa98J47MGRV4yTiiQNhL10loUF9WoVcrYAhVEv2tu2YyjJD2faiRP
        qctjdpxPjB3TTCnPyHb2w1QOpGC2jzJtrjaOhODIQhwDpS66zkFmVTWAxPsngtLDSL41zB
        u4Ja05+8K/mhHO7JeUHNF7vAiDozpw0=
Date:   Fri, 23 Apr 2021 21:57:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <YIMmwhEr46VPAZa4@zn.tnic>
References: <20210415044258.GA6318@zn.tnic>
 <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic>
 <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:35:30PM -0400, Len Brown wrote:
> Yes.  If a library decides to execute AMX instructions on behalf
> of a task, the kernel will allocate an 8KB context switch buffer
> on behalf of that task.

Again, the library should ask the kernel first whether it supports AMX.
And the process should decide whether to use AMX - not the library on
its own, on behalf of the process.

> Granted, if you find a reason to dislike AMX, the mechanisms to disable
> it today are on a system-wide basis, not on a process or task basis.

Again, I don't dislike the feature. I don't want libraries jumping on
new features without asking the process or the kernel first especially
when those features have performance implications and need kernel
support.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
