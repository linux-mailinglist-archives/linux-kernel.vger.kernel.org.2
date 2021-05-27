Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE21F393623
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhE0TSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhE0TSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:18:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44350C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:17:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622143022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WO9Ffk5zvc6wscj8WLhjqrBBshoNYmhwd/PJW0bJ2lY=;
        b=lUszLzgtxK9We+YdyK2J3nzMwT2DmcgQkixgBJNMeSSvvHaKXsaMfV4rG8Maj184ELG3am
        sKIYwHcfJAoaPDiKs9HQsyAMYlnVszZHwp59/GVJPTCDR1V2nmwiopqu1wJ/rQqTpngC6B
        YU0LpsXsjdXEY1Ki2KQdzQQNELDTn3m+EeEqQ7Ra2PAIui+KfoGjb9Z4JB+MPOQT742pS4
        SIYCDhCHzT0tGl7f/0bvQwIeNrAthOVGwU4EoKpVOR2Z44FJJsuZcjh02S7U9C5wy0DVxv
        ej93elObpQw1rdt2/4A6/GDLrCXrslXAZxIONuHg/v017ZbqA2wIFF7GbVCGMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622143022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WO9Ffk5zvc6wscj8WLhjqrBBshoNYmhwd/PJW0bJ2lY=;
        b=1665o0Fkpzcmqas363kUxfojqDCR564RT7XKhttJPSm2n4bAMiPZU5MGBLt6WO42QZTBTE
        wndGTm0EvGTyl+Bg==
To:     "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com,
        x86@kernel.org
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
In-Reply-To: <b2dddfbc-02cd-fcd8-6c89-ae6204e4cf6f@intel.com>
References: <0000000000004c453905c30f8334@google.com> <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org> <87sg29886g.ffs@nanos.tec.linutronix.de> <87bl8w86m3.ffs@nanos.tec.linutronix.de> <b2dddfbc-02cd-fcd8-6c89-ae6204e4cf6f@intel.com>
Date:   Thu, 27 May 2021 21:17:02 +0200
Message-ID: <871r9s7zrl.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 11:59, Yu-cheng Yu wrote:
> On 5/27/2021 9:49 AM, Thomas Gleixner wrote:
>> On Thu, May 27 2021 at 00:03, Thomas Gleixner wrote:
>>> I decoded it fully by now and will send out coherent info (and hopefully
>>> a patch) tomorrow with brain awake. Time for bed here...
>> 
>> Not yet there with a patch, but I have a trivial C reproducer. See
>> below.
>> 
>> The failure mode is:
>> 
>>      signal to task
>>        sigaction_handler()
>>          wreckage xsave.header.reserved[0]
>>          sig_return()
>>            restore_fpu_from_sigframe()
>>              try: XRSTOR from user -> #GP
>>              copy_from_user(fpstate, task->fpu.state.xsave);
>>              validate(task->fpu.state.xsave) -> fail
>>              fpu__clear_user_states()
>>                reinits FPU hardware but task state is still wreckaged
>
> In fpu__clear_user_states(), maybe can we clear xstate_header.reserved[] 
> as well?

Just because my reproducer wreckages xstate_header.reserved, you think
it's sufficient to maybe clear that field? May I recommend to study the
XSAVE documentation?

> Or do we want to check the user buffer first before copy it?

Before your patch the code was correct. So maybe study the SDM, the code
and the commit and carefully read this email plus the following ones
before you come up with more helpful suggestions.

<SNIP>
     80 lines of useless quotes
</SNIP>

See: https://people.kernel.org/tglx/notes-about-netiquette

Thanks,

        tglx
