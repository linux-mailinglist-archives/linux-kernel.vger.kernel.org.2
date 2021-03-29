Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1734D795
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC2SuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:50:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhC2Stf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:49:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617043774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jKxCL0ncWKe7zPEzTZWASnthFKodIPfsqi1oXGFkefU=;
        b=m7pWTXsOVhoQhSejYS3+GlX30pT0MHU2527Ok8kEmic1LUR0MURLTQydsaOg5mOeH/PdwD
        dWGVa5Z3dYCpic9TSUiLttwddP2wc3aYukB9TELAS5aA7qBwevxQVrpD/PXoR7pXyhaS5Q
        SPFoXdlLd2CnAftK6L5e0TThvybs1nY7zEr2VnpE31g0WNyQQRJePgfMobWDRVq5BjtzYE
        //YN1Q9vpJyGK+bfbGnMWuD23tbT6uYkTqN5aiPWZbwvCdmReDalE2C7QGEdw7gET52hMj
        FWkO8x5JNMSOP8YV7E6VzoCSrhZwUxFLO6+qtsMAtCmJG8VsIkQbspPwE9aJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617043774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jKxCL0ncWKe7zPEzTZWASnthFKodIPfsqi1oXGFkefU=;
        b=GVJgaksnA6ObJd+0LpC0i61HwIlweMsMgNpP0neuKbbZQ1i+FE4Z/RY2PiHdxw5XkxywPu
        Q/G8cGphADZabYCw==
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
In-Reply-To: <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de> <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com> <87r1jyaxum.ffs@nanos.tec.linutronix.de> <CAJvTdKnBRmogm6zF0KyDtx1VC_bpRa8_H1P9mxtMP06fy8a57g@mail.gmail.com>
Date:   Mon, 29 Mar 2021 20:49:33 +0200
Message-ID: <87ft0d7q2q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2021 at 11:43, Len Brown wrote:
> On Mon, Mar 29, 2021 at 9:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> But yes, if a bare metal OS doesn't support any threading libraries
> that query XCR0 with xgetbv, and they don't care about the performance
> impact of switching XCR0, they could choose to switch XCR0 and
> would want to TILERELEASE to assure C6 access, if it is enabled.

That's not the point. The C6 issue has nothing to do with the ABI
considerations vs. XCR0.

According to documentation it is irrelevant whether AMX usage is
disabled via XCR0, CR4.OSXSAVE or XFD[18]. In any case the effect of
AMX INIT=0 will prevent C6.

As I explained in great length there are enough ways to get into a
situation where this can happen and a CPU goes idle with AMX INIT=0.

So what are we supposed to do?

   - Use TILERELEASE on context switch after XSAVES?

   - Any other mechanism on context switch

   - Clear XFD[18] when going idle and issue TILERELEASE depending
     on the last state

   - Use any other means to set the thing back into INIT=1 state when
     going idle

There is no option 'shrug and ignore' unfortunately.

Thanks,

        tglx
