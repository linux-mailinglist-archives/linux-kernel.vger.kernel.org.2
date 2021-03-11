Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72467337F79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCKVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:14:55 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:56628 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhCKVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:13:20 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKScQ-00GbqU-U7; Thu, 11 Mar 2021 14:13:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lKScP-0000hL-OB; Thu, 11 Mar 2021 14:13:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
References: <20210311132036.228542540@linutronix.de>
Date:   Thu, 11 Mar 2021 15:13:22 -0600
In-Reply-To: <20210311132036.228542540@linutronix.de> (Thomas Gleixner's
        message of "Thu, 11 Mar 2021 14:20:36 +0100")
Message-ID: <m1blbpjswd.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lKScP-0000hL-OB;;;mid=<m1blbpjswd.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/iCrbfciiRJ2bJ7N3WrBBhNmRg72KlJrU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 873 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.3%), b_tie_ro: 9 (1.1%), parse: 0.83 (0.1%),
         extract_message_metadata: 12 (1.3%), get_uri_detail_list: 1.15 (0.1%),
         tests_pri_-1000: 7 (0.8%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 52 (5.9%), check_bayes: 50
        (5.8%), b_tokenize: 9 (1.0%), b_tok_get_all: 6 (0.7%), b_comp_prob:
        2.7 (0.3%), b_tok_touch_all: 29 (3.3%), b_finish: 0.79 (0.1%),
        tests_pri_0: 209 (23.9%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 561 (64.3%), tests_pri_10:
        1.99 (0.2%), tests_pri_500: 575 (65.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch V2 0/3] signals: Allow caching one sigqueue object per task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> This is a follow up to the initial submission which can be found here:
>
>   https://lore.kernel.org/r/20210303142025.wbbt2nnr6dtgwjfi@linutronix.de
>
> Signal sending requires a kmem cache allocation at the sender side and the
> receiver hands it back to the kmem cache when consuming the signal.
>
> This works pretty well even for realtime workloads except for the case when
> the kmem cache allocation has to go into the slow path which is rare but
> happens.
>
> Preempt-RT carries a patch which allows caching of one sigqueue object per
> task. The object is not preallocated. It's cached when the task receives a
> signal. The cache is freed when the task exits.

I am probably skimming fast and missed your explanation but is there
a reason the caching is per task (aka thread) and not per signal_struct
(aka process)?

My sense is most signal delivery is per process.  Are realtime workloads
that extensively use pthread_sigqueue?  The ordinary sigqueue interface
only allows targeting a process.

Mostly I am just trying to get a sense of the workloads that are
improved by this.

Eric
