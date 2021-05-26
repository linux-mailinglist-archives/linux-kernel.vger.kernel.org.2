Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B813922D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhEZWio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhEZWin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE62613D2;
        Wed, 26 May 2021 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622068631;
        bh=43f0Da5GThG0RObLByn8HYdzHVg9fpmhqgI7p1//ieA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KoWtNwOEzjllHtt/B42ALCJ2I5fdxBSBaiiFeLl0T/XZYkGoxCdX6uMYjvBvjOBO1
         XGQGOBmhJQFzFotiQ3bqVU5isMmD2B1A8BXjAIAZLnQuTmW11Wv/eBauLD4UuOWRG/
         poydu6slWg56FlcqXzjR257YjAbtT+Tn2MQZTp5xKZvCyEIU2aB079JYYU6xSzMAKW
         z1VK7+szHdnQ9FtSIDEQQZA6aVT+XIIDSBCs56vAeSkBYCduBz5uoGf1MK+M629M9M
         TBQck1AAbd2sZ0GShMkfsOIQBCKqcNSD9abSCm4liWlC2djKs6Lzj3BXU6xzeFyFd4
         nGt7RhcOZdiAQ==
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        the arch/x86 maintainers <x86@kernel.org>
References: <0000000000004c453905c30f8334@google.com>
 <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
 <CACT4Y+bpHL6hgY1h+7BM19-R4faOWgYsvTx3QSgpFN0JuxuWiQ@mail.gmail.com>
 <27d52fe4-3159-2f19-33cd-01ef4b3e530b@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <fdae31ab-02ca-79f8-445e-adb5ac8dcb01@kernel.org>
Date:   Wed, 26 May 2021 15:37:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <27d52fe4-3159-2f19-33cd-01ef4b3e530b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 2:21 PM, Yu, Yu-cheng wrote:
> On 5/26/2021 12:00 AM, Dmitry Vyukov wrote:
>> On Wed, May 26, 2021 at 2:33 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> On 5/24/21 1:51 AM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    45af60e7 Merge tag 'for-5.13-rc2-tag' of
>>>> git://git.kernel...
>>>> git tree:       upstream
>>>> console output:
>>>> https://syzkaller.appspot.com/x/log.txt?x=1591e9f7d00000
>>>> kernel config: 
>>>> https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
>>>> dashboard link:
>>>> https://syzkaller.appspot.com/bug?extid=2067e764dbcd10721e2e
>>>> compiler:       Debian clang version 11.0.1-2
>>>> syz repro:     
>>>> https://syzkaller.appspot.com/x/repro.syz?x=11be6bd1d00000
>>>
>>> Hi syz people and x86 people-
>>>
>>> I entirely believe that this bug is real and that syzbot bisected it
>>> correctly, but I'm puzzled by the reproducer.  It says:
>>>
>>> ptrace$setregs(0xd, r0, 0x0, &(0x7f0000000080))
>>>
>>> I would really, really expect this to result from PTRACE_SETREGSET or
>>> PTRACE_SETFPREGS, but this is PTRACE_SETREGS.
>>>
>>> Am I missing something really obvious here?
>>
>> Hi Andy,
>>
>> Sometimes syzkaller uses data format from one syscall variant, but
>> actually invokes another.
>> But here it does _not_ seem to be the case: 0xd is actually
>> PTRACE_SETREGS. And the other ptrace calls in the reproducer are
>> PTRACE_SEIZE and PTRACE_SINGLESTEP.
>> So I would assume somehow it happened with PTRACE_SETREGS.
>> Is there any indication from hardware as to what's wrong with fpregs?
>>
> 
> PTRACE_SETREGS can change segment registers.  The PTRACE_SETREGS is
> using some uninitialized memory area.  One possibility would be that
> XRSTORS has a memory operand outside of segment limits.

It's a regression caused by your fpu__clear_user() patch.  tglx and I
are working on it.

The syzbot report is confusing but correct.
