Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F674590CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhKVPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 10:05:41 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38428 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKVPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:05:37 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51368)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpApw-002FBc-Ru; Mon, 22 Nov 2021 08:02:28 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52422 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpApu-00ChBL-Jd; Mon, 22 Nov 2021 08:02:28 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Vladimir Divjak <vladimir.divjak@bmw.de>
Cc:     <oleg@redhat.com>, <jnewsome@torproject.org>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>, <asml.silence@gmail.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20211122005347.1467288-1-vladimir.divjak@bmw.de> (Vladimir
        Divjak's message of "Mon, 22 Nov 2021 01:53:47 +0100")
References: <20211122005347.1467288-1-vladimir.divjak@bmw.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 22 Nov 2021 09:02:15 -0600
Message-ID: <875ysknsi0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mpApu-00ChBL-Jd;;;mid=<875ysknsi0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YS9+H3cN9mVA3trJJZMYtEKpoB6QI+KQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4481]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Vladimir Divjak <vladimir.divjak@bmw.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1678 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 9 (0.5%), parse: 1.65 (0.1%),
         extract_message_metadata: 36 (2.2%), get_uri_detail_list: 1.61 (0.1%),
         tests_pri_-1000: 36 (2.2%), tests_pri_-950: 18 (1.1%),
        tests_pri_-900: 1.50 (0.1%), tests_pri_-90: 162 (9.7%), check_bayes:
        150 (8.9%), b_tokenize: 29 (1.8%), b_tok_get_all: 15 (0.9%),
        b_comp_prob: 3.1 (0.2%), b_tok_touch_all: 76 (4.6%), b_finish: 1.18
        (0.1%), tests_pri_0: 1292 (77.0%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 37 (2.2%), poll_dns_idle: 19 (1.1%), tests_pri_10:
        4.3 (0.3%), tests_pri_500: 110 (6.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ptrace: exit: re-trigger PTRACE_EVENT_EXIT after coredump finished
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Divjak <vladimir.divjak@bmw.de> writes:

> Re-trigger PTRACE_EVENT_EXIT
> (if one is requested with PTRACE_SEIZE setting PTRACE_O_TRACEEXIT option)
> for a process being core-dumped, after the coredump is finished.
>
> This enables a potential tracer - coredump user mode helper
> (or any other tracer started after the coredump was initiated)
> to receive the PTRACE_EVENT_EXIT for all threads of the crashing process.
>
> Rationale:
>
> For zapped threads, PTRACE_EVENT_EXIT is triggered early during do_exit(),
> before the point at which they sleep, waiting for
> coredump to finish - in exit_mm(), and before a potential
> coredump user mode helper process is launched.
>
> That makes it impossible for the coredump user mode helper process to
> receive PTRACE_EVENT_EXIT events for all threads of the crashing process,
> except for the thread handling the core-dump, which will trigger
> the PTRACE_EVENT_EXIT after the coredump has been finished.

Please test the latest kernel.

The coredump now stops much earlier than exit_mm, and PTRACE_EVENT_EXIT
is after the point the coredump stops.

If you need this functionality on older kernels it should be possible to
backport a subset of my changes without too much trouble

Eric
