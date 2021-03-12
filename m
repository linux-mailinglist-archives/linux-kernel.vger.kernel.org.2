Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E834B339560
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCLRrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhCLRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:47:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D523C061574;
        Fri, 12 Mar 2021 09:47:04 -0800 (PST)
Received: from zn.tnic (p200300ec2f095300e2515c6227fc5863.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5300:e251:5c62:27fc:5863])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A58E51EC0253;
        Fri, 12 Mar 2021 18:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615571220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fY8r53t9pbRenDi1G2fyADL+FGzPpd/9qCxNtjDbrCk=;
        b=Z/5MX6Gz8Zds6X0oz7l4aNvSZF6mevhlDSTBDrfZnLcKS1xEuJWB+tb1KRVw+lz6D3tZrV
        eun3zZ/XL0pudWgp6C4VZLHzqREeThbZwIfgqiXcbEw+K9OuIonHv7eRYBAHLbUoWwrAPa
        gsTgVynnKIbsnsi/wOQx867C7g/hlm0=
Date:   Fri, 12 Mar 2021 18:46:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210312174654.GB22098@zn.tnic>
References: <20210312113253.305040674@infradead.org>
 <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
 <20210312144726.GA22098@zn.tnic>
 <20210312122622.603bd82c@gandalf.local.home>
 <CA+icZUUpQWtLcqjK+07ktO5PCoJ+2HEHzyp4tRRqHZpAOatq5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUUpQWtLcqjK+07ktO5PCoJ+2HEHzyp4tRRqHZpAOatq5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:35:45PM +0100, Sedat Dilek wrote:
> Hey Steve, you degraded me to a number :-).

How did he degrade you to a number?! Actually, he went the length to
patiently explain what you could do.

> I dunno which Git tree this patchset applies to, but I check if I can

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

master branch.

> apply the patchset to my current local Git.
> Then build a kernel in the same build-environment.

Yes, what Steve said. You can run some benchmarks and compare
before/after numbers.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
