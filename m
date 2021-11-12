Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1344EEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhKLVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:40:16 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35128 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhKLVkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:40:14 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:43726)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mleEd-000T4x-5g; Fri, 12 Nov 2021 14:37:23 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43360 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mleEY-005uZV-GM; Fri, 12 Nov 2021 14:37:22 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-9-ebiederm@xmission.com>
        <874k8htmb2.fsf@email.froward.int.ebiederm.org>
        <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
        <87ilwxrvu9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
        <87ee7lqe6k.fsf@email.froward.int.ebiederm.org>
        <CAHk-=whf-nR4xDSEDtXeowFn4QQKY3s_MXoM8Ha-dPiOzFzUxQ@mail.gmail.com>
        <CAHk-=wjU1Nf+zzFgwE5bAGSq2W9DifmKDsAOFuZcaaHq3vEQ8w@mail.gmail.com>
Date:   Fri, 12 Nov 2021 15:37:11 -0600
In-Reply-To: <CAHk-=wjU1Nf+zzFgwE5bAGSq2W9DifmKDsAOFuZcaaHq3vEQ8w@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 12 Nov 2021 13:24:37 -0800")
Message-ID: <87y25toy2g.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mleEY-005uZV-GM;;;mid=<87y25toy2g.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX183eDzckClwkUGV5IHyJePSU9JMKO7b0KM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,XMSubMetaSxObfu_03,
        XMSubMetaSx_00,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1606 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.14
        (0.1%), extract_message_metadata: 18 (1.1%), get_uri_detail_list: 3.7
        (0.2%), tests_pri_-1000: 25 (1.6%), tests_pri_-950: 1.43 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 109 (6.8%), check_bayes:
        107 (6.7%), b_tokenize: 13 (0.8%), b_tok_get_all: 13 (0.8%),
        b_comp_prob: 3.8 (0.2%), b_tok_touch_all: 72 (4.5%), b_finish: 1.08
        (0.1%), tests_pri_0: 1422 (88.5%), check_dkim_signature: 0.76 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.99 (0.1%), tests_pri_10:
        2.4 (0.1%), tests_pri_500: 12 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL ] signal/vm86_32: Remove pointless test in BUG_ON
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the exit-cleanups-for-v5.16 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16

  HEAD: c7a9b6471c8ee6a2180fc5f2f7a1e284754bdfc5 signal/vm86_32: Remove pointless test in BUG_ON


This branch has only one unpulled change.  Just the removal of an
unnecessary test from a BUG_ON.  Which in my running of the fuzzer
locally fixes the issue.

kernel test robot <oliver.sang@intel.com> writes[1]:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 1a4d21a23c4ca7467726be7db9ae8077a62b2c62 ("signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: trinity
> version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
> with following parameters:
>
>
> [ 70.645554][ T3747] kernel BUG at arch/x86/kernel/vm86_32.c:109!
> [ 70.646185][ T3747] invalid opcode: 0000 [#1] SMP
> [ 70.646682][ T3747] CPU: 0 PID: 3747 Comm: trinity-c6 Not tainted 5.15.0-rc1-00009-g1a4d21a23c4c #1
> [ 70.647598][ T3747] EIP: save_v86_state (arch/x86/kernel/vm86_32.c:109 (discriminator 3))
> [ 70.648113][ T3747] Code: 89 c3 64 8b 35 60 b8 25 c2 83 ec 08 89 55 f0 8b 96 10 19 00 00 89 55 ec e8 c6 2d 0c 00 fb 8b 55 ec 85 d2 74 05 83 3a 00 75 02 <0f> 0b 8b 86 10 19 00 00 8b 4b 38 8b 78 48 31 cf 89 f8 8b 7a 4c 81
> [ 70.650136][ T3747] EAX: 00000001 EBX: f5f49fac ECX: 0000000b EDX: f610b600
> [ 70.650852][ T3747] ESI: f5f79cc0 EDI: f5f79cc0 EBP: f5f49f04 ESP: f5f49ef0
> [ 70.651593][ T3747] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> [ 70.652413][ T3747] CR0: 80050033 CR2: 00004000 CR3: 35fc7000 CR4: 000406d0
> [ 70.653169][ T3747] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [ 70.653897][ T3747] DR6: fffe0ff0 DR7: 00000400
> [ 70.654382][ T3747] Call Trace:
> [ 70.654719][ T3747] arch_do_signal_or_restart (arch/x86/kernel/signal.c:792 arch/x86/kernel/signal.c:867)
> [ 70.655288][ T3747] exit_to_user_mode_prepare (kernel/entry/common.c:174 kernel/entry/common.c:209)
> [ 70.655854][ T3747] irqentry_exit_to_user_mode (kernel/entry/common.c:126 kernel/entry/common.c:317)
> [ 70.656450][ T3747] irqentry_exit (kernel/entry/common.c:406)
> [ 70.656897][ T3747] exc_page_fault (arch/x86/mm/fault.c:1535)
> [ 70.657369][ T3747] ? sysvec_kvm_asyncpf_interrupt (arch/x86/mm/fault.c:1488)
> [ 70.657989][ T3747] handle_exception (arch/x86/entry/entry_32.S:1085)

vm86_32.c:109 is: "BUG_ON(!vm86 || !vm86->user_vm86)"

When trying to understand the failure Brian Gerst pointed out[2] that
the code does not need protection against vm86->user_vm86 being NULL.
The copy_from_user code will already handles that case if the address
is going to fault.

Looking futher I realized that if we care about not allowing struct
vm86plus_struct at address 0 it should be do_sys_vm86 (the system
call) that does the filtering.  Not way down deep when the emulation
has completed in save_v86_state.

So let's just remove the silly case of attempting to filter a
userspace address with a BUG_ON.  Existing userspace can't break and
it won't make the kernel any more attackable as the userspace access
helpers will handle it, if it isn't a good userspace pointer.

I have run the reproducer the fuzzer gave me before I made this change
and it reproduced, and after I made this change and I have not seen
the reported failure.  So it does looks like this fixes the reported
issue.

[1] https://lkml.kernel.org/r/20211112074030.GB19820@xsang-OptiPlex-9020
[2] https://lkml.kernel.org/r/CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com
Suggested-by: Brian Gerst <brgerst@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/vm86_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index f14f69d7aa3c..cce1c89cb7df 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -106,7 +106,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	 */
 	local_irq_enable();
 
-	BUG_ON(!vm86 || !vm86->user_vm86);
+	BUG_ON(!vm86);
 
 	set_flags(regs->pt.flags, VEFLAGS, X86_EFLAGS_VIF | vm86->veflags_mask);
 	user = vm86->user_vm86;
-- 
2.20.1

