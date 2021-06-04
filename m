Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8484639BF67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFDSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:16:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DA7C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:14:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622830464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Drple3vblKhjJjN2PXQm8uBxk46WkNL+qLdK3onwHjs=;
        b=Gb+28IIlRpZftlLmUqSe2BoC9yQvta1x9ZE5YOjKxk/5INEfTOaTK72klUpzhIs+nAK28N
        ntR9tnxlQvb23gNj6DCdYFjpa0g7n296IJDxaorFdYXX8PEkwg9b7aTwSvS9HRINc06fa1
        qzs1E3c6aJip3wGBzAaHuc10IgnbuntDH3uYfxvz8Z+pcxuhh/AM4mwvTVOAC1XVXDiYzA
        gR3aVbIHODAQWDUaz9uV2CM+55n7jdIThfQ3WTuuQBd/qq+HkEbPqZWNfLAzwaRHos37bb
        7j68ylyG3+1x6jPTsPpgEtTiy8fd9y7Dxgg6MKk58VUOnHnYCfq7VCnnPf/eJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622830464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Drple3vblKhjJjN2PXQm8uBxk46WkNL+qLdK3onwHjs=;
        b=kqbngnGnCrwXtdTOA/yQz/igNWW68d0w04wEQu1JhIpLkY8UNLVWgjVOapJQbzlsQWr1X1
        R9TZlyyU8D0TyUBg==
To:     Dave Hansen <dave.hansen@intel.com>,
        "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <6a93334d-d771-666f-7fd0-8d152799fb02@intel.com>
References: <20210602095543.149814064@linutronix.de> <9c5c90bf-fbf6-7e45-4668-2f40f11e8b36@intel.com> <87h7idzpwh.ffs@nanos.tec.linutronix.de> <6a93334d-d771-666f-7fd0-8d152799fb02@intel.com>
Date:   Fri, 04 Jun 2021 20:14:24 +0200
Message-ID: <87y2bpzedb.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2021 at 10:46, Dave Hansen wrote:
> On 6/4/21 7:05 AM, Thomas Gleixner wrote:
>> But looking at the above, it's not clear to me why that PKRU stuff works
>> at all (upstream), but I'll figure it out eventually. I'm quite sure
>> that it does work by pure chance not by design.
>
> The upstream flush_thread() code appears correct and even intentionally
> so.  Just how we must eagerly load PKRU on a context switch, the
> fpu__clear*() code eagerly "clears" PKRU.  It doesn't actually zero it,
> of course, but reverts the register and the fpstate back to the
> 'init_pkru_value':
>
> flush_thread()->fpu__clear_all()->fpu__clear(user_only=false)
> 	copy_init_fpstate_to_fpregs()
> 		copy_kernel_to_xregs(init_fpu) // fpstate
> 		copy_init_pkru_to_fpregs()
> 			 write_pkru(init_pkru_value_snapshot) // fpregs
>
> Andy said you have a fix for this, but I think the new fpu__clear_all()
> is failing to do the eager write_pkru().

Yes, that's the reason and it took some time until I realized that
fpu__initialize() is inconsistent vs. PKRU.

We can't use copy_init_pkru_to_fregs() either because that's not
updating the xsaves area because XFEATURE_PKRU has been cleared.
Yay for consistency!

I'll post a fix soonish after testing it.

Thanks,

        tglx
