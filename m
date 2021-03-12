Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C289C339876
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhCLU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:29:49 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:52704 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhCLU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:29:41 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKoPk-0000qd-Qy; Fri, 12 Mar 2021 13:29:40 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKoPj-006Zm2-Ts; Fri, 12 Mar 2021 13:29:40 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210312173855.24843-1-jnewsome@torproject.org>
Date:   Fri, 12 Mar 2021 14:29:46 -0600
In-Reply-To: <20210312173855.24843-1-jnewsome@torproject.org> (Jim Newsome's
        message of "Fri, 12 Mar 2021 11:38:55 -0600")
Message-ID: <m1k0qcglol.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lKoPj-006Zm2-Ts;;;mid=<m1k0qcglol.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/qwjM8dl0Gb1QwnotGtvTTQxD9aoOPQ9s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMGppyBdWords,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  2.5 XMGppyBdWords BODY: Gappy or l33t words
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Jim Newsome <jnewsome@torproject.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 393 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (3.0%), b_tie_ro: 10 (2.6%), parse: 1.12
        (0.3%), extract_message_metadata: 13 (3.4%), get_uri_detail_list: 1.57
        (0.4%), tests_pri_-1000: 13 (3.4%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 131 (33.4%), check_bayes:
        130 (33.0%), b_tokenize: 6 (1.4%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 113 (28.7%), b_finish: 0.94
        (0.2%), tests_pri_0: 206 (52.5%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 4.9 (1.3%), poll_dns_idle: 0.32 (0.1%), tests_pri_10:
        2.7 (0.7%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Newsome <jnewsome@torproject.org> writes:

> do_wait is an internal function used to implement waitpid, waitid,
> wait4, etc. To handle the general case, it does an O(n) linear scan of
> the thread group's children and tracees.
>
> This patch adds a special-case when waiting on a pid to skip these scans
> and instead do an O(1) lookup. This improves performance when waiting on
> a pid from a thread group with many children and/or tracees.

I am going to kibitz just a little bit more.

When I looked at this a second time it became apparent that using
pid_task twice should actually be faster as it removes a dependent load
caused by thread_group_leader, and replaces it by accessing two adjacent
pointers in the same cache line.

I know the algorithmic improvement is the main advantage, but removing
60ns or so for a dependent load can't hurt.

Plus I think using the two pid types really makes it clear that one
is always a process and the other is always potentially a thread.

/*
 * Optimization for waiting on PIDTYPE_PID. No need to iterate through child
 * and tracee lists to find the target task.
 */
static int do_wait_pid(struct wait_opts *wo)
{
	bool ptrace;
	struct task_struct *target;
	int retval;

	ptrace = false;
	target = pid_task(wo->wo_pid, PIDTYPE_TGID);
	if (target && is_effectively_child(wo, ptrace, target)) {
		retval = wait_consider_task(wo, ptrace, target);
		if (retval)
			return retval;
	}

	ptrace = true;
	target = pid_task(wo->wo_pid, PIDTYPE_PID);
	if (target && target->ptrace &&
            is_effectively_child(wo, ptrace, target)) {
		retval = wait_consider_task(wo, ptrace, target);
		if (retval)
			return retval;
	}

	return 0;
}

Since the probably needs to be respun to include the improved
description can we look at my micro performance improvement?

Eric
