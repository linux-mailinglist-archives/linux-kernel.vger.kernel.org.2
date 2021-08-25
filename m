Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DAB3F76EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbhHYOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:12:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59760 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:12:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:58078)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mItd7-00DzB7-7F; Wed, 25 Aug 2021 08:11:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53520 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mItd6-00D0uB-2n; Wed, 25 Aug 2021 08:11:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang\, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20210824151337.GC27667@xsang-OptiPlex-9020>
        <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
        <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
        <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com>
Date:   Wed, 25 Aug 2021 09:11:19 -0500
In-Reply-To: <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 24 Aug 2021 10:39:25 -0700")
Message-ID: <875yvtpqbc.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mItd6-00D0uB-2n;;;mid=<875yvtpqbc.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+f1x4Zi+tQtGk/ZhqOYIuQyM7dMciL9to=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4946]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 569 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.6%), parse: 0.79 (0.1%),
         extract_message_metadata: 10 (1.7%), get_uri_detail_list: 1.51 (0.3%),
         tests_pri_-1000: 4.8 (0.8%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.82 (0.1%), tests_pri_-90: 235 (41.3%), check_bayes:
        226 (39.8%), b_tokenize: 7 (1.2%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 1.70 (0.3%), b_tok_touch_all: 207 (36.4%), b_finish: 0.93
        (0.2%), tests_pri_0: 296 (51.9%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.96 (0.2%), tests_pri_10:
        1.95 (0.3%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Aug 24, 2021 at 10:32 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> We could do the same ugly thing for FASYNC that we do for EPOLLET -
>> make it always fasync on new data, exactly because the previous SIGIO
>> might not have emptied the buffer completely.
>
> The patch would be something like the attached (UNTESTED!)

We have two things going on, a pipe wake up and signal wake up.

Does their order matter?  It feels weird that it is possible that
the data can be read from the pipe and the reader woken up to write
more when the signal that notifies the reader of that state has
not even been queued for delivery.


Eric



>                   Linus
>
>  fs/pipe.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 678dee2a8228..6d4342bad9f1 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -363,10 +363,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		 * _very_ unlikely case that the pipe was full, but we got
>  		 * no data.
>  		 */
> -		if (unlikely(was_full)) {
> +		if (unlikely(was_full))
>  			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -		}
> +		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>  
>  		/*
>  		 * But because we didn't read anything, at this point we can
> @@ -385,12 +384,11 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		wake_next_reader = false;
>  	__pipe_unlock(pipe);
>  
> -	if (was_full) {
> +	if (was_full)
>  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -	}
>  	if (wake_next_reader)
>  		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> +	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>  	if (ret > 0)
>  		file_accessed(filp);
>  	return ret;
> @@ -565,10 +563,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		 * become empty while we dropped the lock.
>  		 */
>  		__pipe_unlock(pipe);
> -		if (was_empty) {
> +		if (was_empty)
>  			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> -			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> -		}
> +		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
>  		__pipe_lock(pipe);
>  		was_empty = pipe_empty(pipe->head, pipe->tail);
> @@ -591,10 +588,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	 * Epoll nonsensically wants a wakeup whether the pipe
>  	 * was already empty or not.
>  	 */
> -	if (was_empty || pipe->poll_usage) {
> +	if (was_empty || pipe->poll_usage)
>  		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> -		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> -	}
> +	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  	if (wake_next_writer)
>  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>  	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
