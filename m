Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F433D0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhCPJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:34:46 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:37344 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCPJeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:34:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615887254; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=9UfEyw436vIESU6W/ayoumRpdy+NziJpgKqhqz2zc6A=; b=Y6Ivj6jLSjXj0WBXqENsr58EZVyn+jJAbBx7SlbydNQbGPOf/EZdy0HnxFCE8CRcLAWgVRk9
 8Mchk0T9Ko4VklxXC/KVJw0XQpyq/tdHGy0IGPzrpe9h81hHPIqzPvt/TXvQOdoPbN6BIiug
 1xAbHk0sumP3smusVTJX2HNS48U=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60507b943f267701a41fad34 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Mar 2021 09:34:12
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F8E4C433CA; Tue, 16 Mar 2021 09:34:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35FC2C433CA;
        Tue, 16 Mar 2021 09:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35FC2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
Date:   Tue, 16 Mar 2021 15:04:06 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org
Subject: Re: [PATCH] f2fs: fix the discard thread sleep timeout under high
 utilization
Message-ID: <20210316093406.GC8562@codeaurora.org>
References: <1615784186-2693-1-git-send-email-stummala@codeaurora.org>
 <49be0c70-4fe4-6acd-b508-08621f0623c0@huawei.com>
 <20210315074645.GA8562@codeaurora.org>
 <0c7220d7-416e-32b7-96cb-effd3f84d6e2@huawei.com>
 <20210315094502.GB8562@codeaurora.org>
 <f0da1e4c-24b0-211c-670a-686067203d08@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0da1e4c-24b0-211c-670a-686067203d08@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Thanks for the review and suggestions.

I think the below code should work and cover all the cases we discussed.
Let me test it and then put up a new patchset for review.

Thanks,
Sahitya.

Mon, Mar 15, 2021 at 06:31:00PM +0800, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2021/3/15 17:45, Sahitya Tummala wrote:
> >Hi Chao,
> >
> >On Mon, Mar 15, 2021 at 04:10:22PM +0800, Chao Yu wrote:
> >>Hi Sahitya,
> >>
> >>On 2021/3/15 15:46, Sahitya Tummala wrote:
> >>>Hi Chao,
> >>>
> >>>On Mon, Mar 15, 2021 at 02:12:44PM +0800, Chao Yu wrote:
> >>>>Sahitya,
> >>>>
> >>>>On 2021/3/15 12:56, Sahitya Tummala wrote:
> >>>>>When f2fs is heavily utilized over 80%, the current discard policy
> >>>>>sets the max sleep timeout of discard thread as 50ms
> >>>>>(DEF_MIN_DISCARD_ISSUE_TIME). But this is set even when there are
> >>>>>no pending discard commands to be issued. This results into
> >>>>>unnecessary frequent and periodic wake ups of the discard thread.
> >>>>>This patch adds check for pending  discard commands in addition
> >>>>>to heavy utilization condition to prevent those wake ups.
> >>>>
> >>>>Could this commit fix your issue?
> >>>>
> >>>>https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=43f8c47ea7d59c7b2270835f1d7c4618a1ea27b6
> >>>>
> >>>I don't think it will help because we are changing the max timeout of the
> >>>dpolicy itself in __init_discard_policy() when util > 80% as below -
> >>>
> >>>dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> >>>
> >>>And issue_discard_thread() uses this value as wait_ms, when there
> >>>are no more pending discard commands to be issued.
> >>><snip>
> >>>                 } else {
> >>>                         wait_ms = dpolicy.max_interval;
> >>>                 }
> >>><snip>
> >>>
> >>>The new patch posted above is not changing anything related to the  max_interval.
> >>>Hence, I think it won't help the uncessary wakeup problem I am trying to solve
> >>>for this condition - util > 80% and when there are no pending discards.
> >>>
> >>>Please let me know if i am missing something.
> >>
> >>Copied, thanks for the explanation.
> >>
> >>But there is another case which can cause this issue in the case of
> >>disk util < 80%.
> >>
> >>wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> >>
> >>do {
> >>	wait_event_interruptible_timeout(, wait_ms);
> >>
> >>	...
> >>
> >>	if (!atomic_read(&dcc->discard_cmd_cnt))
> >>[1] new statement
> >>		continue;
> >>
> >>} while();
> >>
> >>Then the loop will wakeup whenever 50ms timeout.
> >>
> >Yes, only for a short period of time i.e., until the first discard command
> >is issued. Once a discard is issued, it will use
> >wait_ms = dpolicy.max_interval;
> >
> >>So, to avoid this case, shouldn't we reset wait_ms to dpolicy.max_interval
> >>at [1]?
> >>
> >Yes, we can add that to cover the above case.
> >
> >>Meanwhile, how about relocating discard_cmd_cnt check after
> >>__init_discard_policy(DPOLICY_FORCE)? and olny set .max_interval to
> >>DEF_MAX_DISCARD_ISSUE_TIME if there is no discard command, and keep
> >>.granularity to 1?
> >>
> >
> >There is not need to change .granularity, right? It will be controlled
> 
> I think so.
> 
> >as per utilization as it is done today. Only max_interval and wait_ms
> >needs to be updated. Does this look good?
> >
> >diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >index d7076796..958ad1e 100644
> >--- a/fs/f2fs/segment.c
> >+++ b/fs/f2fs/segment.c
> >@@ -1772,13 +1772,16 @@ static int issue_discard_thread(void *data)
> >                         wait_ms = dpolicy.max_interval;
> >                         continue;
> >                 }
> >-               if (!atomic_read(&dcc->discard_cmd_cnt))
> >-                       continue;
> >-
> >                 if (sbi->gc_mode == GC_URGENT_HIGH ||
> >                         !f2fs_available_free_memory(sbi, DISCARD_CACHE))
> >                         __init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
> >
> >+               if (!atomic_read(&dcc->discard_cmd_cnt)) {
> >+                       dpolicy.max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> >+                       wait_ms = dpolicy.max_interval;
> >+                       continue;
> >+               }
> 
> Hmm.. how about cleaning up to configure discard policy in
> __init_discard_policy()?
> 
> Something like:
> 
> ---
>  fs/f2fs/segment.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 592927ccffa7..684463a70eb9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1118,7 +1118,9 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>  		dpolicy->ordered = true;
>  		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
>  			dpolicy->granularity = 1;
> -			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> +			if (atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt))
> +				dpolicy->max_interval =
> +					DEF_MIN_DISCARD_ISSUE_TIME;
>  		}
>  	} else if (discard_type == DPOLICY_FORCE) {
>  		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> @@ -1734,8 +1736,15 @@ static int issue_discard_thread(void *data)
>  	set_freezable();
> 
>  	do {
> -		__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
> -					dcc->discard_granularity);
> +		if (sbi->gc_mode == GC_URGENT_HIGH ||
> +			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
> +			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
> +		else
> +			__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
> +						dcc->discard_granularity);
> +
> +		if (!atomic_read(&dcc->discard_cmd_cnt))
> +			wait_ms = dpolicy.max_interval;
> 
>  		wait_event_interruptible_timeout(*q,
>  				kthread_should_stop() || freezing(current) ||
> @@ -1762,10 +1771,6 @@ static int issue_discard_thread(void *data)
>  		if (!atomic_read(&dcc->discard_cmd_cnt))
>  			continue;
> 
> -		if (sbi->gc_mode == GC_URGENT_HIGH ||
> -			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
> -			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
> -
>  		sb_start_intwrite(sbi->sb);
> 
>  		issued = __issue_discard_cmd(sbi, &dpolicy);
> -- 
> 2.29.2
> 
> Thoughts?
> 
> Thanks,
> 
> >+
> >                 sb_start_intwrite(sbi->sb);
> >
> >                 issued = __issue_discard_cmd(sbi, &dpolicy);
> >
> >thanks,
> >Sahitya.
> >
> >>Thanks,
> >>
> >>>
> >>>Thanks,
> >>>Sahitya.
> >>>
> >>>>Thanks,
> >>>>
> >>>>>
> >>>>>Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> >>>>>---
> >>>>>  fs/f2fs/segment.c | 5 ++++-
> >>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>
> >>>>>diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>>index dced46c..df30220 100644
> >>>>>--- a/fs/f2fs/segment.c
> >>>>>+++ b/fs/f2fs/segment.c
> >>>>>@@ -1112,6 +1112,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> >>>>>  				struct discard_policy *dpolicy,
> >>>>>  				int discard_type, unsigned int granularity)
> >>>>>  {
> >>>>>+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> >>>>>+
> >>>>>  	/* common policy */
> >>>>>  	dpolicy->type = discard_type;
> >>>>>  	dpolicy->sync = true;
> >>>>>@@ -1129,7 +1131,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
> >>>>>  		dpolicy->io_aware = true;
> >>>>>  		dpolicy->sync = false;
> >>>>>  		dpolicy->ordered = true;
> >>>>>-		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
> >>>>>+		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL &&
> >>>>>+				atomic_read(&dcc->discard_cmd_cnt)) {
> >>>>>  			dpolicy->granularity = 1;
> >>>>>  			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> >>>>>  		}
> >>>>>
> >>>
> >

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
