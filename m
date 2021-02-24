Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814A23237DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhBXHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhBXHZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:25:35 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:24:54 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s107so1285214otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hVQRk3vsrmZl5N/tvnjO8rhMNKZckQjY8psEJ67EeM8=;
        b=lHpQY9Xoan3f7RzlfoTCYqMDpB2GYu2zzswfLM+0QwelUNJD+8FU8EhT1+yGzjim0I
         9uhmS/t6MbMp2OziRC6oa2hVMN930QT9YNZkmMACTP1pxcksLVNwPWsDcYvmIXAMASn6
         Sl9jqsO0uRpl9vMRiMcV2BGu0jcOEt68pMewVfz9KsUINtV/UQdajoTuJN0p5Nv59xvR
         DrW2N6oWyo3RmuIQuYeEng/NJSyQks4RvvA5/QCXcgyQztXrtznPlkvR4M6mBZZK9Wb7
         UiZafRQtPqpF8HAR3legu9HznQoAtT1LX7xvkM4aLZbZ7SLwcgmaRx3EE2DBBMSk7sY5
         DeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hVQRk3vsrmZl5N/tvnjO8rhMNKZckQjY8psEJ67EeM8=;
        b=BcGXy5e4cVC6N4vR4tKXCEcToPditQ1oUUbW/vg0y0xGRIxhmzZExLog07+YhUIDOy
         yO/YTiMkb1Yu06W5mb3lDiHDweCvLn1ICqoe2s6gkqV7GrEBaqO9SLzdAmQPIsPnYB29
         3b3c9dDlWl+IlXkU+X39FP871IvAVdl8BWMT8Ylg2dg7tRQuB2T+gNRWytBpGK0p+Iv6
         8+0F+ywyVLP8wCg4TybqBxPmItIeLHy7+rAcCIqAsXA9Qk6vaBw3UCn9mW8bz/LgVwef
         p4yx3qTrdQASATPwb95LbzTLNDnpr4WLJmuYorkiVuiiKwyROsgBy3oZ1KqmJWYYtJSW
         gE1g==
X-Gm-Message-State: AOAM531C4ZWM2CvO8fs3hMGXwIeK1ACETnr+fsdFC7oJEkxtKJReRgd/
        7wJHej09ZZR7uAIt6QwfaK5+JQ==
X-Google-Smtp-Source: ABdhPJwIf+Ts7WN2ZWmu6PeVEXypBZ7ULkjM0QFA8F1//ByW1QhpvC8/0liMfSE/JiCDssbi21C9dA==
X-Received: by 2002:a9d:b90:: with SMTP id 16mr7735327oth.304.1614151493564;
        Tue, 23 Feb 2021 23:24:53 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 64sm227540otu.80.2021.02.23.23.24.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 23 Feb 2021 23:24:53 -0800 (PST)
Date:   Tue, 23 Feb 2021 23:24:23 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200806182555.d7a7fc9853b5a239ffe9f846@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2102232210130.9202@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com> <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007302018350.2410@eggly.anvils> <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils> <20200804004012.GA1049259@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2008051913580.8184@eggly.anvils> <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
 <20200806182555.d7a7fc9853b5a239ffe9f846@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020, Andrew Morton wrote:
> On Thu, 6 Aug 2020 16:38:04 -0700 Roman Gushchin <guro@fb.com> wrote:

August, yikes, I thought it was much more recent.

> 
> > it seems that Hugh and me haven't reached a consensus here.
> > Can, you, please, not merge this patch into 5.9, so we would have
> > more time to find a solution, acceptable for all?
> 
> No probs.  I already had a big red asterisk on it ;)

I've a suspicion that Andrew might be tiring of his big red asterisk,
and wanting to unload
mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings.patch
mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix.patch
mm-vmstat-fix-proc-sys-vm-stat_refresh-generating-false-warnings-fix-2.patch
into 5.12.

I would prefer not, and reiterate my Nack: but no great harm will
befall the cosmos if he overrules that, and it does go through to
5.12 - I'll just want to revert it again later.  And I do think a
more straightforward way of suppressing those warnings would be just
to delete the code that issues them, rather than brushing them under
a carpet of overtuning.

I've been running mmotm with the patch below (shown as sign of good
faith, and for you to try, but not ready to go yet) for a few months
now - overriding your max_drift, restoring nr_writeback and friends to
the same checking, fixing the obvious reason why nr_zone_write_pending
and nr_writeback are seen negative occasionally (interrupt interrupting
to decrement those stats before they have even been incremented).

Two big BUTs (if not asterisks): since adding that patch, I have
usually forgotten all about it, so forgotten to run the script that
echoes /proc/sys/vm/stat_refresh at odd intervals while under load:
so have less data than I'd intended by now.  And secondly (and I've
just checked again this evening) I do still see nr_zone_write_pending
and nr_writeback occasionally caught negative while under load.  So,
there's something more at play, perhaps the predicted Gushchin Effect
(but wouldn't they go together if so? I've only seen them separately),
or maybe something else, I don't know.

Those are the only stats I've seen caught negative, but I don't have
CMA configured at all.  You mention nr_free_cma as the only(?) other
stat you've seen negative, that of course I won't see, but looking
at the source I now notice that NR_FREE_CMA_PAGES is incremented
and decremented according to page migratetype...

... internally we have another stat that's incremented and decremented
according to page migratetype, and that one has been seen negative too:
isn't page migratetype something that usually stays the same, but
sometimes the migratetype of the page's block can change, even while
some pages of it are allocated?  Not a stable basis for maintaining
stats, though won't matter much if they are only for display.

vmstat_refresh could just exempt nr_zone_write_pending, nr_writeback
and nr_free_cma from warnings, if we cannot find a fix to them: but
I see no reason to suppress warnings on all the other vmstats.

The patch I've been testing with:

--- mmotm/mm/page-writeback.c	2021-02-14 14:32:24.000000000 -0800
+++ hughd/mm/page-writeback.c	2021-02-20 18:01:11.264162616 -0800
@@ -2769,6 +2769,13 @@ int __test_set_page_writeback(struct pag
 	int ret, access_ret;
 
 	lock_page_memcg(page);
+	/*
+	 * Increment counts in advance, so that they will not go negative
+	 * if test_clear_page_writeback() comes in to decrement them.
+	 */
+	inc_lruvec_page_state(page, NR_WRITEBACK);
+	inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, page_index(page));
 		struct inode *inode = mapping->host;
@@ -2804,9 +2811,14 @@ int __test_set_page_writeback(struct pag
 	} else {
 		ret = TestSetPageWriteback(page);
 	}
-	if (!ret) {
-		inc_lruvec_page_state(page, NR_WRITEBACK);
-		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+
+	if (WARN_ON_ONCE(ret)) {
+		/*
+		 * Correct counts in retrospect, if PageWriteback was already
+		 * set; but does any filesystem ever allow this to happen?
+		 */
+		dec_lruvec_page_state(page, NR_WRITEBACK);
+		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 	}
 	unlock_page_memcg(page);
 	access_ret = arch_make_page_accessible(page);
--- mmotm/mm/vmstat.c	2021-02-20 17:59:44.838171232 -0800
+++ hughd/mm/vmstat.c	2021-02-20 18:01:11.272162661 -0800
@@ -1865,7 +1865,7 @@ int vmstat_refresh(struct ctl_table *tab
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		val = atomic_long_read(&vm_zone_stat[i]);
-		if (val < -max_drift) {
+		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
 				__func__, zone_stat_name(i), val);
 			err = -EINVAL;
@@ -1874,13 +1874,21 @@ int vmstat_refresh(struct ctl_table *tab
 #ifdef CONFIG_NUMA
 	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
 		val = atomic_long_read(&vm_numa_stat[i]);
-		if (val < -max_drift) {
+		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
 				__func__, numa_stat_name(i), val);
 			err = -EINVAL;
 		}
 	}
 #endif
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		val = atomic_long_read(&vm_node_stat[i]);
+		if (val < 0) {
+			pr_warn("%s: %s %ld\n",
+				__func__, node_stat_name(i), val);
+			err = -EINVAL;
+		}
+	}
 	if (err)
 		return err;
 	if (write)
