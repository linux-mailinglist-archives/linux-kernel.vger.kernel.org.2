Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642D7325A17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBYXOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBYXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:14:47 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:14:07 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e45so7381983ote.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8+F1D1lXhzkAPi6K9Z/dpHmXeEnlD5O2kNPvAi2nZ4Q=;
        b=taz4RTC0+G8PvM1uwoOpuyhIsFuQGdRvf50tuJsYOFiiNSaCi7rH+jPsSMS08o7ric
         bsoj0G8BsyU2k/m14j5nHD0JpfC+lHG4l916bancc93Q0d2eOK2selxVKx14Jc3u6jYF
         t02UXofC8ofRkPG2NlqBOELORdM0pE9BwaH+HalgvvO1H4MMOwHXz7NmFozZXpETZTd8
         fLczgVmcWQ0838PjYA+eAjYKNUknp8SOvgFRH8jkCbXj2qpethyUyuEnVb3cQwS3nO7o
         v7kH1INCxd26bDL+jkucY1HQaqOYon3GasY2S3h+PTTMnC+TMeN+5UhdHt3kL6b97xlr
         O/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8+F1D1lXhzkAPi6K9Z/dpHmXeEnlD5O2kNPvAi2nZ4Q=;
        b=hWvjmZxad/YT6dRQ/5HTZnEsHgqSmgXbL916J5Y+I1TUBKNwlK9T64RDW9y+Bsspk6
         cNoopXxElYkIadY3wBa000roAlRXTmHWtuTQrImgYrD+Rbir9Fg1sf6P76BI2u0CtnhJ
         BLM5r3tUFn1h9MC63t0xYXJS4EjYkhSVm24WLDBombLw9mMXcCYpnCpCyhslFT65ahX9
         JZ5Mtf81CErGBsg3uBUPtjKrq2OVGxBTJJSge0PNaDa7FBq/4pJXTeY+AzAS3wQFxpFT
         Xw4pJ7ZgAJbPHD1kB9WpfUm9CwRBg3LO7IsxGSFwmnLipaeG+C3HUJKdGPndBce35pXE
         RybQ==
X-Gm-Message-State: AOAM533FDc2AwGKY9z8ss6WhNkR8is/vErC0SAt/0q++wf1pU/1BiLSs
        HU5Cok/yWWXK6lBDgKLpH9iIjg==
X-Google-Smtp-Source: ABdhPJz3q+mRKljzmwDKqp3s6gfNtnenOOZq7Rv89IrPJVnkql3IQAP216I6onQbw9nGWCB3wbx3+w==
X-Received: by 2002:a05:6830:1416:: with SMTP id v22mr45280otp.239.1614294846254;
        Thu, 25 Feb 2021 15:14:06 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h11sm1418826ooj.36.2021.02.25.15.14.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Feb 2021 15:14:05 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:14:03 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm: /proc/sys/vm/stat_refresh skip checking known negative
 stats
In-Reply-To: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2102251512170.13363@eggly.anvils>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
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
we have not yet resolved why (Roman believes that it is an unavoidable
consequence of the refresh scheduled on each cpu).  But those stats are
not buggy, they have never been seen to drift away from 0 permanently:
so just avoid the annoyance of showing a warning on them.

Similarly avoid showing a warning on nr_free_cma: CMA users have seen
that one reported negative from /proc/sys/vm/stat_refresh too, but it
does drift away permanently: I believe that's because its incrementation
and decrementation are decided by page migratetype, but the migratetype
of a pageblock is not guaranteed to be constant.

Use switch statements so we can most easily add or remove cases later.

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
