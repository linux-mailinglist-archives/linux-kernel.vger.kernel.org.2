Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4641C430402
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhJPRyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:54:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhJPRyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:54:40 -0400
Received: from zn.tnic (p200300ec2f1ceb006062651ae72baf22.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:eb00:6062:651a:e72b:af22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 912441EC0390;
        Sat, 16 Oct 2021 19:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634406750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ted60gA90RO8nogAFVTIhwaV5qp7YGAkBiqZixtBxb0=;
        b=b4VqB0B09wJUSNd+eREO0vlRLthbd8ZkAyYc8VO5tqnlsL1fmtm+NSF3gz1SMtsXXdGmsS
        FmrQEhJmDuh3+M6VCME/8LCVb1YuC7Swp2iZ/GyuMwSMRFpRH40Dv3gry7HLcy3WDfqiXu
        7aRZP1qPqtcUdBRqCfVVt7JRYjPzmJc=
Date:   Sat, 16 Oct 2021 19:52:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marcos Del Sol Vives <marcos@orca.pet>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: add support DM&P devices
Message-ID: <YWsRXfdqEpHyPVpL@zn.tnic>
References: <20211008162246.1638801-1-marcos@orca.pet>
 <YWcQDYY9CuWKsayl@zn.tnic>
 <a7e54bfa-a015-2be7-e2c0-7bab47cc2b4a@orca.pet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7e54bfa-a015-2be7-e2c0-7bab47cc2b4a@orca.pet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 06:29:12PM +0000, Marcos Del Sol Vives wrote:
> Should I change it then?

Yes please.

> Should I also change the other two, possibly in a different patch?

So I looked at

  8d02c2110b3f ("x86: configuration options to compile out x86 CPU support code")

which added some of those !64_BIT deps. And when you look at

config X86_32
        def_bool !64BIT

and having those items either depend on "!64BIT" or on "X86_32" should
be equivalent. Former is just weird to have in other Kconfig items
except X86_32.

So yes, please, in a separate patch.

> I used that text because it's what every other x86 processor flag is
> also using, even those that also do not do any special initialization.
> 
> For example, the CPU_SUP_UMC_32 flag also has the same warning, yet
> arch/x86/kernel/cpu/umc.c reads "UMC chips appear to be only either 386
> or 486, so no special init takes place". I thus assumed this was
> standard text, in case at some point an special init is required.

Yah, sounds like they've all been copy-pasted from some item which
really needs special init.

> Do you think it should be then reworded, or should I keep it to mantain
> consistency with other existing flag descriptions?

Yeah, please write the correct statement in there and do not take the
other entries too seriosly - looks like semi-automatic copy-paste took
place.

> Greetings and thanks for your time,

Ditto and you're welcome!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
