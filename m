Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B7442914
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhKBIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:09:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC50C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:06:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f62005f026b777d4e743c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6200:5f02:6b77:7d4e:743c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCB491EC0399;
        Tue,  2 Nov 2021 09:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635840400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G6yyxNeqlLWfnq37kI68awUZHyi4mJlK1KBGc6GeZnI=;
        b=fQHPWpdkRccYya5PW65GVHlyDCI3wJr5oHprAEOex6mlKvsLIh7blNSA5JSAGQgH31OJ1I
        hU3kZs1Yi9CEwjwpXkIW2XSuE1YSmxpDKv19Yuym1W5GuS0GpZ7i8xpdtJRQ4EefxNBxMJ
        lsG8wqEZ3vp1/7vLi/uCMQg2q5bRYyY=
Date:   Tue, 2 Nov 2021 09:06:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] objtool/core for v5.16-rc1
Message-ID: <YYDxjPbncyWMRfrs@zn.tnic>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 09:00:36AM +0100, Peter Zijlstra wrote:
> Boris was having a poke at the MCE stuff.

Yeah, on it now that the merge window is open and I finally have some
time to do those.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
