Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD496383B40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbhEQR21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:28:27 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44932 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhEQR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:28:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lih1I-008g3Z-Gy; Mon, 17 May 2021 11:27:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ligwn-0007iG-0m; Mon, 17 May 2021 11:22:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
References: <a068c25c4c08aa8dbc1141a77614711f80f74b65.1621245687.git.asml.silence@gmail.com>
Date:   Mon, 17 May 2021 12:22:13 -0500
In-Reply-To: <a068c25c4c08aa8dbc1141a77614711f80f74b65.1621245687.git.asml.silence@gmail.com>
        (Pavel Begunkov's message of "Mon, 17 May 2021 11:18:07 +0100")
Message-ID: <m1o8d95l8a.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ligwn-0007iG-0m;;;mid=<m1o8d95l8a.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/uHyMU4FoXCJfugdXBJnxPvncafg9cjoo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Pavel Begunkov <asml.silence@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 281 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (1.4%), b_tie_ro: 2.9 (1.0%), parse: 0.57
        (0.2%), extract_message_metadata: 2.4 (0.8%), get_uri_detail_list:
        1.01 (0.4%), tests_pri_-1000: 1.89 (0.7%), tests_pri_-950: 0.99 (0.4%),
         tests_pri_-900: 0.74 (0.3%), tests_pri_-90: 72 (25.4%), check_bayes:
        70 (25.1%), b_tokenize: 4.3 (1.5%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 1.36 (0.5%), b_tok_touch_all: 57 (20.2%), b_finish: 0.58
        (0.2%), tests_pri_0: 187 (66.5%), check_dkim_signature: 0.35 (0.1%),
        check_dkim_adsp: 2.3 (0.8%), poll_dns_idle: 0.22 (0.1%), tests_pri_10:
        1.62 (0.6%), tests_pri_500: 5 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: optimise signal_pending()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Begunkov <asml.silence@gmail.com> writes:

> Optimise signal_pending() by checking both TIF_SIGPENDING and
> TIF_NOTIFY_SIGNAL at once. Saves quite a bit of generated instructions,
> e.g. sheds 240B from io_uring alone, some including ones in hot paths.
>
>    text    data     bss     dec     hex filename
>   84087   12414       8   96509   178fd ./fs/io_uring.o
>   83847   12414       8   96269   1780d ./fs/io_uring.o

I believe the atomic test_bit is pretty fundamental, especially with
it's implied barriers.  I believe you are optimizing out the code
that will makes signal_pending work in a loop.

I have tried looking and I really don't understand why TIF_NOTIFY_SIGNAL
was added.  Perhaps instead of trying to optimize the test, you should
optimize by combining TIF_NOTIFY_SIGNAL with TIF_SIGPENDING.

Perhaps set_notify_signal could be optimized to set both.  I think I
only see 4 calls in the tree.

> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>
> Suggestions on how to make it less disruptive to abstractions are most
> welcome, as even the one below fails to generated anything sane because
> of test_bit()
>
> return unlikely(test_ti_thread_flag(ti, TIF_SIGPENDING) |
> 		test_ti_thread_flag(ti, TIF_SIGPENDING));
>
>  include/linux/sched/signal.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3f6a0fcaa10c..97e1963a13fc 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -361,14 +361,14 @@ static inline int task_sigpending(struct task_struct *p)
>  
>  static inline int signal_pending(struct task_struct *p)
>  {
> +	struct thread_info *ti = task_thread_info(p);
> +
>  	/*
>  	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
>  	 * behavior in terms of ensuring that we break out of wait loops
>  	 * so that notify signal callbacks can be processed.
>  	 */
> -	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
> -		return 1;
> -	return task_sigpending(p);
> +	return unlikely(ti->flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL));
>  }
>  
>  static inline int __fatal_signal_pending(struct task_struct *p)
