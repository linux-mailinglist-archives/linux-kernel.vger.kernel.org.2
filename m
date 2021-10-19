Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FDC433B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhJSPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:52:37 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60746 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhJSPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:52:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:54952)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcrNc-00CVu1-UN; Tue, 19 Oct 2021 09:50:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:56928 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mcrNb-006Ebo-BT; Tue, 19 Oct 2021 09:50:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <oliver.sang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20211019031407.GB7910@xsang-OptiPlex-9020>
Date:   Tue, 19 Oct 2021 10:49:53 -0500
In-Reply-To: <20211019031407.GB7910@xsang-OptiPlex-9020> (kernel test robot's
        message of "Tue, 19 Oct 2021 11:14:07 +0800")
Message-ID: <87wnm9ovz2.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mcrNb-006Ebo-BT;;;mid=<87wnm9ovz2.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+EEHFhzH9f0nHsRpndmO62uShfHklh6Xw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_XMDrugObfuBody_12,
        XMGappySubj_01,XMGappySubj_02,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMGappySubj_02 Gappier still
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;kernel test robot <oliver.sang@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 600 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.15 (0.2%),
         extract_message_metadata: 21 (3.5%), get_uri_detail_list: 3.9 (0.7%),
        tests_pri_-1000: 10 (1.6%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 72 (12.0%), check_bayes:
        70 (11.7%), b_tokenize: 12 (2.1%), b_tok_get_all: 13 (2.2%),
        b_comp_prob: 3.8 (0.6%), b_tok_touch_all: 38 (6.3%), b_finish: 0.90
        (0.2%), tests_pri_0: 471 (78.4%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 4.6 (0.8%), poll_dns_idle: 0.70 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [mm]  6128b3af2a: UBSAN:shift-out-of-bounds_in(null)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed the following commit (built with clang-14):
>
> commit: 6128b3af2a5e42386aa7faf37609b57f39fb7d00 ("mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I believe this failure is misattributed.  Perhaps your reproducer
only intermittently reproduces the problem?

The change in question only contains

	flags &= ~MAP_DENYWRITE

After all of the other users of MAP_DENYWRITE had been removed from the
kernel.  So I don't see how it could possibly be responsible for the
reported shift out of bounds problem.

Eric




> in testcase: trinity
> version: trinity-i386-4d2343bd-1_20200320
> with following parameters:
>
> 	runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +---------------------------------------------+------------+------------+
> |                                             | 8d0920bde5 | 6128b3af2a |
> +---------------------------------------------+------------+------------+
> | UBSAN:shift-out-of-bounds_in(null)          | 0          | 9          |
> +---------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
>
> [  126.758570][ T3293] ================================================================================
> [  126.758949][ T3293] UBSAN: shift-out-of-bounds in (null):0:0
> [  126.759174][ T3293] BUG: kernel NULL pointer dereference, address: 00000000
> [  126.759447][ T3293] #PF: supervisor read access in kernel mode
> [  126.759676][ T3293] #PF: error_code(0x0000) - not-present page
> [  126.759905][ T3293] *pde = 00000000
> [  126.760047][ T3293] Oops: 0000 [#1] SMP
> [  126.760205][ T3293] CPU: 1 PID: 3293 Comm: trinity-c4 Not tainted 5.14.0-00006-g6128b3af2a5e #1
> [  126.760541][ T3293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  126.760890][ T3293] EIP: __ubsan_handle_shift_out_of_bounds+0x88/0x350
> [  126.761147][ T3293] Code: 00 83 c4 04 7f 23 47 04 7f 23 47 04 ff 37 68 ef ff 37 68 ef e3 77 d0 d7 e3 77 d0 d7 00 8b 45 f0 00 8b 45 f0 c4 14 66 83 c4 14 <66> 83 66
> 83 3f 00 66 83 3f 00 00 00 66 83 00 00 66 83 b9 01 00 00
> [  126.761889][ T3293] EAX: 00000000 EBX: f345b500 ECX: 00000027 EDX: eba9ce40
> [  126.762159][ T3293] ESI: 00000046 EDI: 00000000 EBP: f3575f40 ESP: f3575ecc
> [  126.762428][ T3293] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
> [  126.762718][ T3293] CR0: 80050033 CR2: 00000000 CR3: 33464000 CR4: 000406d0
> [  126.762989][ T3293] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  126.763259][ T3293] DR6: fffe0ff0 DR7: 00000400
> [  126.763436][ T3293] Call Trace:
> [  126.763562][ T3293]  ? rcu_lock_acquire+0x30/0x30
> [  126.763749][ T3293]  ? rcu_read_lock_sched_held+0x31/0x70
> [  126.763960][ T3293]  ksys_mmap_pgoff+0x1fc/0x290
> [  126.764146][ T3293]  __ia32_sys_mmap_pgoff+0x1c/0x30
> [  126.764343][ T3293]  do_int80_syscall_32+0x39/0x80
> [  126.764532][ T3293]  entry_INT80_32+0x10d/0x10d
> [  126.764709][ T3293] EIP: 0xb7fbda02
> [  126.764848][ T3293] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6
> 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
> [  126.765591][ T3293] EAX: ffffffda EBX: 00000000 ECX: 00001000 EDX: 55dd7eb6
> [  126.765859][ T3293] ESI: f0bd6374 EDI: ffffffff EBP: 00000000 ESP: bf9964d8
> [  126.766129][ T3293] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
> [  126.766419][ T3293] Modules linked in: aesni_intel crypto_simd qemu_fw_cfg autofs4
> [  126.766715][ T3293] CR2: 0000000000000000
> [  126.766894][ T3293] ---[ end trace e6000e119f0dc7f3 ]---
> [  126.767105][ T3293] EIP: __ubsan_handle_shift_out_of_bounds+0x88/0x350
> [  126.767361][ T3293] Code: 00 83 c4 04 7f 23 47 04 7f 23 47 04 ff 37 68 ef ff 37 68 ef e3 77 d0 d7 e3 77 d0 d7 00 8b 45 f0 00 8b 45 f0 c4 14 66 83 c4 14 <66> 83 66 83 3f 00 66 83 3f 00 00 00 66 83 00 00 66 83 b9 01 00 00
> [  126.768112][ T3293] EAX: 00000000 EBX: f345b500 ECX: 00000027 EDX: eba9ce40
> [  126.768384][ T3293] ESI: 00000046 EDI: 00000000 EBP: f3575f40 ESP: f3575ecc
> [  126.768657][ T3293] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
> [  126.768947][ T3293] CR0: 80050033 CR2: 00000000 CR3: 33464000 CR4: 000406d0
> [  126.769223][ T3293] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  126.769496][ T3293] DR6: fffe0ff0 DR7: 00000400
> [  126.769680][ T3293] Kernel panic - not syncing: Fatal exception
> [  126.769946][ T3293] Kernel Offset: disabled
>
>
>
> To reproduce:
>
>         # build kernel
> 	cd linux
> 	cp config-5.14.0-00006-g6128b3af2a5e .config
> 	make HOSTCC=clang-14 CC=clang-14 ARCH=i386 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
