Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294D3B0D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhFVSkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:40:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99169C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:38:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624387106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ha8dPHpVENEPTcTvRckNIWqoGQQwSzBjWq0eWTDNYsM=;
        b=CvHmpGMnMtu24WJvTBoDzyoZmX9EuIcM2H1ae+xq/1xk+WBZaYlSUYY9B2y78QTgnoBhX1
        BEXPK1ArlLMM6XiQTj0EE04MMPJbrD5gB2v0gJP0ZGkuPoaplE5sENTDjHYSPaO3siinp2
        qeob/eld+jpMCnh+XarCUnr71Z/1dzM9Bmp3v8bPOxQVgEIKHSSJaYefKPcNas7Pz7ma4A
        lrcbfUMkCCF69AroF81GjgP4hJY9od6ocs0/mgsY00DCSYOS/T1qCdV53fWeONQ1WTqlT5
        02erNo2ACv9wQzyBYR5nJiXMhZ8kaj1s+kvvJADjXGJkAJnIgfx9hN7CAMyDCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624387106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ha8dPHpVENEPTcTvRckNIWqoGQQwSzBjWq0eWTDNYsM=;
        b=65WUkz1TOBT4xjagWuXPCsehjaSPssNIXXuPtJH2lPSXwADcumiru66TrZ90y1V2MHKuqW
        G6UTsGp9iI8kVRAw==
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 59/66] x86/fpu/signal: Move initial checks into fpu__sig_restore()
In-Reply-To: <YNIfdidWt/nRwIPa@zn.tnic>
References: <20210618141823.161158090@linutronix.de> <20210618143451.099973627@linutronix.de> <YNIfdidWt/nRwIPa@zn.tnic>
Date:   Tue, 22 Jun 2021 20:38:25 +0200
Message-ID: <87h7hpeoda.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22 2021 at 19:35, Borislav Petkov wrote:
> On Fri, Jun 18, 2021 at 04:19:22PM +0200, Thomas Gleixner wrote:
>>  
>> +	if (unlikely(!buf)) {
>> +		fpu__clear_user_states(&current->thread.fpu);
>
> You could declare
>
> 	struct fpu *fpu = &tsk->thread.fpu;
>
> above so that it is easier to read, as this call is done twice.
>
> Also, you can do:
>
> 	int ret = 0;
>
> 	if (unlikely(!buf))
> 		goto out;
>
> so that the exit paths converge at the end.

I pondered, but look at the condition there. It gets unreadable.

So I kept is as is because this is an intentional clear which returns
success and the other is on error.

>> +	if (!IS_ENABLED(CONFIG_X86_64) && !static_cpu_has(X86_FEATURE_FPU)) {
>
> cpu_feature_enabled()
>
>> +		return fpregs_soft_set(current, NULL, 0,
>> +				       sizeof(struct user_i387_ia32_struct),
>> +				       NULL, buf);
>
> Err, don't you need to catch retval into ret here and goto out, like
> before, so that you can call fpu__clear_user_states() on error?

Yes. Actually we should do that as a separate patch way earlier in the
series. Sigh.

