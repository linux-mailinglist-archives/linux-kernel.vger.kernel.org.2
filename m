Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67B43921E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhEZVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:23:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:1036 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233241AbhEZVXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:23:13 -0400
IronPort-SDR: 4NyT6fev5sLSb6AHR1MWoQHdtaVufHjlo0evuXi8g4gp1wW3vr4dC8IKEW1fRgM3TVGw91EbOY
 FdyZxT2leYUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="199535576"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="199535576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 14:21:41 -0700
IronPort-SDR: RAKV3ZDh178zk956PhHXsakMiYonUgFsJv3xtTwG7pm9LVv+PO3Yegs+JaWRHnq4WbS5cxTGgH
 OnzNfOauM+ew==
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="443237449"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.27.201]) ([10.212.27.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 14:21:39 -0700
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
To:     Dmitry Vyukov <dvyukov@google.com>,
        Andy Lutomirski <luto@kernel.org>
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
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <27d52fe4-3159-2f19-33cd-01ef4b3e530b@intel.com>
Date:   Wed, 26 May 2021 14:21:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bpHL6hgY1h+7BM19-R4faOWgYsvTx3QSgpFN0JuxuWiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/2021 12:00 AM, Dmitry Vyukov wrote:
> On Wed, May 26, 2021 at 2:33 AM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On 5/24/21 1:51 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    45af60e7 Merge tag 'for-5.13-rc2-tag' of git://git.kernel...
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1591e9f7d00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2067e764dbcd10721e2e
>>> compiler:       Debian clang version 11.0.1-2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be6bd1d00000
>>
>> Hi syz people and x86 people-
>>
>> I entirely believe that this bug is real and that syzbot bisected it
>> correctly, but I'm puzzled by the reproducer.  It says:
>>
>> ptrace$setregs(0xd, r0, 0x0, &(0x7f0000000080))
>>
>> I would really, really expect this to result from PTRACE_SETREGSET or
>> PTRACE_SETFPREGS, but this is PTRACE_SETREGS.
>>
>> Am I missing something really obvious here?
> 
> Hi Andy,
> 
> Sometimes syzkaller uses data format from one syscall variant, but
> actually invokes another.
> But here it does _not_ seem to be the case: 0xd is actually
> PTRACE_SETREGS. And the other ptrace calls in the reproducer are
> PTRACE_SEIZE and PTRACE_SINGLESTEP.
> So I would assume somehow it happened with PTRACE_SETREGS.
> Is there any indication from hardware as to what's wrong with fpregs?
> 

PTRACE_SETREGS can change segment registers.  The PTRACE_SETREGS is 
using some uninitialized memory area.  One possibility would be that 
XRSTORS has a memory operand outside of segment limits.
