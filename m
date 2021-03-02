Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14B332A1DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836377AbhCBHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577344AbhCBGEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:04:25 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 22:03:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 105so19003879otd.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 22:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tBhpCAA1jPbTnLiEd7jXA8BiYncum4qnQ5XpzF97iQg=;
        b=ms0IMW24z3+h8/kEwL2uJqzBZnp9BvI/flyVqA+bL8lBcGyDtGnMX7yYiW8WrQjevj
         BOSIm4v30W774hCRni3r02ZTRBocJsycPL8rTdiRo1NgUboqrnAcg1Ts2YzX60YEjdMy
         Hq7+b4v0aZtv1Dm9dGcwtr1E4ql3QRJ9DU7BchDd5xHVdCyUH8poiWf+u3F516mnr+1Z
         U73l1siBOEfhEQ885ZXc8949NNkYX8o4zmBIjELuN87owYx0fhM7w/JwI+nzDDwAMsr1
         kJMn5nQusZ0DhCD3KPUnt93iXhUvFcgLfR52qNCHM1bxTKK3nIkp+kf2o3WwIbLjKk7p
         fMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tBhpCAA1jPbTnLiEd7jXA8BiYncum4qnQ5XpzF97iQg=;
        b=Ne1VLRKDXvQSep3EY3pYPZDATbnh1eRHyRz/0uySjXa9xfrU9qOvp81KYhf24e1MXn
         ASw74dpLsrjSpDgtlmFTeKmQMBPfBG3iYyQHSXHekAGFA84TR+KzLEqS4kJqv2WDzVp+
         kzKrAh6muPNnS+sbcNpN5lrslb565Y8fiZ78fW3MhjDVQtpmWZqZQESTV3CWGQ7a/JMs
         wiy0Sc2rjnRbDqtAfeFvO81dw9ED3XRSavlSXqQw7g5exd5y/68yNUjQxPzOpdJmja9m
         KM/ZsJLlR64VZFbp3KWi/ShLVArSxi6SdsAdrOesWrHabDUEucsIh7dOkLTZ9oslgmNj
         96+g==
X-Gm-Message-State: AOAM533mi7kzsAyyG85WCdPkGCeGDcm2Bw7ER7ucVdaRhgZfdHgRwnlf
        DWfxAppCzn9hbjbsaOyjsq281Q==
X-Google-Smtp-Source: ABdhPJzGl9CU/c+ASlckrwohDeSS2vlX3mr80dlrxGTph/s+yDJ0I9fXJJpkpBpIojX+HmctCZy9Hg==
X-Received: by 2002:a05:6830:239a:: with SMTP id l26mr6541916ots.280.1614665022032;
        Mon, 01 Mar 2021 22:03:42 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x126sm3854510oix.5.2021.03.01.22.03.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 22:03:41 -0800 (PST)
Date:   Mon, 1 Mar 2021 22:03:26 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mm: /proc/sys/vm/stat_refresh skip checking known
 negative stats
In-Reply-To: <YD2IGxfOE5AgYuzc@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2103012158540.7549@eggly.anvils>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils> <alpine.LSU.2.11.2102251512170.13363@eggly.anvils> <YDw67lSx5vLTgx/O@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2103011301010.4832@eggly.anvils>
 <YD2IGxfOE5AgYuzc@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmstat_refresh() can occasionally catch nr_zone_write_pending and
nr_writeback when they are transiently negative.  The reason is partly
that the interrupt which decrements them in test_clear_page_writeback()
can come in before __test_set_page_writeback() got to increment them;
but transient negatives are still seen even when that is prevented, and
I am not yet certain why (but see Roman's note below).  Those stats are
not buggy, they have never been seen to drift away from 0 permanently:
so just avoid the annoyance of showing a warning on them.

Similarly avoid showing a warning on nr_free_cma: CMA users have seen
that one reported negative from /proc/sys/vm/stat_refresh too, but it
does drift away permanently: I believe that's because its incrementation
and decrementation are decided by page migratetype, but the migratetype
of a pageblock is not guaranteed to be constant.

Roman Gushchin points out:
For performance reasons, vmstat counters are incremented and decremented
using per-cpu batches.  vmstat_refresh() flushes the per-cpu batches on
all CPUs, to get values as accurate as possible; but this method is not
atomic, so the resulting value is not always precise.  As a consequence,
for those counters whose actual value is close to 0, a small negative
value may occasionally be reported.  If the value is small and the state
is transient, it is not an indication of an error.

Link: https://lore.kernel.org/linux-mm/20200714173747.3315771-1-guro@fb.com/
Reported-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/vmstat.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- vmstat2/mm/vmstat.c	2021-02-25 11:56:18.000000000 -0800
+++ vmstat3/mm/vmstat.c	2021-02-25 12:42:15.000000000 -0800
@@ -1840,6 +1840,14 @@ int vmstat_refresh(struct ctl_table *tab
 	if (err)
 		return err;
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
+		/*
+		 * Skip checking stats known to go negative occasionally.
+		 */
+		switch (i) {
+		case NR_ZONE_WRITE_PENDING:
+		case NR_FREE_CMA_PAGES:
+			continue;
+		}
 		val = atomic_long_read(&vm_zone_stat[i]);
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
@@ -1856,6 +1864,13 @@ int vmstat_refresh(struct ctl_table *tab
 	}
 #endif
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		/*
+		 * Skip checking stats known to go negative occasionally.
+		 */
+		switch (i) {
+		case NR_WRITEBACK:
+			continue;
+		}
 		val = atomic_long_read(&vm_node_stat[i]);
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
