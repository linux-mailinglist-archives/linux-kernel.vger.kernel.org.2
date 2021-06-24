Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2434A3B26D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFXFdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:33:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43602 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhFXFdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:33:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwHx5-00FHtl-9k; Wed, 23 Jun 2021 23:30:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55232 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwHx4-0018Mx-7G; Wed, 23 Jun 2021 23:30:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, ast@kernel.org, christian@brauner.io,
        jnewsome@torproject.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>
References: <000000000000ef5d1b05c57c2262@google.com>
Date:   Thu, 24 Jun 2021 00:30:16 -0500
In-Reply-To: <000000000000ef5d1b05c57c2262@google.com> (syzbot's message of
        "Wed, 23 Jun 2021 22:17:16 -0700")
Message-ID: <87fsx7akyf.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwHx4-0018Mx-7G;;;mid=<87fsx7akyf.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Z3hExiG9ewRFO3HREZUwvFlw/MIOaijc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,GB_FAKE_RF_SHORT,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3193]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 GB_FAKE_RF_SHORT Fake reply or forward with url shortener
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 507 ms - load_scoreonly_sql: 0.24 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.0%), parse: 1.27
        (0.3%), extract_message_metadata: 22 (4.3%), get_uri_detail_list: 3.3
        (0.7%), tests_pri_-1000: 14 (2.7%), tests_pri_-950: 1.58 (0.3%),
        tests_pri_-900: 1.28 (0.3%), tests_pri_-90: 69 (13.6%), check_bayes:
        67 (13.3%), b_tokenize: 14 (2.7%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 37 (7.3%), b_finish: 1.03
        (0.2%), tests_pri_0: 369 (72.7%), check_dkim_signature: 1.10 (0.2%),
        check_dkim_adsp: 3.3 (0.7%), poll_dns_idle: 0.46 (0.1%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 11 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] KASAN: out-of-bounds Read in do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:

This looks like dueling debug mechanism.  At a quick glance
stack_no_used is deliberately looking for an uninitialized part of the
stack.

Perhaps the fix is to make KASAN and DEBUG_STACK_USAGE impossible to
select at the same time in Kconfig?

Eric

>
> HEAD commit:    9ed13a17 Merge tag 'net-5.13-rc7' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=116c517bd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf635d6d1c7ebabc
> dashboard link: https://syzkaller.appspot.com/bug?extid=b80bbdcca4c4dfaa189e
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: out-of-bounds in stack_not_used include/linux/sched/task_stack.h:101 [inline]
> BUG: KASAN: out-of-bounds in check_stack_usage kernel/exit.c:711 [inline]
> BUG: KASAN: out-of-bounds in do_exit+0x1c6b/0x23d0 kernel/exit.c:869
> Read of size 8 at addr ffffc90017d60400 by task loop0/31717
>
> CPU: 0 PID: 31717 Comm: loop0 Not tainted 5.13.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  print_address_description+0x5f/0x3b0 mm/kasan/report.c:233
>  __kasan_report mm/kasan/report.c:419 [inline]
>  kasan_report+0x15c/0x200 mm/kasan/report.c:436
>  stack_not_used include/linux/sched/task_stack.h:101 [inline]
>  check_stack_usage kernel/exit.c:711 [inline]
>  do_exit+0x1c6b/0x23d0 kernel/exit.c:869
>  kthread+0x3b8/0x3c0 kernel/kthread.c:315
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>
>
> Memory state around the buggy address:
>  ffffc90017d60300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90017d60380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>ffffc90017d60400: 07 07 07 07 07 07 07 07 00 00 00 00 00 00 00 00
>                    ^
>  ffffc90017d60480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90017d60500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
